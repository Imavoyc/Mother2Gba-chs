dofile("m12-codelist.lua")

local baseAddress = 0xC10000

local function split(s, p)
    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt
end

local text_file = io.open('working/m12-strings-chs.txt', "r")
local text = text_file:read("a")
text_file:close()

local function is_match_code(codeStrings, code)
    if (codeStrings == nil or #codeStrings < 2) then return false end
    local byte1 = tonumber(codeStrings[1],16)
    local byte2 = tonumber(codeStrings[2],16)
    
    return byte1 == code and byte2 == 0xff
end

local function match_code(codeStrings)
    for k,v in ipairs(m12_codelist) do
        if(is_match_code(codeStrings, v.Identifier)) then return v end
    end
    
    return nil
end

local function is_codestring_valid(codeStrings, code)
    if (codeStrings == nil or #codeStrings < 2) then return false end
    if not code.HasReferences then
        if #codeStrings ~= code.Length then return false end
        
        for i=3,#codeStrings do
            if tonumber(codeStrings[i],16) == nil then return false end
        end
    else
        if #codeStrings < 3 then return false end
        
        for i=3,code.ReferenceOffset do
            if tonumber(codeStrings[i],16) == nil then return false end
        end
        
        local numReferences = 0
        
        if code.IsVariableLength then
            numReferences = tonumber(codeStrings[3],16)
        else
            numReferences = 1
        end
        
        for i=1,numReferences do
            local ref = codeStrings[i + code.ReferenceOffset]
            
            if ref == nil then return false end
            if string.len(ref) < 3 then return false end
            if string.sub(ref,1,1) ~= '_'  then return false end
            if string.sub(ref,-1,-1) ~= '_'  then return false end
        end
    end
    
    return true
end

local function compile_code(codeStrings, code, referenceAddress, addressMap)
    local buf = ''
    
    for k,v in ipairs(codeStrings) do
        if string.sub(v,1,1) == '_' then
            local label = string.sub(v,2,-2)
            local pointer = addressMap[label]
            assert(pointer,label)
            
            if code.AbsoluteAddressing then
                pointer = pointer | 0x8000000
            else
                pointer = pointer - referenceAddress
            end
            --print(string.format('%s %x referenceAddress %x addressMap[label] %x',label,pointer,referenceAddress,addressMap[label]))
            buf = buf .. string.pack('<i4',pointer) 
            referenceAddress = referenceAddress + 4
        else
            local b = tonumber(v,16)
            buf = buf .. string.pack('<I1',b) 
            referenceAddress = referenceAddress + 1
        end
    end
    
    return buf, referenceAddress
end

local function scan_string(text)
    local i = 1
    local referenceAddress = 0xC10000
    local AddressMap = {}
    local references = {}
    
    while i < #text do
        if string.sub(text,i,i) == '[' then
            local p = string.find(text,"]",i+1,true)
            assert(p,string.format("Opening bracket has no matching closing bracket %d",i))
            local str = string.sub(text,i+1,p-1)
            local codeStrings = split(str,' ');
            
            for k,v in ipairs(codeStrings) do
                if string.sub(v,1,1) == '_' then
                    assert(string.sub(v,-1,-1) == '_',string.format("Reference has no closing underscore %d",i))
                    assert(#v>2,string.format("Reference is empty: %d",i))
                    
                    referenceAddress = referenceAddress + 4
                else
                    local b = tonumber(v,16)
                    assert(b,string.format("Encountered invalid code string %d",i))
                    referenceAddress = referenceAddress + 1
                end
            end
            
            i = p + 1
            
        elseif string.sub(text,i,i) == '{' then
            local p = string.find(text,"}",i+1,true)
            assert(p,string.format("comment not legal %d",i))
            i = p + 1
            
        elseif string.sub(text,i,i) == ']' then 
            assert(false,string.format("Closing bracket has no matching opening bracket: position %d",i))
            
        elseif string.sub(text,i,i) == '^' then
            local p = string.find(text,"^",i+1,true)
            local label = string.sub(text,i+1,p-1)
            assert(p,string.format("Label has no matching closing caret %d",i))

            AddressMap[label] = referenceAddress
            i = p + 1
        else 
            if string.sub(text,i,i) ~= '\n' and string.sub(text,i,i) ~= '\r' then
                referenceAddress = referenceAddress + 1
            end
        
            i = i+1
        end
    end
    
    return AddressMap
end

local function compile_string(text,AddressMap)
    local i = 1
    local referenceAddress = 0xC10000
    local buffer = ''
    local int_progress = 0
    
    while i < #text do
        if string.sub(text,i,i) == '[' then
            local p = string.find(text,"]",i+1,true)
            assert(p,string.format("Opening bracket has no matching closing bracket %d",i))
            local str = string.sub(text,i+1,p-1)
            local codeStrings = split(str,' ');
            
            local code = match_code(codeStrings)
            if code == nil then
                for j=1,#codeStrings do
                    local b = tonumber(codeStrings[j],16)
                    
                    buffer = buffer .. string.pack('<I1',b) 
                    referenceAddress = referenceAddress + 1
                end
            else
                assert(is_codestring_valid(codeStrings,code),string.format("NO valid code %d",i))
                
                local buf = ''
                local new_ref = 0
                buf,new_ref = compile_code(codeStrings,code,referenceAddress,AddressMap)
                
                referenceAddress = new_ref
                buffer = buffer .. buf
            end
            
            i = p + 1
        elseif string.sub(text,i,i) == '{' then
            local p = string.find(text,"}",i+1,true)
            assert(p,string.format("comment not legal %d",i))
            i = p + 1

        elseif string.sub(text,i,i) == ']' then 
            assert(false,string.format("Closing bracket has no matching opening bracket: position %d",i))
        
        elseif string.sub(text,i,i) == '^' then
            local p = string.find(text,"^",i+1,true)
            local label = string.sub(text,i+1,p-1)
            assert(p,string.format("Label has no matching closing caret %d",i))
            
            i = p + 1
        else
            if string.sub(text,i,i) ~= '\n' and string.sub(text,i,i) ~= '\r' then
                local b = string.byte(text,i)
                
                if b < 0xa1 then
                    b = b + 0x30
                    buffer = buffer .. string.pack('<I1',b) 
                    referenceAddress = referenceAddress + 1
                else
                    local b2 = string.byte(text,i+1)
                    --print(string.format("%2x %2x",b,b2))
                    b = b - 0xA1
                    
                    buffer = buffer .. string.pack('<I1',b)
                    buffer = buffer .. string.pack('<I1',b2)
                    referenceAddress = referenceAddress + 2
                    i = i + 1
                end
            end
            
            i = i+1
        end
        

        local progress = i/#text *1000
        if int_progress ~= math.floor(progress) then
            int_progress = math.floor(progress)
            print(string.format('progress %.2f',int_progress/10))
        end
    end
    
    return buffer
end

local AddressMap = scan_string(text)
local buffer = compile_string(text,AddressMap)

local nfile = io.open ('./working/m12-main-strings.bin',"wb")
nfile:write(buffer)
nfile:close()

local labelFiles = {
	"m12-tpt-primary",
	"m12-tpt-secondary",
	"m12-psi-help",
	"m12-battle-actions",
	"m12-item-help",
	"m12-movements",
	"m12-objects",
	"m12-phone-list",
	"m12-unknown",
	"m12-asmrefs",
	"m12-enemy-encounters",
	"m12-enemy-deaths",
	"m12-prayers"
}

local labelAsmFile = io.open('./working/m12-main-strings.asm', "w")
labelAsmFile:write(string.format(".org 0x%X :: .incbin \"m12-main-strings.bin\"\n\n", baseAddress | 0x8000000))

for k,label_file in ipairs(labelFiles) do
    local label_table = dofile(label_file..'.lua')
    
    for k,label in ipairs(label_table) do
        local pointer = label.PointerLocation
        local new_adr = AddressMap[label.Label]
        assert(new_adr,label.Label)
    
        labelAsmFile:write(string.format(".org 0x%X :: dw 0x%08X\n", pointer | 0x8000000, new_adr | 0x8000000))

    end
end

labelAsmFile:close()