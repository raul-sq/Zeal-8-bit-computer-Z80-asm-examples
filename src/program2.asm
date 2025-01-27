; ---------------------------------------------------------------------
; program2.asm
;
; This program:
; 
; - Demonstrates the use of the 8-bit load immediate instruction by
;   loading the value 0x12 (18 in decimal) into register B.
;
; - Converts this value to its ASCII decimal representation ("18"), 
;   outputs the result followed by a newline, and then exits.
;
; - Is based on Example 3-1 (p.38) from the book:
;   "The Z80 Microprocessor. Hardware, Software, Programming and Interfacing"
;   by Barry B. Brey, 1988, Prentice-Hall, Inc., New Jersey.
;
; - Was created for the Zeal 8-bit Computer and can be compiled with the 
;   z88dk-z80asm compiler on Linux using the command:
;     z88dk-z80asm -m=z80 -b -m program2.asm
; ---------------------------------------------------------------------

ORG 0x4000
; Entry point
jp main

; Main program
main:
    ; Load immediate value into B
    ld b, 0x12              ; Load the immediate value 0x12 into register B

    ; Convert to ASCII decimal
    ld de, result           ; Load address of result buffer into DE
    call convert_to_ascii   ; Convert B to ASCII and store in result buffer

    ; Add a newline character
    ld a, 10                ; Newline character
    ld (de), a              ; Store newline in buffer

    ; Write the result and newline
write:
    ld de, result           ; Load address of result buffer into DE
    ld bc, 4                ; BC = 4 (3 digits + newline)
    ld h, 0                 ; Clear H register (initialize HL)
    ld l, 1                 ; L = 1 (STDOUT file descriptor)
    rst 8                   ; Perform WRITE syscall

    ; Exit program
end:
    ld l, 15                ; L = 15 (EXIT syscall number)
    rst 8                   ; Perform EXIT syscall

; Subroutine: Convert B to ASCII decimal
; Input: B = value to convert, DE = address of result buffer
; Output: ASCII digits stored in result buffer, DE points to end of buffer
convert_to_ascii:
    ; Convert hundreds place
    ld c, 100               ; Divisor for hundreds
    call convert_digit      ; Convert and store digit

    ; Convert tens place
    ld c, 10                ; Divisor for tens
    call convert_digit      ; Convert and store digit

    ; Convert units place
    ld c, 1                 ; Divisor for units
    call convert_digit      ; Convert and store digit
    ret                     ; Return to caller

; Subroutine: Convert a single digit
; Input: B = value to convert, C = divisor
; Output: Stores ASCII digit in buffer (DE), updates B to remainder
convert_digit:
    ld a, b                 ; Load the value of B into A
    ld h, 0                 ; Clear H (digit counter)
digit_loop:
    sub c                   ; Subtract divisor from A
    jr c, digit_done        ; If A < C, done with this digit
    inc h                   ; Increment digit counter
    jr digit_loop           ; Repeat until A < C
digit_done:
    add a, c                ; Restore A to the remainder
    ld b, a                 ; Update B with the remainder
    ld a, h                 ; Load digit counter into A
    add a, 48               ; Convert digit to ASCII
    ld (de), a              ; Store ASCII digit in buffer
    inc de                  ; Advance buffer pointer
    ret                     ; Return to caller

result:
    db 0                    ; Placeholder for hundreds place
    db 0                    ; Placeholder for tens place
    db 0                    ; Placeholder for units place
    db 0                    ; Placeholder for newline
