; ---------------------------------------------------------------------
; program4.asm
;
; This program:
;
; - Demonstrates the use of the 8-bit Direct Addressed Instruction:
;   `ld (address), a` to store a value from the accumulator into memory.
;
; - Uses an address within the program's own space (0x4000 in this case) to
;   avoid conflicts with system memory.
;
; - The program:
;   1. Loads the value 0x42 (ASCII 'B') into the accumulator (A).
;   2. Stores the value of A into memory address 0x4000 using `ld (0x4000), a`.
;   3. Loads the value from memory address 0x4000 back into A.
;   4. Writes the value in A to STDOUT, printing the character 'B' to the screen.
;   5. Writes a newline character to STDOUT.
;   6. Exits with code **15**.
;
; - Is based on Example 3-7 (p.41) from the book:
;   "The Z80 Microprocessor. Hardware, Software, Programming and Interfacing"
;   by Barry B. Brey, 1988, Prentice-Hall, Inc., New Jersey.
;
; - Was created for the Zeal 8-bit Computer and can be compiled with the 
;   z88dk-z80asm compiler on Linux using the command:
;     z88dk-z80asm -m=z80 -b -m program4.asm
; ---------------------------------------------------------------------

ORG 0x4000
    jp main             ; Jump to main program

main:
    ; Step 1: Load a value into A
    ld a, 0x42          ; Load 0x42 (ASCII 'B') into A

    ; Step 2: Store the value of A into memory
    ld (0x4000), a      ; Store the value of A into memory address 0x4000

    ; Step 3: Load the value from memory back into A
    ld a, (0x4000)      ; Load the value from memory address 0x4000 into A

    ; Step 4: Write the value in A to STDOUT, printing 'B' to the screen.
    ld h, 0             ; Set H to 0 (file descriptor for STDOUT)
    ld l, 1             ; Set L to 1 (WRITE syscall number)
    ld de, buffer       ; Load buffer address into DE
    ld (de), a          ; Store the value of A into the buffer
    ld bc, 1            ; Load 1 into BC (number of characters to write)
    rst 8               ; Perform WRITE syscall

    ; Step 5: Write a newline to STDOUT
    ld a, 0x0A          ; Load newline character (ASCII 0x0A)
    ld de, newline      ; Load newline buffer address into DE
    ld (de), a          ; Store newline in buffer
    ld bc, 1            ; Load 1 into BC (number of characters to write)
    rst 8               ; Perform WRITE syscall

end:                    ; End program
    ld h, 0             ; Clear H
    ld l, 15            ; Load L with 15 (EXIT syscall)
    rst 8               ; Perform EXIT syscall

buffer:                 ; Buffer to store the value from memory
    db 0                ; Placeholder for the value

newline:                ; Buffer for newline character
    db 0                ; Placeholder for the newline
