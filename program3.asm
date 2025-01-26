; ---------------------------------------------------------------------
; program3.asm
;
; This program:
; 
; - Loads a 16-bit value (0x10CD, decimal 4301) into HL.
;
; - Converts this value to ASCII decimal digits (five digits, leading zeros included,
;   plus a newline), stores them in a buffer, and writes them to STDOUT. Finally,
;   it exits with code 15.
;
; - Is based on Example 3-4 (p.40) from the book:
;   "The Z80 Microprocessor. Hardware, Software, Programming and Interfacing"
;   by Barry B. Brey, 1988, Prentice-Hall, Inc., New Jersey.
;
; - Was created for the Zeal 8-bit Computer and can be compiled with the 
;   z88dk-z80asm compiler on Linux using the command:
;     z88dk-z80asm -m=z80 -b -m program3.asm
; ---------------------------------------------------------------------

ORG 0x4000
    jp main             ; Jump to main program

main:
    ld hl, 0x10cd       ; Load 0x10CD into HL (decimal 4301)
    ld de, result       ; Load buffer location into DE
    ld ix, result       ; Store buffer start address in IX
    call num2dec        ; Call subroutine to convert HL to ASCII decimal

write:                  ; Write buffer to STDOUT    
    ld de, ix           ; Load buffer start address from IX into DE
    ld bc, 6            ; Load 6 into BC (number of characters to write)
    ld h, 0             ; Set H to 0 (file descriptor for STDOUT)             
    ld l, 1             ; Set L to 1 (WRITE syscall number)
    rst 8               ; Perform WRITE syscall 

end:                    ; End program
    ld l, 15            ; Load 15 into L (exit code 15)
    rst 8               ; Perform EXIT syscall

num2dec:                ; Convert 16-bit number in HL to ASCII decimal
    ld bc, 10000        ; Ten-thousands place divisor
    call num1           ; Call subroutine to convert to ASCII digit
    ld bc, 1000         ; Thousands place divisor
    call num1           ; Call subroutine to convert to ASCII digit
    ld bc, 100          ; Hundreds place divisor
    call num1           ; Call subroutine to convert to ASCII digit
    ld c, 10            ; Tens place divisor (low byte only)
    call num1           ; Call subroutine to convert to ASCII digit
    ld c, 1             ; Units place divisor (low byte only)
    call num1           ; Call subroutine to convert to ASCII digit
    ld (de), 10         ; Store newline character in the last position of the buffer
    ret                 ; Return to caller

num1:                   ; Convert 16-bit number in HL to ASCII decimal digit
    ld a, 47            ; Initialize digit to ASCII '0' - 1
    or a                ; Clear carry flag
num2:                   ; Loop to find ASCII digit
    inc a               ; Increment ASCII digit
    sbc hl, bc          ; Subtract divisor from HL
    jr nc, num2         ; Repeat until HL < divisor
    add hl, bc          ; Undo last subtraction (restore HL to valid range)
    ld (de), a          ; Store ASCII digit in the buffer
    inc de              ; Move buffer pointer forward
    ret                 ; Return to caller

result:                 ; Buffer to store ASCII decimal digits
    db 0                ; Placeholder for ten-thousands place
    db 0                ; Placeholder for thousands place
    db 0                ; Placeholder for hundreds place
    db 0                ; Placeholder for tens place
    db 0                ; Placeholder for units place
    db 0                ; Placeholder for newline character