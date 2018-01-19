#		   			#		
#						  							#
# 		     Assignment 1		   					#
#            	          			#
#####################################################
.data
WelcomeString:	.asciiz		"Welcome to Scrambled ASM!\n"
opcodeChar:	.asciiz		"add\0", "addi", "or\0\0", "ori\0", "lw\0\0", "sw\0\0", "j\0\0\0", "beq\0", "bne\0"
opcodeBin:	.asciiz		"000000","001000","000000","001101","100011", "101011", "000010",  "000100","000101"
funct:		.asciiz		"100000","000000","100101","000000","000000", "000000", "000000",  "000000","000000"   
type:		.byte		  'R',     'I',     'R',      'I',     'I',       'I',     'J',      'I',    'I'
registers:	.asciiz		"00000", "00001", "00010", "00011", "00100", "00101", "00110", "00111", "01000", "01001", "01010", "01011", "01100", "01101", "01110", "01111",	"10000", "10001", "10010", "10011", "10100", "10101", "10110", "10111", "11000", "11001", "11010", "11011", "11100", "11101", "11110", "11111"
registerChar:	.asciiz		"$zero",  "$at",   "$v0",   "$v1",   "$a0",   "$a1",  "$a2",   "$a3",    "$t0",   "$t1",   "$t2",   "$t3",   "$t4",   "$t5",   "$t6",   "$t7",  "$s0",    "$s1",    "$s2",  "$s3",   "$s4",  "$s5",   "$s6",    "$s7",   "$t8",   "$t9",   "$k0",   "$k1",   "$gp",   "$sp",   "$fp",   "$ra" 
space:		.asciiz		" "
commaSpace:	.asciiz		", "
newLine:	.asciiz		"\n"
openParen:	.asciiz		"("
closeParen:	.asciiz		")"
STR_1:		.asciiz		"Machine code (guess the '*'): "
STR_2:		.asciiz		"Enter guess ('0' or '1') for stars (without spaces), '.' to end, or '?' to show answer: "
STR_3:		.asciiz		"Correct answer is:            "
STR_4:		.asciiz		"Your score is: "
STR_5:		.asciiz		"Answer:                       "
bad:		.asciiz		"Invalid input. Try again." 
ExitString:	.asciiz		"Thanks for playing! Goodbye!"   
display:	.space		33
answer:		.space		33
hiddenAnswer:	.space		9
userInput:	.space		50


.text
####################################
# Registers
# $t9 --> hold copy of randomly generated int to be used as a counter
# $t8 --> holds a SECOND copy of randomly generated int to be used as a counter
# $t7 --> holds rs register, binary representation of rs to put into display buffer
# $t6 --> holds rt register, binary representation of rt to put into display buffer
# $t5 --> holds rd register, binary representation of rd to put into display buffer
# $t4 --> will hold length of user input

# $s7 --> hold address of selected char instruction
# $s6 --> holds the opcode of R and I functions
# $s5 --> holds the address of first randomly selected char register for R format, I format
# $s4 --> holds the address of second randomly selected char register for R format, I format, or random 26 bit immediate for J format
# $s3 --> holds the address of third randomly selected char register for R format, or random 16 bit immediate for I format
# $s2 --> holds '*' character
# $s1 --> will hold the user's current score
# $s0 --> will hold length of the correct answer (hiddenAnswer buffer)

####################################
# print welcome string
la	$a0, WelcomeString
addi	$v0, $zero, 4   		# for print str syscall
syscall	

addi	$s1, $s1, 0			# intialize user score
																																			
MAIN_LOOP:	
# intialize everything to 0 at the start of each MAIN LOOP
	
##################################
# initialize hidden answer to null
la	$t9, hiddenAnswer
addi	$t8, $zero, '\0'
addi	$t7, $zero, 8

clearLoop:
beq	$t7, $zero, clear
sb	$t8, ($t9)
addi	$t9, $t9, 1
subi	$t7, $t7, 1
j	clearLoop
##################################
clear:	
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																															
li	$t9, 0
li	$t8, 0																											
li	$t8, 0
li	$t7, 0
li	$t5, 0
li	$t4, 0
li	$s7, 0
li	$s6, 0
li	$s5, 0
li	$s4, 0
li	$s3, 0
li	$s2, 0
li	$s0, 0					
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																	0
####################################
# generate random int in range[0-7]
addi	$v0, $zero, 42			# for syscall
addi	$a1, $zero, 9			# upper bound of range
syscall
add	$t9, $zero, $a0			# copy of random int into $t9
add	$t8, $zero, $a0			# copy of random int into $t8
####################################
la	$a0, opcodeChar			# load the address of the opcodeChar

#loops through and picks the instruction at the randomly generated int index
instrLoop:
beq	$t9, $zero, storeAddress	# if the counter is equal to zero, save instruction at that index	
addi	$a0, $a0, 5			# else add 5 to the opcodeChar address to move to the next instruction
subi	$t9, $t9, 1			# decrement the random index by one, and repeat the loop
j	instrLoop	
storeAddress:
add	$s7, $zero, $a0			# holds address of selected char instruction
j	next
####################################
# this part gets the R, I , or J type of the randomly picked opcode in order to properly construct the instruction
next:
la	$a0, type			# Loads the address of type array into $a0
add	$a0, $a0, $t8,			# adds random int to byte address because each index in type array separated by byte
lbu	$t0, 0($a0)			# loads the char of whatever type the opcode instruction is
beq	$t0, 'R', R_type		# if the type is R, go to R_type
beq	$t0, 'I', I_type		# if the type is I, go to I_type
beq	$t0, 'J', J_type		# if the type is J, go to J_type
##################################################################################
R_type:
# three registers must be randomly picked 

# generate random int 1
addi	$v0, $zero, 42			# for random int syscall
addi	$a1, $zero, 32			# upper bound for random int range
syscall					# generates random int in $a0


# grab bit string of register to add to display buffer
add	$t0, $zero, $a0			# make copy of rand int to use as counter
la	$t1, registers			# loads the registers array

RT_loop1:
beq	$t0, $zero, saveReg1
addi	$t1, $t1, 6			# add 6 to move to next index
subi	$t0, $t0, 1			# decrement counter
j	RT_loop1

saveReg1:
add	$t5, $zero, $t1			# save address of register at index 


la	$t1, registerChar		# load the address of the registers array
beq	$a0, $zero, zeroCase1		# if the generated int is 0, that means register 0 needs to be saved
addi	$t1, $t1, 6			# add 6 to the address if the int is not 0 to move to the next index in the registerChar array
subi	$a0, $a0, 1			# decrement generated int by 1 because you have moved one index over

reg1:
beq	$a0, $zero, getRegister1	# if the counter has reached zero, save the address of the register
addi	$t1, $t1, 4			
subi	$a0, $a0, 1
j	reg1			
	
zeroCase1:
add	$s5, $s5, $t1			# save zero register to $s5
j	generate2

getRegister1:
add	$s5, $s5, $t1			# save the address of first randomly selected register into $s5


# generate random int 2
generate2:
addi	$v0, $zero, 42			# for random int syscall
addi	$a1, $zero, 32			# upper bound for random int range
syscall					# generates random int in $a0


# grab bit string of register to add to display buffer
add	$t0, $zero, $a0			# make copy of rand int to use as counter
la	$t1, registers			# loads the registers array

loopy:
beq	$t0, $zero, saveRegisterBinary
addi	$t1, $t1, 6			# add 6 to move to next index
subi	$t0, $t0, 1			# decrement counter
j	loopy

saveRegisterBinary:
add	$t7, $zero, $t1			# save address of register at index 

la	$t1, registerChar		# load the address of the registers array
beq	$a0, $zero, zeroCase2		# if the generated int is 0, that means register 0 needs to be saved
addi	$t1, $t1, 6			# add 6 to the address if the int is not 0 to move to the next index in the registerChar array
subi	$a0, $a0, 1			# decrement generated int by 1 because you have moved one index over

reg2:
beq	$a0, $zero, getRegister2	# if the counter has reached zero, save the address of the register
addi	$t1, $t1, 4			
subi	$a0, $a0, 1
j	reg2			
	
zeroCase2:
add	$s4, $s4, $t1			# save zero register to $s4
j	generate3

getRegister2:
add	$s4, $s4, $t1			# save the address of second randomly selected register into $s4

# generate random int 3
generate3:
addi	$v0, $zero, 42			# for random int syscall
addi	$a1, $zero, 32			# upper bound for random int range
syscall					# generates random int in $a0

# grab bit string of register to add to display buffer
add	$t0, $zero, $a0			# make copy of rand int to use as counter
la	$t1, registers			# loads the registers array

loopyy:
beq	$t0, $zero, saveRegisterBinaryy
addi	$t1, $t1, 6			# add 6 to move to next index
subi	$t0, $t0, 1			# decrement counter
j	loopyy

saveRegisterBinaryy:
add	$t6, $zero, $t1			# save address of register at index 


la	$t1, registerChar		# load the address of the registers array
beq	$a0, $zero, zeroCase3		# if the generated int is 0, that means register 0 needs to be saved
addi	$t1, $t1, 6			# add 6 to the address if the int is not 0 to move to the next index in the registerChar array
subi	$a0, $a0, 1			# decrement generated int by 1 because you have moved one index over

reg3:
beq	$a0, $zero, getRegister3	# if the counter has reached zero, save the address of the register
addi	$t1, $t1, 4			
subi	$a0, $a0, 1
j	reg3			
	
zeroCase3:
add	$s3, $s3, $t1			# save zero register to $s3
j	continue_program

getRegister3:
add	$s3, $s3, $t1			# save the address of third randomly selected register into $s3



# below will take everything and make a 33 bit(32 + null) instruction out of it and place it into the display buffer
la	$t0, display			#load the buffer
addi	$t1, $zero, 6			# counter to add 6 bits for op code


# this loop adds the first 6 bits that correspond to the op code
display_loop:	
beq	$t1, $zero, next_part		# if the ocunter 	
addi	$t2, $zero, 0x30		# holds hex representation of '0'
sb	$t2, ($t0)			# stores it into $s0
addi	$t0, $t0, 1			# increment to move pointer to next index of display buffer
subi	$t1, $t1, 1			#decrement counter
j	display_loop

#
next_part:
# this part will add the rs($t7) bits to display buffer
la	$t3, ($t7)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rs to the display buffer
looop:
beq	$t1, $zero, next_partt
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($t0)			# save byte to display buffer
addi	$t0, $t0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rs index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	looop


next_partt:
# this part will add rt($t6) bits to display buffer
la	$t3, ($t6)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rs to the display buffer
loooop:
beq	$t1, $zero, next_parttt
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($t0)			# save byte to display buffer
addi	$t0, $t0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rt index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	loooop


next_parttt:
# this part will add rd($t5) bits to display buffer
la	$t3, ($t5)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rs to the display buffer
looooop:
beq	$t1, $zero, next_partttt
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($t0)			# save byte to display buffer
addi	$t0, $t0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rd index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	looooop


next_partttt:
# this part will add 5 zeroes for the shamt field to the display buffer
addi	$t1, $zero, 5			# counter to add 5 bits for shift amount

# this loop adds 5 bits that correspond to the shift amount
display_looop:	
beq	$t1, $zero, neext_part		# if the counter equals zero, go to next part	
addi	$t2, $zero, 0x30		# holds hex representation of '0'
sb	$t2, ($t0)			# stores it into $s0
addi	$t0, $t0, 1			# increment to move pointer to next index of display buffer
subi	$t1, $t1, 1			# decrement counter
j	display_looop

neext_part:
# this last part adds the function code to the end of the display buffer along with a null
la	$t3, ($s7)
lbu	$t4, ($t3)
beq	$t4, 'a', addOpCode

addi	$t2, $zero, 0x31		# holds the hex representation of '1'
sb	$t2, ($t0)			# stores the 1 into the display buffer
addi	$t0, $t0, 1			# increment move pointer to next index of display buffer

addi	$t2, $zero, 0x30		# holds the hex representation of '0'
sb	$t2, ($t0)			# stores the 0 into the display buffer
addi	$t0, $t0, 1			# increment move pointer to next index of display buffer
sb	$t2, ($t0)			# stores the 0 into the display buffer
addi	$t0, $t0, 1			# increment move pointer to next index of display buffer

addi	$t2, $zero, 0x31		# holds the hex representation of '1'
sb	$t2, ($t0)			# stores the 1 into the display buffer
addi	$t0, $t0, 1			# increment move pointer to next index of display buffer

addi	$t2, $zero, 0x30		# holds the hex representation of '0'
sb	$t2, ($t0)			# stores the 0 into the display buffer
addi	$t0, $t0, 1			# increment move pointer to next index of display buffer

addi	$t2, $zero, 0x31		# holds the hex representation of '1'
sb	$t2, ($t0)			# stores the 1 into the display buffer
addi	$t0, $t0, 1			# increment move pointer to next index of display buffer

j	continue_program


addOpCode:
addi	$t2, $zero, 0x31		# holds the hex representation of '1'
sb	$t2, ($t0)			# stores the 1 into the display buffer
addi	$t0, $t0, 1			# increment move pointer to next index of display buffer
addi	$t1, $zero, 5			# counter to add 5 zeroes to finish the opcode

loopp:
beq	$t1, $zero, addNull		# go to next part when counter equals 0
addi	$t2, $zero, 0x30		# holds hex representation of '0'
sb	$t2, ($t0)			# store the byte $s0
addi	$t0, $t0, 1			# increment display buffer by 1
subi	$t1, $t1, 1			# decrement counter
j 	loopp

addNull:
addi	$t2, $zero, 0
sb	$t2, ($t0)

j 	continue_program

#################################################################################################
I_type:

# generate random int 1
addi	$v0, $zero, 42			# for random int syscall
addi	$a1, $zero, 32			# upper bound for random int range
syscall					# generates random int in $a0

# grab bit string of register to add to display buffer
add	$t0, $zero, $a0			# make copy of rand int to use as counter
la	$t1, registers			# loads the registers array

loopy1:
beq	$t0, $zero, saveRegisterBinary1
addi	$t1, $t1, 6			# add 6 to move to next index
subi	$t0, $t0, 1			# decrement counter
j	loopy1

saveRegisterBinary1:
add	$t7, $zero, $t1			# save address of register at index 

la	$t1, registerChar		# load the address of the registers array
beq	$a0, $zero, zeroCase11		# if the generated int is 0, that means register 0 needs to be saved
addi	$t1, $t1, 6			# add 6 to the address if the int is not 0 to move to the next index in the registerChar array
subi	$a0, $a0, 1			# decrement generated int by 1 because you have moved one index over

reg11:
beq	$a0, $zero, getRegister11	# if the counter has reached zero, save the address of the register
addi	$t1, $t1, 4			
subi	$a0, $a0, 1
j	reg11			
	
zeroCase11:
add	$s5, $s5, $t1			# save zero register to $s5
j	generate22

getRegister11:
add	$s5, $s5, $t1			# save the address of first randomly selected register into $s5


# generate random int 2
generate22:
addi	$v0, $zero, 42			# for random int syscall
addi	$a1, $zero, 32			# upper bound for random int range
syscall					# generates random int in $a0

# grab bit string of register to add to display buffer
add	$t0, $zero, $a0			# make copy of rand int to use as counter
la	$t1, registers			# loads the registers array

loopyy2:
beq	$t0, $zero, saveRegisterBinaryy2
addi	$t1, $t1, 6			# add 6 to move to next index
subi	$t0, $t0, 1			# decrement counter
j	loopyy2

saveRegisterBinaryy2:
add	$t6, $zero, $t1			# save address of register at index 


la	$t1, registerChar		# load the address of the registers array
beq	$a0, $zero, zeroCase22		# if the generated int is 0, that means register 0 needs to be saved
addi	$t1, $t1, 6			# add 6 to the address if the int is not 0 to move to the next index in the registerChar array
subi	$a0, $a0, 1			# decrement generated int by 1 because you have moved one index over

reg22:
beq	$a0, $zero, getRegister22	# if the counter has reached zero, save the address of the register
addi	$t1, $t1, 4			
subi	$a0, $a0, 1
j	reg22			
	
zeroCase22:
add	$s4, $s4, $t1			# save zero register to $s4
j	next2

getRegister22:
add	$s4, $s4, $t1			# save the address of second randomly selected register into $s4

# Generates a random int in the range 0-0xFFFF
next2:

addi	$v0, $zero, 42
addi	$a1, $zero, 0xFFFF
syscall

add	$s3, $zero, $a0			# save the randomly generated int into $s3


# the parts below will construct the display buffer
la	$a0, display			# loads the display buffer
la	$a1, ($s7)			# loads the char instruction
lbu	$t0, ($a1)			# loads the first char of the instruction

beq	$t0, 'a', addiOpcode		# if the first char is an a, then add the opode for addi to display buffer
beq	$t0, 'o', oriOpcode		# if the first char is an o, then add the opcode for ori to display buffer
beq	$t0, 'l', lwOpcode		# if the first char is an l, then add the opcode for lw to display buffer
beq	$t0, 's', swOpcode		# if the first char is an s, then add the opcode for sw to display buffer
beq	$t0, 'b', branchOpcode		# if the first char is an b , then go to another loop which differentiates between beq and bne


addiOpcode:
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1

# this part will add the rs($t7) bits to display buffer
la	$t3, ($t7)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rs to the display buffer
addi_loop:
beq	$t1, $zero, addi_next
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rs index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	addi_loop

addi_next:
# this part will add rt($t6) bits to display buffer
la	$t3, ($t6)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rt to the display buffer
addi_loop2:
beq	$t1, $zero, addi_next2
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rt index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	addi_loop2


addi_next2:
# next, the random 16 bit int will need to be added to the display buffer to complete the 32 bit instruction
addi	$t1, $zero, 15			# creates a counter to add the 15 bits

addi_loop3:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
beq	$t1, $zero, addi_last		# if the counter is 0 all 15 bits have been added, just add null
srlv	$t0, $t0, $t1			# shift bit to lsb position
and	$t2, $t0, 1			# isolate the LSB into $t2
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index
subi	$t1, $t1, 1			# decrement counter by 1
j	addi_loop3		

addi_last:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
and	$t2, $t0, 1			# isolate lsb
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index


# the final part is to add a null at the end of the display buffer
addi	$t1, $zero, 0
sb	$t1, ($a0)			# store the null char at the end of the display buffer

j 	continue_program

oriOpcode:
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1

# this part will add the rs($t7) bits to display buffer
la	$t3, ($t7)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rs to the display buffer
ori_loop:
beq	$t1, $zero, ori_next
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rs index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	ori_loop

ori_next:
# this part will add rt($t6) bits to display buffer
la	$t3, ($t6)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rt to the display buffer
ori_loop2:
beq	$t1, $zero, ori_next2
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rt index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	ori_loop2


ori_next2:
# next, the random 16 bit int will need to be added to the display buffer to complete the 32 bit instruction
addi	$t1, $zero, 15			# creates a counter to add the 15 bits

ori_loop3:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
beq	$t1, $zero, ori_last		# if the counter is 0 all 15 bits have been added, just add null
srlv	$t0, $t0, $t1			# shift bit to lsb position
and	$t2, $t0, 1			# isolate the LSB into $t2
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index
subi	$t1, $t1, 1			# decrement counter by 1
j	ori_loop3		

ori_last:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
and	$t2, $t0, 1			# isolate lsb
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index


# the final part is to add a null at the end of the display buffer
ori	$t1, $zero, 0
sb	$t1, ($a0)			# store the null char at the end of the display buffer

j 	continue_program

lwOpcode:
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1

# this part will add the rs($t7) bits to display buffer
la	$t3, ($t7)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rs to the display buffer
lw_loop:
beq	$t1, $zero, lw_next
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rs index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	lw_loop

lw_next:
# this part will add rt($t6) bits to display buffer
la	$t3, ($t6)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rt to the display buffer
lw_loop2:
beq	$t1, $zero, lw_next2
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rt index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	lw_loop2


lw_next2:
# next, the random 16 bit int will need to be added to the display buffer to complete the 32 bit instruction
addi	$t1, $zero, 15			# creates a counter to add the 15 bits

lw_loop3:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
beq	$t1, $zero, lw_last		# if the counter is 0 all 15 bits have been added, just add null
srlv	$t0, $t0, $t1			# shift bit to lsb position
and	$t2, $t0, 1			# isolate the LSB into $t2
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index
subi	$t1, $t1, 1			# decrement counter by 1
j	lw_loop3		

lw_last:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
and	$t2, $t0, 1			# isolate lsb
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index


# the final part is to add a null at the end of the display buffer
ori	$t1, $zero, 0
sb	$t1, ($a0)			# store the null char at the end of the display buffer

j 	continue_program

swOpcode:
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1

# this part will add the rs($t7) bits to display buffer
la	$t3, ($t7)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rs to the display buffer
sw_loop:
beq	$t1, $zero, sw_next
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rs index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	sw_loop

sw_next:
# this part will add rt($t6) bits to display buffer
la	$t3, ($t6)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rt to the display buffer
sw_loop2:
beq	$t1, $zero, sw_next2
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rt index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	sw_loop2

sw_next2:
# next, the random 16 bit int will need to be added to the display buffer to complete the 32 bit instruction
addi	$t1, $zero, 15			# creates a counter to add the 15 bits

sw_loop3:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
beq	$t1, $zero, sw_last		# if the counter is 0 all 15 bits have been added, just add null
srlv	$t0, $t0, $t1			# shift bit to lsb position
and	$t2, $t0, 1			# isolate the LSB into $t2
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index
subi	$t1, $t1, 1			# decrement counter by 1
j	sw_loop3		

sw_last:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
and	$t2, $t0, 1			# isolate lsb
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index

# the final part is to add a null at the end of the display buffer
ori	$t1, $zero, 0
sb	$t1, ($a0)			# store the null char at the end of the display buffer

j 	continue_program

branchOpcode:
addi	$a1, $a1, 1			# add 1 to the index of the char instruction to get the second letter of the branch
lbu	$t0, ($a1)			# loads the second char of the instruction
beq	$t0, 'e', beqOpcode		# if the second char is an e, then add the opode for beq to display buffer
beq	$t0, 'n', bneOpcode		# if the second char is an n, then add the opcode for bne to display buffer

beqOpcode:
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1

# this part will add the rs($t7) bits to display buffer
la	$t3, ($t7)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rs to the display buffer
beq_loop:
beq	$t1, $zero, beq_next
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rs index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	beq_loop

beq_next:
# this part will add rt($t6) bits to display buffer
la	$t3, ($t6)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rt to the display buffer
beq_loop2:
beq	$t1, $zero, beq_next2
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rt index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	beq_loop2


beq_next2:
# next, the random 16 bit int will need to be added to the display buffer to complete the 32 bit instruction
addi	$t1, $zero, 15			# creates a counter to add the 15 bits

beq_loop3:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
beq	$t1, $zero, beq_last		# if the counter is 0 all 15 bits have been added, just add null
srlv	$t0, $t0, $t1			# shift bit to lsb position
and	$t2, $t0, 1			# isolate the LSB into $t2
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index
subi	$t1, $t1, 1			# decrement counter by 1
j	beq_loop3		

beq_last:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
and	$t2, $t0, 1			# isolate lsb
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index

# the final part is to add a null at the end of the display buffer
ori	$t1, $zero, 0
sb	$t1, ($a0)			# store the null char at the end of the display buffer

j 	continue_program

bneOpcode:
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1

# this part will add the rs($t7) bits to display buffer
la	$t3, ($t7)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rs to the display buffer
bne_loop:
beq	$t1, $zero, bne_next
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rs index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	bne_loop


bne_next:
# this part will add rt($t6) bits to display buffer
la	$t3, ($t6)			# load the rs binary string 
addi	$t1, $zero, 5			# make counter equal to 5 for each byte to add

# add the 5 bit representation of rt to the display buffer
bne_loop2:
beq	$t1, $zero, bne_next2
lbu	$t4, ($t3)			# load byte 
sb	$t4, ($a0)			# save byte to display buffer
addi	$a0, $a0, 1			# increment display buffer address to move to next index
addi	$t3, $t3, 1			# increment rt index to next byte
subi	$t1, $t1, 1			# decrement counter by 1
j	bne_loop2

bne_next2:
# next, the random 16 bit int will need to be added to the display buffer to complete the 32 bit instruction
addi	$t1, $zero, 15			# creates a counter to add the 15 bits

bne_loop3:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
beq	$t1, $zero, bne_last		# if the counter is 0 all 15 bits have been added, just add null
srlv	$t0, $t0, $t1			# shift bit to lsb position
and	$t2, $t0, 1			# isolate the LSB into $t2
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index
subi	$t1, $t1, 1			# decrement counter by 1
j	beq_loop3		

bne_last:
add	$t0, $zero, $s3			# loads the 15 bit random int into $t1
and	$t2, $t0, 1			# isolate lsb
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index


# the final part is to add a null at the end of the display buffer
ori	$t1, $zero, 0
sb	$t1, ($a0)			# store the null char at the end of the display buffer

j 	continue_program

#############################################################################################################
J_type:
# first generate a 26 bit random int

addi	$v0, $zero, 42			# to generate random int
addi	$a1, $zero, 0xFFFFFF		# upper bound for random int
syscall

sll	$a0, $a0, 2			# shift randominzed int left by to to make it a 26 bit instead of 24
add	$s4, $zero, $a0			# saves the random int into $s4

# next, add the 000010 op code for the jump instruction into the display buffer
la	$a0, display

addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x31		# holds hex representation of '1'
sb	$t1, ($a0)			# store 1 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1
addi	$t1, $zero, 0x30		# holds hex representation of '0'
sb	$t1, ($a0)			# store 0 into display buffer
addi	$a0, $a0, 1			# increment the index of display by 1

# next, the random 26 bit int will need to be added to the display buffer to complete the 32 bit instruction
addi	$t1, $zero, 25			# creates a counter to add the 25 bits

LOOP:
add	$t0, $zero, $s4			# loads the 26 bit random int into $t1
beq	$t1, $zero, last		# if the counter is 0 all 26 bits have been added, just add null
srlv	$t0, $t0, $t1			# shift bit to lsb position
and	$t2, $t0, 1			# isolate the LSB into $t2
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index
subi	$t1, $t1, 1			# decrement counter by 1
j	LOOP		

last:
add	$t0, $zero, $s4			# loads the 26 bit random int into $t1
and	$t2, $t0, 1			# isolate lsb
add	$t2, $t2, 48			# if the bit is a 0, adding 48 will make it '0', if the bit is a 1, it will become '1'
sb	$t2, ($a0)			# store the byte into the display buffer
addi	$a0, $a0, 1			# increment buffer by 1 index


# the final part is to add a null at the end of the display buffer
addi	$t1, $zero, 0
sb	$t1, ($a0)			# store the null char at the end of the display buffer

j 	continue_program
######################################################################################################
continue_program:
# by this point, i have the display buffer and now need to replace a random number of bits with '*'
# first i can copy the display buffer to the answer buffer
la	$t0, display
la	$t1, answer
addi	$t2, $zero, 33

copy_loop:
beq	$t2, $zero, keep_going
lbu	$t3, ($t0)			# load first byte of display
sb	$t3, ($t1)			# save that byte to answer buffer
addi	$t0, $t0, 1			# increment display buffer index
addi	$t1, $t1, 1			# increment answer buffer index
subi	$t2, $t2, 1			# decrement counter
j	copy_loop

keep_going:
# This  will replace random int number of bits with '*'

addi	$s2, $zero, 0x2a		 # holds star character

addi	$v0, $zero, 42			# for random int syscall
addi	$a1, $zero, 8			# upper bound of range
syscall

addi	$a0, $a0, 1			# to make sure that the number of chars to replace with '*' is not 0
add	$a2, $zero, $a0			# make copy of random int to $a2
	

ReplaceChars:
beq	$a2, $zero, next_step
# makes sys call to generate rand char in $a0
RC_generate:
addi	$v0, $zero, 42	#adds 42 to $v0 for rand int range syscall
addi	$a1, $zero , 32 #adds str_len -1 as upper bounds of rand range
syscall

# This loads the input string
la	$a3, answer			# load address of answer buffer

RC_loop:
add 	$a3, $a3, $a0			# to the answer address, add random number to move index over randomly
RC_replace:
lbu	$t1, ($a3)			# load the byte at that index
beq	$t1, '*', RC_generate		# makes sure that the byte there is not already a '*'
sb	$s2, 0($a3)			# store '*' at randomized index in answer buffer
subi	$a2, $a2, 1			# decrement random int by 1
j	 ReplaceChars	

####################################
next_step:
# next form the correct answer in the hidden answer buffer
addi	$t2, $zero, 0			# current index on answer	
la	$t5, hiddenAnswer

###################################
getAnswerLooop:

la	$t0, answer			# loads address of starred out instruction
beq	$t2, 32, continueProgram
add	$t0, $t0, $t2			# add current index to the address of answer
lbu	$t1, ($t0)			# loads byte of answer

beq	$t1, 0x2a , storeBit		# if the byte is a star, we want to grab the corresponding bit in the display buffer
addi	$t2, $t2, 1			# increment index by 1
j	getAnswerLooop

storeBit:
la	$t3, display			# load address of correct instruction
add	$t3, $t3, $t2			# add index to that address
lbu	$t4, ($t3)			# load the byte to be saved
sb	$t4, ($t5)			# save byte to hidden answer
addi	$t5, $t5, 1			# increment the hidden answer index by 1
addi	$t2, $t2, 1			# increment the index to next int


j	getAnswerLooop

##############################################################################################
continueProgram:
la	$t0, ($s7)			# load randomly picked char instruction
lbu	$t1, ($t0)			# load first char of the instruction

# checks the first letter of the instruction to construct the proper string to display to the user
beq	$t1, 'a', addDifferentiate
beq	$t1, 'o', orDifferentiate
beq	$t1, 'l', lwInstr
beq	$t1, 's', swInstr
beq	$t1, 'j', jInstr
beq	$t1, 'b', bDifferentiate

addDifferentiate:
addi	$t0, $t0, 3			# move to 4th char and see if its an i, else its add
lbu	$t1, ($t0)			# load char
beq	$t1, 'i', addiInstr
j	addInstr

orDifferentiate:
addi	$t0, $t0, 2			# move to 3rd char and see if its an i, else its or
lbu	$t1, ($t0)			# load char
beq	$t1, 'i', oriInstr
j	orInstr

###################################
addInstr:
#This will print the correct output to the user as per the Assignment 1 guidelines
addi	$v0, $zero, 4
la	$a0, ($s7)
syscall
la	$a0, space
syscall
la	$a0, ($s5)
syscall
la	$a0, commaSpace
syscall
la	$a0, ($s4)
syscall
la	$a0, commaSpace
syscall
la	$a0, ($s3)
syscall
la	$a0, newLine
syscall
la	$a0, STR_1
syscall
la	$a0, answer
syscall
la	$a0, newLine
syscall
la	$a0, STR_2
syscall

# read user input
addi	$v0, $zero, 8
la	$a0, userInput
addi	$a1, $zero, 50
syscall

# analyze first char of user input
la	$t0, userInput
lbu	$t1, ($t0)

beq	$t1, '.', end
beq	$t1, '?', showAnswer

# first i will get the length of the user input. if its length is not equal to the length of the right answer, i dislay "try again"
la	$t0, userInput			# load string that you need length of
addi	$t2, $zero, 0			# holds null byte
addi	$t4, $zero, 0 			# will hold the length of the user input

lenLoop1:
lb	$t1, ($t0)			# loads byte of user input
beq	$t1, $t2, moveOn		# if null is found, end of string is found, so program continues
addi	$t4, $t4, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of user input by 1 index
j	lenLoop1

moveOn:
# next i'll get the length of the correct answer (hiddenAnswer buffer)
la	$t0, hiddenAnswer		# loads the correct answer string
addi	$t2, $zero, 0			# holds the null byte
addi	$s0, $zero, 0			# will hold the length of the correct answer string

lenLoop2:
lb	$t1, ($t0)			# loads byte of correct answer
beq	$t1, $t2, nextPart		# if null, end of string, so program continutes
addi	$s0, $s0, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of correct answer by 1 index
j	lenLoop2	

nextPart:
# this checks to make sure that the correct answer and the user input are the same len. If theyre not, 'Try again'
subi	$t4, $t4, 1			# remove 1 from length to remove length added by null

bne	$t4, $s0, invalidInput

la	$t0, hiddenAnswer		# load correct answer
la	$t1, userInput			# load user input

analyzeInput:
lbu	$t2, ($t0)			# load byte of correct answer
lbu	$t3, ($t1)			# load byte of user input
beq	$t2, '\0', showScore		# if null bit is reached, show answer and continue program
beq	$t2, $t3, awardPoints		
subi	$s1, $s1, 1			# remove 1 point for an incorrect answer
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j	analyzeInput

awardPoints:
addi	$s1, $s1, 2			# add 2 points to the user's score for each correct bit
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j 	analyzeInput

showScore:
addi	$v0, $zero, 4
la	$a0, STR_3
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
la	$a0, STR_4
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s1
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
j	MAIN_LOOP

# Reports to user that the answer they entered has too many/few guessed bits, and reprompts for answer again
invalidInput:
addi	$v0, $zero, 4
la	$a0, bad
syscall
la	$a0, newLine
syscall
j	addInstr

showAnswer:
addi	$v0, $zero, 4
la	$a0, STR_5
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
j	addInstr

#################################
addiInstr:
#This will print the correct output to the user as per the Assignment 1 guidelines
addi	$v0, $zero, 4
la	$a0, ($s7)
syscall
la	$a0, space
syscall
la	$a0, ($s4)
syscall
la	$a0, commaSpace
syscall
la	$a0, ($s5)
syscall
la	$a0, commaSpace
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s3
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
la	$a0, STR_1
syscall
la	$a0, answer
syscall
la	$a0, newLine
syscall
la	$a0, STR_2
syscall

# read user input
addi	$v0, $zero, 8
la	$a0, userInput
addi	$a1, $zero, 50
syscall

# analyze first char of user input
la	$t0, userInput
lbu	$t1, ($t0)

beq	$t1, '.', end
beq	$t1, '?', showAnswer2

# first i will get the length of the user input. if its length is not equal to the length of the right answer, i dislay "try again"
la	$t0, userInput			# load string that you need length of
addi	$t2, $zero, 0			# holds null byte
addi	$t4, $zero, 0 			# will hold the length of the user input

lenLoop11:
lb	$t1, ($t0)			# loads byte of user input
beq	$t1, $t2, moveOn2		# if null is found, end of string is found, so program continues
addi	$t4, $t4, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of user input by 1 index
j	lenLoop11

moveOn2:
# next i'll get the length of the correct answer (hiddenAnswer buffer)
la	$t0, hiddenAnswer		# loads the correct answer string
addi	$t2, $zero, 0			# holds the null byte
addi	$s0, $zero, 0			# will hold the length of the correct answer string

lenLoop22:
lb	$t1, ($t0)			# loads byte of correct answer
beq	$t1, $t2, nextPart2		# if null, end of string, so program continutes
addi	$s0, $s0, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of correct answer by 1 index
j	lenLoop22	

nextPart2:
# this checks to make sure that the correct answer and the user input are the same len. If theyre not, 'Try again'
subi	$t4, $t4, 1			# remove 1 from length to remove length added by null

bne	$t4, $s0, invalidInput2

la	$t0, hiddenAnswer		# load correct answer
la	$t1, userInput			# load user input

analyzeInput2:
lbu	$t2, ($t0)			# load byte of correct answer
lbu	$t3, ($t1)			# load byte of user input
beq	$t2, '\0', showScore2		# if null bit is reached, show answer and continue program
beq	$t2, $t3, awardPoints2		
subi	$s1, $s1, 1			# remove 1 point for an incorrect answer
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j	analyzeInput2

awardPoints2:
addi	$s1, $s1, 2			# add 2 points to the user's score for each correct bit
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j 	analyzeInput2

showScore2:
addi	$v0, $zero, 4
la	$a0, STR_3
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
la	$a0, STR_4
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s1
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
j	MAIN_LOOP

showAnswer2:
addi	$v0, $zero, 4
la	$a0, STR_5
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
j	addiInstr

invalidInput2:
addi	$v0, $zero, 4
la	$a0, bad
syscall
la	$a0, newLine
syscall
j	addiInstr

###################################################
orInstr:
#This will print the correct output to the user as per the Assignment 1 guidelines
addi	$v0, $zero, 4
la	$a0, ($s7)
syscall
la	$a0, space
syscall
la	$a0, ($s5)
syscall
la	$a0, commaSpace
syscall
la	$a0, ($s4)
syscall
la	$a0, commaSpace
syscall
la	$a0, ($s3)
syscall
la	$a0, newLine
syscall
la	$a0, STR_1
syscall
la	$a0, answer
syscall
la	$a0, newLine
syscall
la	$a0, STR_2
syscall

# read user input
addi	$v0, $zero, 8
la	$a0, userInput
addi	$a1, $zero, 50
syscall

# analyze first char of user input
la	$t0, userInput
lbu	$t1, ($t0)

beq	$t1, '.', end
beq	$t1, '?', showAnswer3

# first i will get the length of the user input. if its length is not equal to the length of the right answer, i dislay "try again"
la	$t0, userInput			# load string that you need length of
addi	$t2, $zero, 0			# holds null byte
addi	$t4, $zero, 0 			# will hold the length of the user input

lenLoop3:
lb	$t1, ($t0)			# loads byte of user input
beq	$t1, $t2, moveOn3		# if null is found, end of string is found, so program continues
addi	$t4, $t4, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of user input by 1 index
j	lenLoop3

moveOn3:
# next i'll get the length of the correct answer (hiddenAnswer buffer)
la	$t0, hiddenAnswer		# loads the correct answer string
addi	$t2, $zero, 0			# holds the null byte
addi	$s0, $zero, 0			# will hold the length of the correct answer string

lenLoop4:
lb	$t1, ($t0)			# loads byte of correct answer
beq	$t1, $t2, nextPart3		# if null, end of string, so program continutes
addi	$s0, $s0, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of correct answer by 1 index
j	lenLoop4	

nextPart3:
# this checks to make sure that the correct answer and the user input are the same len. If theyre not, 'Try again'
subi	$t4, $t4, 1			# remove 1 from length to remove length added by null

bne	$t4, $s0, invalidInput3

la	$t0, hiddenAnswer		# load correct answer
la	$t1, userInput			# load user input

analyzeInput3:
lbu	$t2, ($t0)			# load byte of correct answer
lbu	$t3, ($t1)			# load byte of user input
beq	$t2, '\0', showScore3		# if null bit is reached, show answer and continue program
beq	$t2, $t3, awardPoints3		
subi	$s1, $s1, 1			# remove 1 point for an incorrect answer
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j	analyzeInput

awardPoints3:
addi	$s1, $s1, 2			# add 2 points to the user's score for each correct bit
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j 	analyzeInput3

showScore3:
addi	$v0, $zero, 4
la	$a0, STR_3
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
la	$a0, STR_4
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s1
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
j	MAIN_LOOP

# Reports to user that the answer they entered has too many/few guessed bits, and reprompts for answer again
invalidInput3:
addi	$v0, $zero, 4
la	$a0, bad
syscall
la	$a0, newLine
syscall
j	orInstr

showAnswer3:
addi	$v0, $zero, 4
la	$a0, STR_5
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
j	orInstr

##################################################
oriInstr:
#This will print the correct output to the user as per the Assignment 1 guidelines
addi	$v0, $zero, 4
la	$a0, ($s7)
syscall
la	$a0, space
syscall
la	$a0, ($s4)
syscall
la	$a0, commaSpace
syscall
la	$a0, ($s5)
syscall
la	$a0, commaSpace
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s3
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
la	$a0, STR_1
syscall
la	$a0, answer
syscall
la	$a0, newLine
syscall
la	$a0, STR_2
syscall

# read user input
addi	$v0, $zero, 8
la	$a0, userInput
addi	$a1, $zero, 50
syscall

# analyze first char of user input
la	$t0, userInput
lbu	$t1, ($t0)

beq	$t1, '.', end
beq	$t1, '?', showAnswer4

# first i will get the length of the user input. if its length is not equal to the length of the right answer, i dislay "try again"
la	$t0, userInput			# load string that you need length of
addi	$t2, $zero, 0			# holds null byte
addi	$t4, $zero, 0 			# will hold the length of the user input

lenLoop44:
lb	$t1, ($t0)			# loads byte of user input
beq	$t1, $t2, moveOn4		# if null is found, end of string is found, so program continues
addi	$t4, $t4, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of user input by 1 index
j	lenLoop44

moveOn4:
# next i'll get the length of the correct answer (hiddenAnswer buffer)
la	$t0, hiddenAnswer		# loads the correct answer string
addi	$t2, $zero, 0			# holds the null byte
addi	$s0, $zero, 0			# will hold the length of the correct answer string

lenLoop5:
lb	$t1, ($t0)			# loads byte of correct answer
beq	$t1, $t2, nextPart4		# if null, end of string, so program continutes
addi	$s0, $s0, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of correct answer by 1 index
j	lenLoop5	

nextPart4:
# this checks to make sure that the correct answer and the user input are the same len. If theyre not, 'Try again'
subi	$t4, $t4, 1			# remove 1 from length to remove length added by null

bne	$t4, $s0, invalidInput4

la	$t0, hiddenAnswer		# load correct answer
la	$t1, userInput			# load user input

analyzeInput4:
lbu	$t2, ($t0)			# load byte of correct answer
lbu	$t3, ($t1)			# load byte of user input
beq	$t2, '\0', showScore4		# if null bit is reached, show answer and continue program
beq	$t2, $t3, awardPoints4		
subi	$s1, $s1, 1			# remove 1 point for an incorrect answer
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j	analyzeInput4

awardPoints4:
addi	$s1, $s1, 2			# add 2 points to the user's score for each correct bit
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j 	analyzeInput4

showScore4:
addi	$v0, $zero, 4
la	$a0, STR_3
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
la	$a0, STR_4
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s1
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
j	MAIN_LOOP

showAnswer4:
addi	$v0, $zero, 4
la	$a0, STR_5
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
j	oriInstr

invalidInput4:
addi	$v0, $zero, 4
la	$a0, bad
syscall
la	$a0, newLine
syscall
j	oriInstr

######################################################
lwInstr:
#This will print the correct output to the user as per the Assignment 1 guidelines
addi	$v0, $zero, 4
la	$a0, ($s7)
syscall
la	$a0, space
syscall
la	$a0, ($s4)
syscall
la	$a0, commaSpace
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s3
syscall
addi	$v0, $zero, 4
la	$a0, openParen
syscall
la	$a0, ($s5)
syscall
la	$a0, closeParen
syscall
la	$a0, newLine
syscall
la	$a0, STR_1
syscall
la	$a0, answer
syscall
la	$a0, newLine
syscall
la	$a0, STR_2
syscall

# read user input
addi	$v0, $zero, 8
la	$a0, userInput
addi	$a1, $zero, 50
syscall

# analyze first char of user input
la	$t0, userInput
lbu	$t1, ($t0)

beq	$t1, '.', end
beq	$t1, '?', showAnswer8

# first i will get the length of the user input. if its length is not equal to the length of the right answer, i dislay "try again"
la	$t0, userInput			# load string that you need length of
addi	$t2, $zero, 0			# holds null byte
addi	$t4, $zero, 0 			# will hold the length of the user input

lenLoop8:
lb	$t1, ($t0)			# loads byte of user input
beq	$t1, $t2, moveOn8		# if null is found, end of string is found, so program continues
addi	$t4, $t4, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of user input by 1 index
j	lenLoop8

moveOn8:
# next i'll get the length of the correct answer (hiddenAnswer buffer)
la	$t0, hiddenAnswer		# loads the correct answer string
addi	$t2, $zero, 0			# holds the null byte
addi	$s0, $zero, 0			# will hold the length of the correct answer string

lenLoop9:
lb	$t1, ($t0)			# loads byte of correct answer
beq	$t1, $t2, nextPart9		# if null, end of string, so program continutes
addi	$s0, $s0, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of correct answer by 1 index
j	lenLoop9	

nextPart9:
# this checks to make sure that the correct answer and the user input are the same len. If theyre not, 'Try again'
subi	$t4, $t4, 1			# remove 1 from length to remove length added by null

bne	$t4, $s0, invalidInput9

la	$t0, hiddenAnswer		# load correct answer
la	$t1, userInput			# load user input

analyzeInput9:
lbu	$t2, ($t0)			# load byte of correct answer
lbu	$t3, ($t1)			# load byte of user input
beq	$t2, '\0', showScore9		# if null bit is reached, show answer and continue program
beq	$t2, $t3, awardPoints9		
subi	$s1, $s1, 1			# remove 1 point for an incorrect answer
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j	analyzeInput9

awardPoints9:
addi	$s1, $s1, 2			# add 2 points to the user's score for each correct bit
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j 	analyzeInput9

showScore9:
addi	$v0, $zero, 4
la	$a0, STR_3
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
la	$a0, STR_4
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s1
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
j	MAIN_LOOP

showAnswer8:
addi	$v0, $zero, 4
la	$a0, STR_5
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
j	lwInstr

invalidInput9:
addi	$v0, $zero, 4
la	$a0, bad
syscall
la	$a0, newLine
syscall
j	lwInstr
######################################################
swInstr:
#This will print the correct output to the user as per the Assignment 1 guidelines
addi	$v0, $zero, 4
la	$a0, ($s7)
syscall
la	$a0, space
syscall
la	$a0, ($s4)
syscall
la	$a0, commaSpace
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s3
syscall
addi	$v0, $zero, 4
la	$a0, openParen
syscall
la	$a0, ($s5)
syscall
la	$a0, closeParen
syscall
la	$a0, newLine
syscall
la	$a0, STR_1
syscall
la	$a0, answer
syscall
la	$a0, newLine
syscall
la	$a0, STR_2
syscall

# read user input
addi	$v0, $zero, 8
la	$a0, userInput
addi	$a1, $zero, 50
syscall

# analyze first char of user input
la	$t0, userInput
lbu	$t1, ($t0)

beq	$t1, '.', end
beq	$t1, '?', showAnswer88

# first i will get the length of the user input. if its length is not equal to the length of the right answer, i dislay "try again"
la	$t0, userInput			# load string that you need length of
addi	$t2, $zero, 0			# holds null byte
addi	$t4, $zero, 0 			# will hold the length of the user input

lenLoop88:
lb	$t1, ($t0)			# loads byte of user input
beq	$t1, $t2, moveOn88		# if null is found, end of string is found, so program continues
addi	$t4, $t4, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of user input by 1 index
j	lenLoop88

moveOn88:
# next i'll get the length of the correct answer (hiddenAnswer buffer)
la	$t0, hiddenAnswer		# loads the correct answer string
addi	$t2, $zero, 0			# holds the null byte
addi	$s0, $zero, 0			# will hold the length of the correct answer string

lenLoop99:
lb	$t1, ($t0)			# loads byte of correct answer
beq	$t1, $t2, nextPart99		# if null, end of string, so program continutes
addi	$s0, $s0, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of correct answer by 1 index
j	lenLoop99	

nextPart99:
# this checks to make sure that the correct answer and the user input are the same len. If theyre not, 'Try again'
subi	$t4, $t4, 1			# remove 1 from length to remove length added by null

bne	$t4, $s0, invalidInput99

la	$t0, hiddenAnswer		# load correct answer
la	$t1, userInput			# load user input

analyzeInput99:
lbu	$t2, ($t0)			# load byte of correct answer
lbu	$t3, ($t1)			# load byte of user input
beq	$t2, '\0', showScore99		# if null bit is reached, show answer and continue program
beq	$t2, $t3, awardPoints99		
subi	$s1, $s1, 1			# remove 1 point for an incorrect answer
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j	analyzeInput99

awardPoints99:
addi	$s1, $s1, 2			# add 2 points to the user's score for each correct bit
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j 	analyzeInput99

showScore99:
addi	$v0, $zero, 4
la	$a0, STR_3
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
la	$a0, STR_4
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s1
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
j	MAIN_LOOP

showAnswer88:
addi	$v0, $zero, 4
la	$a0, STR_5
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
j	swInstr

invalidInput99:
addi	$v0, $zero, 4
la	$a0, bad
syscall
la	$a0, newLine
syscall
j	swInstr

#######################################################
jInstr:
#This will print the correct output to the user as per the Assignment 1 guidelines
addi	$v0, $zero, 4
la	$a0, ($s7)
syscall
la	$a0, space
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s4
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
la	$a0, STR_1
syscall
la	$a0, answer
syscall
la	$a0, newLine
syscall
la	$a0, STR_2
syscall

# read user input
addi	$v0, $zero, 8
la	$a0, userInput
addi	$a1, $zero, 50
syscall

# analyze first char of user input
la	$t0, userInput
lbu	$t1, ($t0)

beq	$t1, '.', end
beq	$t1, '?', showAnswer333

# first i will get the length of the user input. if its length is not equal to the length of the right answer, i dislay "try again"
la	$t0, userInput			# load string that you need length of
addi	$t2, $zero, 0			# holds null byte
addi	$t4, $zero, 0 			# will hold the length of the user input

lenLoop333:
lb	$t1, ($t0)			# loads byte of user input
beq	$t1, $t2, moveOn333		# if null is found, end of string is found, so program continues
addi	$t4, $t4, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of user input by 1 index
j	lenLoop333

moveOn333:
# next i'll get the length of the correct answer (hiddenAnswer buffer)
la	$t0, hiddenAnswer		# loads the correct answer string
addi	$t2, $zero, 0			# holds the null byte
addi	$s0, $zero, 0			# will hold the length of the correct answer string

lenLoop444:
lb	$t1, ($t0)			# loads byte of correct answer
beq	$t1, $t2, nextPart333		# if null, end of string, so program continutes
addi	$s0, $s0, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of correct answer by 1 index
j	lenLoop444	



nextPart333:
# this checks to make sure that the correct answer and the user input are the same len. If theyre not, 'Try again'
subi	$t4, $t4, 1			# remove 1 from length to remove length added by null

bne	$t4, $s0, invalidInput333

la	$t0, hiddenAnswer		# load correct answer
la	$t1, userInput			# load user input

analyzeInput333:
lbu	$t2, ($t0)			# load byte of correct answer
lbu	$t3, ($t1)			# load byte of user input
beq	$t2, '\0', showScore333		# if null bit is reached, show answer and continue program
beq	$t2, $t3, awardPoints333		
subi	$s1, $s1, 1			# remove 1 point for an incorrect answer
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j	analyzeInput333

awardPoints333:
addi	$s1, $s1, 2			# add 2 points to the user's score for each correct bit
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j 	analyzeInput333

showScore333:
addi	$v0, $zero, 4
la	$a0, STR_3
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
la	$a0, STR_4
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s1
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
j	MAIN_LOOP

# Reports to user that the answer they entered has too many/few guessed bits, and reprompts for answer again
invalidInput333:
addi	$v0, $zero, 4
la	$a0, bad
syscall
la	$a0, newLine
syscall
j	jInstr

showAnswer333:
addi	$v0, $zero, 4
la	$a0, STR_5
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
j	jInstr

###################
bDifferentiate:
addi	$t0, $t0, 1			# move to 2nd char and see if its an e, else its bne
lbu	$t1, ($t0)			# load char
beq	$t1, 'e', beqInstr
j	bneInstr

beqInstr:
#This will print the correct output to the user as per the Assignment 1 guidelines
addi	$v0, $zero, 4
la	$a0, ($s7)
syscall
la	$a0, space
syscall
syscall
la	$a0, ($s5)
syscall
la	$a0, commaSpace
syscall
la	$a0, ($s4)
syscall
la	$a0, commaSpace
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s3
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
la	$a0, STR_1
syscall
la	$a0, answer
syscall
la	$a0, newLine
syscall
la	$a0, STR_2
syscall

# read user input
addi	$v0, $zero, 8
la	$a0, userInput
addi	$a1, $zero, 50
syscall

# analyze first char of user input
la	$t0, userInput
lbu	$t1, ($t0)

beq	$t1, '.', end
beq	$t1, '?', showAnswer5

# first i will get the length of the user input. if its length is not equal to the length of the right answer, i dislay "try again"
la	$t0, userInput			# load string that you need length of
addi	$t2, $zero, 0			# holds null byte
addi	$t4, $zero, 0 			# will hold the length of the user input

lenLoop55:
lb	$t1, ($t0)			# loads byte of user input
beq	$t1, $t2, moveOn5		# if null is found, end of string is found, so program continues
addi	$t4, $t4, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of user input by 1 index
j	lenLoop55

moveOn5:
# next i'll get the length of the correct answer (hiddenAnswer buffer)
la	$t0, hiddenAnswer		# loads the correct answer string
addi	$t2, $zero, 0			# holds the null byte
addi	$s0, $zero, 0			# will hold the length of the correct answer string

lenLoop6:
lb	$t1, ($t0)			# loads byte of correct answer
beq	$t1, $t2, nextPart5		# if null, end of string, so program continutes
addi	$s0, $s0, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of correct answer by 1 index
j	lenLoop6	

nextPart5:
# this checks to make sure that the correct answer and the user input are the same len. If theyre not, 'Try again'
subi	$t4, $t4, 1			# remove 1 from length to remove length added by null

bne	$t4, $s0, invalidInput5

la	$t0, hiddenAnswer		# load correct answer
la	$t1, userInput			# load user input

analyzeInput5:
lbu	$t2, ($t0)			# load byte of correct answer
lbu	$t3, ($t1)			# load byte of user input
beq	$t2, '\0', showScore5		# if null bit is reached, show answer and continue program
beq	$t2, $t3, awardPoints5	
subi	$s1, $s1, 1			# remove 1 point for an incorrect answer
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j	analyzeInput5

awardPoints5:
addi	$s1, $s1, 2			# add 2 points to the user's score for each correct bit
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j 	analyzeInput5


showScore5:
addi	$v0, $zero, 4
la	$a0, STR_3
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
la	$a0, STR_4
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s1
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
j	MAIN_LOOP

showAnswer5:
addi	$v0, $zero, 4
la	$a0, STR_5
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
j	beqInstr

invalidInput5:
addi	$v0, $zero, 4
la	$a0, bad
syscall
la	$a0, newLine
syscall
j	beqInstr

###################################################
bneInstr:
#This will print the correct output to the user as per the Assignment 1 guidelines
addi	$v0, $zero, 4
la	$a0, ($s7)
syscall
la	$a0, space
syscall
syscall
la	$a0, ($s5)
syscall
la	$a0, commaSpace
syscall
la	$a0, ($s4)
syscall
la	$a0, commaSpace
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s3
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
la	$a0, STR_1
syscall
la	$a0, answer
syscall
la	$a0, newLine
syscall
la	$a0, STR_2
syscall

# read user input
addi	$v0, $zero, 8
la	$a0, userInput
addi	$a1, $zero, 50
syscall

# analyze first char of user input
la	$t0, userInput
lbu	$t1, ($t0)

beq	$t1, '.', end
beq	$t1, '?', showAnswer6

# first i will get the length of the user input. if its length is not equal to the length of the right answer, i dislay "try again"
la	$t0, userInput			# load string that you need length of
addi	$t2, $zero, 0			# holds null byte
addi	$t4, $zero, 0 			# will hold the length of the user input

lenLoop66:
lb	$t1, ($t0)			# loads byte of user input
beq	$t1, $t2, moveOn66		# if null is found, end of string is found, so program continues
addi	$t4, $t4, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of user input by 1 index
j	lenLoop66

moveOn66:
# next i'll get the length of the correct answer (hiddenAnswer buffer)
la	$t0, hiddenAnswer		# loads the correct answer string
addi	$t2, $zero, 0			# holds the null byte
addi	$s0, $zero, 0			# will hold the length of the correct answer string

lenLoop7:
lb	$t1, ($t0)			# loads byte of correct answer
beq	$t1, $t2, nextPart6		# if null, end of string, so program continutes
addi	$s0, $s0, 1			# increment len by 1
addi	$t0, $t0, 1			# increment address of correct answer by 1 index
j	lenLoop7	

nextPart6:
# this checks to make sure that the correct answer and the user input are the same len. If theyre not, 'Try again'
subi	$t4, $t4, 1			# remove 1 from length to remove length added by null

bne	$t4, $s0, invalidInput6

la	$t0, hiddenAnswer		# load correct answer
la	$t1, userInput			# load user input

analyzeInput6:
lbu	$t2, ($t0)			# load byte of correct answer
lbu	$t3, ($t1)			# load byte of user input
beq	$t2, '\0', showScore6		# if null bit is reached, show answer and continue program
beq	$t2, $t3, awardPoints6	
subi	$s1, $s1, 1			# remove 1 point for an incorrect answer
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j	analyzeInput6

awardPoints6:
addi	$s1, $s1, 2			# add 2 points to the user's score for each correct bit
addi	$t0, $t0, 1			# increment index by 1
addi 	$t1, $t1, 1			# increment index by 1
j 	analyzeInput6


showScore6:
addi	$v0, $zero, 4
la	$a0, STR_3
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
la	$a0, STR_4
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s1
syscall
addi	$v0, $zero, 4
la	$a0, newLine
syscall
j	MAIN_LOOP

showAnswer6:
addi	$v0, $zero, 4
la	$a0, STR_5
syscall
la	$a0, display
syscall
la	$a0, newLine
syscall
j	bneInstr

invalidInput6:
addi	$v0, $zero, 4
la	$a0, bad
syscall
la	$a0, newLine
syscall
j	bneInstr


##########################################################################
end:
addi	$v0, $zero, 4
la	$a0, ExitString
syscall
addi	$v0, $zero, 10
syscall

##################################
LAWLS:


