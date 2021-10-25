.gba
.open "../bin/m12.gba",0x8000000

//==============================================================================
// Relocation hacks
//==============================================================================

// Move the weird box font from 0xFCE6C
.org 0x80B3274 :: dw m2_font_relocate


//==============================================================================
// Font hacks
//==============================================================================

.org 0x8AFED84 :: .incbin "data/m2-mainfont1-empty.bin"
.org 0x8B0F424 :: .incbin "data/m2-mainfont2-empty.bin"
.org 0x8B13424 :: .incbin "data/m2-mainfont3-empty.bin"
.org 0x8B088A4 :: .incbin "data/m2-shifted-cursor.bin"
.org 0x8B03384 :: .incbin "data/m2-header-bg.bin"
.org 0x8B03964 :: .incbin "data/m2-header-bg-sigle-tile.bin"
.org 0x8B03D64 :: .incbin "data/m2-header-bg-sigle-tile.bin"
.org 0x8B03DE4 :: .incbin "data/m2-status-symbols.bin"

// Greek letters
.org 0x8B1B907 :: db 0x8B // alpha
.org 0x8B1B90A :: db 0x8C // beta
.org 0x8B1B90D :: db 0x8D // gamma
.org 0x8B1B910 :: db 0x8E // sigma
.org 0x8B1B913 :: db 0x8F // omega


//==============================================================================
// VWF hacks
//==============================================================================

// 32- to 16-bit access change for window flags
.org 0x80BE16A :: strh r2,[r4]
.org 0x80BE1FA :: strh r2,[r6]
.org 0x80BE222 :: strh r6,[r1]

// PSI class window size
.org    0x80B7820
mov     r1,4
mov     r2,1
mov     r3,6

//---------------------------------------------------------
// 00270 hacks (intro screen)
//---------------------------------------------------------

.org 0x800027A :: bl m12_intro_screen

//---------------------------------------------------------
// C0A5C hacks (status window)
//---------------------------------------------------------

.include "m2-status-initial.asm"
.include "m2-status-switch.asm"

//---------------------------------------------------------
// Main window hacks
//---------------------------------------------------------

.org 0x80B7D9A :: bl b7d9a_main_window_manage_input
.org 0x80B7DD2 :: bl printCashWindow
//.org 0x80B8A36 :: bl initWindow_buffer //Money window
//.org 0x80B8A3C :: bl print_window_with_buffer
.org 0x80B8890 :: bl print_window_with_buffer :: bl b8894_printCashWindowAndStore //Main window + Cash Window out of Status menu
.org 0x80B8664 :: bl print_window_with_buffer :: bl b8894_printCashWindowAndStore //Main window + Cash Window out of PSI menu
.org 0x80B8740 :: bl print_window_with_buffer :: bl b8894_printCashWindowAndStore //Main window + Cash Window out of Equip menu
.org 0x80B859C :: bl print_window_with_buffer :: bl b8894_printCashWindowAndStore //Main window + Cash Window out of Goods menu
.org 0x80B831A :: bl initWindow_buffer
.org 0x80B8320 :: bl b8320_statusWindowTextStore

//---------------------------------------------------------
// Overworld main window/PSI class window input management hacks
//---------------------------------------------------------

.org 0x80BEAA6 :: bl beaa6_fix_sounds
.org 0x80BEA88 :: bl bea88_fix_sounds

//---------------------------------------------------------
// Main battle window hacks
//---------------------------------------------------------

.org 0x80DC22A :: bl dc22a_load_buffer_battle
.org 0x80DC8C8 :: lsl r1,r0,#4 :: nop //Fixes wrong pointer
.org 0x80DC8DE :: nop :: nop //Removes useless print

//---------------------------------------------------------
// PSI battle window hacks
//---------------------------------------------------------

.org 0x80E00C8 :: bl e02c6_print_target_store
.org 0x80E02C6 :: bl e02c6_print_target_store
.org 0x80E0762 :: bl initWindow_buffer
.org 0x80E0776 :: bl print_window_with_buffer
.org 0x80E07C2 :: bl clearWindowTiles_buffer
.org 0x80E0892 :: bl initWindow_buffer
.org 0x80E08A6 :: bl print_window_with_buffer
.org 0x80E0990 :: bl initWindow_buffer
.org 0x80E0A30 :: bl initWindow_buffer
.org 0x80E0A54 :: bl print_window_with_buffer
.org 0x80C24A2 :: bl printstr_hlight_buffer
.org 0x80C24B4 :: bl printstr_hlight_buffer
.org 0x80C24CC :: bl printstr_hlight_buffer
.org 0x80C2500 :: bl printstr_hlight_buffer
.org 0x80C2518 :: bl printstr_hlight_buffer
.org 0x80E08D8 :: bl e06ec_redraw_bash_psi_goods_defend

//---------------------------------------------------------
// BAC18 hacks (status window)
//---------------------------------------------------------

.org 0x80BAC46 :: nop :: nop
.org 0x80BAC6E :: bl bac6e_statusWindowNumbersInputManagement
.org 0x80BAD7E :: bl printstr_buffer
.org 0x80BAD88 :: bl initWindow_buffer
.org 0x80BAD92 :: bl initWindow_buffer
.org 0x80BACFC :: bl bac18_redraw_status_store
.org 0x80BADE6 :: bl bac18_redraw_status
.org 0x80BACEA :: bl bacea_status_psi_window
.org 0x80BACBA :: bl print_window_with_buffer
.org 0x80BACC4 :: bl initWindow_buffer
.org 0x80BAD1A :: bl clearWindowTiles_buffer
.org 0x80BADF6 :: bl initWindow_buffer
.org 0x80BACEE :: bl bac18_clear_psi
.org 0x80BADB0 :: bl badb0_status_inner_window
.org 0x80BADCC :: b 0x80BADD8

//---------------------------------------------------------
// Normal PSI window hacks
//---------------------------------------------------------

.org 0x80B8C34 :: bl initWindow_buffer
.org 0x80B8C42 :: bl baec6_psi_window_print_buffer
.org 0x80B8C7E :: bl initWindow_buffer
.org 0x80B8C8C :: nop :: nop
.org 0x80B8CA8 :: bl initWindow_buffer
.org 0x80B8CAE :: bl print_window_with_buffer
.org 0x80B8CEA :: bl baec6_psi_window_print_buffer
.org 0x80B8D0C :: bl initWindow_buffer
.org 0x80B8D16 :: bl initWindow_buffer
.org 0x80B8D22 :: bl psiWindow_buffer
.org 0x80B8E44 :: bl initWindow_buffer
.org 0x80B8E62 :: bl baec6_psi_window_print_buffer
.org 0x80B9222 :: bl initWindow_buffer
.org 0x80B922E :: bl psiTargetWindow_buffer
.org 0x80B916E :: bl initWindow_buffer
.org 0x80B9174 :: bl print_window_with_buffer
.org 0x80B9238 :: bl initWindow_buffer
.org 0x80B9256 :: bl baec6_psi_window_print_buffer
.org 0x80BA9FA :: bl initWindow_buffer
.org 0x80BAA00 :: bl print_window_with_buffer
.org 0x80BAB64 :: bl initWindow_buffer
.org 0x80BABA6 :: bl printstr_hlight_buffer
.org 0x80BA8AC :: bl ba8ac_load_targets_print
.org 0x80B9100 :: bl initWindow_buffer
.org 0x80B910C :: bl initWindow_buffer
.org 0x80B9118 :: bl psiTargetWindow_buffer
.org 0x80B9122 :: bl initWindow_buffer
.org 0x80B9142 :: bl baec6_psi_window_print_buffer

//---------------------------------------------------------
// Teleport window hacks
//---------------------------------------------------------
.org 0x80B9030 :: bl initWindow_buffer//Opening teleport window - "Where?"
.org 0x80B9036 :: bl print_window_with_buffer
.org 0x80B9040 :: bl b9040_special_string
.org 0x80B90D4 :: bl initWindow_buffer //Going back from teleport to the PSI window
.org 0x80B90DE :: bl initWindow_buffer
.org 0x80C5D1C :: bl initWindow_buffer //Initializes the actual teleport window
.org 0x80C5EB0 :: bl printstr_hlight_buffer
.org 0x80C5F46 :: bl printstr_hlight_buffer
.org 0x80C5F80 :: bl c5f80_printstr_hlight_buffer_store_buffer // Multiple pages initial case
.org 0x80C5EB0 :: bl printstr_hlight_buffer
.org 0x80C6134 :: bl clearWindowTiles_buffer
.org 0x80C61C8 :: lsl r0,r5,#3 :: add r0,r0,r5 :: nop //Proper string address
.org 0x80C6224 :: bl printstr_hlight_buffer
.org 0x80C625E :: bl c5f80_printstr_hlight_buffer_store_buffer // Multiple pages changing pages
.org 0x80C5F04 :: bl c5f04_store_if_done //Only one page case

//---------------------------------------------------------
// Class PSI window hacks
//---------------------------------------------------------

.org 0x80BAE1C :: bl print_window_with_buffer
.org 0x80BAEC6 :: bl baec6_psi_window_print_buffer
.org 0x80BAED4 :: bl baec6_psi_window_print_buffer
.org 0x80BAEE2 :: bl baec6_psi_window_print_buffer
.org 0x80BAEF0 :: bl baec6_psi_window_print_buffer

//---------------------------------------------------------
// Equip window generic hacks
//---------------------------------------------------------

.org 0x80BB02C :: bl innerEquipInput
.org 0x80B8066 :: bl printstr_hlight_buffer
.org 0x80B8074 :: mov r3,#0x12
.org 0x80B80A2 :: mov r1,#3 :: mov r2,#0xB :: mov r3,#0xD
.org 0x80B8092 :: bl initWindow_buffer //Initialize equipment window
.org 0x80B8098 :: bl print_window_with_buffer
.org 0x80B80BE :: bl initWindow_buffer
.org 0x80B80C4 :: bl printEquipWindowNumberText
.org 0x80B80EA :: mov r2,#0x37 :: mov r3,#3 :: bl printNumberEquip //Offense Number
.org 0x80B8112 :: mov r2,#0x37 :: mov r3,#0x13 :: bl printNumberEquip //Defense Number
.org 0x80B8138 :: bl initWindow_buffer
.org 0x80B813E :: bl print_window_with_buffer
.org 0x80B814A :: bl equipPrint
.org 0x80B8152 :: bl innerEquipInput
.org 0x80B81A2 :: bl initWindow_buffer
.org 0x80B81A8 :: bl print_window_with_buffer
.org 0x80B81BC :: bl equipPrint
.org 0x80B81CC :: bl print_equip_base_numbers
.org 0x80BAF96 :: bl initWindow_buffer //Go to inner window from outer window
.org 0x80BAF9C :: bl baf9c_print_window_store_buffer
.org 0x80BAFE6 :: mov r2,#0x37 :: mov r3,#3 :: bl printNumberEquip //Offense Number
.org 0x80BB00C :: mov r2,#0x37
.org 0x80BB17C :: bl equippableReadInput
.org 0x80BB198 :: bl printEquipNumbersArrow :: bl store_pixels_overworld :: b 0x80BB1AE //Offense Number
.org 0x80BB1A6 :: mov r2,#0x4C :: mov r3,#0x13 :: bl bb1aa_printnumberequip_store //Defense Number
.org 0x80BB05E :: bl initWindow_buffer
.org 0x80BB066 :: bl print_window_with_buffer
.org 0x80BB08A :: nop :: nop //Remove highlighting
.org 0x80BB0A8 :: bl initWindow_buffer
.org 0x80BB24C :: bl initWindow_buffer //Go back to outer window - Also does going back to inner (not innermost) window from weapons - not touched equipment
.org 0x80BB254 :: bl print_window_with_buffer
.org 0x80BB2C2 :: bl initWindow_buffer
.org 0x80BB2CA :: bl print_window_with_buffer
.org 0x80BB2E0 :: bl initWindow_buffer
.org 0x80BB2E8 :: bl print_window_with_buffer
.org 0x80BB2F6 :: bl equipPrint
.org 0x80BB300 :: bl innerEquipInput
.org 0x80BB33C :: mov r2,#0x37 :: mov r3,#3 :: bl printNumberEquip
.org 0x80BB36C :: mov r2,#0x37 :: mov r3,#0x13 :: bl printNumberEquip
.org 0x80BB3FC :: bl initWindow_buffer //Go back to inner (not innermost) window from weapons - removed equipment
.org 0x80BB404 :: bl print_window_with_buffer
.org 0x80BB41A :: bl initWindow_buffer
.org 0x80BB422 :: bl print_window_with_buffer
.org 0x80BB430 :: bl equipPrint
.org 0x80BB43A :: bl innerEquipInput
.org 0x80BB476 :: mov r2,#0x37 :: mov r3,#3 :: bl printNumberEquip
.org 0x80BB4A6 :: mov r2,#0x37 :: mov r3,#0x13 :: bl printNumberEquip
.org 0x80BB532 :: bl initWindow_buffer //Go back to inner (not innermost) window from weapons - equipped a weapon
.org 0x80BB53A :: bl print_window_with_buffer
.org 0x80BB550 :: bl initWindow_buffer
.org 0x80BB558 :: bl print_window_with_buffer
.org 0x80BB566 :: bl equipPrint
.org 0x80BB570 :: bl innerEquipInput
.org 0x80BB5AC :: mov r2,#0x37 :: mov r3,#3 :: bl printNumberEquip
.org 0x80BB5DC :: mov r2,#0x37 :: mov r3,#0x13 :: bl printNumberEquip
.org 0x80BB9E4 :: bl initWindow_buffer //Go back to inner (not innermost) window from defensive equipment - not touched equipment
.org 0x80BB9EC :: bl print_window_with_buffer
.org 0x80BBA02 :: bl initWindow_buffer
.org 0x80BBA0A :: bl print_window_with_buffer
.org 0x80BBA18 :: bl equipPrint
.org 0x80BBA22 :: bl innerEquipInput
.org 0x80BBA5E :: mov r2,#0x37 :: mov r3,#3 :: bl printNumberEquip
.org 0x80BBA8E :: mov r2,#0x37 :: mov r3,#0x13 :: bl printNumberEquip
.org 0x80BBB2C :: bl initWindow_buffer //Go back to inner (not innermost) window from defensive equipment - removed equipment
.org 0x80BBB34 :: bl print_window_with_buffer
.org 0x80BBB4A :: bl initWindow_buffer
.org 0x80BBB52 :: bl print_window_with_buffer
.org 0x80BBB60 :: bl equipPrint
.org 0x80BBB6A :: bl innerEquipInput
.org 0x80BBBA6 :: mov r2,#0x37 :: mov r3,#3 :: bl printNumberEquip
.org 0x80BBBD6 :: mov r2,#0x37 :: mov r3,#0x13 :: bl printNumberEquip
.org 0x80BBC8A :: bl initWindow_buffer //Go back to inner (not innermost) window from defensive equipment - equipped something
.org 0x80BBC92 :: bl print_window_with_buffer
.org 0x80BBCA8 :: bl initWindow_buffer
.org 0x80BBCB0 :: bl print_window_with_buffer
.org 0x80BBCBE :: bl equipPrint
.org 0x80BBCC8 :: bl innerEquipInput
.org 0x80BBD04 :: mov r2,#0x37 :: mov r3,#3 :: bl printNumberEquip
.org 0x80BBD34 :: mov r2,#0x37 :: mov r3,#0x13 :: bl printNumberEquip
//When first entering the innermost menu
.org 0x80BB6E0 :: mov r2,#0x54 :: mov r3,#3 :: bl printNumberEquip //Change second offense number's position - Weapon
.org 0x80BB710 :: mov r2,#0x54 :: mov r3,#0x13 :: bl bb1aa_printnumberequip_store //Change second defense number's position - Weapon
.org 0x80BB820 :: mov r2,#0x54 :: mov r3,#0x13 :: bl printNumberEquip //Change second defense number's position - Body
.org 0x80BB950 :: mov r2,#0x54 :: mov r3,#0x13 :: bl printNumberEquip //Change second defense number's position - Arms
.org 0x80BBE8E :: mov r2,#0x54 :: mov r3,#0x13 :: bl printNumberEquip //Change second defense number's position - Other
.org 0x80BBEBE :: mov r2,#0x54 :: mov r3,#3 :: bl bb1aa_printnumberequip_store //Change second offense number's position - Other
//When changing selection in the innermost menu
.org 0x80BBDF0 :: mov r2,#0x54 :: mov r3,#0x13 :: bl printNumberEquip //Change second defense number's position - Defensive Equipment
.org 0x80BBE20 :: mov r2,#0x54 :: mov r3,#3 :: bl bb1aa_printnumberequip_store //Change second offense number's position - Defensive Equipment

//---------------------------------------------------------
// Target dialogue window hacks
//---------------------------------------------------------

.org 0x80BD496 :: bl ba8ac_load_targets_print

//---------------------------------------------------------
// Goods window hacks
//---------------------------------------------------------

.org 0x80B7F4E :: bl c5f80_printstr_hlight_buffer_store_buffer //Prints the balance window
.org 0x80B7F72 :: bl initWindow_cursor_buffer //Sets up the goods window
.org 0x80B97A8 :: bl initWindow_buffer //Prints "Who?" going into the window
.org 0x80B97AE :: bl baf9c_print_window_store_buffer_top
.org 0x80B992A :: bl initWindow_buffer //Prints "Who?" coming from the inner window
.org 0x80B9930 :: bl baf9c_print_window_store_buffer_top
.org 0x80B986E :: bl initWindow_buffer
.org 0x80B98B8 :: bl b98b8_print_window_store_buffer_needed //Prints "Which?" going into the window
.org 0x80B99A0 :: bl highlight_string //Highlight chosen item
.org 0x80B9A4C :: bl baf9c_print_window_store_buffer_needed //Prints "Use\nDrop\n,etc." going into the window
.org 0x80B9ADE :: bl initWindow_buffer
.org 0x80BA688 :: bl baf9c_print_window_store_buffer_top //Prints "Use\nDrop\n,etc." going out of the give window
.org 0x80BA340 :: bl initWindow_buffer //Prints "Who?" going into the window
.org 0x80BA346 :: bl print_window_with_buffer
.org 0x80BA37A :: bl initWindow_buffer //initiates the Give window
.org 0x80BA7FA :: bl initWindow_buffer //initiates the inventory window out of help
.org 0x80BA810 :: bl initWindow_buffer //initiates the options window out of help

//---------------------------------------------------------
// Goods window hacks - Stored Goods
//---------------------------------------------------------

//Choose inventory
.org 0x80BCDB4 :: bl initWindow_buffer
//First enter window - More than one page
.org 0x80C63BC :: bl initWindow_buffer
.org 0x80C63CC :: bl printstr_hlight_buffer //->Stored Goods(X)
.org 0x80C6412 :: bl printstr_hlight_buffer //Left part of the inventory
.org 0x80C643E :: bl printstr_hlight_buffer //Right part of the inventory
//First enter window - Only one page
.org 0x80C6492 :: bl initWindow_buffer
.org 0x80C64DA :: bl printstr_hlight_buffer //Left part of the inventory
.org 0x80C6518 :: bl printstr_hlight_buffer //Right part of the inventory
.org 0x80C694A :: bl clearWindowTiles_buffer
//When pressing arrow to switch page
.org 0x80C69D8 :: mov r0,#0x12 //Proper address to "->Stored Goods(3)" string
.org 0x80C69EE :: bl printstr_hlight_buffer //->Stored Goods(X)
.org 0x80C6A6C :: bl printstr_hlight_buffer //Left part of the inventory
.org 0x80C6AA4 :: bl printstr_hlight_buffer //Right part of the inventory
.org 0x80C6AC0 :: bl c6ac0_store_buffer_stored_goods_switch_page

//---------------------------------------------------------
// Goods window hacks - in battle
//---------------------------------------------------------

.org 0x80E05C0 :: lsl r1,r0,#4 :: nop //Fixes wrong pointer
.org 0x80E05D8 :: nop :: nop //Removes useless print
.org 0x80E0C46 :: bl initWindow_cursor_buffer //initiates the goods window in battle
.org 0x80E0CE4 :: bl e0ce4_redraw_battle_window_first_four //Reprints the background window for the target choosing items
.org 0x80E0D1E :: bl printstr_hlight_buffer //Prints the chosen item
.org 0x80E0EFA :: bl initWindow_buffer :: ldr r0,[r4,#0xC] :: bl print_window_with_buffer //Out of ally target window
.org 0x80E0FAA :: bl e0faa_redraw_battle_window_first_two

//---------------------------------------------------------
// BAEF8 hacks (equip window)
//---------------------------------------------------------

// Erase offense change
.macro erase_offense_buffer
    mov     r0,0xC
    mov     r1,0xB
    mov     r2,4
    bl      bb21c_print_blankstr_buffer
.endmacro

.macro erase_defense_buffer
    mov     r0,0xC
    mov     r1,0xD
    mov     r2,4
    bl      bb21c_print_blankstr_buffer
.endmacro

.macro erase_defense_buffer_store
    mov     r0,0xC
    mov     r1,0xD
    mov     r2,4
    bl      bb21c_print_blankstr_buffer_store
.endmacro

.org 0x80BB216 :: erase_offense_buffer
.org 0x80BB38C :: erase_offense_buffer
.org 0x80BB4C6 :: erase_offense_buffer
.org 0x80BB5FC :: erase_offense_buffer
.org 0x80BBAAE :: erase_offense_buffer
.org 0x80BBBF6 :: erase_offense_buffer
.org 0x80BBD54 :: erase_offense_buffer

// Erase defense change
.org 0x80BB226 :: erase_defense_buffer
.org 0x80BBABE :: erase_defense_buffer_store
.org 0x80BBC06 :: erase_defense_buffer_store
.org 0x80BBD64 :: erase_defense_buffer_store

// Erase offense/defense after changing equipment
.org 0x80BB3E2 :: bl baef8_reequip_erase
.org 0x80BB518 :: bl baef8_reequip_erase
.org 0x80BBB12 :: bl baef8_reequip_erase
.org 0x80BBC70 :: bl baef8_reequip_erase

//---------------------------------------------------------
// C5500 hacks (equip window switching)
//---------------------------------------------------------

// Don't draw equip icon
.org 0x80C5A1A :: nop
.org 0x80C5A28 :: nop

// Draw equipment window header
.org 0x80C55CE :: b 0x80C55F8
.org    0x80C55F8
mov     r4,r0
mov     r0,r9
mov     r1,#0x10 //Tiles to clear
mov     r2,#0x10 //x
mov     r3,#0x11 //y
bl      clear_window_header
mov     r0,r4
mov     r1,r6 // tilemap
mov     r2,r9 // vram
mov     r3,r7 // window
bl      print_equip_header
mov     r6,r0
b       0x80C5726

//---------------------------------------------------------
// C1FBC hacks (PSI window)
//---------------------------------------------------------

.org 0x80C203E :: mov r1,0x14 // new PSI name entry length
.org 0x80C2096 :: mov r1,0x14
.org 0x80C21B4 :: mov r1,0x14
.org 0x80C224A :: mov r1,0x14
.org 0x80C229E :: mov r1,0x14

// Draw PSI Rockin
.org    0x80C2192
mov     r2,r8
str     r2,[sp]
mov     r2,0xFE
lsl     r2,r2,1
add     r0,r6,r2
mov     r1,0x71
mov     r2,8
bl      print_string

//---------------------------------------------------------
// C239C hacks (print PSI name)
//---------------------------------------------------------

.org 0x80C23AA :: lsr r2,r2,0xD                             // tiles-to-pixels
.org 0x80C23AE :: lsr r6,r3,0xD                             // tiles-to-pixels
.org 0x80C23CE :: bl c239c_print_psi :: nop :: nop :: nop
.org 0x80C23DA :: add r4,17                                 // pixel width of "PSI "
.org 0x80C23F0 :: bl printstr_hlight_pixels_buffer             // print rockin'
.org 0x80C2402 :: mov r0,3 :: lsl r0,r0,0x10                // pixel width of space
.org 0x80C242E :: mov r0,0x14                               // new PSI name entry length
.org    0x80C2448
bl      printstr_hlight_pixels_buffer // print PSI name
mov     r2,r1                      // record X width
add     r2,3                       // add a space
.org 0x80C2468 :: bl printstr_hlight_pixels_buffer

//---------------------------------------------------------
// PSI target window hacks
//---------------------------------------------------------

// PSI target length hack
.org 0x80B8B12 :: mov r0,0x14
.org 0x80C24EE :: mov r1,0x14

// Fix PSI target offset calculation
.org 0x80B8B08
mov     r1,100
mul     r1,r2
nop
nop

// Make PP cost use correct number values
.org    0x80CA732
add     r1,0x60

// Make PP cost use the correct space value if there's only one digit
.org    0x80CA712
mov     r0,0x50

//---------------------------------------------------------
// C438C hacks (Inner PSI window input management + target window printing + header printing)
//---------------------------------------------------------

.org 0x80C495A :: bl c495a_status_target

//---------------------------------------------------------
// B8BBC hacks (PSI window)
//---------------------------------------------------------

//Do not redraw unless it is needed
.org 0x80B8CD2 :: bl b8cd2_psi_window

//Fix multiple sounds issue when going inside the psi window
.org 0x80B8D40 :: bl b8d40_psi_going_inner_window

//Sets up for the target window
.org 0x80B8DB4 :: bl b8db4_psi_inner_window

// Redraw main menu when exiting PSI target window
.org 0x80B8E3A :: bl b8bbc_redraw_menu_2to1

// Redraw main menu when entering PSI target window
.org 0x80B8CF8 :: bl b8bbc_redraw_menu_13to2 // 1 to 2
.org 0x80B920C :: bl b8bbc_redraw_menu_13to2_store // 3 to 2

//---------------------------------------------------------
// E06EC hacks (PSI window in battle)
//---------------------------------------------------------

//Sets up for the target window
.org 0x80E0854 :: bl e0854_psi_inner_window_battle

//Do not redraw unless it is needed
.org 0x80E079A :: bl e079a_battle_psi_window

//---------------------------------------------------------
// C4B2C hacks (Equip window render)
//---------------------------------------------------------

// Start equipment at the 6th tile instead of 5th
.org 0x80C4C96 :: mov r2,6 // Weapon
.org 0x80C4D1C :: mov r2,6 // Body
.org 0x80C4DA4 :: mov r2,6 // Arms
.org 0x80C4E2C :: mov r2,6 // Other

// Only render (None) if necessary
.org    0x80C4C0C
bl      c4b2c_skip_nones
b       0x80C4C58

// Don't render equip symbols
.org 0x80C4CD0 :: nop
.org 0x80C4CDE :: nop
.org 0x80C4D58 :: nop
.org 0x80C4D66 :: nop
.org 0x80C4DE0 :: nop
.org 0x80C4DEE :: nop
.org 0x80C4E68 :: nop
.org 0x80C4E76 :: nop

//---------------------------------------------------------
// C4B2C hacks (Equip window loop)
//---------------------------------------------------------

.org 0x80C4F80 :: bl c4b2c_clear_left
.org 0x80C4F84 :: bl c4b2c_clear_right

//---------------------------------------------------------
// C980C hacks (main character printing)
//---------------------------------------------------------

// Reset pixel X during scroll
.org 0x80C9858 :: bl c980c_resetx_newline
.org 0x80C9BF0 :: bl c980c_resetx_scroll
.org 0x80C9D18 :: bl c980c_resetx_newline
.org 0x80CA336 :: bl c980c_resetx_newline

// Reset pixel X during a newline
.org    0x80C9CC4
bl      c980c_resetx_newline

// Other reset X
.org 0x80C9D62 :: bl c980c_resetx_other
.org 0x80C9D76 :: bl c980c_resetx_other2
.org 0x80C9EEC :: bl c980c_resetx_other3
.org 0x80C9F34 :: bl c980c_resetx_other3
.org 0x80CA204 :: bl c980c_resetx_other4
.org 0x80CA274 :: bl c980c_resetx_other4
.org 0x80CA30E :: bl c980c_resetx_newline

// Disable newline if the text overflows
//.org 0x80CA2FA :: nop

// Custom codes check
.org    0x80CA2BC
bl      c980c_custom_codes

// Reset pixel X when redrawing the window
.org    0x80CA2E6
bl      c980c_resetx

// Welding entry
.org    0x80CA448
bl      c980c_weld_entry
b       0x80CA46C

// Disable X coordinate incrementing
.org    0x80CA48E
nop

// Saturn text welding entry
.org    0x80CA39A
bl      weld_entry_saturn

//---------------------------------------------------------
// C8FFC hacks (main string printing)
//---------------------------------------------------------

// Custom codes check
.org    0x80C90A2
bl      c8ffc_custom_codes

// Welding entry
.org    0x80C9114
bl      c8ffc_weld_entry
b       0x80C9144

// Integer-to-char changes
.org 0x80CA67C :: mov r3,0x50 // space
.org 0x80CA69C :: mov r2,0x60 // zero
.org 0x80CA6DC :: mov r2,0x69 // nine
.org 0x80CA78A :: mov r0,0x60 // zero
.org 0x80CA7AC :: mov r2,0x69 // nine
.org 0x80CA7EC :: sub r1,0xA0

//---------------------------------------------------------
// C87D0 hacks (draw blank window)
//---------------------------------------------------------

.org    0x80C87DC
bl      c87d0_clear_entry

//---------------------------------------------------------
// C9634 hacks (string printing)
//---------------------------------------------------------

.org    0x80C967E
bl      c9634_resetx

//---------------------------------------------------------
// C96F0 hacks (string printing with highlight)
//---------------------------------------------------------

.org    0x80C9714
lsl     r3,r3,1 // change from row coords to tile coords
ldrh    r1,[r0,0x22]
add     r1,r1,r2
lsl     r1,r1,3 // r1 = tile_x * 8
ldrh    r2,[r0,0x24]
add     r2,r2,r3
lsl     r2,r2,3 // r2 = tile_y * 8
mov     r0,r6
bl      print_string
lsl     r0,r0,16
lsr     r7,r0,16
b       0x80C9788

//---------------------------------------------------------
// CA4BC hacks (scroll text)
//---------------------------------------------------------

.org 0x80CA55E :: bl ca4bc_erase_tile_short
.org 0x80CA60E :: bl ca4bc_copy_tile_up
.org 0x80CA626 :: bl ca4bc_erase_tile

//---------------------------------------------------------
// CAB90 hacks (print window header string)
//---------------------------------------------------------

.org    0x80CAB90
push    {lr}
lsl     r2,r2,3
lsl     r3,r3,3 // tiles to pixels
bl      print_window_header_string
add     r0,7
lsr     r0,r0,3 // pixels to tiles
pop     {pc}

//---------------------------------------------------------
// Change checkerboard printing to properly handle statuses
//---------------------------------------------------------

.org 0x80D68C2 :: bl dead_name
.org 0x80D6960 :: bl sick_name
.org 0x80D6A8A :: bl alive_name
.org 0x80D6B5E :: bl dead_name
.org 0x80D6BFA :: bl sick_name
.org 0x80D6DAC :: bl d6dac_alive_name

.org m2_stat_symb_checker :: .incbin "data/m2-status-symbols-checkerboard.bin"

//---------------------------------------------------------
// CABF8 hacks (print checkerboard string)
//---------------------------------------------------------

.org 0x80CABF8 :: push {r4-r7,lr}
.org    0x80CAC0A
mov     r6,1
mov     r7,0
add     sp,-4
b       @@print_checkerboard_check

@@print_checkerboard_skip:
add     r4,1

@@print_checkerboard_loop:
ldrb    r0,[r4]
sub     r0,0x50
mov     r1,r5
add     r2,r6,1
mov     r3,6
str     r3,[sp]
mov     r3,3
bl      print_character_to_ram
add     r6,r0,r6
add     r7,1
add     r4,1

@@print_checkerboard_check:
ldrb    r0,[r4,1]
cmp     r0,0xFF
bne     @@print_checkerboard_loop
ldrb    r0,[r4]
cmp     r0,0
bne     @@print_checkerboard_skip

add     r0,r6,7
lsr     r0,r0,3 // number of tiles used
add     sp,4
pop     {r4-r7,pc}

//---------------------------------------------------------
// D2E94 hacks (print party character name)
//---------------------------------------------------------

.org    0x80D2F24
mov     r1,r6
mov     r2,r7
mov     r0,r4
bl      weld_entry
b       0x80D2F52

// Disable X increment
.org 0x80D2F5A :: nop

// Saturn weld entry
.org    0x80D2F1A
bl      weld_entry_saturn

//---------------------------------------------------------
// D2FA0 hacks (print item)
//---------------------------------------------------------

.org    0x80D3044
mov     r0,r4
mov     r1,r6
bl      weld_entry
b       0x80D3072

// Disable X increment
.org 0x80D307A :: nop

// Saturn weld entry
.org    0x80D301A
bl      weld_entry_saturn

//---------------------------------------------------------
// D30C4 hacks (print number)
//---------------------------------------------------------

.org    0x80D314A
mov     r0,r5
mov     r1,r7
bl      weld_entry
b       0x80D3178

// Disable X increment
.org 0x80D3180 :: nop

//---------------------------------------------------------
// D31F8 hacks (print money balance)
//---------------------------------------------------------

.org 0x80D327E
ldrb    r0,[r7]
bl      decode_character
mov     r1,r5
bl      print_character_to_window
b       0x80D32AC

.org 0x80D32B2 :: b 0x80D32B8

//---------------------------------------------------------
// D332C hacks (print name)
//---------------------------------------------------------

.org    0x80D34E8
mov     r0,r5
mov     r1,r4
bl      weld_entry
b       0x80D3514

// Disable X increment
.org 0x80D351A :: nop

// Don't print [1E 20] after the name if there are multiple people
.org 0x80D3418 :: b 0x80D348C

//---------------------------------------------------------
// D3560 hacks (print money balance)
//---------------------------------------------------------

.org 0x80D35BA
bl      decode_character
mov     r1,r5
bl      print_character_to_window
b       0x80D35EA

//---------------------------------------------------------
// D3934 hacks (print PSI name)
//---------------------------------------------------------

.org 0x80D39BA :: mov r0,0x14 // PSI name length

// Weld entry
.org    0x80D39E2
mov     r0,r4
mov     r1,r5
bl      weld_entry
b       0x80D3A14

// Print a space before the Greek letter
.org 0x80D39D4 :: bl d3934_print_space

// Battle command hacks
.org 0x8B1F4C8 :: db 0x11 // Extend command window width two tiles (Normal)
.org 0x8B1F4CC :: db 0x16 // Extend command window width two tiles (Paula paralyzed leader)
.org 0x80D7A56 :: mov r1,4 // Move PSI class window left one tile
.org 0x80D7A5A :: mov r3,6 // Extend PSI class window width one tile
.org 0x80DC038 :: add r5,0x30 // String address calculation
.org 0x80DC0A8 :: add r1,0x60 // String address calculation

.org 0x80DC27C :: lsl r1,r2,4 :: nop // String address calculation
.org 0x80DC2AC :: lsl r1,r2,4 :: nop // String address calculation

.org 0x80DCC36 :: mov r2,2 // "to X" position
.org 0x80DCCE0 :: mov r2,2 // "to the Front Row" position

.org 0x80E079E :: bl e06ec_clear_window
.org 0x80E0888 :: bl e06ec_redraw_psi
.org 0x80E0A16 :: bl e06ec_redraw_bash_psi

//---------------------------------------------------------
// Equipment number printing in dialogue window
//---------------------------------------------------------

.org 0x80D37EC :: bl d37ec_print_number :: b 0x80D381C //Offense
.org 0x80D36D0 :: bl d37ec_print_number :: b 0x80D3700 //Defense

//---------------------------------------------------------
// Remove continuous printing of outer equip window and also
// remove continuous printing of Offense and Defense numbers
// in both outer and innermost equipment windows
//---------------------------------------------------------

.org 0x80C518E :: bl c518e_outer_equip
.org 0x80BAF60 :: bl baf60_outer_equip_setup
.org 0x80BAFC8 :: bl bafc8_outer_equip_attack_defense
.org 0x80BB26E :: bl bb990_inner_equip_attack_defense_setup //Weapon
.org 0x80BB730 :: bl bb990_inner_equip_attack_defense_setup //Body
.org 0x80BB860 :: bl bb990_inner_equip_attack_defense_setup //Arms
.org 0x80BB990 :: bl bb990_inner_equip_attack_defense_setup //Other
.org 0x80BB6B2 :: bl bb6b2_inner_equip_attack_defense_weapon
.org 0x80BB64E :: bl bb64e_inner_equip_attack_defense_none_weapon
.org 0x80BB80E :: bl bbe7c_inner_equip_attack_defense_defensive_equipment //Body Offense/Defense printing
.org 0x80BB93E :: bl bbe7c_inner_equip_attack_defense_defensive_equipment //Arms Offense/Defense printing
.org 0x80BBE7C :: bl bbe7c_inner_equip_attack_defense_defensive_equipment //Other Offense/Defense printing
.org 0x80BBDDE :: bl bbe7c_inner_equip_attack_defense_defensive_equipment //Defensive equipment Offense/Defense none printing

//---------------------------------------------------------
// B89EC hacks (print current cash balance)
//---------------------------------------------------------

.org 0x80B8A06
mov     r2,r1
mov     r1,0x30 // right-align to 48 pixels
bl      format_cash_window
b       0x80B8A2E

.org 0x80B785C :: mov r0,0xC // allocate 2 extra bytes for cash window string
.org 0x80B786C :: mov r3,6   // make window 1 fewer tiles wide

//---------------------------------------------------------
// B8A60 hacks (print current cash balance, called from script. Since the script is already executing,
// this version cannot use m2_printnextch, so it requires an edited version of m2_printstr_hlight which recognizes 5F FF)
//---------------------------------------------------------

.org 0x80B8A80
ldr     r2,[r5,#0]
mov     r1,0x30 // right-align to 48 pixels
bl      format_cash_window
b       0x80B8AAA

.org 0x80B8AC0 :: bl printstr_hlight_edited

//---------------------------------------------------------
// [68 FF] - clear window
//---------------------------------------------------------

.org m2_clearwindowtiles
push    {r4,lr}
mov     r4,r0

// Clear out the pixel data
bl      clear_window

// Reset the X/Y printing coordinates
mov     r0,0
strh    r0,[r4,0x2A]
strh    r0,[r4,0x2C]
pop     {r4,pc}

//---------------------------------------------------------
// B96B8 hacks (Selected item action menu)
//---------------------------------------------------------

.org 0x80B998E :: bl b998e_get_itemstring_x

//---------------------------------------------------------
// BD918 hacks (battle setup)
//---------------------------------------------------------

// Longest enemy name is 24 letters + 2 for the end code, for 26 total
// We might have "The " later on, so make that 30
// " and its cohorts" makes that 46
// Let's round it to a nice 64: we need to allocate that many bytes for user
// and target strings on the heap. The game only allocates 16 each.
// Goal: allocate an extra 128 bytes and fix all the offsets to the user/target
// strings. We'll store the user string at +0x4C0 and the target string at +0x500.
.org 0x80BD97A :: mov r0,0xA8 // malloc an extra 128 bytes for longer user/target strings

// Fix user/target pointers
.org 0x80C9942 :: bl c980c_user_pointer
.org 0x80C9954 :: bl c980c_target_pointer
.org 0x80EBFDC :: bl ebfd4_user_pointer :: b 0x80EBFFA
.org 0x80EC004 :: push {lr} :: bl ec004_user_pointer
.org 0x80EC018 :: bl ec010_target_pointer :: b 0x80EC038
.org 0x80EC046 :: push {lr} :: bl ec046_target_pointer

// Length fixes
.org 0x80DAE02 :: add sp,-0x40
.org 0x80DAE08 :: mov r2,0x3E
.org 0x80DAE38 :: mov r2,0x3A
.org 0x80DAEA2 :: mov r1,0x3E
.org 0x80DAEDE :: add sp,0x40

.org 0x80DB04E :: add sp,-0x40
.org 0x80DB058 :: mov r2,0x3E
.org 0x80DB08C :: mov r2,0x3A
.org 0x80DB116 :: mov r1,0x3E
.org 0x80DB15A :: add sp,0x40

.org 0x80DCD02 :: add sp,-0x40
.org 0x80DCD0C :: mov r2,0x3C
.org 0x80DCD64 :: mov r2,0x3A
.org 0x80DCDA2 :: mov r1,0x3E
.org 0x80DCDA8 :: add sp,0x40

// Add a space between enemy name and letter
.org 0x80DCD94 :: bl dcd00_enemy_letter
.org 0x80DCD9A :: strb r0,[r5,2]
.org 0x80DCD9E :: strb r0,[r5,3]

.org 0x80DAE7E :: bl dae00_enemy_letter
.org 0x80DAE84 :: strb r0,[r4,2]
.org 0x80DAE88 :: strb r0,[r4,3]

.org 0x80DB0CE :: bl dae00_enemy_letter
.org 0x80DB0D2 :: strb r5,[r4,2]
.org 0x80DB0D6 :: strb r0,[r4,3]

// "The" flag checks
.org 0x80DB084 :: bl db04c_theflag :: nop :: nop
.org 0x80DB110 :: bl dae9c_king_0_the
.org 0x80DB156 :: bl db156_party_0_the //Not needed anymore, but is a good measure
.org 0x80DAE30 :: bl db04c_theflag :: nop :: nop
.org 0x80DAE9C :: bl dae9c_king_0_the
.org 0x80DAEDA :: bl daeda_party_0_the //Not needed anymore, but is a good measure
.org 0x80EC93C :: bl ec93c_party_0_the //Leveling up - Not needed anymore, but is a good measure
.org 0x80DCD5C :: bl dcd5c_theflag :: nop :: nop
.org 0x80DB08E :: bl db08e_theflagflag
.org 0x80DAE3A :: bl db08e_theflagflag
.org 0x80DCD66 :: bl db08e_theflagflag
.org 0x80C9C58 :: bl c9c58_9f_ad_minThe
.org 0x80C9C84 :: bl c9c58_9f_ad_minThe
.org 0x80CA442 :: bl ca442_store_letter

// Ignore the hard-coded Japanese "and cohorts"
.org 0x80DB0E6 :: b 0x80DB0FE

// Update musical note value (for Ness' Nightmare)
.org 0x80DAF12 :: cmp r0,0xAC

//---------------------------------------------------------
// Name setup hacks (improves the "The" fix and makes it portable)
//---------------------------------------------------------
.org 0x80020AE :: bl copy_name_perm_mem
.org 0x80020BE :: bl copy_name_perm_mem
.org 0x80020CE :: bl copy_name_perm_mem
.org 0x80020DE :: bl copy_name_perm_mem
.org 0x80020EE :: bl copy_name_perm_mem
.org 0x80020FE :: bl copy_name_perm_mem
.org 0x800210E :: bl copy_name_perm_mem
.org 0x800215A :: bl _215a_load_names

//---------------------------------------------------------
// BEB6C hacks (Goods inner menu)
//---------------------------------------------------------

.org 0x80BEB6C
push    {lr}
bl      goods_inner_process
pop     {pc}

//---------------------------------------------------------
// BF858 hacks (Goods outer menu)
//---------------------------------------------------------

.org 0x80BF858
push    {lr}
mov     r1,0
mov     r2,0
bl      goods_outer_process
pop     {pc}

//---------------------------------------------------------
// C0420 hacks (Goods outer menu for Tracy)
//---------------------------------------------------------

.org 0x80C0420
push    {lr}
mov     r1,1
mov     r2,0
bl      goods_outer_process
pop     {pc}

//---------------------------------------------------------
// C7CA4 hacks (Shop)
//---------------------------------------------------------
.org 0x80C7EA2
bl      c7ea2_shop_clear //Clear the dialogue window when exiting a shop window - Pressing B

.org 0x80C7ECE
bl      c7ea2_shop_clear //Clear the dialogue window when exiting a shop window - Pressing L or A

.org 0x80C7C90
bl      clearWindowTiles_buffer //Setup the buffer

.org 0x80C7CA4
mov     r0,r8 //Window
ldr     r1,[sp,#0xC] //Items in shop
mov     r2,#0 //y_offset | r3 already has the item total for this window
bl      shop_print_items //Print the items
b       0x80C7E12 //Avoid the game's printing by jumping it

//---------------------------------------------------------
// BFE74 hacks (Goods outer menu for Give)
//---------------------------------------------------------
.org 0x80BFE74
push    {lr}
mov     r1,#1
mov     r2,#1
bl      goods_outer_process
pop     {pc}

//---------------------------------------------------------
// BA61C hacks (Fixes inventory when out of Give via B button)
//---------------------------------------------------------
.org 0x80BA61C
bl ba61c_get_print_inventory_window

//---------------------------------------------------------
// B9ECC hacks (Fixes inventory when out of selecting a party member to give food to via B button)
//---------------------------------------------------------
.org 0x80B9ECC
bl b9ecc_get_print_inventory_window

//---------------------------------------------------------
// BA48E hacks (Fixes inventory when out of Give via text)
//---------------------------------------------------------
.org 0x80BA48E
bl ba48e_get_print_inventory_window

//---------------------------------------------------------
// B9F96 hacks (Fixes main window after consuming an item)
//---------------------------------------------------------
.org 0x80B9F96
bl _reprint_first_menu

//---------------------------------------------------------
// B9CF8 hacks (Fixes main window after an item prints a dialogue)
//---------------------------------------------------------
.org 0x80B9CF8
bl _reprint_first_menu

//---------------------------------------------------------
// B9C88 hacks (Fixes main window after an equippable item prints a dialogue)
//---------------------------------------------------------
.org 0x80B9C88
bl _reprint_first_menu

//---------------------------------------------------------
// BA52C hacks (Fixes main window after giving an item)
//---------------------------------------------------------
.org 0x80BA52C
bl _reprint_first_menu

//---------------------------------------------------------
// BA44E hacks (Fixes main window after not being able to give an item)
//---------------------------------------------------------
.org 0x80BA44E
bl _reprint_first_menu

//---------------------------------------------------------
// BA7BE hacks (Fixes main window after calling the help function)
//---------------------------------------------------------
.org 0x80BA7BE
bl ba7be_reprint_first_menu

//---------------------------------------------------------
// B9AA2 hacks (Fixes main window after exiting the item action window)
//---------------------------------------------------------
.org 0x80B9AA2
bl b9aa2_reprint_first_menu

//---------------------------------------------------------
// BCEB0 hacks (Fixes main window after exiting the pickup menu)
//---------------------------------------------------------
.org 0x80BCEB0
bl _reprint_first_menu

//---------------------------------------------------------
// C1C98 hacks (menu selection)
//---------------------------------------------------------

// Print the selection menu string
.org 0x80C1CA6
ldr     r7,=0x3005270
ldr     r6,=0x30051EC
ldr     r5,=0x3005228
bl      print_menu_string
ldr     r0,=0x3002500
mov     r10,r0
b       0x80C1D20
.pool

.org 0x80C8EFC
ldrh    r1,[r5,0x2C]
mov     r0,0
ldrh    r2,[r5,0x26]
mov     r3,r5
bl      print_blankstr_window
b       0x80C8FE8

//---------------------------------------------------------
// BCF00 hacks (number selection menu)
//---------------------------------------------------------

// Skip printing the first four columns of blank tiles
.org 0x80BCF88 :: nop
.org 0x80BCF98 :: nop
.org 0x80BCFA4 :: nop
.org 0x80BCFAE :: nop
.org 0x80BCFBA :: nop
.org 0x80BCFC6 :: nop
.org 0x80BCFD0 :: nop
.org 0x80BCFD8 :: nop

// Print dollar sign, zeroes, and 00 symbol
.org 0x80BCFDE
ldr     r1,=0x3005238
ldr     r0,[r1]          // Get window pointer
mov     r1,r9
bl      print_number_menu
b       0x80BD084
.pool

// Clear number selector row
.org 0x80BD096
// [r4 + 8] = window
ldr     r0,[r4,8]
bl      clear_number_menu
b       0x80BD122

// Clear border tiles

//---------------------------------------------------------
// C9444 hacks (print number selection menu)
//---------------------------------------------------------

// Print the proper character
.org 0x80C956C
push    {r2}
// r0 = digit, r6 = window
mov     r1,r6
bl      print_number_menu_current
pop     {r2}
ldr     r3,=0x3005228
ldr     r4,=0x30051EC
ldrh    r3,[r3]
b       0x080C959A
.pool

//---------------------------------------------------------
// EEB1A (load player name)
//---------------------------------------------------------

.org 0x80EEB1A
bl      eeb1a_player_name //Call the new routine
b       0x80EEB7A //Do the rest of the original routine

//Remove subtract from player name printing
.org 0x80EEB94 :: mov r2,r3

//---------------------------------------------------------
// End of battle hacks
//---------------------------------------------------------

.org 0x80cb936
bl      cb936_battle_won //Removes the game's ability to read the script instantly out of a won battle

.org 0x80a1f8c
bl      a1f8c_set_script_reading //Change the game's ability to read the script instantly a bit

.org 0x80b7702
bl      b7702_check_script_reading //Change the newly set value slowly and make it 0 when it's safe

//---------------------------------------------------------
// Teleport window hacks
//---------------------------------------------------------

// Note that the teleport table pointer has 6 instances in the ROM,
// but we are only changing two of them in m12-teleport-names.json.
// This is because the other four pointers are used for accessing
// the teleport flag/coord data in the table instead of the text.
// We need a couple hacks to make this work...

.org 0x80C5E8A :: ldr r7,[pc,0xC8]  // This is used for text; load from one of the
                                    // pointers that we DID change (previously it
                                    // loaded from a pointer that we didn't change)

.org 0x80C5D8A
lsl     r1,r0,4                     // Text entries are now 16 bytes each, so multiply by 16
ldr     r7,[pc,0x1C4]               // ... to make room for loading r7 with the text pointer
add     r1,r1,r7
ldrb    r0,[r1]
ldr     r7,[pc,0x13C]               // The game uses r7 as the data pointer when looping back,
                                    // so let's sneak the data pointer in here before it loops

.org 0x80C5E96
lsl     r0,r1,4
nop
nop

.org 0x80C5F2C
lsl     r0,r1,4
nop
nop

.org 0x80C620C
lsl     r0,r1,4
nop
nop

//---------------------------------------------------------
// Teleport header fix
//---------------------------------------------------------
.org 0x80C5DE0 :: bl c65da_clean_print //To:
.org 0x80C5E30 :: bl c6190_clean_print //Number on first entering the menu
.org 0x80C6190 :: bl c6190_buffer_number //Number on page change
.org 0x80C5E04 :: nop :: strh r0,[r4,#0] :: add r4,#2 :: nop ::nop //Remove extra tile

//---------------------------------------------------------
// Stored Goods header fix
//---------------------------------------------------------
.org 0x80C656C :: mov r2,#0x10 :: mov r3,#0x11 :: bl c6570_clean_print_change_pos :: b 0x80C65C0 //Changes position and cleans tiles for Stored Goods
.org 0x80C65DA :: bl c65da_clean_print //Number on first entering the menu
.org 0x80C6996 :: bl c65da_clean_print //Number on page change

//---------------------------------------------------------
// Call header fix
//---------------------------------------------------------
.org 0x80BD26A :: bl c6190_clean_print //Call:

//---------------------------------------------------------
// Fix windows printing too many tiles due to not going off of pixels, but off of characters
//---------------------------------------------------------
.org 0x80C0B28 :: bl c0b28_fix_char_tiles //Status window
.org 0x80C009E :: bl c009e_fix_char_tiles //Give window
.org 0x80C4BD6 :: bl c4bd6_fix_char_tiles //Equip window
.org 0x80C42E0 :: bl c42e0_fix_char_tiles //Outer PSI window
.org 0x80C3FD8 :: bl c42e0_fix_char_tiles //Inner PSI window
.org 0x80C4448 :: bl c4448_fix_char_tiles //Inner PSI window - part 2
.org 0x80DBF36 :: bl c009e_fix_char_tiles //Battle menu window

//---------------------------------------------------------
// Proper dollar and 00 symbols for [9C FF]
//---------------------------------------------------------
.org 0x80B8AA0 :: mov r0,#0x54 //Dollar
.org 0x80B8AA6 :: mov r0,#0x56 //00

//---------------------------------------------------------
// wvf_skip hacks
//---------------------------------------------------------
.org 0x80B8C2A :: bl b8c2a_set_proper_wvf_skip_and_window_type //Fixes bug of M2GBA
.org 0x80BE45A :: bl be45a_set_proper_wvf_skip
.org 0x80BE4CA :: bl be4ca_set_proper_wvf_skip_goods_battle_window

//---------------------------------------------------------
// PSI Rockin in battle text
//---------------------------------------------------------
.org 0x80D3984 :: cmp r0,#3 //Now "PSI " is 4 letters long, not 2
.org 0x80D399E :: sub r0,#4 //Subtract from r0 the length of "PSI "

//---------------------------------------------------------
// Flyover hacks
//---------------------------------------------------------

//Notes
//Flyover entries are made of 8-bit codes with arguments.
//Codes with the first byte between 0 and 9 are special cases.
//00    = End
//01 XX = Position at X tile XX (Changed to Position at X pixel XX)
//02 XX = Position at Y tile XX
//08 XX = Print PC name (for this hack, use 80 FC-FF instead)
//09    = line break
//80 XX = Print character XX

//Flyover pointer remapping
.org 0x873112c :: dw flyovertextYear //The year is 199x
.org 0x8731130 :: dw flyovertextOnett //Onett, a small town in eagleland
.org 0x8731134 :: dw flyovertextNess //Ness's House
.org 0x8731138 :: dw flyovertextWinters //Winters, a small country to the north
.org 0x873113C :: dw flyovertextSnow //Snow Wood Boarding House
.org 0x8731140 :: dw flyovertextDalaam //Dalaam, in the Far East
.org 0x8731144 :: dw flyovertextPoo //The palace of Poo\nThe Crown Prince
.org 0x8731148 :: dw flyovertextLater //Later that night...

.org 0x80B3A80 :: dw flyover_tea
.org 0x80B3AA4 :: dw flyover_coffee

//Change line size to 0x20 pixels
//.org 0x80B3ABA :: add r0,#0x20
//.org 0x80B3B0C :: mov r1,#0x3F :: and r0,r1 :: nop
//.org 0x80B4162 :: bl flyover_scroll_routine :: b 0x80B41B0
//.org 0x80B3B44 :: dw 0x85000900


//Flyover remapping
.org 0x80B3482 :: bl largevwf :: b 0x80B348E

//Flyover remapping
.org 0x80B3B5E :: bl wrapper_largevwf_tea :: b 0x80B3A18

// Weld the odd-numbered flyover letters
.org 0x80B3254 :: bl flyoverweld :: nop

// Make it so the entire possible tileset is used
.org 0x80AE568 :: mov r0,#8
.org 0x80AE56E :: mov r0,#7
.org 0x80AE57A :: mov r1,#0x80 //Start at 0x100 instead of 0x120

// Change the [01 XX] flyover code to pixels from left of screen
.org 0x80B332C :: b 0x80B3334

// Alter the flyover palette so the borders don't show (orig 0x739C)
.org 0x80FCE50 :: .byte 0x00,0x00

//Insert the font
.org 0x80B3274 :: dw m2_font_big

//Print all 16 rows
.org 0x80B3262 :: cmp r7,0xF

//Print all 16 columns
.org 0x80B325C :: cmp r6,7

//---------------------------------------------------------
// Names hacks
//---------------------------------------------------------
//Change location of the names to allow 5-letter long characters and 6 letters long food, rockin and king
//Direct reference change
.org 0x80C98F8 :: dw m2_paula_name
.org 0x80C9908 :: dw m2_jeff_name
.org 0x80C9918 :: dw m2_poo_name
.org 0x80C9928 :: dw m2_food
.org 0x80C9938 :: dw m2_rockin
.org 0x80C9BC0 :: dw m2_king_name //Control Code for printing its name
.org 0x80DB134 :: dw m2_king_name //Action user related
.org 0x80DAEB8 :: dw m2_king_name //Action target related
.org 0x80133E8 :: dw m2_king_name //Cast Roll
.org 0x80C2368 :: dw m2_rockin
.org 0x80C2424 :: dw m2_rockin
.org 0x80C24E0 :: dw m2_rockin
.org 0x80D39AC :: dw m2_rockin

//Change the way the characters' names are called. Instead of number * 6, it's now number * 7
.org 0x80D6A72 :: lsl r1,r4,#3 :: sub r1,r1,r4 :: nop
.org 0x80D6948 :: lsl r1,r4,#3 :: sub r1,r1,r4 :: nop
.org 0x80D28B8 :: lsl r0,r6,#3 :: sub r0,r0,r6 :: nop
.org 0x80C4BC4 :: lsl r1,r0,#3 :: sub r1,r1,r0 :: nop
.org 0x80DB14A :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80DAECE :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80D336C :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80D339C :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80D33C4 :: lsl r1,r0,#3 :: sub r1,r1,r0 :: nop
.org 0x80D2EE2 :: lsl r1,r0,#3 :: sub r1,r1,r0 :: nop
.org 0x80BAB8A :: lsl r1,r5,#3 :: sub r1,r1,r5 :: nop
.org 0x80D6D96 :: lsl r1,r2,#3 :: sub r1,r1,r2 :: nop
.org 0x80D7096 :: lsl r1,r2,#3 :: sub r1,r1,r2 :: nop
.org 0x80EC92C :: lsl r0,r2,#3 :: sub r0,r0,r2 :: nop
.org 0x80B9C00 :: lsl r0,r2,#3 :: sub r0,r0,r2 :: nop
.org 0x80D68AA :: lsl r1,r4,#3 :: sub r1,r1,r4 :: nop
.org 0x80D6BE0 :: lsl r1,r4,#3 :: sub r1,r1,r4 :: nop
.org 0x80B9FAC :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80B93F0 :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80B9FE6 :: lsl r0,r7,#3 :: sub r0,r0,r7 :: nop
.org 0x80B932C :: lsl r1,r0,#3 :: sub r0,r1,r0 :: nop
.org 0x80C0B14 :: lsl r1,r0,#3 :: sub r1,r1,r0 :: nop
.org 0x80C008C :: lsl r1,r0,#3 :: sub r1,r1,r0 :: nop
.org 0x80C42CE :: lsl r1,r0,#3 :: sub r1,r1,r0 :: nop
.org 0x8013652 :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80B9CB2 :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80BA086 :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80C97C0 :: lsl r4,r1,#3 :: sub r4,r4,r1 :: nop
.org 0x80B9316 :: lsl r0,r1,#3 :: sub r0,r0,r1 :: nop
.org 0x80D6B44 :: lsl r1,r4,#3 :: sub r1,r1,r4 :: nop
.org 0x80D6E3A :: lsl r1,r4,#3 :: sub r1,r1,r4 :: nop
.org 0x80D6ED0 :: lsl r1,r4,#3 :: sub r1,r1,r4 :: nop
.org 0x80C3FC6 :: lsl r1,r0,#3 :: sub r1,r1,r0 :: nop
.org 0x80C4436 :: lsl r1,r0,#3 :: sub r1,r1,r0 :: nop

//Change the way the characters' names are called. Instead of number * 6, it's now number * 7. These ones already received an lsl of 1 beforehand.
.org 0x80C0AC8 :: lsl r1,r1,#2 :: sub r1,r1,r5
.org 0x80C4B84 :: lsl r1,r1,#2 :: sub r1,r1,r5
.org 0x80C3F88 :: lsl r1,r1,#2 :: sub r1,r1,r5
.org 0x80C43FC :: lsl r1,r1,#2 :: sub r1,r1,r3
.org 0x80C0040 :: lsl r1,r1,#2 :: sub r1,r1,r3
.org 0x80C4296 :: lsl r1,r1,#2 :: sub r1,r1,r3
.org 0x80DBEFA :: lsl r2,r2,#2 :: sub r2,r2,r4
.org 0x80BEFCA :: lsl r1,r1,#2 :: sub r1,r1,r3
.org 0x80BFA3A :: lsl r1,r1,#2 :: sub r1,r1,r4

.org 0x80BD9AA :: add r0,r5,#7
.org 0x80BD9BA :: mov r1,#0xE
.org 0x80BD9CC :: add r6,#0x15

//Load proper addresses
.org 0x80C98C4 :: bl c98c4_load_1d7
.org 0x80C98CC :: mov r4,#0xEF
.org 0x80C98D4 :: bl c98d4_load_1e5

//Name writing
.org 0x80020B6 :: bl _2352_load_1d7
.org 0x80020C6 :: mov r0,#0xEF
.org 0x80020D6 :: bl _2372_load_1e5
.org 0x80020E8 :: add r0,#0xC0
.org 0x80020F8 :: add r0,#0x80
.org 0x8002108 :: add r0,#0x40

.org 0x80020AC :: mov r0,#5
.org 0x80020BC :: mov r0,#5
.org 0x80020CC :: mov r0,#5
.org 0x80020DC :: mov r0,#5

//Name loading
.org 0x8002214 :: bl _2352_load_1d7
.org 0x8002224 :: mov r0,#0xEF
.org 0x8002234 :: bl _2372_load_1e5
.org 0x8002246 :: mov r0,#0xF6
.org 0x8002258 :: mov r0,#0xFA
.org 0x800226A :: mov r0,#0xFE

.org 0x800220A :: mov r0,#5
.org 0x800221A :: mov r0,#5
.org 0x800222A :: mov r0,#5
.org 0x800223A :: mov r0,#5

//Name Reset change
.org 0x8002352 :: bl _2352_load_1d7
.org 0x8002362 :: mov r0,#0xEF
.org 0x8002372 :: bl _2372_load_1e5
.org 0x8002384 :: add r0,#0xC0
.org 0x8002394 :: add r0,#0x80
.org 0x80023A4 :: add r0,#0x40

.org 0x8002348 :: mov r0,#5
.org 0x8002358 :: mov r0,#5
.org 0x8002368 :: mov r0,#5
.org 0x8002378 :: mov r0,#5

//Change the maximum name size
.org 0x80DB154 :: mov r1,#7
.org 0x80DAED8 :: mov r1,#7
.org 0x80B9FB6 :: mov r1,#7
.org 0x80B9C0A :: mov r1,#7
.org 0x80B9320 :: mov r1,#7
.org 0x80B9CBC :: mov r1,#7
.org 0x80B9FF2 :: mov r1,#7
.org 0x80B93FA :: mov r1,#7
.org 0x80B9334 :: mov r1,#7
.org 0x80D28C6 :: mov r1,#7
.org 0x80BA090 :: mov r1,#7
.org 0x80EC93A :: mov r1,#7

.org 0x80B9FEE :: sub r1,#7

.org 0x80121DC :: cmp r2,#4
.org 0x8013672 :: cmp r5,#4
.org 0x80C0B0A :: cmp r2,#4 //Status window header
.org 0x80C4BBC :: cmp r2,#4 //Equip window header
.org 0x80C42C6 :: cmp r2,#4 //Outer PSI window header
.org 0x80C3FBE :: cmp r2,#4 //Inner PSI window header
.org 0x80C442E :: cmp r2,#4 //Inner PSI window - part 2 header
.org 0x80C0082 :: cmp r5,#4 //Give window header
.org 0x80DBF28 :: cmp r0,#4 //Battle menu window header
.org 0x80C97E2 :: cmp r1,#6
.org 0x80DAF3A :: cmp r0,#6
.org 0x80D33BC :: cmp r2,#6

//Default options auto-setup routine.
.org 0x80CB2F2 :: bl cb2f2_hardcoded_defaults :: b 0x80CB434

//Remove japanese name's storing and loading
.org 0x80C7524 :: nop
.org 0x80C752C :: nop
.org 0x80C76A2 :: mov r5,#0xFF
.org 0x80C76D0 :: mov r5,#0xFF
.org 0x80C76EA :: nop
.org 0x80C76F2 :: nop
.org 0x80C76FA :: nop
.org 0x80C7864 :: nop
.org 0x80C786C :: nop
.org 0x80C79C0 :: nop
.org 0x80D3AAE :: mov r0,#0xFF

//Select File name length
.org 0x8001F22 :: cmp r4,#4
.org 0x8001F3A :: cmp r4,#4

//Naming screen name length
.org 0x8004F54 :: mov r2,#5 //Ness
.org 0x8004F78 :: mov r0,#5 :: str r0,[sp,#0x18] :: bl _4f7c_window_selector //Paula
.org 0x8004F9C :: mov r0,#5 //Jeff
.org 0x8004FC0 :: mov r1,#5 //Poo

//Black bar hacks - Need to replace the position windows point at and move the >
//.org 0x80BD9DE :: mov r2,#0x16 //Ness
//.org 0x80BD9EA :: mov r2,#0x1B //Paula
//.org 0x80BD9F6 :: mov r2,#0x16 //Jeff
//.org 0x80BDA02 :: mov r2,#0x1B //Poo


//---------------------------------------------------------
// Movement code hacks
//---------------------------------------------------------
// Censor the spanking sound in Pokey's house
.org 0x8027BCB :: db 70 // Add 30 extra frames before the sound plays
.org 0x8027BD1 :: dh 84 // Replace sound effect

// Carpainter's timing fix
.org 0x802A75F :: db 0x30 //Add 8 extra frames before the game can start reading again.

//==============================================================================
// File select hacks
//==============================================================================

// Main file select window resize
.org 0x82B79BC :: dw 0x1C       // new window width
.org 0x8003998 :: mov r0,1      // new window x
.org 0x8003F92 :: mov r0,1
.org 0x80053DC :: mov r0,1
.org 0x8003A04 :: bl _3a04_highlight_file //Changes window position and makes sure the file is properly highlighted
.org 0x8003B40 :: mov r0,0x10   // new cursor x
.org 0x86DB070 :: .incbin "data/m2-fileselect-template.bin"

.org 0x86D9808
.incbin "data/m2-fileselect-tileset.bin"

// Formatting
.org 0x80021E8 :: bl format_file_string
.org 0x8002284 :: bl format_file_string

//Load the pixels in fileselect_pixels_location
.org 0x80038C0 :: bl _38c0_load_pixels

// Printing
.org 0x80038CC :: mov r2,0x40 :: bl wrapper_first_file_string
.org 0x80038DE :: mov r2,0x40 :: bl wrapper_first_file_string
.org 0x80038F2 :: mov r2,0x40 :: bl wrapper_first_file_string :: bl _38f8_store_pixels

// Bump file select cursor up by 3 pixels - Not needed now that the text is 3 pixels lower
//.org 0x8003844 :: add r0,r5,1

// File select options
.org 0x8003F78 :: bl _3f78_highlight_file //Keeps highlight consistent when changing palette in the text flavour window
.org 0x8004072 :: bl _40e2_cursor_X //Removing highlight position
.org 0x8004080 :: mov r3,#4 //Remove highlight of 4 tiles maximum
.org 0x8004092 :: bl _4092_print_window_store //Printing + storing pixels
.org 0x80040E2 :: bl _40e2_cursor_X //Highlight position
.org 0x80040F4 :: mov r3,#4 //Print highlight of 4 tiles maximum
.org 0x80041D4 :: bl _41d4_cursor_X //New cursor's X

//Text Speed options
.org 0x8003BBC :: bl _4092_print_window_store //Printing + storing pixels
.org 0x8003C44 :: mov r3,#4 //Make highlighting the same speed for all text speeds
.org 0x8003FA2 :: bl _4092_print_window
.org 0x8003F8C :: mov r3,#4 //Print highlight of 4 tiles maximum
.org 0x8003E86 :: bl _3e86_special_setup //Avoid printing when not necessary
.org 0x8003EF2 :: bl _3e86_special_setup //Avoid printing when not necessary
.org 0x82B79D0 :: dw 0x10 //new window width
.org 0x86DB0FC :: .incbin "data/m2-textspeed-template.bin"

//Text Flavour options
.org 0x8003D8A :: bl _4092_print_window_store //Printing + storing pixels
.org 0x8003D86 :: mov r1,#4 //new window Y
.org 0x8003DB6 :: mov r1,#4
.org 0x8003E0C :: mov r1,#4
.org 0x8003E8C :: mov r1,#4
.org 0x8003EF8 :: mov r1,#4
.org 0x80053F2 :: mov r1,#4
.org 0x82B79E4 :: dw 0xF //new window width
.org 0x82B79E8 :: dw 0x10 //new window height
.org 0x8003DCE :: bl _3dce_fix_out_of_text_flavour
.org 0x86DB1F8 :: .incbin "data/m2-flavour-template.bin"

//Delete
.org 0x8004410 :: mov r1,#3 :: mov r2,#0x15 :: bl wrapper_delete_string
.org 0x800441E :: bl _4092_print_window_store //Printing + storing pixels
.org 0x82B7AFC :: dw 0x15 //new window width
.org 0x86DBE8C :: .incbin "data/m2-delete-template.bin"

//Copy
.org 0x8004294 :: bl _4294_print_window_store //Printing - 1 slot available
.org 0x80042BA :: bl _4092_print_window_store //Printing + storing pixels
.org 0x8004268 :: mov r2,#0x2 :: bl wrapper_copy_string

//Descriptions and Names
.org 0x80053F6 :: bl _53f6_fix_out_of_description
.org 0x8004ED2 :: bl wrapper_name_string //Printing names
.org 0x8004EDC :: bl _4edc_print_window_store //Printing + storing pixels
.org 0x86DB2B8 :: .incbin "data/m2-descriptions-template.bin"
.org 0x82B7A00 :: dw 0x86DB2B8 //Point all the descriptions + names to the same template
.org 0x82B7A14 :: dw 0x86DB2B8
.org 0x82B7A28 :: dw 0x86DB2B8
.org 0x82B7A3C :: dw 0x86DB2B8
.org 0x82B7A50 :: dw 0x86DB2B8
.org 0x82B7A64 :: dw 0x86DB2B8

//Alphabets
.org 0x80051A4 :: bl _4092_print_window_store //Printing + storing pixels - CAPITAL
.org 0x8004EA2 :: bl _4092_print_window_store //Printing + storing pixels - small
.org 0x82B7A8C :: dw 0x86DB5C4
.org 0x86DB5C4 :: .incbin "data/m2-alphabet-template.bin"
.org 0x8005222 :: bl setupCursorAction
.org 0x8005382 :: bl setupCursorMovement
.org 0x800538A :: bl setupCursorPosition //Cursor position
.org 0x800536C :: bl setupCursorPosition //Cursor position
.org 0x82B8FFC :: .incbin "data/m2-alphabet-table.bin"
.org 0x8002322 :: bl _2322_setup_windowing

//Summary
.org 0x80054F2 :: mov r2,#5 :: bl wrapper_name_summary_string //Printing Ness' name
.org 0x8005502 :: mov r2,#5 :: bl wrapper_name_summary_string //Printing Paula's name
.org 0x8005512 :: mov r2,#5 :: bl wrapper_name_summary_string //Printing Jeff's name
.org 0x8005522 :: mov r2,#5 :: bl wrapper_name_summary_string //Printing Poo's name
.org 0x800555C :: nop :: nop //Sends to a bunch of 0xFF
.org 0x800556A :: nop :: nop //Sends to a bunch of 0xFF
.org 0x8005530 :: mov r0,#0x11 //New x for King's name
.org 0x8005536 :: bl wrapper_name_summary_string //Printing King's name
.org 0x8005578 :: bl wrapper_count_pixels_to_tiles :: mov r2,#6 :: mov r4,#0x17 :: sub r0,r4,r0 //Count length of Food's name in tiles
.org 0x8005588 :: bl wrapper_name_summary_string //Printing Food's name
.org 0x8005596 :: bl wrapper_count_pixels_to_tiles :: mov r2,#6 :: sub r4,r4,r0 //Count length of Thing's name in tiles
.org 0x80055A6 :: bl wrapper_name_summary_string //Printing Thing's name
.org 0x80055B0 :: bl _4092_print_window_store //Printing + storing pixels
.org 0x80056F0 :: add r0,#0x90 //New cursor's X
.org 0x86DBC6C :: .incbin "data/m2-summary-template.bin"

//==============================================================================
// Overworld player name alphabet
//==============================================================================

//"Register your name" in buffer
.org 0x80C6C54 :: bl printstr_buffer

//BLANK name in buffer
.org 0x80C6C7A :: bl printstr_buffer

//First time entering the menu's alphabet
.org 0x80C6D72 :: bl initWindow_buffer :: ldr r0,[r5,#0x10] :: bl c6d78_print_slphabet_store

//Player name printing - character is added
.org 0x80C75B4 :: bl c75b4_overworld_naming_top_printing :: b 0x80C777A

//Player name printing - character is deleted via b button
.org 0x80C780E :: bl c780e_overworld_naming_top_printing :: b 0x80C789A

//Player name printing - character is deleted via backspace
.org 0x80C74CC :: bl c74cc_overworld_naming_top_printing :: b 0x80C755A

//Player name printing - menu is re-entered after the name has been inserted once
.org 0x80C6CC6 :: bl c6cc6_overworld_naming_top_printing :: b 0x80C6D5E

//Player name alphabet - cursor movement
.org 0x80C6F24 :: bl c6f24_overworld_alphabet_movement :: b 0x80C7340

//Alphabet - switching support - removal of unused alphabet
.org 0x80C7380 :: nop :: nop :: nop :: mov r0,r9 :: cmp r0,#0 :: beq 0x80C741A :: nop :: nop :: cmp r0,#1

//Print CAPITAL alphabet only if needed
.org 0x80C7394 :: bl c7394_CAPITAL_overworld_alphabet :: b 0x80C73B8

//Print small alphabet
.org 0x80C73B8 :: nop :: mov r0,r9 :: cmp r0,#2

//Print small alphabet only if needed
.org 0x80C73C0 :: bl c73c0_small_overworld_alphabet :: b 0x80C73E2

//Choose character table based on alphabet loaded in
.org 0x80C7578 :: bl c7578_load_letters


//==============================================================================
// Bug fixes for the original game
//==============================================================================

// Disallow warping with an Exit mouse in the Cave of the Past
.org 0x8731046 :: dh 00h


//==============================================================================
// Fix Gyigas' poison bug
//==============================================================================
.org 0x80DEE6C :: bl dee6c_fix_poison_gyigas :: nop :: nop :: nop

//==============================================================================
// Credits hacks
//==============================================================================

//Repoint credits font (Before it pointed to 0x82FF1B8)
.org 0x82DB284 :: dw m2_credits_font
.org 0x82DB28C :: dw m2_credits_arrangements
.org 0x82DB2A4 :: .incbin "data/m2-credits-size.bin"
.org 0x80B53BC :: .incbin "data/m2-credits-scroll-size-limit.bin"
.org 0x80B53C0 :: .incbin "data/m2-credits-scroll-size.bin"
.org 0x801352E :: bl printPlayerNameCredits

//Repoint cast graphical data
.org m2_cast_roll_pointers :: dw m2_cast_graphics :: dw m2_cast_palette :: dw m2_cast_arrangements

//Remove flavour changing the palette
.org 0x8010426 :: bl prevent_cast_changed_palettes

//Cast Roll VWF
.org 0x800F640 :: bl writeCastText

//Master Belch and Star Master text appearing later
.org 0x8018934 :: dw m2_cast_belch_arrangement
.org 0x80188B2 :: .incbin "data/cast_roll_master_belch_size.bin"
.org 0x82D92BC :: .incbin "data/cast_roll_master_belch_data.bin"
.org 0x8018940 :: dw m2_cast_star_arrangement
.org 0x8018904 :: .incbin "data/cast_roll_star_master_size.bin"
.org 0x82D92C4 :: .incbin "data/cast_roll_star_master_data.bin"

//==============================================================================
// "THE END...?" hacks
//==============================================================================
.org 0x88B5AA0 :: .incbin "data/the_end_graphics.bin"
.org 0x88B62A0 :: .incbin "data/the_end_palette.bin"
.org 0x88B62C0 :: .incbin "data/the_end_arrangements_frame0.bin"

//Add an extra event for the "?" in "THE END..."
.org 0x80A5F5C :: bl extra_event_end_question_mark

//==============================================================================
// Move stuff around in order to make space for the code
//==============================================================================

.org 0x82D92D4 :: dw moved_graphics_table :: dw moved_graphics_table + 0x1CD2C
.org 0x82D9BBC :: dw moved_graphics_table + 0x26618 :: dw moved_graphics_table + 0x3F818

//==============================================================================
// Lumine Hall hacks
//==============================================================================

.org 0x800ECB2 :: bl writeLumineHallText

//==============================================================================
// Cartridge choosing screen hacks
//==============================================================================

.org 0x8013C62 :: bl change_palette_needed_foreground
.org 0x8013CAA :: bl change_palette_needed_background

.org 0x86DD794 :: .incbin "data/m2-cartridge-tiles.bin"
.org 0x8706994 :: .incbin "data/m2-cartridge-arrangements.bin"

.org 0x8705794

m12_cartridge_palettes:
.incbin "data/m2-cartridge-palettes.bin"

//==============================================================================
// Data files
//==============================================================================

.org m2_default_names
.incbin "data/m2-default-names.bin"

.org 0x8B1BA88

m2_overworld_alphabet_table:
.incbin "data/m2-overworld-alphabet-table.bin"

.org 0x8B2C000

//This table MUST be 4-bytes padded
moved_graphics_table:
.incbin "data/moved-graphics-table.bin"

// Box font relocation
m2_font_relocate:
.incbin "data/m2-font-relocate.bin"

// Co-ordinate table
m2_coord_table:
.incbin "data/m2-coord-table.bin"

// Co-ordinate table, version which has 5 bits used for how many consecutive tiles there are after each tile
m2_coord_table_fast_progression:
.incbin "data/m2-coord-table-fast-progression.bin"

// EB fonts
m2_font_table:
dw      m2_font_main
dw      m2_font_saturn
dw      m2_font_big
dw      m2_font_battle
dw      m2_font_tiny

m2_font_main:
.incbin "data/m2-font-main.bin"
m2_font_saturn:
.incbin "data/m2-font-saturn.bin"
m2_font_big:
.incbin "data/bigfont.bin"
m2_font_battle:
.incbin "data/m2-font-battle.bin"
m2_font_tiny:
.incbin "data/m2-font-tiny.bin"

// EB font dimensions
m2_font_widths:
db      2, 2, 2, 1, 1
.align 4

m2_font_heights:
db      2, 2, 2, 2, 1
.align 4

// EB font widths
m2_widths_table:
dw      m2_widths_main
dw      m2_widths_saturn
dw      m2_widths_big
dw      m2_widths_battle
dw      m2_widths_tiny

m2_widths_main:
.incbin "data/m2-widths-main.bin"
m2_widths_saturn:
.incbin "data/m2-widths-saturn.bin"
m2_widths_big:
.incbin "data/largewidths.bin"
m2_widths_battle:
.incbin "data/m2-widths-battle.bin"
m2_widths_tiny:
.incbin "data/m2-widths-tiny.bin"

.align 4
m2_bits_to_nybbles:
.incbin "data/m2-bits-to-nybbles.bin"

m2_bits_to_nybbles_fast:
.incbin "data/m2-bits-to-nybbles-fast.bin"

m2_bits_to_nybbles_fast_cast:
.incbin "data/m2-bits-to-nybbles-fast-cast.bin"

m2_nybbles_to_bits:
.incbin "data/m2-nybbles-to-bits.bin"

m2_enemy_attributes:
.incbin "data/m2-enemy-attributes.bin"

cast_vwf_names:
.include "data/cast-vwf-names.asm"

.align 2
luminesquaretable:
.incbin "data/luminesquaretable.bin"

luminetext:
.include "data/lumine-text.asm"

flyovertextYear:
.include "data/flyover-text-year.asm"

flyovertextOnett:
.include "data/flyover-text-onett.asm"

flyovertextNess:
.include "data/flyover-text-ness.asm"

flyovertextWinters:
.include "data/flyover-text-winters.asm"

flyovertextSnow:
.include "data/flyover-text-snow.asm"

flyovertextDalaam:
.include "data/flyover-text-dalaam.asm"

flyovertextPoo:
.include "data/flyover-text-poo.asm"

flyovertextLater:
.include "data/flyover-text-later.asm"

flyover_tea:
.include "data/flyover-tea.asm"

flyover_coffee:
.include "data/flyover-coffee.asm"

give_self:
.include "m12-give-strings/m12-give-self-alive.asm"

give_self_dead:
.include "m12-give-strings/m12-give-self-dead.asm"

give_alive:
.include "m12-give-strings/m12-give-both-alive.asm"

give_giver_dead:
.include "m12-give-strings/m12-give-giver-dead.asm"

give_target_dead:
.include "m12-give-strings/m12-give-target-dead.asm"

give_dead:
.include "m12-give-strings/m12-give-both-dead.asm"

give_alive_full:
.include "m12-give-strings/m12-give-both-alive-full.asm"

give_giver_dead_full:
.include "m12-give-strings/m12-give-giver-dead-full.asm"

give_target_dead_full:
.include "m12-give-strings/m12-give-target-dead-full.asm"

give_dead_full:
.include "m12-give-strings/m12-give-both-dead-full.asm"

.align 4
give_strings_table:
dw      give_self
dw      give_self_dead
dw      give_alive
dw      give_giver_dead
dw      give_target_dead
dw      give_dead
dw      give_alive_full
dw      give_giver_dead_full
dw      give_target_dead_full
dw      give_dead_full

.align 4
m2InsaneCultist:
.incbin "data/m2-insane-cultist.bin"

.align 2
m2_coord_table_file:
.incbin "data/m2-coord-table-file-select.bin"

.align 2
m2_credits_conversion_table:
.incbin "data/m2-credits-conversion-table.bin"

.align 4
m2_cast_belch_arrangement:
.incbin "data/cast_roll_master_belch_arrangement.bin"

.align 4
m2_cast_star_arrangement:
.incbin "data/cast_roll_star_master_arrangement.bin"

.align 2
m2_cast_vwf_free:
.incbin "data/cast_roll_first_free.bin"

.align 4
m2_cast_graphics:
.incbin "data/cast_roll_graphics_[c].bin"

.align 4
m2_cast_palette:
.incbin "data/cast_roll_palette_[c].bin"

.align 4
m2_cast_arrangements:
.incbin "data/cast_roll_arrangements_[c].bin"

.align 4
m2_credits_font:
.incbin "data/m2-credits-font_[c].bin"

.align 4
m2_credits_arrangements:
.incbin "data/m2-credits-arrangements_[c].bin"

.align 2
m2_credits_extras:
.incbin "data/m2-credits-extra-data.bin"

.align 4
m2_end_frame1:
.incbin "data/the_end_arrangements_frame1.bin"

.align 4
optimized_byte_4bpp_to_1bpp_table:
.incbin "data/optimized-byte-4bpp-to-1bpp-table.bin"

m12_cartridge_palettes_dimmed:
.incbin "data/m12-cartridge-palettes-dimmed.bin"

.org 0x08D00000
.area 8FEE000h-.
m2_chs_font_table:
//start at A1
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0
dw      0

dw      m2_chs_font_b0
dw      m2_chs_font_b1
dw      m2_chs_font_b2
dw      m2_chs_font_b3
dw      m2_chs_font_b4
dw      m2_chs_font_b5
dw      m2_chs_font_b6
dw      m2_chs_font_b7
dw      m2_chs_font_b8
dw      m2_chs_font_b9
dw      m2_chs_font_ba
dw      m2_chs_font_bb
dw      m2_chs_font_bc
dw      m2_chs_font_bd
dw      m2_chs_font_be
dw      m2_chs_font_bf
dw      m2_chs_font_c0
dw      m2_chs_font_c1
dw      m2_chs_font_c2
dw      m2_chs_font_c3
dw      m2_chs_font_c4
dw      m2_chs_font_c5
dw      m2_chs_font_c6
dw      m2_chs_font_c7
dw      m2_chs_font_c8
dw      m2_chs_font_c9
dw      m2_chs_font_ca
dw      m2_chs_font_cb
dw      m2_chs_font_cc
dw      m2_chs_font_cd
dw      m2_chs_font_ce
dw      m2_chs_font_cf
dw      m2_chs_font_d0
dw      m2_chs_font_d1
dw      m2_chs_font_d2
dw      m2_chs_font_d3
dw      m2_chs_font_d4
dw      m2_chs_font_d5
dw      m2_chs_font_d6
dw      m2_chs_font_d7
dw      m2_chs_font_d8
dw      m2_chs_font_d9
dw      m2_chs_font_da
dw      m2_chs_font_db
dw      m2_chs_font_dc
dw      m2_chs_font_dd
dw      m2_chs_font_de
dw      m2_chs_font_df
dw      m2_chs_font_e0
dw      m2_chs_font_e1
dw      m2_chs_font_e2
dw      m2_chs_font_e3
dw      m2_chs_font_e4
dw      m2_chs_font_e5
dw      m2_chs_font_e6
dw      m2_chs_font_e7
m2_chs_font_b0:
.incbin "data/m2_chs_font_b0.bin"
m2_chs_font_b1:
.incbin "data/m2_chs_font_b1.bin"
m2_chs_font_b2:
.incbin "data/m2_chs_font_b2.bin"
m2_chs_font_b3:
.incbin "data/m2_chs_font_b3.bin"
m2_chs_font_b4:
.incbin "data/m2_chs_font_b4.bin"
m2_chs_font_b5:
.incbin "data/m2_chs_font_b5.bin"
m2_chs_font_b6:
.incbin "data/m2_chs_font_b6.bin"
m2_chs_font_b7:
.incbin "data/m2_chs_font_b7.bin"
m2_chs_font_b8:
.incbin "data/m2_chs_font_b8.bin"
m2_chs_font_b9:
.incbin "data/m2_chs_font_b9.bin"
m2_chs_font_ba:
.incbin "data/m2_chs_font_ba.bin"
m2_chs_font_bb:
.incbin "data/m2_chs_font_bb.bin"
m2_chs_font_bc:
.incbin "data/m2_chs_font_bc.bin"
m2_chs_font_bd:
.incbin "data/m2_chs_font_bd.bin"
m2_chs_font_be:
.incbin "data/m2_chs_font_be.bin"
m2_chs_font_bf:
.incbin "data/m2_chs_font_bf.bin"
m2_chs_font_c0:
.incbin "data/m2_chs_font_c0.bin"
m2_chs_font_c1:
.incbin "data/m2_chs_font_c1.bin"
m2_chs_font_c2:
.incbin "data/m2_chs_font_c2.bin"
m2_chs_font_c3:
.incbin "data/m2_chs_font_c3.bin"
m2_chs_font_c4:
.incbin "data/m2_chs_font_c4.bin"
m2_chs_font_c5:
.incbin "data/m2_chs_font_c5.bin"
m2_chs_font_c6:
.incbin "data/m2_chs_font_c6.bin"
m2_chs_font_c7:
.incbin "data/m2_chs_font_c7.bin"
m2_chs_font_c8:
.incbin "data/m2_chs_font_c8.bin"
m2_chs_font_c9:
.incbin "data/m2_chs_font_c9.bin"
m2_chs_font_ca:
.incbin "data/m2_chs_font_ca.bin"
m2_chs_font_cb:
.incbin "data/m2_chs_font_cb.bin"
m2_chs_font_cc:
.incbin "data/m2_chs_font_cc.bin"
m2_chs_font_cd:
.incbin "data/m2_chs_font_cd.bin"
m2_chs_font_ce:
.incbin "data/m2_chs_font_ce.bin"
m2_chs_font_cf:
.incbin "data/m2_chs_font_cf.bin"
m2_chs_font_d0:
.incbin "data/m2_chs_font_d0.bin"
m2_chs_font_d1:
.incbin "data/m2_chs_font_d1.bin"
m2_chs_font_d2:
.incbin "data/m2_chs_font_d2.bin"
m2_chs_font_d3:
.incbin "data/m2_chs_font_d3.bin"
m2_chs_font_d4:
.incbin "data/m2_chs_font_d4.bin"
m2_chs_font_d5:
.incbin "data/m2_chs_font_d5.bin"
m2_chs_font_d6:
.incbin "data/m2_chs_font_d6.bin"
m2_chs_font_d7:
.incbin "data/m2_chs_font_d7.bin"
m2_chs_font_d8:
.incbin "data/m2_chs_font_d8.bin"
m2_chs_font_d9:
.incbin "data/m2_chs_font_d9.bin"
m2_chs_font_da:
.incbin "data/m2_chs_font_da.bin"
m2_chs_font_db:
.incbin "data/m2_chs_font_db.bin"
m2_chs_font_dc:
.incbin "data/m2_chs_font_dc.bin"
m2_chs_font_dd:
.incbin "data/m2_chs_font_dd.bin"
m2_chs_font_de:
.incbin "data/m2_chs_font_de.bin"
m2_chs_font_df:
.incbin "data/m2_chs_font_df.bin"
m2_chs_font_e0:
.incbin "data/m2_chs_font_e0.bin"
m2_chs_font_e1:
.incbin "data/m2_chs_font_e1.bin"
m2_chs_font_e2:
.incbin "data/m2_chs_font_e2.bin"
m2_chs_font_e3:
.incbin "data/m2_chs_font_e3.bin"
m2_chs_font_e4:
.incbin "data/m2_chs_font_e4.bin"
m2_chs_font_e5:
.incbin "data/m2_chs_font_e5.bin"
m2_chs_font_e6:
.incbin "data/m2_chs_font_e6.bin"
m2_chs_font_e7:
.incbin "data/m2_chs_font_e7.bin"
.endarea

.org 0x8FEE000
disclaimer_palette:
.incbin "data/intro-screen-pal.bin"
.align 4
disclaimer_graphics:
.incbin "data/intro-screen-gfx.bin"
.align 4
disclaimer_map:
.incbin "data/intro-screen-map.bin"


//==============================================================================
// Existing subroutines/data
//==============================================================================

.definelabel buffer_subtractor      ,0x0000800
.definelabel overworld_buffer       ,0x200F200
.definelabel m2_hall_line_size      ,0x3000374
.definelabel m2_ness_data           ,0x3001D54
.definelabel m2_ness_name           ,0x3001F10
.definelabel m2_old_paula_name      ,0x3001F16
.definelabel m2_paula_name          ,0x3001F17
.definelabel m2_old_jeff_name       ,0x3001F1C
.definelabel m2_jeff_name           ,0x3001F1E
.definelabel m2_old_poo_name        ,0x3001F22
.definelabel m2_poo_name            ,0x3001F25
.definelabel m2_old_king_name       ,0x3001F28
.definelabel m2_king_name           ,0x3001F2C
.definelabel m2_old_food            ,0x3001F30
.definelabel m2_food                ,0x3001F34
.definelabel m2_old_rockin          ,0x3001F3A
.definelabel m2_rockin              ,0x3001F3C
.definelabel m2_old_japanese_name   ,0x3001F42
.definelabel m2_cstm_last_printed   ,0x3001F4F
.definelabel m2_player1             ,0x3001F50
.definelabel m2_script_readability  ,0x3004F08
.definelabel m2_psi_exist           ,0x300525C
.definelabel m2_active_window_pc    ,0x3005264
.definelabel m2_setup_naming_mem    ,0x8001D5C
.definelabel m2_soundeffect         ,0x8001720
.definelabel m2_copy_names_perm_mem ,0x8002088
.definelabel m2_reset_names         ,0x8002318
.definelabel m2_copy_name_perm_mem  ,0x80023C0
.definelabel m2_main_menu_handler   ,0x80023F8
.definelabel m2_change_naming_space ,0x8004E08
.definelabel m2_copy_name_temp_mem  ,0x8004E34
.definelabel m2_insert_default_name ,0x8005708
.definelabel m2_get_hall_address    ,0x800D7BC
.definelabel m12_dim_palette        ,0x80137DC
.definelabel m2_enable_script       ,0x80A1F6C
.definelabel m2_sub_a334c           ,0x80A334C
.definelabel m2_sub_a3384           ,0x80A3384
.definelabel m2_jump_to_offset      ,0x80A6C24
.definelabel m2_get_selected_item   ,0x80A469C
.definelabel m2_psitargetwindow     ,0x80B8AE0
.definelabel m2_isequipped          ,0x80BC670
.definelabel m2_swapwindowbuf       ,0x80BD7AC
.definelabel m2_setup_window        ,0x80BD844
.definelabel m2_strlookup           ,0x80BE260
.definelabel m2_initwindow          ,0x80BE458
.definelabel m2_initwindow_cursor   ,0x80BE4C8
.definelabel m2_statuswindow_numbers,0x80C0A5C
.definelabel m2_psiwindow           ,0x80C1FBC
.definelabel m2_drawwindow          ,0x80C87D0
.definelabel m2_print_window        ,0x80C8BE4
.definelabel m2_print_alphabet      ,0x80C8FFC
.definelabel m2_printstr            ,0x80C9634
.definelabel m2_printstr_hlight     ,0x80C96F0
.definelabel m2_printnextch         ,0x80C980C
.definelabel m2_scrolltext          ,0x80CA4BC
.definelabel m2_formatnumber        ,0x80CA65C
.definelabel m2_clearwindowtiles    ,0x80CA834
.definelabel m2_menuwindow          ,0x80C1C98
.definelabel m2_setupwindow         ,0x80BE188
.definelabel m2_resetwindow         ,0x80BE490
.definelabel m2_sub_d3c50           ,0x80D3C50
.definelabel m2_hpwindow_up         ,0x80D3F0C
.definelabel m2_curhpwindow_down    ,0x80D41D8
.definelabel m2_sub_d6844           ,0x80D6844
.definelabel m2_setupbattlename     ,0x80DCD00
.definelabel m2_stat_symb_checker   ,0x8B0EDA4 
.definelabel m2_div                 ,0x80F49D8
.definelabel m2_remainder           ,0x80F4A70
.definelabel cpuset                 ,0x80F47C0
.definelabel m2_cast_roll_pointers  ,0x82DB25C
.definelabel m2_items               ,0x8B1D62C
.definelabel m2_default_names       ,0x82B9330
.definelabel m2_psi_print_table     ,0x8B2A9C0

//==============================================================================
// Code files
//==============================================================================

.include "m2-localize.asm"

.org 0x80FCE6C
.include "syscalls.asm"
.include "m2-vwf.asm"
.include "m2-vwf-entries.asm"
.include "m2-bugfixes.asm"
.include "m2-formatting.asm"
.include "m2-customcodes.asm"
.include "m2-compiled.asm"
.include "m2-flyover.asm"
.include "m12-intro.asm"

.close
