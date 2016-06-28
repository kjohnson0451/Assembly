	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Keith Johnson
	;; 
	;; Calculator assembly application
	;; 
	;; 
	;; 
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	global  _start

	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Declare initialized data here
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	section .data
msgA:	db "Enter the first value: "
msgB:	db "Enter the second value: "
msgC:	db "Enter the operator: "
msgD:	db 10, "The answer is: "
msgE:	db 10, 10, "ERROR! One of the values is not an integer.", 10, 10
msgZ:	db "test"
	
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Declare variables here
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	section .bss

var1:	resb 4	;First variable to be calculated
var2:	resb 4	;Second variable to be calculated
oper:	resb 2	;Operand (+, -, *, or /)
	
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Code goes here
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	section .text

_start:

	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Print "Enter first value"
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	mov rax, 4
	mov rbx, 1
	mov rcx, msgA
	mov rdx, 23
	int 0x80
	
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Read the first variable from std input
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	mov rax, 3
	mov rbx, 0
	mov rcx, var1
	mov rdx, 5
	int 0x80

	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Print "Enter second value"
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        mov rax, 4
        mov rbx, 1
        mov rcx, msgB
        mov rdx, 24
        int 0x80
	
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Read the second variable from std input
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	mov rax, 3
	mov rbx, 0
	mov rcx, var2
	mov rdx, 5
	int 0x80

	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Print "Enter operator"
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	mov rax, 4
	mov rbx, 1
	mov rcx, msgC
	mov rdx, 20
	int 0x80

	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Read the operator from std input
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	mov rax, 3
	mov rbx, 0
	mov rcx, oper
	mov rdx, 2
	int 0x80

	
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Convert var1 to integer
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	mov esi, var1
	mov rcx, 4
	call .strToInt

	push rbx
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Convert var2 to integer
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	mov esi, var2
	mov rcx, 4
	call .strToInt

	pop rax

	mov cx, [oper]
	
	cmp rcx, 0x0a2b
	je .addition
	cmp rcx, 0x0a2d
	je .subtraction


	.addition:
        add rax, rbx
	jmp .afterCalculation

        .subtraction:
        sub rax, rbx
	jmp .afterCalculation
	
	.afterCalculation:
	
	jmp .exit	
	
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; FUNCTION: Convert string to integer
	;; Arguments: rsi contains a pointer to the string
	;; 	      rcx contains the number of maximum characters
	;;
	;; Return:    rbx contains the integer
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	.strToInt:
	xor rbx, rbx
	.next_digit:
	movzx eax, byte[esi]
	cmp eax, 10
	je .is_newline
	cmp eax, '0'
	jl .errorNotInt
	cmp eax, '9'
	jg .errorNotInt
	inc esi
	sub al, '0'
	imul ebx, 10
	add ebx, eax
	loop .next_digit
	.is_newline:
	ret
	
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Exits under error code 1 if inputs aren't positive integers
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	.errorNotInt:
	mov rax, 4
        mov rbx, 1
	mov rcx, msgE
	mov rdx, 47
	int 0x80

	mov rax, 1
	mov rbx, 1
	int 0x80	

	
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;; Exit Program
	;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	.exit:
        mov rax, 1
        mov rbx, 0
        int 0x80
