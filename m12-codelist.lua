m12_codelist = {
  {
    Identifier= 0x0,
    Description= "End (02)",
    IsEnd= true,
    Length= 2
  },
  {
    Identifier= 0x1,
    Description= "New line (00)",
    Length= 2
  },
  {
    Identifier= 0x2,
    Description= "Prompt + new line (03 00)",
    Length= 2
  },
  {
    Identifier= 0x3,
    Description= "Display menu string set {0:X}",
    Length= 4,
  },
  {
    Identifier= 0x4,
    Description= "Jump to offset {0:X} if first choice selected",
    Length= 6,
    HasReferences= true,
    ReferenceOffset= 2
  },
  {
    Identifier= 0x5,
    Description= "Jump to offset {0:X} if second choice selected",
    Length= 6,
    HasReferences= true,
    ReferenceOffset= 2
  },
  {
    Identifier= 0x8,
    Description= "Set flag {0:X} (04)",
    Length= 4
  },
  {
    Identifier= 0x9,
    Description= "Unset flag {0:X} (05)",
    Length= 4
  },
  {
    Identifier= 0xC,
    Description= "Party leader's name (1C 11 69)",
    Length= 2
  },
  {
    Identifier= 0xD,
    Description= "Ness' name (1C 02 01 or 1C 01 08)",
    Length= 2
  },
  {
    Identifier= 0xE,
    Description= "Paula's name (1C 02 02 or 1C 01 1E)",
    Length= 2
  },
  {
    Identifier= 0xF,
    Description= "Jeff's name (1C 02 03 or 1C 01 34)",
    Length= 2
  },
  {
    Identifier= 0x10,
    Description= "Poo's name (1C 02 04 or 1C 01 4A)",
    Length= 2
  },
  {
    Identifier= 0x11,
    Description= "Favorite food (1C 01 04)",
    Length= 2
  },
  {
    Identifier= 0x12,
    Description= "Favorite thing (1C 01 05)",
    Length= 2
  },
  {
    Identifier= 0x14,
    Description= "Teleport to entry {0:X} (1F 21)",
    Length= 4
  },
  {
    Identifier= 0x15,
    Description= "King's name (1C 02 07 or 1C 01 03)",
    Length= 2
  },
  {
    Identifier= 0x18,
    Description= "Unknown",
    Length= 4
  },
  {
    Identifier= 0x19,
    Description= "Unknown",
    Length= 4
  },
  {
    Identifier= 0x1A,
    Description= "Display string in string slot as kind {0:X} (Appears after 90 FF)",
    Length= 4
  },
  {
    Identifier= 0x1B,
    Description= "Pause for {0:X} frames (10)",
    Length= 4
  },
  {
    Identifier= 0x1C,
    Description= "If flag {0:X} is set, jump to offset {1:X} and don't return (06)",
    Length= 8,
    HasReferences= true,
    ReferenceOffset= 4
  },
  {
    Identifier= 0x1D,
    Description= "Wait without prompt (13)",
    Length= 2
  },
  {
    Identifier= 0x1E,
    Description= "Return one letter from a character's name (19 11)",
    Length= 4
  },
  {
    Identifier= 0x1F,
    Description= "Display text character {0:X} (1C 03)",
    Length= 4
  },
  {
    Identifier= 0x20,
    Description= "Display SMAAASH!! graphics (1C 08 01)",
    Length= 2
  },
  {
    Identifier= 0x21,
    Description= "Display YOU WIN! graphics (1C 08 02)",
    Length= 2
  },
  {
    Identifier= 0x22,
    Description= "Wait with prompt, even in battle (14, sometimes used in place of 03)",
    Length= 2
  },
  {
    Identifier= 0x23,
    Description= "Display cash in ATM (1C 01 07)",
    Length= 2
  },
  {
    Identifier= 0x24,
    Description= "Display character 1 defense (1C 01 12)",
    Length= 2
  },
  {
    Identifier= 0x25,
    Description= "Display character 2 defense (1C 01 28)",
    Length= 2
  },
  {
    Identifier= 0x26,
    Description= "Display character 3 defense (1C 01 3E)",
    Length= 2
  },
  {
    Identifier= 0x27,
    Description= "Display character 4 defense (1C 01 54)",
    Length= 2
  },
  {
    Identifier= 0x28,
    Description= "Display character 1 offense (1C 01 11)",
    Length= 2
  },
  {
    Identifier= 0x29,
    Description= "Display character 2 offense (1C 01 27)",
    Length= 2
  },
  {
    Identifier= 0x2A,
    Description= "Display character 3 offense (1C 01 3D)",
    Length= 2
  },
  {
    Identifier= 0x2B,
    Description= "Display character 4 offense (1C 01 53)",
    Length= 2
  },
  {
    Identifier= 0x2D,
    Description= "Display PSI name? (1C 12 00)",
    Length= 2
  },
  {
    Identifier= 0x2E,
    Description= "Display the player's name for the second prompt (1C 01 01)",
    Length= 2
  },
  {
    Identifier= 0x5E,
    Description= "Load value into memory (custom code)",
    Length= 3
  },
  {
    Identifier= 0x5F,
    Description= "Set the current rendering location to {0:X} (custom code)",
    Length= 3
  },
  {
    Identifier= 0x60,
    Description= "Add {0:X} pixels to the current rendering location (custom code)",
    Length= 3
  },
  {
    Identifier= 0x61,
    Description= "Toggles sound for text printing (?) (1F 04)",
    Length= 4
  },
  {
    Identifier= 0x62,
    Description= "Display inventory? (?)",
    Length= 2
  },
  {
    Identifier= 0x63,
    Description= "Display cash on hand (1C 01 06)",
    Length= 2
  },
  {
    Identifier= 0x64,
    Description= "Purge first NPC from party? (1F 65)",
    Length= 2
  },
  {
    Identifier= 0x65,
    Description= "Purge all NPCs from party (1F 64)",
    Length= 2
  },
  {
    Identifier= 0x66,
    Description= "Return numerical delta (19 1E)",
    Length= 2
  },
  {
    Identifier= 0x67,
    Description= "Return one letter from the second player name (19 28 01)",
    Length= 2
  },
  {
    Identifier= 0x68,
    Description= "Clear main text window (18 06, sometimes used in place of 18 01 01)",
    Length= 2
  },
  {
    Identifier= 0x69,
    Description= "Open party HP/PP status windows (1C 04)",
    Length= 2
  },
  {
    Identifier= 0x6A,
    Description= "Set binary flag if number in memory != {0:X} (0C)",
    Length= 4
  },
  {
    Identifier= 0x6B,
    Description= "Apply audio effect {0:X} (1F 07)",
    Length= 4
  },
  {
    Identifier= 0x6C,
    Description= "Sets binary flag true if character {0:X} does not have item {1:X} (1D 04)",
    Length= 6
  },
  {
    Identifier= 0x6D,
    Description= "Remove item {1:X} from character {0:X}'s inventory (1D 01)",
    Length= 6
  },
  {
    Identifier= 0x6E,
    Description= "Deactivate hotspot {0:X} (1F 67)",
    Length= 4
  },
  {
    Identifier= 0x6F,
    Description= "Boost vitality in character {0:X} by {1:X} (1E 0D, values match)",
    Length= 6
  },
  {
    Identifier= 0x70,
    Description= "Boost speed in character {0:X} by {1:X} (1E 0C, values match)",
    Length= 6
  },
  {
    Identifier= 0x71,
    Description= "Boost guts in character {0:X} by {1:X} (1E 0B, values match)",
    Length= 6
  },
  {
    Identifier= 0x72,
    Description= "Boost IQ in character {0:X} by {1:X} (1E 0A, values match)",
    Length= 6
  },
  {
    Identifier= 0x73,
    Description= "Boost luck in character {0:X} by {1:X} (1E 0E, values match)",
    Length= 6
  },
  {
    Identifier= 0x74,
    Description= "Stop music (1F 01 00)",
    Length= 2
  },
  {
    Identifier= 0x75,
    Description= "Unknown (?)",
    Length= 2
  },
  {
    Identifier= 0x76,
    Description= "Display Tenda horn of life trade-in window beginning with prize {0:X}",
    Length= 4
  },
  {
    Identifier= 0x77,
    Description= "Unknown (1D 18, values match)",
    Length= 4
  },
  {
    Identifier= 0x78,
    Description= "Unknown (19 1D, values match)",
    Length= 6
  },
  {
    Identifier= 0x79,
    Description= "Unknown (19 1C, values match)",
    Length= 6
  },
  {
    Identifier= 0x7A,
    Description= "Unknown (19 1A, values match)",
    Length= 4
  },
  {
    Identifier= 0x7B,
    Description= "Change to Mr. Saturn font (1F 31)",
    Length= 2
  },
  {
    Identifier= 0x7C,
    Description= "Change to normal font (1F 30)",
    Length= 2
  },
  {
    Identifier= 0x7D,
    Description= "Activate bicycle (1F F0)",
    Length= 2
  },
  {
    Identifier= 0x7E,
    Description= "Set respawn location to current position? Purpose of argument unclear (19 26)",
    Length= 4
  },
  {
    Identifier= 0x7F,
    Description= "Save the game in the slot selected at the beginning (1F B0)",
    Length= 2
  },
  {
    Identifier= 0x80,
    Description= "Jump to offset {0:X} and don't return (0A)",
    IsEnd= true,
    Length= 6,
    HasReferences= true,
    ReferenceOffset= 2
  },
  {
    Identifier= 0x81,
    Description= "If binary flag is set, jump to offset {0:X} and don't return (1B 03)",
    Length= 6,
    HasReferences= true,
    ReferenceOffset= 2
  },
  {
    Identifier= 0x82,
    Description= "If binary flag is unset, jump to offset {0:X} and don't return (1B 02)",
    Length= 6,
    HasReferences= true,
    ReferenceOffset= 2
  },
  {
    Identifier= 0x83,
    Description= "Set binary flag to status of flag {0:X} (07)",
    Length= 4
  },
  {
    Identifier= 0x84,
    Description= "Generate TPT entry {0:X} with movement pattern {1:X} using style {2:X} (1F 17)",
    Length= 8
  },
  {
    Identifier= 0x85,
    Description= "Make TPT entry {0:X} disappear via style {1:X} (1F 1E)",
    Length= 6
  },
  {
    Identifier= 0x86,
    Description= "Jump to offset {0:X} and return (08)",
    Length= 6,
    HasReferences= true,
    ReferenceOffset= 2
  },
  {
    Identifier= 0x87,
    Description= "Swap working and argumentary memory (1B 04)",
    Length= 2
  },
  {
    Identifier= 0x88,
    Description= "Copy active memory to storage memory (1B 00)",
    Length= 2
  },
  {
    Identifier= 0x89,
    Description= "Copy storage memory to active memory (1B 01)",
    Length= 2
  },
  {
    Identifier= 0x8A,
    Description= "Back up active memory to RAM copy (1B 05)",
    Length= 2
  },
  {
    Identifier= 0x8B,
    Description= "Restore RAM copy of active memory (1B 06)",
    Length= 2
  },
  {
    Identifier= 0x8C,
    Description= "Return the value of the current TPT entry's map flag (1F A2)",
    Length= 2
  },
  {
    Identifier= 0x8D,
    Description= "Load character number in party position {0:X}  (19 10)",
    Length= 4
  },
  {
    Identifier= 0x8E,
    Description= "TPT entry being spoken to/checked faces downwards (1F A0)",
    Length= 2
  },
  {
    Identifier= 0x8F,
    Description= "Change direction of current TPT entry to down (1F A1)",
    Length= 2
  },
  {
    Identifier= 0x90,
    Description= "Store {0:X} to string slot (for 1A FF printing). If 00, store argumentary memory to string slot.",
    Length= 3
  },
  {
    Identifier= 0x91,
    Description= "Set binary flag if character {0:X} has free space in their inventory (1D 03)",
    Length= 3
  },
  {
    Identifier= 0x92,
    Description= "Set binary flag true if character {0:X} has ailment {1:X} (corresponds exactly to 1D 0D XX YY YY)",
    Length= 5
  },
  {
    Identifier= 0x93,
    Description= "Add item {1:X} to character {0:X}'s inventory and return number of items held (1D 0E)",
    Length= 4
  },
  {
    Identifier= 0x94,
    Description= "Display shop window {0:X} (1A 06)",
    Length= 3
  },
  {
    Identifier= 0x95,
    Description= "Jump table with no return (09)",
    IsVariableLength= true,
    HasReferences= true,
    ReferenceOffset= 3
  },
  {
    Identifier= 0x96,
    Description= "Set binary flag if there are {0:X} party members (1D 19)",
    Length= 3
  },
  {
    Identifier= 0x97,
    Description= "Unknown; related to whether an item is food (1D 02)",
    Length= 3
  },
  {
    Identifier= 0x98,
    Description= "Return price of item {0:X} (1D 0A)",
    Length= 3
  },
  {
    Identifier= 0x99,
    Description= "Set binary flag if the player does not have {0:X} dollars in the wallet (1D 14)",
    Length= 6
  },
  {
    Identifier= 0x9A,
    Description= "Set binary flag if number in memory == {0:X} (0B)",
    Length= 4
  },
  {
    Identifier= 0x9B,
    Description= "Remove {0:X} dollars from wallet (1D 09)",
    Length= 6
  },
  {
    Identifier= 0x9C,
    Description= "Open wallet window and display current cash on hand (18 0A)",
    Length= 2
  },
  {
    Identifier= 0x9D,
    Description= "Activate hotspot {0:X} with address ${2:X} (1F 66)",
    Length= 8,
    HasReferences= true,
    ReferenceOffset= 4,
    AbsoluteAddressing= true
  },
  {
    Identifier= 0x9E,
    Description= "Simultaneously commences all prepared movements (1F 61)",
    Length= 2
  },
  {
    Identifier= 0x9F,
    Description= "Display action user name (1C 0D)",
    Length= 2
  },
  {
    Identifier= 0xA0,
    Description= "Generate sprite {0:X} with movement pattern {1:X} using style {2:X} (1F 15)",
    Length= 8
  },
  {
    Identifier= 0xA1,
    Description= "Apply movement pattern {1:X} to TPT entry {0:X} (1F F1)",
    Length= 6
  },
  {
    Identifier= 0xA2,
    Description= "After finishing this text block, close all other windows, jump to offset {0:X} and don't return (?)",
    Length= 6,
    HasReferences= true,
    ReferenceOffset= 2,
    AbsoluteAddressing=  true
  },
  {
    Identifier= 0xA3,
    Description= "Restrict player movement until end of text block (1F E9, use 9E FF after)",
    Length= 4
  },
  {
    Identifier= 0xA4,
    Description= "Delay appearance of TPT entry {0:X} until end of text parsing (1F E6)",
    Length= 4
  },
  {
    Identifier= 0xA5,
    Description= "Delete A0 FF-generated sprite {0:X} via style {1:X} (1F 1F)",
    Length= 6
  },
  {
    Identifier= 0xA6,
    Description= "Apply movement pattern {1:X} to sprite {0:X} (1F F2)",
    Length= 6
  },
  {
    Identifier= 0xA7,
    Description= "Trigger battle with enemy group entry {0:X} (1F 23)",
    Length= 4
  },
  {
    Identifier= 0xA8,
    Description= "Copy from memory {0:X} into argumentative memory (0D)",
    Length= 3
  },
  {
    Identifier= 0xA9,
    Description= "Apply 'cutscene' visual/sound FX associated with sprite {0:X}? (1F EA, values don't match)",
    Length= 4
  },
  {
    Identifier= 0xAA,
    Description= "Apply 'cutscene' visual/sound FX associated with A0 FF-generate sprite {0:X}? (1F E7, values don't match)",
    Length= 4
  },
  {
    Identifier= 0xAB,
    Description= "Copies item {1:X} from character {0:X}'s inventory into working memory (19 19)",
    Length= 4
  },
  {
    Identifier= 0xAC,
    Description= "Print numerical delta (1C 0F)",
    Length= 2
  },
  {
    Identifier= 0xAD,
    Description= "Display action target name (1C 0E)",
    Length= 2
  },
  {
    Identifier= 0xAE,
    Description= "Add character {0:X} to party (1F 11)",
    Length= 3
  },
  {
    Identifier= 0xAF,
    Description= "Remove character {0:X} from party (1F 12)",
    Length= 3
  },
  {
    Identifier= 0xB0,
    Description= "Generate sprite {1:X} near TPT entry {0:X} (1F 1A)",
    Length= 6
  },
  {
    Identifier= 0xB1,
    Description= "Generate sprite {1:X} near sprite {0:X} (1F F3)",
    Length= 6
  },
  {
    Identifier= 0xB2,
    Description= "Generate sprite {1:X} near character {0:X} (1F 1C)",
    Length= 6
  },
  {
    Identifier= 0xB3,
    Description= "Delete B0 FF sprite near TPT entry {0:X} (1F 1B)",
    Length= 4
  },
  {
    Identifier= 0xB4,
    Description= "Delete B1 FF sprite near sprite {0:X} (1F F4)",
    Length= 4
  },
  {
    Identifier= 0xB5,
    Description= "Delete B2 FF sprite near character {0:X} (1F 1D)",
    Length= 4
  },
  {
    Identifier= 0xB6,
    Description= "Display the inventory of character {1:X} in window {0:X} (1A 05, values match)",
    Length= 4
  },
  {
    Identifier= 0xB7,
    Description= "Return half-price of item {0:X} (1D 0B)",
    Length= 3
  },
  {
    Identifier= 0xB8,
    Description= "Store {0:X} to string slot (for 1A FF printing). If 00, store secondary memory to string slot.",
    Length= 3
  },
  {
    Identifier= 0xB9,
    Description= "Remove the item in character {0:X}'s {1:X}th item slot (1D 0F)",
    Length= 6
  },
  {
    Identifier= 0xBA,
    Description= "Add {0:X} dollars to wallet (1D 08)",
    Length= 6
  },
  {
    Identifier= 0xBB,
    Description= "Multiply {0:X} by the number of characters in the party, and store in working memory (1D 15)",
    Length= 3
  },
  {
    Identifier= 0xBC,
    Description= "Input {0:X} into memory bank (0E)",
    Length= 4
  },
  {
    Identifier= 0xBD,
    Description= "Jump table with return (1F C0)",
    IsVariableLength= true,
    HasReferences= true,
    ReferenceOffset= 3
  },
  {
    Identifier= 0xBE,
    Description= "Set binary flag if character {0:X} has item {1:X} (1D 05)",
    Length= 6
  },
  {
    Identifier= 0xBF,
    Description= "Return number of party members (19 20)",
    Length= 2
  },
  {
    Identifier= 0xC0,
    Description= "Increment secondary memory (0F)",
    Length= 2
  },
  {
    Identifier= 0xC1,
    Description= "Return the argument passed to the current battle action (19 1F)",
    Length= 2
  },
  {
    Identifier= 0xC2,
    Description= "Copy party leader to string slot; appears before 1A FF 05 00",
    Length= 2
  },
  {
    Identifier= 0xC3,
    Description= "Store to memory the direction from character {0:X} to object {1:X} (19 22)",
    Length= 6
  },
  {
    Identifier= 0xC4,
    Description= "Play music {1:X} (1F 00)",
    Length= 4
  },
  {
    Identifier= 0xC5,
    Description= "Return music to sector default (1F 03)",
    Length= 2
  },
  {
    Identifier= 0xC6,
    Description= "Close all windows (18 04)",
    Length= 2
  },
  {
    Identifier= 0xC7,
    Description= "Close most recently-used window (18 00)",
    Length= 2
  },
  {
    Identifier= 0xC8,
    Description= "Number selector with {0:X} digits and {1:X} style (1F 52)",
    Length= 4
  },
  {
    Identifier= 0xC9,
    Description= "Focuses the camera to where A0 FF-generated sprite {0:X} is but doesn't follow it (1F EF)",
    Length= 4
  },
  {
    Identifier= 0xCA,
    Description= "Your party will be teleported (in a glitchy way) on top of some sprite that is nearby when the text block is over if the camera switched to another sprite in the block of text (1F ED)",
    Length= 2
  },
  {
    Identifier= 0xCB,
    Description= "Make character {0:X} disappear via style {1:X} (1F EB)",
    Length= 6
  },
  {
    Identifier= 0xCC,
    Description= "Make character {0:X} appear via style {1:X} (1F EC)",
    Length= 6
  },
  {
    Identifier= 0xCD,
    Description= "Change map palette to that of tileset {0:X}, palette {1:X} at speed {2:X} (1F E1)",
    Length= 8
  },
  {
    Identifier= 0xCE,
    Description= "Turn TPT entry {0:X} to direction {1:X} (1F 16)",
    Length= 6
  },
  {
    Identifier= 0xCF,
    Description= "Trigger timed event {0:X} (1F D3)",
    Length= 4
  },
  {
    Identifier= 0xD0,
    Description= "Sets binary flag true if the player currently holds {0:X} in the ATM (1D 17)",
    Length= 6
  },
  {
    Identifier= 0xD1,
    Description= "Add {0:X} dollars to ATM balance (1D 06)",
    Length= 6
  },
  {
    Identifier= 0xD3,
    Description= "Remove {0:X} dollars from ATM balance? (1D 07)",
    Length= 4
  },
  {
    Identifier= 0xD4,
    Description= "Play sound effect {0:X} (1F 02)",
    Length= 4
  },
  {
    Identifier= 0xD5,
    Description= "Unknown (1D 23, value matches)",
    Length= 4
  },
  {
    Identifier= 0xD6,
    Description= "Unknown (1D 11, value matches)",
    Length= 6
  },
  {
    Identifier= 0xD7,
    Description= "Equip character {0:X} with their {1:X}'th item (1F 83)",
    Length= 6
  },
  {
    Identifier= 0xD8,
    Description= "Turn character {0:X} to direction {1:X} (1F 13)",
    Length= 6
  },
  {
    Identifier= 0xD9,
    Description= "Unknown (1F 14 XX)",
    Length= 4
  },
  {
    Identifier= 0xDA,
    Description= "Unknown (occurs after A0 FF and DC FF)",
    Length= 6
  },
  {
    Identifier= 0xDB,
    Description= "Store to memory the direction from TPT entry {0:X} to object {1:X} (ZZ unknown) (19 23)",
    Length= 8
  },
  {
    Identifier= 0xDC,
    Description= "Unknown (sandwiched between DA FF codes?)",
    Length= 8
  },
  {
    Identifier= 0xDD,
    Description= "Check for {0:X} inequality to memory (18 07)",
    Length= 10
  },
  {
    Identifier= 0xDE,
    Description= "Unknown (?)",
    Length= 2
  },
  {
    Identifier= 0xDF,
    Description= "Open non-working phone window (1A 0A)",
    Length= 2
  },
  {
    Identifier= 0xE0,
    Description= "Return cash added by dad to ATM, and reset if {0:X} = 2 (1D 24)",
    Length= 4
  },
  {
    Identifier= 0xE1,
    Description= "Return amount of exp character {0:X} needs to level up, zero if at max level (19 18)",
    Length= 4
  },
  {
    Identifier= 0xE2,
    Description= "Summon photographer to location {0:X} (1F D2)",
    Length= 4
  },
  {
    Identifier= 0xE3,
    Description= "Return food classification (food, drink, or condiment) (19 21 00)",
    Length= 2
  },
  {
    Identifier= 0xE4,
    Description= "Return the ID of the condiment being used, zero if none (19 25 00)",
    Length= 2
  },
  {
    Identifier= 0xE5,
    Description= "Check same user/target (1D 20)",
    Length= 2
  },
  {
    Identifier= 0xE6,
    Description= "Unknown (1F EE, value matches)",
    Length= 4
  },
  {
    Identifier= 0xE7,
    Description= "Show Mach Pizza window? Different arguments yield different menu strings (02 = full A menu, 03 = A menu sans PSI, and more)",
    Length= 4
  },
  {
    Identifier= 0xE8,
    Description= "Character {0:X} realizes special PSI {1:X} (1F 71)",
    Length= 6
  },
  {
    Identifier= 0xE9,
    Description= "Character {0:X} gains {1:X} EXP (1E 09)",
    Length= 8
  },
  {
    Identifier= 0xEA,
    Description= "Lock player movement (1F E5, value matches)",
    Length= 4
  },
  {
    Identifier= 0xEB,
    Description= "Restrict player movement if camera is focused on other sprite (XX is usually FF) (1F E8)",
    Length= 4
  },
  {
    Identifier= 0xEC,
    Description= "Display party select menu? (1A 01)",
    Length= 2
  },
  {
    Identifier= 0xED,
    Description= "Return byte {1:X} of character {0:X} status (19 16, values match)",
    Length= 6
  },
  {
    Identifier= 0xEE,
    Description= "Inflict ailment {1:X} on character {0:X} (ZZ might possibly be the value to set? 0 for off, 1 for on) (YY and ZZ flipped w.r.t EB) (19 05)",
    Length= 8
  },
  {
    Identifier= 0xEF,
    Description= "PSI Teleport to destination {0:X} using method {1:X} (1F 20, values match)",
    Length= 6
  },
  {
    Identifier= 0xF0,
    Description= "Display animation {0:X} (YY is usually 00) (1C 13)",
    Length= 6
  },
  {
    Identifier= 0xF1,
    Description= "Show Escargo Express window? ([18 02][1A 07][18 03 0D][18 00][18 03 01][01])",
    Length= 2
  },
  {
    Identifier= 0xF2,
    Description= "Unknown (1D 13, values match)",
    Length= 6
  },
  {
    Identifier= 0xF3,
    Description= "Unknown (1D 12, values match)",
    Length= 6
  },
  {
    Identifier= 0xF4,
    Description= "Unknown (1D 0C, values match)",
    Length= 6
  },
  {
    Identifier= 0xF5,
    Description= "Return the ID of one item from Escargo Express storage (19 14)",
    Length= 2
  },
  {
    Identifier= 0xF6,
    Description= "Generate random number from 0 to {0:X} (1D 21)",
    Length= 4
  },
  {
    Identifier= 0xF7,
    Description= "Character {0:X} recovers HP by {1:X} percent of max (1E 00)",
    Length= 6
  },
  {
    Identifier= 0xF8,
    Description= "Character {0:X} recovers PP by {1:X} percent of max (1E 04)",
    Length= 6
  },
  {
    Identifier= 0xF9,
    Description= "Character {0:X} loses HP by {1:X} percent of max (1E 01)",
    Length= 6
  },
  {
    Identifier= 0xFA,
    Description= "Character {0:X} loses PP by {1:X} percent of max (1E 05)",
    Length= 6
  },
  {
    Identifier= 0xFB,
    Description= "Attempt to fix items (1F D0)",
    Length= 4
  },
  {
    Identifier= 0xFC,
    Description= "Call special event/code (1F 41)",
    Length= 4
  },
  {
    Identifier= 0xFD,
    Description= "Set binary flag if current sector is Exit mouse-compatible (1D 22)",
    Length= 2
  },
  {
    Identifier= 0xFE,
    Description= "Store current coordinates into memory (1F 68)",
    Length= 2
  },
  {
    Identifier= 0xFF,
    Description= "Returns a numeric value based on the proximity of a magic truffle TPT entry (1F D1)",
    Length= 2
  }
}