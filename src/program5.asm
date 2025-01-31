; ---------------------------------------------------------------------
; program5.asm
;
; This program:
;
; - Demonstrates the use of the 16-bit Direct Addressed Instruction:
;   ld (address), hl to store a 16-bit register pair into memory.
;
; - Uses an address within the program's own space (0x4000 in this case) to
;   avoid conflicts with system memory.
;
; - The program:
;   1. Loads the value 0x4241 (ASCII 'BA') into HL.
;   2. Stores the value of HL into memory address 0x4000 using ld (0x4000), hl.
;   3. Loads the value from memory address 0x4000 back into HL.
;   4. Writes both bytes of HL (ASCII 'B' and 'A') to STDOUT.
;   5. Writes a newline character to STDOUT.
;   6. Exits with code **15**.
;
; - Is based on Example 3-8 (p.42) from the book:
;   "The Z80 Microprocessor. Hardware, Software, Programming and Interfacing"
;   by Barry B. Brey, 1988, Prentice-Hall, Inc., New Jersey.
;
; - Was created for the Zeal 8-bit Computer and can be compiled with the 
;   z88dk-z80asm compiler on Linux using the command:
;     z88dk-z80asm -m=z80 -b -m program5.asm
; ---------------------------------------------------------------------

ORG 0x4000
    jp main             ; Jump to main program

main:
    ; Step 1: Load a value into HL
    ld hl, 0x4241       ; Load 0x4241 (ASCII 'BA') into HL

    ; Step 2: Store the value of HL into memory
    ld (0x4000), hl     ; Store the value of HL into memory address 0x4000

    ; Step 3: Load the value from memory back into HL
    ld hl, (0x4000)     ; Load the value from memory address 0x4000 into HL

    ; Step 4: Write both bytes of HL (ASCII 'B' and 'A') to STDOUT
    ld a, h             ; Load the upper byte of HL (0x42, ASCII 'B') into A
    call print_char     ; Call subroutine to print the character in A

    ld a, l             ; Load the lower byte of HL (0x41, ASCII 'A') into A
    call print_char     ; Call subroutine to print the character in A

    ; Step 5: Write a newline to STDOUT
    ld a, 0x0A          ; Load newline character (ASCII 0x0A) into A
    call print_char     ; Call subroutine to print the newline character

end:                    ; End program
    ld h, 0             ; Clear H
    ld l, 15            ; Load L with 15 (EXIT syscall)
    rst 8               ; Perform EXIT syscall

; Subroutine to print a single character in A to STDOUT
print_char:
    push hl             ; Save HL to the stack
    push de             ; Save DE to the stack
    push bc             ; Save BC to the stack

    ld h, 0             ; Set H to 0 (file descriptor for STDOUT)
    ld l, 1             ; Set L to 1 (WRITE syscall number)
    ld de, buffer       ; Load buffer address into DE
    ld (de), a          ; Store the character in A into the buffer
    ld bc, 1            ; Load 1 into BC (number of characters to write)
    rst 8               ; Perform WRITE syscall

    pop bc              ; Restore BC from the stack
    pop de              ; Restore DE from the stack
    pop hl              ; Restore HL from the stack
    ret

buffer:                 ; Buffer to store the character
    db 0                ; Placeholder for the character

newline:                ; Buffer for newline character
    db 0                ; Placeholder for the newline