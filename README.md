# Zeal-8-bit-computer-Z80-asm-examples
A collection of Z80 Assembly language examples and projects created for self-study and experimentation on the Zeal 8-bit Computer.


## program1.asm

This program demonstrates basic arithmetic and output functionality on the Zeal 8-bit Computer. It performs the following steps:

  1. Calculates the sum of two predefined operands (`operand1 = 2` and `operand2 = 3`).

  2. Converts the result into its ASCII representation.

  3. Appends a newline character to the result.

  4. Outputs the result using a syscall and then exits.

This example is designed to run on the Zeal 8-bit Computer and can be compiled using the Zealasm compiler with the following command:

`exec zealasm.bin program1.asm program1.bin`

The source code can be accessed here: [program1.asm](src/program1.asm)


## program2.asm

This program demonstrates the use of the 8-bit load immediate instruction on the Zeal 8-bit Computer. It performs the following steps:

  1. Loads the value `0x12` (18 in decimal) into register B using the `LD` instruction.

  2. Converts the value into its ASCII decimal representation (`"18"`).

  3. Outputs the result followed by a newline character.

  4. Exits the program.

This example is based on **Example 3-1 (p. 38)** from the book:
"**The Z80 Microprocessor: Hardware, Software, Programming, and Interfacing**" by Barry B. Brey (1988, Prentice-Hall, Inc., New Jersey).

It is designed for the Zeal 8-bit Computer and can be compiled using the `z88dk-z80asm` compiler on Linux with the following command:

`z88dk-z80asm -m=z80 -b -m program2.asm`


## program3.asm

This program demonstrates 16-bit value manipulation and ASCII conversion on the Zeal 8-bit Computer. It performs the following steps:

  1. Loads the 16-bit value `0x10CD` (4301 in decimal) into the HL register pair.

  2. Converts the value into its ASCII decimal representation, including five digits with leading zeros (e.g., `"04301"`).

  3. Appends a newline character to the result and stores it in a buffer.

  4. Writes the result to STDOUT and exits with code `15`.

This example is based on Example **3-4 (p. 40)** from the book:
"**The Z80 Microprocessor: Hardware, Software, Programming, and Interfacing**" by Barry B. Brey (1988, Prentice-Hall, Inc., New Jersey).

It is designed for the Zeal 8-bit Computer and can be compiled using the `z88dk-z80asm` compiler on Linux with the following command:

`z88dk-z80asm -m=z80 -b -m program3.asm`
