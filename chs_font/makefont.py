
bdf_file = open('zpix.bdf',"r",encoding = "utf-8")
bdf_lines = bdf_file.readlines()
bdf_file.close()

#print('file lines', len(bdf_lines))

bdf_line_index = {}

for i,line in enumerate(bdf_lines):
    #print(bdf_lines[i])
    #line = bdf_lines[i]
    if line.startswith('STARTCHAR'):
        chr_encoding = line[-5:-1]
        chr_encoding = int(chr_encoding,base = 16)
        bdf_line_index[chr_encoding] = i

def read_char(i):
    assert(bdf_lines[i].startswith('STARTCHAR'))
    assert(bdf_lines[i+4].startswith('BBX'))
    assert(bdf_lines[i+5] == 'BITMAP\n')
    #assert(bdf_lines[i+17] == 'ENDCHAR\n')
    
    bbx = bdf_lines[i+4].split(' ')

    lb = int(bbx[3])
    va = int(bbx[4])
    height = int(bbx[2])
    bit_map = [0] * 16
    tmp = []
    
    base = 12 - va
    top = 16 - base
    if top >= 2:
        top = top - 2

    for j in range(6,6+height):
        bits = int(bdf_lines[i+j],base=16) >> lb
        offset = (j - 6)
        bit_map[offset + top] = bits

    return bit_map


def utf82gbk(s):
    return s.encode('gbk')

def gbkcode2unicode(gbk_code):
    assert(gbk_code > 0xa1a1 and gbk_code < 0xF7FE)
    s = gbk_code.to_bytes(2,'big').decode('gbk')
    return int.from_bytes(s.encode('utf-16-le'),'little')

def make_font_char(code):
    line = bdf_line_index[code]
    bit_map = read_char(line)
    bitmap_bytes = bytearray([0]*2*2*8)
    
    for i in range(0,8):
        b = (bit_map[i] >> 8) & 0xff
        b = int('{:08b}'.format(b)[::-1],2)
        bitmap_bytes[i] = b
        
    for i in range(0,8):
        b = (bit_map[i]) & 0xff
        b = int('{:08b}'.format(b)[::-1],2)
        bitmap_bytes[i + 8] = b
        
    left = len(bit_map) - 8
    for i in range(0,left):
        b = (bit_map[i+8] >> 8) & 0xff
        b = int('{:08b}'.format(b)[::-1],2)
        bitmap_bytes[i + 16] = b
        
    for i in range(0,left):
        b = (bit_map[i+8]) & 0xff
        b = int('{:08b}'.format(b)[::-1],2)
        bitmap_bytes[i + 24] = b
    
    return bitmap_bytes

def draw_font_char(code):
    line = bdf_line_index[code]
    bit_map = read_char(line)
    for bits in bit_map:
        line = '{:016b}'.format(bits)
        line = line.replace('0',' ')
        line = line.replace('1','*')
        print(line)
    
    
def make_font_region(r):
    assert(r >= 0xa1 and r <= 0xF7)
    bitmap_bytes = bytearray()
    
    for w in range(0xA1,0xFF):
        #print('hex 0x%x' % (r<<8 | w))
        gbk_code = r<<8 | w
        #print('make font %04x' % gbk_code )
        
        if r == 0xd7 and w >= 0xfa:
            break
        unicode = gbkcode2unicode(gbk_code)
        char_bytes = make_font_char(unicode)
        bitmap_bytes = bitmap_bytes + char_bytes
    
    filename = 'm2_chs_font_%02x.bin' % r
    f = open(filename,'wb')
    f.write(bitmap_bytes)
    f.close()

for r in range(0xb0,0xE8):
    make_font_region(r)
    
print('m2_chs_font_table:')
for r in range(0xb0,0xE8):
    print('dw      m2_chs_font_%02x'% r)
    
for r in range(0xb0,0xE8):
    print('m2_chs_font_%02x:'% r)
    print('.incbin "data/m2_chs_font_%02x.bin"'% r)