dofile('common.lua')

local combined_symbols = read_sym_file('src/c/combined_obj.sym')
local ext_symbols = read_sym_file('src/c/undefine_obj.sym')

local ext_symbols_names = {}
for k,v in ipairs(ext_symbols) do
    if v.IsGlobal and v.IsFunction then
        table.insert(ext_symbols_names,v.name)
    end
end

local nfile = io.open ("src/m2-compiled.asm","w")


for k,v in ipairs(combined_symbols) do
    if v.IsGlobal and v.IsFunction then
        if not is_include(v.name,ext_symbols_names) then
            nfile:write(string.format(".definelabel %s,0x%08x\n",v.name,v.value))
        end
    end
end

nfile:close()