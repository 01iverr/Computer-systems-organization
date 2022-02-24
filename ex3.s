
#Program: MIPS Subprograms
# ---------------------------------------------------------------------------
.text
.globl main
main:
# ---------------------------------------------------------------------------
# main program
# ---------------------------------------------------------------------------
	la $a0, messageA # print message read array A
	li $v0, 4
	syscall
	li $t1,1# counter = 1
	la $t2,A# $t2 is base register of A
for1: bgt $t1,5,exit_for1 # if counter>5 goto exit_for1
	li $v0,5# $v0=readInt()
	syscall
	sw $v0,($t2)# A[i]=$v0
	add $t2,$t2,4# i++
	add $t1,$t1,1# counter++
	j for1# goto for1
exit_for1: la $a0,messageb1 # print message
	li $v0,4
	syscall
	li $v0,5
	syscall
	sw $v0,b1 # b1 = readInt()
	la $a0,messageb2 # print message
	li $v0,4
	syscall
	li $v0,5
	syscall
	sw $v0,b2 # b2 = readInt()
# --------------------- check bounds ----------------------
	lw $t1,b1
	lw $t2,b2
	blt $t1,1,error # b1>=1 
	bgt $t1,5,error #b1<=5
	blt $t2,1,error # b2>=1 
	bgt $t2,5,error #b2<=5
	bgt $t1,$t2,error # b1<=b2
# --------------------- call subprogram max------------------
	la $a0, A
	move $a1, $t1
	move $a2, $t2
	jal max # k = max (A, b1, b2)
# --------------------- print results -----------------------
	la $a0, resultmessage
	li $v0, 4
	syscall # print result message
	move $a0, $v1 
	li $v0, 1
	syscall # print(k)
	j exit
error: 
	la $a0, errormessage
	li $v0, 4
	syscall# print error message
exit:
	li $v0, 10 
	syscall # end of program
# ---------------------------------------------------------------------------
# max subprogram
# ---------------------------------------------------------------------------
max: move $s0, $a0 # $s0 is A
	move $s1, $a1 # $s1 is K
	move $s2, $a2 # $s2 is P
	sub $sp, $sp, 4
	sw $ra, ($sp) # save $ra - push ($ra)
	move $t1, $s1 # K
	sub $t1,$t1,1 # K - 1
	mul $t1,$t1,4 # (K - 1) * 4
	add $t1,$t1,$s0 # (K - 1) * 4 + A
	lw $s3, ($t1) # $s3 is maxA = A[K]
again1: 
	add $s1,$s1,1 # K++
	bgt $s1,$s2,exit_again1 # if (K>P) exit_for2
	#lw $s3, ($t1) # $s3 is maxA = A[K]
	move $t1,$s1 # K
	sub $t1,$t1,1 # K - 1
	mul $t1,$t1,4 # (K - 1) * 4
	add $t1,$t1,$s0 # (K - 1) * 4 + A
	lw $s4,($t1) # $s4 = A[K] - next	position in array A
	move $a0,$s3 # $a0 = maxA
	move $a1,$s4 # $a1 = A[K]
	jal greatersubprogram # greater (maxA, A[K])
	move $s3,$v1 # maxA = greater (maxA, A[K])
	j again1
exit_again1: 
	lw $ra,($sp) # load $ra - pop ($ra)
	add $sp,$sp,4 # return value is maxA
	move $v1,$s3 # return from max
	jr $ra
greatersubprogram: 
	bge $a0,$a1,exit_greatersubprogram #if (x < y)
	move $v1,$a1# return y
	jr $ra
exit_greatersubprogram: 
	move $v1,$a0 # return x
	jr $ra
# ---------------------------------------------------------------------------
# Data Segment:
# ---------------------------------------------------------------------------
.data
A: .space 20
b1: .space 4
b2: .space 4 
messageA: .asciiz "\n - Array A (5 elements) \n"
messageb1: .asciiz "\n - b1 = "
messageb2: .asciiz "\n - b2 = "
resultmessage: .asciiz "\n - max = "
errormessage: .asciiz "\n - index out of bounds"