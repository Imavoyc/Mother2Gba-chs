@echo off

SET lua_cmd=bin\lua.exe

%lua_cmd% compile_text.lua

cd chs_font
echo make font
python3 makefont.py s

type special_char.txt
cd ..


copy chs_font\m2_chs_font_aa.bin src\data\m2_chs_font_aa.bin
pause