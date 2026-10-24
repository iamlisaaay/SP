	.file	"dsp_audio.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	generate_audio_buffers
	.type	generate_audio_buffers, @function
generate_audio_buffers:
.LFB39:
	.cfi_startproc
	endbr64
	mov	eax, 8
	lea	rsi, input_signal[rip]
	xor	ecx, ecx
	vmovdqa	ymm3, YMMWORD PTR .LC0[rip]
	vmovd	xmm6, eax
	mov	eax, 127
	vbroadcastss	ymm7, DWORD PTR .LC4[rip]
	lea	rdx, 4096[rsi]
	vmovd	xmm5, eax
	vpbroadcastd	ymm6, xmm6
	vpbroadcastd	ymm5, xmm5
	.p2align 4,,10
	.p2align 3
.L3:
	vmovd	xmm4, ecx
	mov	rax, rsi
	vmovdqa	ymm1, ymm3
	vpbroadcastd	ymm4, xmm4
	.p2align 4,,10
	.p2align 3
.L2:
	vmovdqa	ymm2, ymm1
	add	rax, 32
	vpaddd	ymm1, ymm1, ymm6
	vpslld	ymm0, ymm2, 1
	vpaddd	ymm0, ymm0, ymm2
	vpaddd	ymm0, ymm0, ymm4
	vpand	ymm0, ymm0, ymm5
	vcvtdq2ps	ymm0, ymm0
	vmulps	ymm0, ymm0, ymm7
	vmovaps	YMMWORD PTR -32[rax], ymm0
	cmp	rdx, rax
	jne	.L2
	add	ecx, 1
	add	rsi, 4096
	add	rdx, 4096
	cmp	ecx, 1024
	jne	.L3
	mov	eax, 8
	lea	rsi, ir_kernel[rip]
	xor	ecx, ecx
	vbroadcastss	ymm6, DWORD PTR .LC7[rip]
	vmovd	xmm5, eax
	mov	eax, 63
	lea	rdx, 4096[rsi]
	vmovd	xmm4, eax
	lea	rdi, 4194304[rdx]
	vpbroadcastd	ymm5, xmm5
	vpbroadcastd	ymm4, xmm4
	.p2align 4,,10
	.p2align 3
.L7:
	vmovd	xmm2, ecx
	mov	rax, rsi
	vmovdqa	ymm1, ymm3
	vpbroadcastd	ymm2, xmm2
	.p2align 4,,10
	.p2align 3
.L6:
	vmovdqa	ymm0, ymm1
	add	rax, 32
	vpaddd	ymm1, ymm1, ymm5
	vpaddd	ymm0, ymm2, ymm0
	vpand	ymm0, ymm0, ymm4
	vcvtdq2ps	ymm0, ymm0
	vmulps	ymm0, ymm0, ymm6
	vmovaps	YMMWORD PTR -32[rax], ymm0
	cmp	rax, rdx
	jne	.L6
	lea	rdx, 4096[rax]
	add	ecx, 7
	add	rsi, 4096
	cmp	rdx, rdi
	jne	.L7
	mov	edx, 4194304
	xor	esi, esi
	lea	rdi, output_signal[rip]
	vzeroupper
	jmp	memset@PLT
	.cfi_endproc
.LFE39:
	.size	generate_audio_buffers, .-generate_audio_buffers
	.p2align 4
	.globl	apply_ir_naive
	.type	apply_ir_naive, @function
apply_ir_naive:
.LFB40:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	lea	r8, output_signal[rip]
	xor	esi, esi
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r12
	.cfi_offset 12, -24
	lea	r12, ir_kernel[rip+4096]
	push	rbx
	.cfi_offset 3, -32
	lea	r11, 4190208[r12]
	lea	rbx, input_signal[rip]
.L20:
	mov	r10, rsi
	mov	rcx, r11
	lea	rdi, ir_kernel[rip]
	mov	r9, r8
	sal	r10, 12
	add	r10, rbx
.L24:
	mov	rax, rdi
	mov	rdx, r10
	vxorps	xmm1, xmm1, xmm1
	.p2align 4,,10
	.p2align 3
.L21:
	vbroadcastss	ymm0, DWORD PTR [rdx]
	vmulps	ymm0, ymm0, YMMWORD PTR [rax]
	add	rax, 4096
	add	rdx, 4
	vaddps	ymm1, ymm1, ymm0
	cmp	rax, rcx
	jne	.L21
	add	rdi, 32
	vmovaps	YMMWORD PTR [r9], ymm1
	lea	rcx, 32[rax]
	add	r9, 32
	cmp	rdi, r12
	jne	.L24
	add	rsi, 1
	add	r8, 4096
	cmp	rsi, 1024
	jne	.L20
	vzeroupper
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	apply_ir_naive, .-apply_ir_naive
	.p2align 4
	.globl	apply_ir_optimized
	.type	apply_ir_optimized, @function
apply_ir_optimized:
.LFB41:
	.cfi_startproc
	endbr64
	lea	rdx, output_signal[rip]
	lea	r9, input_signal[rip]
	lea	r10, 4194304[rdx]
	lea	r8, ir_kernel[rip+4194304]
.L29:
	lea	rcx, ir_kernel[rip]
	mov	rdi, r9
.L34:
	vbroadcastss	ymm2, DWORD PTR [rdi]
	vbroadcastss	ymm1, DWORD PTR 4[rdi]
	lea	rsi, 4096[rcx]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L31:
	vmovaps	ymm0, YMMWORD PTR [rcx+rax]
	vfmadd213ps	ymm0, ymm2, YMMWORD PTR [rdx+rax]
	vfmadd231ps	ymm0, ymm1, YMMWORD PTR [rsi+rax]
	vmovaps	YMMWORD PTR [rdx+rax], ymm0
	add	rax, 32
	cmp	rax, 4096
	jne	.L31
	add	rcx, 8192
	add	rdi, 8
	cmp	rcx, r8
	jne	.L34
	add	rdx, 4096
	add	r9, 4096
	cmp	rdx, r10
	jne	.L29
	vzeroupper
	ret
	.cfi_endproc
.LFE41:
	.size	apply_ir_optimized, .-apply_ir_optimized
	.p2align 4
	.globl	compute_audio_energy
	.type	compute_audio_energy, @function
compute_audio_energy:
.LFB42:
	.cfi_startproc
	endbr64
	lea	rcx, output_signal[rip]
	vxorps	xmm0, xmm0, xmm0
	lea	rdx, 4096[rcx]
	lea	rsi, 4194304[rdx]
	.p2align 4,,10
	.p2align 3
.L39:
	mov	rax, rcx
	.p2align 4,,10
	.p2align 3
.L40:
	vaddss	xmm0, xmm0, DWORD PTR [rax]
	add	rax, 32
	vaddss	xmm0, xmm0, DWORD PTR -28[rax]
	vaddss	xmm0, xmm0, DWORD PTR -24[rax]
	vaddss	xmm0, xmm0, DWORD PTR -20[rax]
	vaddss	xmm0, xmm0, DWORD PTR -16[rax]
	vaddss	xmm0, xmm0, DWORD PTR -12[rax]
	vaddss	xmm0, xmm0, DWORD PTR -8[rax]
	vaddss	xmm0, xmm0, DWORD PTR -4[rax]
	cmp	rax, rdx
	jne	.L40
	lea	rdx, 4096[rax]
	add	rcx, 4096
	cmp	rdx, rsi
	jne	.L39
	ret
	.cfi_endproc
.LFE42:
	.size	compute_audio_energy, .-compute_audio_energy
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC9:
	.string	"Audio Output Checksum: %.2f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB43:
	.cfi_startproc
	endbr64
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	xor	eax, eax
	call	generate_audio_buffers
	xor	eax, eax
	call	apply_ir_optimized
	xor	eax, eax
	mov	edi, 2
	call	compute_audio_energy
	lea	rsi, .LC9[rip]
	mov	eax, 1
	vcvtss2sd	xmm0, xmm0, xmm0
	vzeroupper
	call	__printf_chk@PLT
	xor	eax, eax
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE43:
	.size	main, .-main
	.local	output_signal
	.comm	output_signal,4194304,32
	.local	ir_kernel
	.comm	ir_kernel,4194304,32
	.local	input_signal
	.comm	input_signal,4194304,32
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC4:
	.long	1000593162
	.align 4
.LC7:
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
