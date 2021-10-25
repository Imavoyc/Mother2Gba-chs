@echo off
Setlocal enabledelayedexpansion

SET input_rom_file=bin\m12fresh.gba
SET output_rom_file=bin\m12.gba
SET compiled_asm_file=src\m2-compiled.asm
SET working_dir=working
SET give_dir=working\m12-give-strings
SET give_new_dir=src\m12-give-strings
SET src_dir=src

SET includes_asm_file=m12-includes.asm
SET includes_sym_file=m12-includes.sym

SET hack_asm_file=m2-hack.asm
SET hack_sym_file=m2-hack.sym
SET input_c_files=src/c/ext.c src/c/vwf.c src/c/locs.c src/c/credits.c src/c/fileselect.c src/c/goods.c src/c/status.c src/c/battle.c src/c/equip.c src/c/psi.c src/c/luminehall.c

SET lua_cmd=bin\lua.exe
SET asm_cmd=bin\armips.exe
SET gcc_cmd=arm-none-eabi-gcc
SET ld_cmd=arm-none-eabi-ld
SET objdump_cmd=arm-none-eabi-objdump
SET readelf_cmd=arm-none-eabi-readelf

SET gcc_args= -c -O1 -fno-ipa-cp -fno-inline -march=armv4t -mtune=arm7tdmi -mthumb -ffixed-r12 -mno-long-calls

SET base_c_address=0x83755B8
SET combined_obj_file=src/c/combined.o
SET combine_script=src/c/combine.ld
SET link_script=src/c/link.ld
SET undefine_obj_file=src/c/ext.o
SET linked_obj_file=src/c/linked.o

copy %input_rom_file%  %output_rom_file% 

echo Copying give strings to src folder...
if exist "%give_new_dir%" (
    rd/s/q "%give_new_dir%"
)
echo create dir %give_new_dir% ...
md "%give_new_dir%"

copy %give_dir%\*.* %give_new_dir%\

:: ------------------------ ASSEMBLE HACK CODE -----------------------
echo Assembling game text...
%asm_cmd% -root %working_dir% -sym %includes_sym_file% %includes_asm_file%

:: ----------------------------- COMPILE C ---------------------------
for %%c in (%input_c_files%) do ( 
    %gcc_cmd% %gcc_args% -o src/c/%%~nc.o src/c/%%~nc.c
    SET obj_files=!obj_files! src/c/%%~nc.o
)

:: ----------------------------- 1ST LINK ----------------------------
echo "Writing combine_script..."
echo SECTIONS { .text %base_c_address% : { *(.text .rodata) } } > %combine_script%

echo "Linking %obj_files%..."
%ld_cmd% -i -T %combine_script% -o %combined_obj_file% %obj_files%


echo "Reading symbols from %combined_obj_file%..."
%objdump_cmd% -t %combined_obj_file% > src/c/combined_obj.sym

echo "Reading symbols from %undefine_obj_file%..."
%objdump_cmd% -t %undefine_obj_file% > src/c/undefine_obj.sym

echo "Exporting C symbols to %compiled_asm_file%..."
%lua_cmd% export_c_symbols.lua

:: ------------------------ ASSEMBLE HACK CODE -----------------------
echo "Assembling %hack_asm_file%..."
%asm_cmd% -root %src_dir% -sym %hack_sym_file% %hack_asm_file%

:: ------------------- GENERATE FINAL LINKER SCRIPT ------------------
echo "Writing %link_script%..."
%lua_cmd% gen_link_script.lua

:: ---------------------------- FINAL LINK ---------------------------
echo "Linking to %linked_obj_file%..."
%ld_cmd% -T %link_script% -o %linked_obj_file% %combined_obj_file%


:: -------------------- COPY COMPILED C CODE TO ROM ------------------
echo "Copying compiled code to %output_rom_file%..."
%readelf_cmd% -S %linked_obj_file% > src/linked_obj.section

%lua_cmd% copy_rom.lua
pause