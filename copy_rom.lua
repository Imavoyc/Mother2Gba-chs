local function read_section_file(filename)
    local addr = 0
    local offset = 0
    local size = 0
    
    local p1,p2,p3 = 0,0,0

    for line in io.lines(filename) do
        if string.find(line,'[Nr] Name',1,true) then
            p1 = string.find(line,'Addr',1,true)
            p2 = string.find(line,'Off',1,true)
            p3 = string.find(line,'Size',1,true)
        end
        
        if string.find(line,'.text',1,true) then
            addr = tonumber(string.sub(line,p1,p1+7),16)
            offset = tonumber(string.sub(line,p2,p2+5),16)
            size = tonumber(string.sub(line,p3,p3+5),16)
        end
    end
    
    return addr, offset, size
end

addr, offset, size = read_section_file('src/linked_obj.section')

local linked_obj = io.open('src/c/linked.o', "rb")
local text_section = linked_obj:read("a")
linked_obj:close()


local rom_file = io.open('bin/m12.gba', "rb")
local rom_bytes = rom_file:read("a")
rom_file:close()

addr = addr - 0x8000000
out_bytes = string.sub(rom_bytes, 1, addr)

out_bytes = out_bytes .. string.sub(text_section,offset+1,offset+size)
out_bytes = out_bytes .. string.sub(rom_bytes, addr+size+1, -1)

local out_file = io.open('bin/m12.gba', "wb")
out_file:write(out_bytes)
out_file:close()