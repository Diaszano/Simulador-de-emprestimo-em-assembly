.data
	menuInicialString: 		.asciiz "Olá, escolha uma opção a seguir: \n1 - Pedido de financiamento \n2 - Listar financiamento \n3 - Sair do programa \nOpção:\t"
	menuFinanciamentoString:	.asciiz "Olá, escolha uma opção a seguir: \n1 - Financiar uma casa \n2 - Financiar um veiculo \n3 - Emprestimo pessoal \n4 - Voltar \nOpção:\t"
	clear:				.asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	nLinha:				.asciiz "\n"
	listaVazia:			.asciiz "A Lista está vazia!!!\nDigite enter para continuar"
	entradaDoNome:			.asciiz "\n\nO seu nome:"
	entradaDoCelular:		.asciiz "O seu telefone ( Somente os numero sem o DDD):"
	entradaDoSalario:		.asciiz "\nO seu salário:"
	entradaDoEmprestimo:		.asciiz "\nO valor do emprestimo:"
	entradaDasPrestacoes:		.asciiz "\nA quantidade de prestações:"
	tamanhoNome: 			.space 	20
	situacao:			.asciiz "\nSituação do emprestimo:"
	aprovado:			.asciiz "Aprovado"
	rejeitado:			.asciiz "Rejeitado"
	tipo:				.asciiz "\nTipo do emprestimo solicitado é:"
	casa:				.asciiz "Residencial"
	veiculo:			.asciiz "Veicular"
	pessoal:			.asciiz "Pessoal"			
					
	array:				
		.align 2
		.space 80
	string:	
		.align 2
		.space 20000
	celular:
		.align 2
		.space 40
	salario:
		.align 2
		.space 40
	valor:
		.align 2
		.space 40
	prestacoes:
		.align 2
		.space 40
	situacaoEmprestimo:
		.align 2
		.space 40
	tipoDoEmprestimo:
		.align 2
		.space 40
	
.text
	.main:
		li $a3,0
		li $a1,0
		jal menuInicial			
		jal limparTela
		jal fechar			
	menuInicial:
		addiu $sp,$sp,-4		
		sw $ra,($sp)
		beq $a1,1,um			
			j nnum
			um:
			beq $a3,10,nntres
				jal menuEmprestimo
				j nntres			
		nnum:
		beq $a1,2,dois			
			j nndois
			dois:
				jal listar
				j   nntres		
		nndois:
		beq $a1,3,saida
		nntres:		
			jal limparTela
			la $a0, menuInicialString 			
			jal printfString
			jal scanfInt			
			move $a1,$v0
			jal menuInicial
			li $a1,0
		saida:
			li $a1,0
			lw $ra,($sp)
			addiu $sp,$sp,4
			jr $ra
	menuEmprestimo:
		addiu $sp,$sp,-4		
		sw $ra,($sp)
		jal limparTela
		la $a0, menuFinanciamentoString 			
		jal printfString
		jal scanfInt			
		move $a1,$v0
		beq $a1,1,un			
			j nnun
			un:
			li $a2,0
			jal entradaDeDados
			# Fazer a criação dos user e empretimos...
			# Financiar uma casa
				j sada			
		nnun:
		beq $a1,2,dos			
			j nndos
			dos:
			li $a2,1
			jal entradaDeDados
			# Fazer a criação dos user e empretimos...
			# Financiar um veiculo
				j sada		
		nndos:
		beq $a1,3,treis			
			j nntreis
			treis:
			li $a2,2
			jal entradaDeDados
			# Fazer a criação dos user e empretimos...
			# Emprestimo pessoal
				j sada			
		nntreis:
		beq $a1,4,sada					
		nncuatro:
			jal menuEmprestimo
		sada:
			li $a1,0
			lw $ra,($sp)
			addiu $sp,$sp,4
			jr $ra
	listar:
		addiu $sp,$sp,-4		
		sw $ra,($sp)
		jal limparTela
		add $s0,$zero,$zero 
		add $s1,$zero,$zero 
		beq $a3,0,vazio
		
			j nao_vazio
			vazio:
				la $a0, listaVazia 			
				jal printfString
				j exit
		nao_vazio:
			beq $a3,$s0,exit
				la 	$a0, entradaDoNome 			
				jal 	printfString
				# Printa os nomes
				lw 	$t2,array($s1)	
				li      $v0,4
    				move    $a0,$t2
    				syscall
    				
    				
    				# Printa os numeros
    				la 	$a0, entradaDoCelular 			
				jal 	printfString
    				lw 	$a0,celular($s1)
    				jal 	printfInt
    				
    				# Printa os salarios
    				la 	$a0, entradaDoSalario 			
				jal 	printfString
    				lw 	$a0,salario($s1)
    				jal 	printfInt
    				
    				# Printa os valores dos emprestimos
    				la 	$a0, entradaDoEmprestimo  			
				jal 	printfString
    				lw 	$a0,valor($s1)
    				jal 	printfInt
    				    				
    				# Printa as parcelas dos emprestimos
    				la 	$a0, entradaDasPrestacoes  			
				jal 	printfString
    				lw 	$a0,prestacoes($s1)
    				jal 	printfInt
    				
    				# Printa situação do emprestimo
    				la 	$a0, situacao  			
				jal 	printfString
    				lw 	$a0,situacaoEmprestimo($s1)
    				beq	$a0,0,apro_vado
    					j repro_vado
    					apro_vado:
    						la 	$a0, aprovado  			
						jal 	printfString	
 						j pulo	
    					repro_vado:
    						la 	$a0, rejeitado 			
						jal 	printfString
				pulo:
				# Printa situação do emprestimo
    				la 	$a0, tipo  			
				jal 	printfString
    				lw 	$a0,tipoDoEmprestimo($s1)
    				beq	$a0,0,moradia
    					j nn_moradia
    					moradia:
    						la 	$a0, casa  			
						jal 	printfString
    						j 	nnpes_soal
    				nn_moradia:
    				beq	$a0,1,car_ro
    					j nncar_ro
    					car_ro:
    						la 	$a0, veiculo  			
						jal 	printfString
    						j 	nnpes_soal
    				nncar_ro:
    				beq	$a0,2,pes_soal
    					j nnpes_soal
    					pes_soal:
    						la 	$a0, pessoal  			
						jal 	printfString
    				nnpes_soal:
    				addi    $s1,$s1,4
    				addi	$s0,$s0,1
				j nao_vazio
		exit:
			jal proximaLinha
			jal scanfString
			li $a1,0
			lw $ra,($sp)
			addiu $sp,$sp,4
			jr $ra
		
	entradaDeDados:
		# Guarda o retorno
		addiu 	$sp,$sp,-4		
		sw 	$ra,($sp)
		
		# Limpa a tela
		jal 	limparTela
		
		# Pega o Local especifico do vetor
		la      $s1,string
		
		li	$t1,4
		multu 	$a3,$t1
		mflo 	$s3
		li	$s2,0
		for:
		beq 	$a3,$s2,rof
			addi 	$s1,$s1,20
			addi	$s2,$s2,1
			j for
		rof:
		move $s2,$s1
		# printa a mensagem
		la 	$a0, entradaDoNome 			
		jal 	printfString
		# Lê nome
		move    $a0,$s2
		jal 	scanfString
		sw      $a0,array($s3)
		jal limparTela
		
		# printa a mensagem
		la 	$a0, entradaDoCelular 			
		jal 	printfString
		# Lê numero do telefone
		jal 	scanfInt			
		move	$a0,$v0
		sw 	$a0, celular($s3)
		jal limparTela
		
		# printa a mensagem
		la 	$a0, entradaDoSalario 			
		jal 	printfString
		# Lê salario
		jal 	scanfInt			
		move 	$a0,$v0
		move	$t6,$v0
		sw 	$a0, salario($s3)
		jal limparTela
		
		# printa a mensagem
		la 	$a0, entradaDoEmprestimo  			
		jal 	printfString
		# Lê emprestimo
		jal 	scanfInt			
		move 	$a0,$v0
		move 	$t3,$v0
		sw 	$a0, valor($s3)
		jal limparTela
		
		# printa a mensagem
		la 	$a0, entradaDasPrestacoes  			
		jal 	printfString
		# Lê parcelas
		jal 	scanfInt			
		move 	$a0,$v0
		move 	$t4,$v0
		sw 	$a0, prestacoes($s3)
		jal 	limparTela
		div	$t3,$t4
		mflo 	$t5
		beq	$a2,0,mora_dia
    			j nn_mora_dia
    			mora_dia:
    				li 	$s4,0
    				sw 	$s4, tipoDoEmprestimo($s3)
    				li	$t7,2
    				div 	$t6,$t7
    				mflo	$t6
    				bge     $t6,$t5,apro_va_do
    					j rejei_ta_do
    					apro_va_do:
    						li 	$s4,0
    						sw 	$s4, situacaoEmprestimo($s3)
    						j nn_pes_soal
    					rejei_ta_do:
    						li 	$s4,1
    						sw 	$s4, situacaoEmprestimo($s3)
    						j nn_pes_soal
    			nn_mora_dia:
    		beq	$a2,1,ca_r_ro
    			j nn_car_ro
    			ca_r_ro:
    				li 	$s4,1
    				sw 	$s4, tipoDoEmprestimo($s3)
    				li	$t7,3
    				div 	$t6,$t7
    				mflo	$t6
    				bge    $t6,$t5,apro_v_ado
    					j rejei_t_ado
    					apro_v_ado:
    						li 	$s4,0
    						sw 	$s4, situacaoEmprestimo($s3)
    						j nn_pes_soal
    					rejei_t_ado:
    						li 	$s4,1
    						sw 	$s4, situacaoEmprestimo($s3)
    						j nn_pes_soal
    			nn_car_ro:
    		beq	$a2,2,p_es_soal
    			j nn_pes_soal
    			p_es_soal:
    				li 	$s4,2
    				sw 	$s4, tipoDoEmprestimo($s3)
    				li	$t7,4
    				div 	$t6,$t7
    				mflo	$t6
    				bge     $t6,$t5,ap_ro_vado
    					j rejei_tado
    					ap_ro_vado:
    						li 	$s4,0
    						sw 	$s4, situacaoEmprestimo($s3)
    						j nn_pes_soal
    					rejei_tado:
    						li 	$s4,1
    						sw 	$s4, situacaoEmprestimo($s3)
    						j nn_pes_soal
    		nn_pes_soal:
		
		#saida
		addi 	$a3,$a3,1
		li 	$a1,0
		lw 	$ra,($sp)
		addiu 	$sp,$sp,4
		jr 	$ra
	
	limparTela:
		addiu 	$sp,$sp,-4		
		sw 	$ra,($sp)
		la $a0, clear
		jal printfString
		li $v0,4			
		syscall
		lw 	$ra,($sp)
		addiu 	$sp,$sp,4
		jr 	$ra				
		
	proximaLinha:
		addiu 	$sp,$sp,-4		
		sw 	$ra,($sp)
		la $a0, nLinha
		jal printfString
		li $v0,4			
		syscall				
		lw 	$ra,($sp)
		addiu 	$sp,$sp,4
		jr 	$ra
		
	printfString:
		addiu 	$sp,$sp,-4		
		sw 	$ra,($sp)
		li $v0,4			
		syscall				
		lw 	$ra,($sp)
		addiu 	$sp,$sp,4
		jr 	$ra
	
	printfInt:	
		addiu 	$sp,$sp,-4		
		sw 	$ra,($sp)
		li $v0,1			
		syscall				
		lw 	$ra,($sp)
		addiu 	$sp,$sp,4
		jr 	$ra
		
	scanfInt:
		addiu 	$sp,$sp,-4		
		sw 	$ra,($sp)	
		li $v0,5			
		syscall	
		lw 	$ra,($sp)
		addiu 	$sp,$sp,4
		jr 	$ra
		
	scanfString:
		addiu 	$sp,$sp,-4		
		sw 	$ra,($sp)	
		li      $a1,20
    		li      $v0,8
		syscall				
		lw 	$ra,($sp)
		addiu 	$sp,$sp,4
		jr 	$ra
	
	fechar:		
		li $v0,10			
		syscall				
