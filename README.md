# Weird-Sized Integers in x64 Assembly

## Objective

This program demonstrates how to store and retrieve 5-byte integers (non-standard size) in memory using x64 assembly. It emphasizes understanding of memory layout, byte-wise operations, and bit-level manipulations.

---

## Layout

We define an array `weird_array` large enough to store 4 integers, each 5 bytes long (20 bytes total).

## Storing a 5-byte Integer

We manually store the value `0x0102030405` into the 3rd integer slot (index 2, starting at byte offset 10). Since x64 doesn't support 5-byte `mov` operations, we store each byte separately using:

```asm
mov byte [rdi],   0x05  ; LSB
mov byte [rdi+1], 0x04
mov byte [rdi+2], 0x03
mov byte [rdi+3], 0x02
mov byte [rdi+4], 0x01  ; MSB
