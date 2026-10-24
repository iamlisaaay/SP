	.file	"dsp_audio.c"
	.intel_syntax noprefix
	.text
	.local	input_signal
	.comm	input_signal,4194304,32
	.local	ir_kernel
	.comm	ir_kernel,4194304,32
	.local	output_signal
	.comm	output_signal,4194304,32
	.globl	generate_audio_buffers
	.type	generate_audio_buffers, @function
generate_audio_buffers:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR -8[rbp], 0
	jmp	.L2
.L5:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L3
.L4:
	mov	edx, DWORD PTR -4[rbp]
	mov	eax, edx
	add	eax, eax
	add	edx, eax
	mov	eax, DWORD PTR -8[rbp]
	add	edx, eax
	mov	eax, edx
	sar	eax, 31
	shr	eax, 25
	add	edx, eax
	and	edx, 127
	sub	edx, eax
	mov	eax, edx
	pxor	xmm1, xmm1
	cvtsi2ss	xmm1, eax
	movss	xmm0, DWORD PTR .LC0[rip]
	mulss	xmm0, xmm1
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	edx, DWORD PTR -8[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, input_signal[rip]
	movss	DWORD PTR [rdx+rax], xmm0
	mov	edx, DWORD PTR -8[rbp]
	mov	eax, edx
	sal	eax, 3
	sub	eax, edx
	mov	ecx, eax
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, [rcx+rax]
	mov	eax, edx
	sar	eax, 31
	shr	eax, 26
	add	edx, eax
	and	edx, 63
	sub	edx, eax
	mov	eax, edx
	pxor	xmm1, xmm1
	cvtsi2ss	xmm1, eax
	movss	xmm0, DWORD PTR .LC1[rip]
	mulss	xmm0, xmm1
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	edx, DWORD PTR -8[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, ir_kernel[rip]
	movss	DWORD PTR [rdx+rax], xmm0
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	edx, DWORD PTR -8[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, output_signal[rip]
	pxor	xmm0, xmm0
	movss	DWORD PTR [rdx+rax], xmm0
	add	DWORD PTR -4[rbp], 1
.L3:
	cmp	DWORD PTR -4[rbp], 1023
	jle	.L4
	add	DWORD PTR -8[rbp], 1
.L2:
	cmp	DWORD PTR -8[rbp], 1023
	jle	.L5
	nop
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	generate_audio_buffers, .-generate_audio_buffers
	.globl	apply_ir_naive
	.type	apply_ir_naive, @function
apply_ir_naive:
.LFB7:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR -16[rbp], 0
	jmp	.L7
.L12:
	mov	DWORD PTR -12[rbp], 0
	jmp	.L8
.L11:
	pxor	xmm0, xmm0
	movss	DWORD PTR -8[rbp], xmm0
	mov	DWORD PTR -4[rbp], 0
	jmp	.L9
.L10:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	edx, DWORD PTR -16[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, input_signal[rip]
	movss	xmm1, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, ir_kernel[rip]
	movss	xmm0, DWORD PTR [rdx+rax]
	mulss	xmm0, xmm1
	movss	xmm1, DWORD PTR -8[rbp]
	addss	xmm0, xmm1
	movss	DWORD PTR -8[rbp], xmm0
	add	DWORD PTR -4[rbp], 1
.L9:
	cmp	DWORD PTR -4[rbp], 1023
	jle	.L10
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	mov	edx, DWORD PTR -16[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, output_signal[rip]
	movss	xmm0, DWORD PTR -8[rbp]
	movss	DWORD PTR [rdx+rax], xmm0
	add	DWORD PTR -12[rbp], 1
.L8:
	cmp	DWORD PTR -12[rbp], 1023
	jle	.L11
	add	DWORD PTR -16[rbp], 1
.L7:
	cmp	DWORD PTR -16[rbp], 1023
	jle	.L12
	nop
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	apply_ir_naive, .-apply_ir_naive
	.globl	apply_ir_optimized
	.type	apply_ir_optimized, @function
apply_ir_optimized:
.LFB8:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR -16[rbp], 0
	jmp	.L14
.L19:
	mov	DWORD PTR -12[rbp], 0
	jmp	.L15
.L18:
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	mov	edx, DWORD PTR -16[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, input_signal[rip]
	movss	xmm0, DWORD PTR [rdx+rax]
	movss	DWORD PTR -4[rbp], xmm0
	mov	DWORD PTR -8[rbp], 0
	jmp	.L16
.L17:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	mov	edx, DWORD PTR -16[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, output_signal[rip]
	movss	xmm1, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	mov	edx, DWORD PTR -12[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, ir_kernel[rip]
	movss	xmm0, DWORD PTR [rdx+rax]
	mulss	xmm0, DWORD PTR -4[rbp]
	addss	xmm0, xmm1
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	mov	edx, DWORD PTR -16[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, output_signal[rip]
	movss	DWORD PTR [rdx+rax], xmm0
	add	DWORD PTR -8[rbp], 1
.L16:
	cmp	DWORD PTR -8[rbp], 1023
	jle	.L17
	add	DWORD PTR -12[rbp], 1
.L15:
	cmp	DWORD PTR -12[rbp], 1023
	jle	.L18
	add	DWORD PTR -16[rbp], 1
.L14:
	cmp	DWORD PTR -16[rbp], 1023
	jle	.L19
	nop
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	apply_ir_optimized, .-apply_ir_optimized
	.globl	compute_audio_energy
	.type	compute_audio_energy, @function
compute_audio_energy:
.LFB9:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	pxor	xmm0, xmm0
	movss	DWORD PTR -12[rbp], xmm0
	mov	DWORD PTR -8[rbp], 0
	jmp	.L21
.L24:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L22
.L23:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	edx, DWORD PTR -8[rbp]
	movsx	rdx, edx
	sal	rdx, 10
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	lea	rax, output_signal[rip]
	movss	xmm0, DWORD PTR [rdx+rax]
	movss	xmm1, DWORD PTR -12[rbp]
	addss	xmm0, xmm1
	movss	DWORD PTR -12[rbp], xmm0
	add	DWORD PTR -4[rbp], 1
.L22:
	cmp	DWORD PTR -4[rbp], 1023
	jle	.L23
	add	DWORD PTR -8[rbp], 1
.L21:
	cmp	DWORD PTR -8[rbp], 1023
	jle	.L24
	movss	xmm0, DWORD PTR -12[rbp]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	compute_audio_energy, .-compute_audio_energy
	.section	.rodata
.LC3:
	.string	"Audio Output Checksum: %.2f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB10:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	eax, 0
	call	generate_audio_buffers
	mov	eax, 0
	call	apply_ir_naive
	mov	eax, 0
	call	compute_audio_energy
	movd	eax, xmm0
	mov	DWORD PTR -4[rbp], eax
	pxor	xmm1, xmm1
	cvtss2sd	xmm1, DWORD PTR -4[rbp]
	movq	rax, xmm1
	movq	xmm0, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1000593162
	.align 4
.LC1:
	.long	990057071
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
