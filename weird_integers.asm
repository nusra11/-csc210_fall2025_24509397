; weird_integers.asm
; NASM syntax, for x64 Linux or Windows
; Objective: store and retrieve 5-byte "weird" integers using bitwise ops

section .data
    ; Reserve space for 4 x 5-byte integers = 20 bytes
    weird_array: times 20 db 0

section .text
    global _start

_start:
    ; ------------------------------------------------------------
    ; Step 1: Store a 5-byte value into 3rd slot (index 2)
    ; Let's store: 0x0102030405  (5 bytes)
    ; Stored in little endian order: 05 04 03 02 01
    ; 3rd slot starts at offset 2 * 5 = 10 bytes
    ; ------------------------------------------------------------

    mov rdi, weird_array    ; base address
    add rdi, 10             ; move to 3rd slot (index 2)

    mov byte [rdi],   0x05
    mov byte [rdi+1], 0x04
    mov byte [rdi+2], 0x03
    mov byte [rdi+3], 0x02
    mov byte [rdi+4], 0x01

    ; ------------------------------------------------------------
    ; Step 2: Retrieve the 5-byte value back into RAX
    ; Reconstruct using shifts and OR operations
    ; ------------------------------------------------------------

    xor rax, rax            ; clear RAX before reconstruction

    mov al, [rdi]           ; load least significant byte (0x05)
    mov bl, [rdi+1]
    shl rbx, 8
    or  rax, rbx

    mov bl, [rdi+2]
    shl rbx, 16
    or  rax, rbx

    mov bl, [rdi+3]
    shl rbx, 24
    or  rax, rbx

    mov bl, [rdi+4]
    shl rbx, 32
    or  rax, rbx

    ; Now RAX = 0x0102030405
    ; ------------------------------------------------------------

    ; (Optional) — You could verify this in gdb or print it if using Linux syscalls.

    ; ------------------------------------------------------------
    ; Step 3: Exit cleanly
    ; ------------------------------------------------------------
    mov rax, 60     ; syscall: exit
    xor rdi, rdi    ; exit code 0
    syscall
