	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# 
	# Showcase of procedures, and how they populate the runtime stack.
	#
	# You can examine $esp and $ebp in gdb. In order to set a break point at the
	# "true" beginning of a procedure, you'll have to find the address with
	#
	# (gdb) b <func name>
	# (gdb) r
	# (gdb) disas <func name>
	# (gdb) b *<address of first line>
	# (gdb) c
	# (gdb) r
	#
	# If you don't, it'll set a breakpoint after the instructions that deal with the
	# stack. Which you don't want, if you want to observe how the stack and procedures
	# relate to each other.
	#
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# Declare initialized data here
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	.section .data
	
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# Declare variables here
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	.section .bss
	
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# Code goes here
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	.section .text
	.globl swap_add
swap_add:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	movl 8(%ebp), %edx
	movl 12(%ebp), %ecx
	movl (%edx), %ebx
	movl (%ecx), %eax
	movl %eax, (%edx)
	movl %ebx, (%ecx)
	addl %ebx, %eax
	popl %ebx
	popl %ebp
	ret

	.globl caller
caller:
	pushl %ebp
	movl %esp, %ebp
	subl $24, %esp
	movl $534, -4(%ebp)
	movl $1057, -8(%ebp)
	leal -8(%ebp), %eax
	movl %eax, 4(%esp)
	leal -4(%ebp), %eax
	movl %eax, (%esp)
	call swap_add
	movl -4(%ebp), %edx
	subl -8(%ebp), %edx
	imull %edx, %eax
	leave
	ret

	.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	call caller
	movl %eax, %ebx

	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# Exit Program
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	movl $1, %eax
	int $0x80
