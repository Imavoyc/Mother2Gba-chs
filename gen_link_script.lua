dofile('common.lua')

local hack_symbols = read_asm_sym_file('src/m2-hack.sym')
local includes_symbols = read_asm_sym_file('working/m12-includes.sym')

local asm_symbols = {}
for k,v in ipairs(hack_symbols) do
    if v.IsGlobal then
        table.insert(asm_symbols,v)
    end
end

for k,v in ipairs(includes_symbols) do
    if v.IsGlobal then
        table.insert(asm_symbols,v)
    end
end

local asm_symbols_names = {}
for k,v in ipairs(asm_symbols) do
    table.insert(asm_symbols_names,v.name)
end

local ext_symbols = read_sym_file('src/c/undefine_obj.sym')
local ext_symbols_names = {}
for k,v in ipairs(ext_symbols) do
    if v.IsGlobal and v.IsFunction then
        table.insert(ext_symbols_names,v.name)
    end
end

for k,v in ipairs(ext_symbols_names) do
    if not is_include(v, asm_symbols_names) then
        print(string.format("Error: Undefined external symbol %s\n",v))
    end
end

local nfile = io.open ("src/c/link.ld","w")

nfile:write("SECTIONS { .text 0x83755B8 : { *(.text .data .rodata*) } }\n")

for k,v in ipairs(asm_symbols) do
    --table.insert(asm_symbols_names,v.name)
    nfile:write(string.format("%s = 0x%X;\n",v.name, v.value))
end
nfile:close()