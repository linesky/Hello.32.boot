bits 32
org 0x10000
    mov esi, hello
    call print
    call exits
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

exits:
halts:
    jmp halts
hello:
db 'hello world.....'
adr:
dd 0x103000
