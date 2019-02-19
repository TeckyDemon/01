# 01

## Description

**01** is an esoteric programming language with only 2 instructions.

## Prerequisites

### Windows

Install Ruby: https://rubyinstaller.org/

Install required gems:

`$ gem install securerandom`

### Linux

```
$ sudo apt update && sudo apt upgrade -y
$ sudo apt install ruby -y
$ sudo gem install securerandom
```

## Installation

Clone this repository:

`$ git clone "https://github.com/DeBos99/01.git"`

## Usage

Help:

`$ main.rb --help`

Convert \*.zo (see: [file extensions](#file-extensions)) file to other language source file (see: [supported languages](#supported-languages)):

`$ main.rb --convert <language> --input <input> --output <output>`

Convert \*.tzo (see: [file extensions](#file-extensions)) file to \*.zo (see: [file extensions](#file-extensions)) file:

`$ main.rb --generate --input <input> --output <output>`

Minify \*.zo (see: [file extensions](#file-extensions)) file:

`$ main.rb --minify --input <input> --output <output>`

Convert \*.zo file to hex:

`$ main.rb --hex --input <input> --output <output>`

## Instructions

* 0 - increment command pointer (if pointer is equal to the number of instructions it is set to 0)
* 1 - push command on stack (see [commands](#commands))

## Commands

* \> - increment the data pointer
* < - decrement the data pointer
* \+ - increment the byte at the data pointer
* \- - decrement the byte at the data pointer
* . - output the byte at the data pointer
* , - accept one byte of input, storing its value in the byte at the data pointer.
* \[ - if the byte at the data pointer is zero, then instead of moving the instruction pointer forward to the next command, jump it forward to the command after the matching \] command
* \] - if the byte at the data pointer is nonzero, then instead of moving the instruction pointer forward to the next command, jump it back to the command after the matching \[ command
* 0 - set the byte at the data pointer to 0
* 1 - set the data pointer to 0
* x - exit the program with the exit code 0
* X - exit the program with the exit code equal to the byte at the data pointer
* c - copy the byte at the data pointer to next cell (next 2 cells will be cleared first)
* C - copy the byte at the data pointer to next cell
* m - move the byte at the data pointer to next cell

## Supported languages

* Brainfuck (some commands are not implemented)
* C
* C++
* Ruby
* Blub (some commands are not implemented)
* Ook! (some commands are not implemented)
* \*brainfuck (some commands are not implemented)
* Binaryfuck (some commands are not implemented)

## File extensions

* .zo - 01 source file with instructions
* .tzo - 01 source file with commands

## Example program

Hello World:

`00111111110000100001001111000010000100110000000010011100000000100111000000001001000000000111100100001000100100000000100100000000100010000000110010000100000100000010000100100001000110000100000010001110100000000111111100110000000011100100000011000010000000100101000000010001000000001110010000000001111110100000000011111111010000001100100100000010011001`

## Authors

* **Michał "DeBos" Wróblewski** - Main Developer - [DeBos99](https://github.com/DeBos99)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
