function is_include(value, tab)
    for k,v in ipairs(tab) do
      if v == value then
          return true
      end
    end
    return false
end

function read_sym_file(filename)
    local sym_table = {}

    for line in io.lines(filename) do
        if(tonumber(string.sub(line,1,8),16)) then
            --print(line)
            local sym = {}
            local flag = string.sub(line,10,17)
            local tab_pos = string.find(line,'\t')
            local section = string.sub(line,18,tab_pos-1)
            local size = string.sub(line,tab_pos+1,tab_pos+9)
            local name = string.sub(line,tab_pos+10,-1)
    
            sym.name = name
            sym.value = tonumber(string.sub(line,1,8),16)
            sym.size = tonumber(size,16)
            sym.IsAbsolute = section == "*ABS*"
            sym.IsUndefined = section == "*UND*"

            sym.IsLocal = (string.find(flag,'l') ~= nil)
            sym.IsGlobal = (string.find(flag,'g') ~= nil)
            sym.IsWarning = (string.find(flag,'W') ~= nil)
            sym.IsConstructor = (string.find(flag,'C') ~= nil)
            sym.IsIndirect = (string.find(flag,'I') ~= nil)
            sym.IsDebugging = (string.find(flag,'d') ~= nil)
            sym.IsDynamic = (string.find(flag,'D') ~= nil)
            sym.IsFunction = (string.find(flag,'F') ~= nil)
            sym.IsFile = (string.find(flag,'f') ~= nil)
            sym.IsObject = (string.find(flag,'O') ~= nil)

            table.insert(sym_table,sym)
        end
    end

    return sym_table
end

function read_asm_sym_file(filename)
    local sym_table = {}
    
    for line in io.lines(filename) do
        if(tonumber(string.sub(line,1,8),16)) then
            local sym = {}
            local value = tonumber(string.sub(line,1,8),16)
            local name = string.sub(line,10,-1)
            
            if(name ~= '0') then 
                sym.name = name
                sym.value = value
                sym.IsLocal = string.sub(name,1,2) == '@@'
                sym.IsGlobal = (string.sub(name,1,1) ~= '.') and (not sym.IsLocal)
                table.insert(sym_table,sym)
            end
        end
    end
    
    return sym_table
end