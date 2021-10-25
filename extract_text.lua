dofile("m12-codelist.lua")

local baseAddress = 0xC10000

local function split(s, p)
    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt
end

local function scan_string(text,strip)
    local i = 1
    local referenceAddress = 0xC10000
    --local AddressMap = {}
    local references = {}
    local diagloug_text = ''
    local diaglougs = {}
    local glabel = nil
    while i < #text do
        if string.sub(text,i,i) == '[' then
            local p = string.find(text,"]",i+1,true)
            assert(p,string.format("Opening bracket has no matching closing bracket %d",i))
            local str = string.sub(text,i+1,p-1)
            --local codeStrings = split(str,' ');
            
            --[[
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
            ]]--
            if strip then 
                --diagloug_text = diagloug_text .. '☆'
            else
                diagloug_text = diagloug_text .. string.format("[%s]",str)
            end

            i = p + 1
            
        elseif string.sub(text,i,i) == ']' then 
            assert(false,string.format("Closing bracket has no matching opening bracket: position %d",i))
            
        elseif string.sub(text,i,i) == '^' then
            local p = string.find(text,"^",i+1,true)
            local label = string.sub(text,i+1,p-1)
            assert(p,string.format("Label has no matching closing caret %d",i))


            if strip then
                diagloug_text = string.gsub(diagloug_text,'◆','')
                diagloug_text = string.gsub(diagloug_text,'｡','')
            end
            if glabel == nil then 
                glabel = label
            else
                diaglougs[glabel] = diagloug_text
                glabel = label
                diagloug_text = ''
            end
            --print(string.format("%s:%s\n",label,diagloug_text))
            
            i = p + 1
        else 
            if string.sub(text,i,i) ~= '\n' and string.sub(text,i,i) ~= '\r' then
                diagloug_text = diagloug_text .. string.sub(text,i,i)
                referenceAddress = referenceAddress + 1
            end
        
            i = i+1
        end
    end
    
    return diaglougs
end


local text_file = io.open('working/m12-strings-english.txt', "r")
local text = text_file:read("a")
text_file:close()

local jp_text_file = io.open('working/m12-strings.txt', "r")
local jp_text = jp_text_file:read("a")
jp_text_file:close()

local en_diaglougs = scan_string(text,false)
local jp_diaglougs = scan_string(jp_text,true)


ofile = io.open('working/m12-strings-chs.txt', "w")

--[[
for k,v in pairs(en_diaglougs) do
    ofile:write(string.format('%s:\n',k))
    ofile:write(string.format('%s\n',v))
    if jp_diaglougs[k] then 
        ofile:write(string.format('%s\n',jp_diaglougs[k]))
    end
    ofile:write('\n')
end
]]--

for i=0,40000 do
    local k = string.format("L%d",i)
    if en_diaglougs[k] then
        ofile:write(string.format('^%s^\n',k))
        ofile:write(string.format('%s\n',en_diaglougs[k]))
        ofile:write(string.format('{%s}\n',en_diaglougs[k]))
        if jp_diaglougs[k] then 
            ofile:write(string.format('{☆%s☆}\n',jp_diaglougs[k]))
        end
        ofile:write('\n')
    end
end

ofile:close()