;---------------------------------------------------------------------------------------
; program1.asm
;
; This program:
;
; - Calculates the sum of two operands (operand1 = 2 and operand2 = 3).
;
; - Converts the result to its ASCII representation, appends a newline character,
;   and outputs the result via a syscall before exiting.
;
; - Was created for the Zeal 8-bit Computer and can be compiled with the 
;   Zealasm compiler natively using the command:
;   exec zealasm.bin program1.asm program1.bin
;---------------------------------------------------------------------------------------

ORG 0x4000

; Load operand1 into A
ld hl, operand1       ; Load address of operand1 into HL
ld a, (hl)            ; Load value at address HL into A

; Load operand2 into B
ld hl, operand2       ; Load address of operand2 into HL
ld b, (hl)            ; Load value at address HL into B

; Add operand1 and operand2
add a, b              ; Add B to A (result in A)

; Convert result to ASCII
add a, 48             ; Add ASCII offset ('0') to convert number to ASCII

; Store result and newline in memory
ld hl, result         ; Load address of result into HL
ld (hl), a            ; Store ASCII character in memory
inc hl
ld (hl), 10           ; Store newline character ('\n') in memory

; Write the result and newline
ld de, result         ; DE points to the result in memory
ld bc, 2              ; BC = 2 (2 bytes to output: result + newline)
ld hl, 1              ; HL = 1 (WRITE syscall)
rst 8                 ; Perform WRITE syscall

; Exit program
ld hl, 15             ; HL = 15 (EXIT syscall)
rst 8                 ; Perform EXIT syscall

operand1:
.db 2                 ; Define operand1 with value 2

operand2:
.db 3                 ; Define operand2 with value 3

result:
.db 0                 ; Placeholder for the ASCII result
.db 0                 ; Placeholder for the newline character
