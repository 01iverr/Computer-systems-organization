 # AM:3190167 
.text
.globl __start
__start:
		#Give a 4-digit number:
		la $a0,str
		li $v0,4
		syscall
		li 	$v0, 5
		# i need an integer from the keyboard ua apo8hkeytei sto $v0
		syscall 
		#do it now 
		#dn 8eloyme na brisketai sto $v0 kai to metaferoume sto $t0
		move $t0,$v0  
	again: 
		#KOITAEI AN EINAI LIGOTERO APO 4 PSHFIA
			bge $t0,1000,exit
			# ---------------------------- 	Print Error Message -----------------------------------------
			#"\nInvalid input, not a 4-digit number"
			la $a0,str1
			li $v0,4
			syscall
			#Give a 4-digit number:
			la $a0,str
			li $v0,4
			syscall
			# ---------------------------- 	Read Initial Number -----------------------------------------
			li 	$v0, 5
			# i need an integer from the keyboard ua apo8hkeytei sto $v0
			syscall 
			#do it now 
			#dn 8eloyme na brisketai sto $v0 kai to metaferoume sto $t0
			move $t0,$v0
			j again 
			#phgaine sto again	
	exit: 
			#KOITAEI AN EINAI PERISSOTERO  APO 4 PSHFIA
			ble $t0,10000,exit1
			#"\nInvalid input, not a 4-digit number":
			la $a0,str1
			li $v0,4
			syscall
			# ---------------------------- 	Print Error Message -----------------------------------------
			#Give a 4-digit number:
			la $a0,str
			li $v0,4
			syscall
			# ---------------------------- 	Read Initial Number -----------------------------------------
			li 	$v0, 5
			# i need an integer from the keyboard ua apo8hkeytei sto $v0
			syscall 
			#do it now 
			#dn 8eloyme na brisketai sto $v0 kai to metaferoume sto $t0
			move $t0,$v0
			j again
			#phgaine sto again
	exit1:
			#KSEROYME OTI EINAI 4PSHFIO
			# ---------------------------- 	Calculate 1st Digit-------------
			div $s1,$t0,1000
			rem $s2,$t0,1000
			# ---------------------------- 	Calculate 2nd Digit -------------
			div $s0,$s2,100
			rem $s3,$s2,100
			move $s2,$s0
			div $s0,$s3,10
			# ---------------------------- 	Calculate 4nd Digit -------------
			rem $s4,$s3,10
			# ---------------------------- 	Calculate 3nd Digit ------------
			move $s3,$s0
			# ---------------------------- 	Encryption of Digits ----------------------------------------
			#1o pshfio
			add $s0,$s1,7
			rem $s1,$s0,10
			#2o pshfio
			add $s0,$s2,7
			rem $s2,$s0,10
			#3o pshfio
			add $s0,$s3,7
			rem $s3,$s0,10
			#4o pshfio
			add $s0,$s4,7
			rem $s4,$s0,10
			#---------------------------1-->3--------------
			move $s0,$s1
			move $s1,$s3
			move $s3,$s0
			#------------------------2->4--------------------------------------------
			move $s0,$s2
			move $s2,$s4
			move $s4,$s0
			#---------------------------------pyknwnei--------------------------------
			mul $s1,$s1,1000
			mul $s2,$s2,100
			mul $s3,$s3,10
			add $s0,$s1,$s2
			add $s0,$s0,$s3
			add $s0,$s0,$s4
			# ---------------------------- 	Print Encrypted Number --------------------------------------
			# "\nEncrypted number is :"
			la $a0,str3
			li $v0,4
			syscall
			move $a0,$s0
			li $v0,1
			syscall
			#edw teleiwnoyme
			li $v0,10
			syscall
			.data
str:    .asciiz "Give a 4-digit number: "
str1:   .asciiz "Invalid input, not a 4-digit number\n\n"
str3:	.asciiz "Encrypted number is: "