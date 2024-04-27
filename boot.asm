bits 16
org 0x7c00
boots:
jmp _start
nop
oem             db      'MY OEM  '
bsector         dw      200h
scluster        db      1h 
rsector         dw      1h
tfat            db      2h
rent            dw      0e0h
tsectors        dw      0b40h
media           db      0f0h 
sfat            dw      9h
strak           dw      12h
head            dw      2h
hidden          dd      0h
large           dd      0h
drive           db      0h
flag            db      0h
sig             db      29h
vol             dd      0ffffffffh
label           db      'MY LABEL    '
id              db      'FAT12   '
;--------------------------------------------------------
eess            dw      0
ees1            dw      0
_start:
jmp kernel_start
gdt_start:

gdt_null:
    dd 0x0
    dd 0x0

gdt_code:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
kernel_start:
    mov ax, 0
    mov ss, ax
    mov sp, 0xFFFC

    mov ax, 0
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    cli
    lgdt[gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:b32

[bits 32]

print:
    pusha
    mov edi, 0xb8000
print2:
    mov al, [esi]
    mov ah, 0x60
    cmp al, 0
    je print3
    mov[edi],ax
    add esi, 1
    add edi, 2
    jmp print2
print3:
    popa
    ret

b32:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov ebp, 0x90000
    mov esp, ebp

    mov esi, hello
    call print
exits:
halts:
    jmp halts
hello:
db 'hello world.....', 0
spere:
times  510-(spere-boots) db 0 
signature:
dw 0xaa55

