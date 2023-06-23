.data
    opc: .asciiz "Escolha uma opção a seguir\n| A - Adição| S - Subtração | D - Divisão | M - Multiplicação | P - Potenciação |\n|Escolha uma opção: "
    resul: .asciiz "O resultado é: "
    msg_erro: .asciiz "Erro! Divisão por zero.\n"
    num1: .asciiz "\nDigite o primeiro número: "
    num2: .asciiz "Digite o segundo número: "
    soma: .asciiz "\n|-- Operação escolhida - SOMA --|\n"
    subt: .asciiz "\n|-- Operação escolhida - SUBTRAÇÃO |\n"
    multip: .asciiz "\n|-- Operação escolhida - MULTIPLICAÇÃO --|\n"
    divi: .asciiz "\n|-- Operação escolhida - DIVISÃO --|\n"
    potenc: .asciiz "\n|-- Operação escolhida - POTENCIALIZAÇÃO --|\n"


.text
.globl main
main:
    li $v0, 4
    la $a0, opc
    syscall

menu_loop:
    li $v0, 12
    syscall
    move $t0, $v0
    
    # Escolhas em maiúsculo
    beq $t0, 65, adicao
    beq $t0, 83, subtracao
    beq $t0, 68, divisao
    beq $t0, 77, multi
    beq $t0, 80, poten
    
    # Escolhas em minúsculo
    beq $t0, 97, adicao
    beq $t0, 115, subtracao
    beq $t0, 100, divisao
    beq $t0, 109, multi
    beq $t0, 112, poten
    
    j exit

adicao:     # Adição
    # Exibe qual operação está sendo realizada
    li $v0, 4
    la $a0, soma
    syscall

    # Chamando o primeiro número
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo número
    li $v0, 4
    la $a0, num2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    # Calculando e imprimindo o resultado
    add $t3, $t1, $t2

    li $v0, 4
    la $a0, resul
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    j menu_loop

subtracao:  # Subtração
    # Chamando o primeiro número
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo número
    li $v0, 4
    la $a0, num2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    # Calculando e imprimindo o resultado
    sub $t3, $t1, $t2

    li $v0, 4
    la $a0, resul
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    j menu_loop

divisao:    # Divisão
    # Chamando o primeiro número
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo número
    li $v0, 4
    la $a0, num2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    # Verifica se o divisor é zero
    beqz $t2, div_erro

    # Calculando e imprimindo o resultado
    div $t3, $t1, $t2

    li $v0, 4
    la $a0, resul
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    j menu_loop

div_erro:
    li $v0, 4
    la $a0, msg_erro
    syscall
    j menu_loop

multi:      # Multiplicação
    # Chamando o primeiro número
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo número
    li $v0, 4
    la $a0, num2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    # Calculando e imprimindo o resultado
    mul $t3, $t1, $t2

    li $v0, 4
    la $a0, resul
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    j menu_loop

poten:      # Potenciação
    # Chamando o primeiro número
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo número
    li $v0, 4
    la $a0, num2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    # Inicializando o resultado com 1
    li $t3, 1

    cont_pot:
    beqz $t2, end   # Se o expoente é zero, sair do loop

    # Multiplica o resultado pela base
    mul $t3, $t3, $t1

    subi $t2, $t2, 1   # Decrementa o expoente
    j cont_pot

    end:
    li $v0, 4
    la $a0, resul
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    j menu_loop

exit:
    j main
    syscall
