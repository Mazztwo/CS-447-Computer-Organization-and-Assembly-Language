
# Assignment 2

.data
Forfeit_String:		.asciiz		"Game forfeited. Your score was "
GameFinished_String:	.asciiz		"Game finished. Your score was "
leftFlies:		.byte		99,99,99,99,4,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99
rightFlies:		.byte		99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99
red:		 	.word		1
yellow:			.word		2
green:			.word		3
black:			.word		0
curr_x:			.word		32
curr_y:			.word		4
new_y:			.word		32

.text
# starts frog at (32, 4)
############################
lw	$a0, curr_x			# loads the current position of X, by defult it is 32	
lw	$a1, curr_y			# loads the current position of Y, by defult it is 4
lw	$a2, green
jal 	_setLED

# starts first fly at (4,4)
############################
addi	$a0, $zero, 4			# X
addi	$a1, $zero, 4			# Y
lw	$a2, yellow			# Color
jal	_setLED

# initializes score to 0. Score will be held in $s5
addi	$s5, $zero, 0


# grabs time(START)
addi	$v0, $zero, 30
syscall					# grabs system time
add	$s7, $zero, $a0			# stores this time into $s7 as time(START)

############################
# this is the main loop of the game
gameLoop:
		
jal	keyPressed
back:
jal	moveFlies
back2:
j	gameLoop


############################
# this function will check each row every 10ms and move flies if they are there
moveFlies:
addi	$v0, $zero, 30
syscall					# grabs system time
add	$s6, $zero, $a0			# stores this time into $s6 as time(CURRENT)

sub	$t8, $s6, $s7			# gets the elapsed time
bgt	$t8, 640, moveTheFly

j	back2

moveTheFly:
#################
#these three lines below will update time(START)
addi	$v0, $zero, 30
syscall
add	$s7, $zero, $a0
#################

update_flies:
addi	$t9, $zero, 0			# keeps track of index of current row
la	$s0, leftFlies
la	$s1, rightFlies	

UF_loop:
beq	$t9, 64, backToMain		# goes back to main when all rows have been updated

lbu	$s2, ($s0)			# load X value of left flies index
beq	$s2, 99, checkRight		# if the X value for that row is -1, it means there's no fly on the left side, so check right side
beq	$s2, 32, gameOver		# if the fly's X coordinate is 32, the game is over

add	$a0, $zero, $s2			# pass X value as argument for _setLED
add	$a1, $zero, $t9			# pass curr index of left flies, which corresponds to Y value, as argument for _setLED
lw	$a2, black		
jal	_setLED				# set curr position of fly to black

addi	$s2, $s2, 1			# add 1 to X to make fly move right by 1
sb	$s2, ($s0)			# update X to X + 1 in leftFlies array

add	$a0, $zero, $s2			# X + 1 is new argument for _setLED
add	$a1, $zero, $t9			# curr index of left flies is argument of _setLED
lw	$a2, yellow
jal	_setLED				# move fly to X + 1 position in same row


checkRight:
lbu	$s3, ($s1)			# load X value of right flies index
beq	$s3, 99, nextRow		# if the X value for that row is -1, it means theres no flies in this row, so increment index to move to next row
beq	$s3, 32, gameOver		# if the fly's X coordinate is 32, the game is over

add	$a0, $zero, $s3			# pass X value as argument for _setLED
add	$a1, $zero, $t9			# pass curr index of right flies, which corresponds to Y value, as argument for _setLED  
lw	$a2, black
jal	_setLED				# set curr position of fly to black

subi	$s3, $s3, 1			# subtract 1 to make fly move left by 1
sb	$s3, ($s1)			# update X to X - 1 in rightFlies array

add	$a0, $zero, $s3			# X - 1 is new argument for _setLED
add	$a1, $zero, $t9			# curr index of right flies is argument of _setLED
lw	$a2, yellow			
jal	_setLED				# move fly to X - 1 position in same row


nextRow:
addi	$t9, $t9, 1			# increment index by 1, moves to next row in board
addi	$s0, $s0, 1			# increment address by 1 index
addi	$s1, $s1, 1			# increment address by 1 index

j	UF_loop

backToMain:
j	back2


##################################
# if a fly reaches X = 32, then the game is over. The game finished string will print along with the user's score, and the program will end
gameOver:
addi	$v0, $zero, 4
la	$a0, GameFinished_String
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s5
syscall
addi	$v0, $zero, 10
syscall

######################################################################

spawn_flies_left:
addi	$t9, $zero, 2			# counter to add only 2 flies

sfl_back:
beq	$t9, $zero, backToFrogLeft
addi	$v0, $zero, 42
addi	$a1, $zero, 2			# if 0, add fly to left, else add fly to right
syscall

beq	$a0, 0, add_to_left1

addi	$v0, $zero, 42
addi	$a1, $zero, 64			# pick random row between in range [0-63]
syscall

#############################
# checks to see if the row already has a fly
la	$s4, rightFlies
add	$s4, $s4, $a0
lbu	$t1, ($s4)
bne	$t1, 99, sfl_back
#############################

add	$a1, $zero, $a0			# add fly at random row
addi	$a0, $zero, 60			# start fly at X = 60
lw	$a2, yellow
sb	$a0, ($s4)			# store 60 into flies randomized row in rightFlies
jal	_setLED				# put fly on board
subi	$t9, $t9, 1			# decrement counter
j	sfl_back

add_to_left1:
addi	$a1, $zero, 64			# pick random row between in range [0-63]
syscall

###############################
# checks to see if the row already has a fly
la	$s3, leftFlies
add	$s3, $s3, $a0
lbu	$t1, ($s3)
bne	$t1, 99, sfl_back
##############################

add	$a1, $zero, $a0			# add fly at random row
addi	$a0, $zero, 4			# start fly at X = 4
lw	$a2, yellow			
sb	$a0, ($s3)			# store 4 into flies randomized row in leftFlies
jal	_setLED				# put fly on board
subi	$t9, $t9, 1			# decrement counter 

j	sfl_back

backToFrogLeft:
j	LP_next			

######################################################################
spawn_flies_right:
addi	$t9, $zero, 2			# counter to add only 2 flies

sfr_back:
beq	$t9, $zero, backToFrogRight
addi	$v0, $zero, 42
addi	$a1, $zero, 2			# if 0, add fly to left, else add fly to right
syscall

beq	$a0, 0, add_to_left2

addi	$a1, $zero, 64			# pick random row between in range [0-63]
syscall

#############################
# checks to see if the row already has a fly
la	$s4, rightFlies
add	$s4, $s4, $a0
lbu	$t1, ($s4)
bne	$t1, 99, sfr_back
#############################

add	$a1, $zero, $a0			# add fly at random row
addi	$a0, $zero, 60			# start fly at X = 60
lw	$a2, yellow
sb	$a0, ($s4)			# store 60 into flies randomized row in rightFlies
jal	_setLED				# put fly on board
subi	$t9, $t9, 1			# decrement counter
j	sfr_back

add_to_left2:
addi	$a1, $zero, 64			# pick random row between in range [0-63]
syscall

##############################
# checks to see if the row already has a fly
la	$s3, leftFlies
add	$s3, $s3, $a0
lbu	$t1, ($s3)
bne	$t1, 99, sfr_back
##############################

add	$a1, $zero, $a0			# add fly at random row
addi	$a0, $zero, 4			# start fly at X = 4
lw	$a2, yellow	
sb	$a0, ($s3)			# store 4 into flies randomized row in leftFlies		
jal	_setLED				# put fly on board
subi	$t9, $t9, 1			# decrement counter 

j	sfr_back

backToFrogRight:
j	RP_next			

############################
# this function will check which key was pressed and will handle it properly
keyPressed:
li	$t0, 0xFFFF0000			# if the LSB at this address is 0, no key was pressed. If it is 1, a key was pressed
lw	$t1, ($t0)			# loads the word at 0xFFFF0000	
andi	$t1, $t1, 1			# isolates the LSB
beq	$t1, $zero, KP_end		# if the value is 0, no key was pressed, and returns to the main Game Loop
	
# if the program gets to this point, it means that a key was pressed
li	$t0, 0xFFFF0004			# this holds the value of they key that was pressed
lw	$t1, ($t0)			# loads the value of the key that was pressed
	
beq	$t1, 66, forfeitGame		# if the value of 'b' is found, that means that the player has chosen to end the game
beq 	$t1, 226, left_pressed		# if the value of 'a' is found, the player wants to shoot the frog's tongue left
beq	$t1, 227, right_pressed		# if the value of 'd' is found, the player wants to shoot the frog's tongue right
beq	$t1, 224, up_pressed		# if the value of 'w' is found, the player wants to move the frog up a position
beq	$t1, 225, down_pressed		# if the value of 's' is found, the player wants to move the frog down a position
	
############################
left_pressed:
lw	$t8, curr_x			# loads the current X position of the frog	
addi	$t9, $zero, 24				

# sticks out red part of tongue to max length of 24
left_tongue_loop1:
beq	$t9, $zero, LP_next
subi	$t8, $t8, 1
add	$a0, $zero, $t8
lw	$a1, curr_y			# loads the current Y position of the frog
jal	_getLED
beq	$v0, 2, flyHitLeft		# if a yellow LED is found, that means a fly was hit, else continue
lw	$a2, red
jal	_setLED	
subi	$t9, $t9, 1		
j	left_tongue_loop1

flyHitLeft:
addi	$s5, $s5, 1			# updates user score
lw	$a2, black			
jal	_setLED				# sets the LED at the end of the tongues length to black
jal	stopFlyLeft
spawn1:
jal 	spawn_flies_left

##############
LP_next:
# pause for 100ms
addi	$a0, $zero, 100
jal	Pause
##############

addi	$t9, $zero, 24			# counter for max tongue length

###################
# this loops makes the tongue come back to the frog.
left_tongue_loop2:
beq	$t9, 0, KP_end
add	$a0, $zero, $t8
lw	$a1, curr_y
jal	_getLED
beq	$v0, 3, KP_end			# if a green LED is seen, that means the tongue is back at the frog and the loop should end
lw	$a2, black
jal	_setLED	
subi	$t9, $t9, 1
addi	$t8, $t8, 1
j	left_tongue_loop2
###################

stopFlyLeft:
la	$t0, leftFlies
add	$t0, $t0, $a1			# adds curr Y value to index, to increment leftFlies to the right row
addi	$t1, $zero, 99			
sb	$t1, ($t0)			# updates array with 99, the value I have chosen to indicate that there is now fly on that row on that side
j	spawn1

############################
right_pressed:
lw	$t8, curr_x			# loads the current X position of the frog	
addi	$t9, $zero, 24				

# sticks out red part of tongue to max length of 24
right_tongue_loop1:
beq	$t9, $zero, RP_next
addi	$t8, $t8, 1
add	$a0, $zero, $t8
lw	$a1, curr_y			# loads the current Y position of the frog
jal	_getLED
beq	$v0, 2, flyHitRight		# if a yellow LED is found, that means a fly was hit, else continue
lw	$a2, red
jal	_setLED	
subi	$t9, $t9, 1		
j	right_tongue_loop1

flyHitRight:
addi	$s5, $s5, 1			# updates user score
lw	$a2, black
jal	_setLED				# sets the LED at the end of the tongues length to black
jal	stopFlyRight
spawn2:
jal 	spawn_flies_right

################
RP_next:
# pause for 100ms
addi	$a0, $zero, 100
jal	Pause
###############

addi	$t9, $zero, 24			# counter for max tongue length

###################
# this loops makes the tongue come back to the frog.
right_tongue_loop2:
beq	$t9, 0, KP_end
add	$a0, $zero, $t8
lw	$a1, curr_y
jal	_getLED
beq	$v0, 3, KP_end			# if a green LED is seen, that means the tongue is back at the frog and the loop should end
lw	$a2, black
jal	_setLED	
subi	$t9, $t9, 1
subi	$t8, $t8, 1
j	right_tongue_loop2
###################

stopFlyRight:
la	$t0, rightFlies
add	$t0, $t0, $a1			# adds curr Y value to index, to increment leftFlies to the right row
addi	$t1, $zero, 99			
sb	$t1, ($t0)			# updates array with 99, the value I have chosen to indicate that there is now fly on that row on that side
j	spawn2

############################
# this function will move the frog up a position from (X,Y) to (X, Y - 1)
up_pressed:
lw	$t2, curr_y			# loads the current Y position of the frog
beq	$t2, 0, UP_at_top		# if the current position is 0, it means the frog is at the top most position and needs to be wrapped to the bottom most position
subi	$t2, $t2, 1			# subtract 1 from the Y position
j	UP_update_y			# change the curr_y, Y ,to the value of new_y, Y-1

UP_at_top:
li	$t2, 63				# wrap the frog around to the bottom most position

UP_update_y:	
sw	$t2, new_y			# updates curr_y to new_y
jal	UpdateLED			# makes the LED at curr_Y black and the LED at new_Y green

j	KP_end

############################
# this function will move the frog up a position from (X,Y) to (X, Y + 1)
down_pressed:
lw	$t2, curr_y			# loads the current Y position of the frog
beq	$t2, 63, DP_at_bottom		# if the current position is 63, it means the frog is at the bottom most position and needs to be wrapped to the top most position
addi	$t2, $t2, 1			# add 1 from the Y position
j	UP_update_y			# change the curr_y, Y ,to the value of new_y, Y+1

DP_at_bottom:
li	$t2, 0				# wrap the frog around to the top most position
	
DP_update_y:	
sw	$t2, new_y			# updates curr_y to new_y
jal	UpdateLED			# makes the LED at curr_Y black and the LED at new_Y green

j	KP_end

############################
# if b is pressed, this game will display the forfeit string with the user score and exit the program
forfeitGame:
addi	$v0, $zero, 4
la	$a0, Forfeit_String
syscall
addi	$v0, $zero, 1
add	$a0, $zero, $s5
syscall
addi	$v0, $zero, 10
syscall

############################
KP_end:
j	back				# returns back to the main Game Loop

############################
_setLED:
# void _setLED(int x, int y, int color)
#   sets the LED at (x,y) to color
#   color: 0=off, 1=red, 2=orange, 3=green
#
# warning:   x, y and color are assumed to be legal values (0-63,0-63,0-3)
# arguments: $a0 is x, $a1 is y, $a2 is color 
# trashes:   $t0-$t3
# returns:   none
#
# byte offset into display = y * 16 bytes + (x / 4)

#clear trash registers
addi	$t0, $zero, 0
addi	$t1, $zero, 0
addi	$t2, $zero, 0
addi	$t3, $zero, 0


sll	$t0,$a1,4      # y * 16 bytes
srl	$t1,$a0,2      # x / 4
add	$t0,$t0,$t1    # byte offset into display
li	$t2,0xffff0008	# base address of LED display
add	$t0,$t2,$t0    # address of byte with the LED
# now, compute led position in the byte and the mask for it
andi	$t1,$a0,0x3    # remainder is led position in byte
neg	$t1,$t1        # negate position for subtraction
addi	$t1,$t1,3      # bit positions in reverse order
sll	$t1,$t1,1      # led is 2 bits
# compute two masks: one to clear field, one to set new color
li	$t2,3		
sllv	$t2,$t2,$t1
not	$t2,$t2        # bit mask for clearing current color
sllv	$t1,$a2,$t1    # bit mask for setting color
# get current LED value, set the new field, store it back to LED
lbu	$t3,0($t0)     # read current LED value	
and	$t3,$t3,$t2    # clear the field for the color
or	$t3,$t3,$t1    # set color field
sb	$t3,0($t0)     # update display
jr	$ra

############################
_getLED:
# int _getLED(int x, int y)
#   returns the value of the LED at position (x,y)
#
#  warning:   x and y are assumed to be legal values (0-63,0-63)
#  arguments: $a0 holds x, $a1 holds y
#  trashes:   $t0-$t2
#  returns:   $v0 holds the value of the LED (0, 1, 2, 3)
#

# byte offset into display = y * 16 bytes + (x / 4)
sll  $t0,$a1,4      # y * 16 bytes
srl  $t1,$a0,2      # x / 4
add  $t0,$t0,$t1    # byte offset into display
la   $t2,0xffff0008	
add  $t0,$t2,$t0    # address of byte with the LED
# now, compute bit position in the byte and the mask for it
andi $t1,$a0,0x3    # remainder is bit position in byte
neg  $t1,$t1        # negate position for subtraction
addi $t1,$t1,3      # bit positions in reverse order
sll  $t1,$t1,1      # led is 2 bits
# load LED value, get the desired bit in the loaded byte
lbu  $t2,0($t0)
srlv $t2,$t2,$t1    # shift LED value to lsb position
andi $v0,$t2,0x3    # mask off any remaining upper bits
jr   $ra

############################
# this function will read the key that was pressed, either up or down, and update the frogs position accordingly
UpdateLED:
subi	$sp, $sp, 8			# removes appropirate are from the stack to save the return address and position
sw	$ra, 0($sp)
sw	$t1, 4($sp)


lw	$a0, curr_x			# loads the current x position of the frog(ALWAYS 31)
lw	$a1, curr_y			# loads the current y position of the frog
lw	$a2, black			# sets the current position to black in order to set the new position to green
jal	UL_setLED


lw	$a0, curr_x			# loads the new x position of the frog(ALWAYS 31)
lw	$a1, new_y			# loads the new y position of the frog
lw	$a2, green			# sets the new X and Y coordinates to green
jal	UL_setLED


# updates the current Y position to the new Y position
lw	$t1, new_y
sw	$t1, curr_y

# this restores the stack, and returns back recursively
lw	$ra, 0($sp)
lw	$t1, 4($sp)
addi	$sp, $sp, 8
jr	$ra

UL_setLED:
subi	$sp, $sp, 20
sw	$ra, 0($sp)
sw	$t0, 4($sp)
sw	$t1, 8($sp)
sw	$t2, 12($sp)
sw	$t3, 16($sp)

jal	_setLED

lw	$ra, 0($sp)
lw	$t0, 4($sp)
lw	$t1, 8($sp)
lw	$t2, 12($sp)
lw	$t3, 16($sp)
addi	$sp, $sp, 20
jr	$ra

############################
# takes $a0 as an argument. $a0 should hold the time in ms that the program should pause for
Pause:
addi	$v0, $zero, 32		
syscall
jr	$ra
