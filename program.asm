bits 32
org 0x10000
    mov esi, hello
    call print
    mov edx,2
    mov edi,0xb8001
    mov al,0x60
    mov ecx,2000
    call fill 
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
fill:
    mov [edi],al
    add edi,edx
    dec ecx
    cmp ecx,0
    jnz fill
ret
exits:
halts:
    jmp halts
hello:
db 'hello world.....'
adr:
dd 0x103000
