.gba
.open "../bin/m12.gba",0x8000000
.include "m12-main-strings.asm"
.include "m12-itemnames.asm"
.include "m12-misctext.asm"
.include "m12-psitext.asm"
.include "m12-enemynames.asm"
.include "m12-menuchoices.asm"
.include "m12-psinames.asm"

// Fix pointers to "PSI "
.definelabel psitext, 0x08C04244
.org 0x80C21AC :: dw psitext
.org 0x80C2364 :: dw psitext
.org 0x80C2420 :: dw psitext
.org 0x80C24DC :: dw psitext
.org 0x80D3998 :: dw psitext
.include "m12-psitargets.asm"
.include "m12-battle-commands.asm"
.include "m12-other.asm"
.include "m12-teleport-names.asm"
.close
