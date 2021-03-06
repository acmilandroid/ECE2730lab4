/* begin assembly solution */

.globl AtoI
.type AtoI,@function
AtoI:
	/* prolog */
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi

	/* put code here */
	movl $1, sign # initializes sign to positive
	space:
		movl ascii, %eax
		cmpb $32, (%eax) # dereferences ascii and compares it to ' '
		jne tabs # jumps to tabs if not equal
		addl $1, ascii # increments ascii
		jmp space # first while loop
	plus:
		movl ascii, %eax
		cmpb $43, (%eax) # dereferences ascii and compares it to '+'
		jne minus # jumps to minus check if not equal
		addl $1, ascii
	minus:
		movl ascii, %eax
		cmpb $45, (%eax) # dereferences ascii and compares it to '-'
		jne finish
		movl $-1, sign # found a minus sign
		addl $1, ascii
	tabs:
		movl ascii, %eax
		cmpb $9, (%eax) # dereferences ascii and compares it to '\t'
		jne plus # continues to plus check if not equal
		addl $1, ascii 
		jmp space # first while loop
	finish:
		movl intptr, %eax
		movl $0, (%eax) # sets *intptr to 0
		movl $0, i # initializes i to 0 in for loop
	forloop:
		movl $0, %eax
		movl ascii, %ebx
		movl i, %esi
		movb (%ebx, %esi, 1), %al
		cmpb $48, %al
		jnge afterfor
		cmpb $57, %al
		jg afterfor
		addl $1, i # increments i in for loop
		jmp forloop # repeats for loop
	afterfor:
		addl $-1, i # back up to the one's place
		movl $1, multiplier # set multiplier for one's place
	forloop2:
		cmp $0, i # checks loop conditional
		jl afterfor2
		movl $0, %eax
		movl $0, %ecx
		movl ascii, %ebx
		movl i, %esi
		movb (%ebx, %esi, 1), %al
		subb $48, %al
		mull multiplier
		movl $0, %ecx
		movl intptr, %ebx
		addl %eax, (%ebx)
		movl multiplier, %eax
		movl $10, %edx
		mull %edx
		movl %eax, multiplier
		addl $-1, i # decrements loop counter
		jmp forloop2 # repeats loop
	afterfor2:
		movl intptr, %ebx
		movl (%ebx), %eax
		mull sign
		movl %eax, %edx
		movl %edx, (%ebx)
	return:
		/* epilog */
		popl %edi
		popl %esi
		popl %ebx
		movl %ebp, %esp
		popl %ebp
		ret
	
/* end assembly stub */
