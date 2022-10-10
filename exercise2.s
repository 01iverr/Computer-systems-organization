.text
.globl __start
__start:
			la $t0,CodeWord 
			lw $t1,($t0) #$t1 = CodeWord [0] 
			add $s1,0,1 # counter = 1
	again:
			blt $s1,12,exit  # while (counter < 12)
			li 	$v0, 12 #Read one char ('0' or '1') from input //# i need a char from the keyboard ua apo8hkeytei sto $v0
			syscall #do it now 
			move $s0,$v0 #dn 8eloyme na brisketai sto $v0 kai to metaferoume sto $s0
			sub $s0 ,$s0,48 # 	convert char to digit
			sb $s0,($t0) # 	Store digit (0 or 1) to CodeWord
			
			
			#	calculate next potition of array CodeWord[]
			
			
			add $s1,$s1,1 #counter ++
			j again #phgaine sto again	
			
	exit: # end of while

			# for example: input in CodeWord -> 1  1  1  0  1  1  1  0  1  1  1  1
				
# --------------------------------------------------------------------------------------------
#  	Control 4 parity digits (potitions 1, 2, 4, 8) and their data digits for even parity
# --------------------------------------------------------------------------------------------

			add $s1,0,1 # counter = 1

			# $t0 = base register of array CodeWord

			
	again2	
			blt $s1,4,exit2 # while (counter < 4)
			add $s2,-1,1 # sum = 0
				

				# if counter == 1 $t1 = base register of array PositionsForBit1
				# if counter == 2 $t1 = base register of array PositionsForBit2
				# if counter == 3 $t1 = base register of array PositionsForBit4
				# if counter == 4 $t1 = base register of array PositionsForBit8

				move $t2,$t1 #p = ($t1)
				# 	if p == -1 exit_loop# 
				add $t2,$t2,$t0 #p = p + $t0 
				sub $t2,$t2,1 #p = p - 1
				add $s2,$s2,(t2)#sum += (p)
				add $t1,$t1,1 #$t1++
				j again2 #phgaine sto again2
	exit2 
				# if sum % 2 != 0 go to not ok
				add $s1,$s1,1 #counter ++

	ok
			la $a0,ok_message
			li $v0,4
			syscall # print ("No error in codeword")
			#edw teleiwnoyme
			li $v0,10
			syscall
	notok	
			la $a0,not_ok_message
			li $v0,4
			syscall # not ok: print ("Error in codeword")
			#edw teleiwnoyme
			li $v0,10
			syscall
.data
CodeWord:		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

PotitionsForDigit1: 	.byte 1, 3, 5, 7, 9, 11, -1
PotitionsForDigit2: 	.byte 2, 3, 6, 7, 10, 11, -1
PotitionsForDigit4: 	.byte 4, 5, 6, 7, 12, -1
PotitionsForDigit8: 	.byte 8, 9, 10, 11, 12, -1

not_ok_message:		.asciiz "\n - Error in CodeWord"

ok_message:		.asciiz "\n - No error in CodeWord"




