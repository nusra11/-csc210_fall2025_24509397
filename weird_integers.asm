; weird_integers.asm
; NASM syntax, for x64 Linux or Windows

section .data
    ; Reserve space for 4 x 5-byte integers = 20 bytes
    weird_array: times 20 db 0

section .text
    global _start

_start:

    ; ------------------------------------
    ; Step 1: Store a 5-byte value into 3rd slot (index 2)
    ; Let's store: 0x0102030405 (hex, 5 bytes)
    ; Bytes in little endian order: 05 04 03 02 01
    ; 3rd integer slot starts at offset 2 * 5 = 10
    ; ------------------------------------
    mov rdi, weird_array      ; base address
    add rdi, 10               ; move to 3rd slot

    mov byte [rdi],     0x05  ; least significant byte
    mov byte [rdi+1],   0x04
    mov byte [rdi+2],   0x03
    mov byte [rdi+3],   0x02
    mov byte [rdi+4],   0x01  ; most significant byte

    ; ------------------------------------
    ; Step 2: Retrieve the 5-byte value into RAX
    ; using shifts and ORs
    ; ------------------------------------
    xor rax, rax              ; clear RAX to hold result

    movzx rcx, byte [rdi+4]
    shl rcx, 32
    or rax, rcx

    movzx rcx, byte [rdi+3]
    shl rcx, 24
    or rax, rcx

    movzx rcx, byte [rdi+2]
    shl rcx, 16
    or rax, rcx

    movzx rcx, byte [rdi+1]
    shl rcx, 8
    or rax, rcx

    movzx rcx, byte [rdi]
    or rax, rcx

    ; RAX now contains the 5-byte value: 0x0102030405

    ; (Optional: Exit cleanly)
    ; We'll return 0 to the OS
    mov rdi, 0
    mov rax, 60         ; syscall: exit
    syscall
