printf "\x1bc\x1b[43;37m give me a .c file to compile ? "
read ai
nasm -o /tmp/boot.bin boot.asm
gcc -o3 -c "$ai" -o /tmp/kernel.o -nostdlib
ld -T link.ld /tmp/kernel.o -o /tmp/hello.com -nostdlib
objcopy -O binary  /tmp/hello.com  /tmp/hellos.com
dd if=/tmp/hellos.com of=/tmp/boot.bin seek=1 conv=notrunc
cp -f /tmp/boot.bin ./
/usr/bin/qemu-system-x86_64 -boot a -fda boot.bin
