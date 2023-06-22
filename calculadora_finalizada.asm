.data
    opc: .asciiz "Escolha uma op��o a seguir\n| A - Adi��o| S - Subtra��o | D - Divis�o | M - Multiplica��o | P - Potencia��o |\n|Escolha uma op��o: "
    resul: .asciiz "O resultado �: "
    msg_erro: .asciiz "Erro! Divis�o por zero.\n"
    num1: .asciiz "\nDigite o primeiro n�mero: "
    num2: .asciiz "Digite o segundo n�mero: "
    soma: .asciiz "\n|-- Opera��o escolhida - SOMA --|\n"
    subt: .asciiz "\n|-- Opera��o escolhida - SUBTRA��O |\n"
    multip: .asciiz "\n|-- Opera��o escolhida - MULTIPLICA��O --|\n"
    divi: .asciiz "\n|-- Opera��o escolhida - DIVIS�O --|\n"
    potenc: .asciiz "\n|-- Opera��o escolhida - POTENCIALIZA��O --|\n"


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
    
    # Escolhas em mai�sculo
    beq $t0, 65, adicao
    beq $t0, 83, subtracao
    beq $t0, 68, divisao
    beq $t0, 77, multi
    beq $t0, 80, poten
    
    # Escolhas em min�sculo
    beq $t0, 97, adicao
    beq $t0, 115, subtracao
    beq $t0, 100, divisao
    beq $t0, 109, multi
    beq $t0, 112, poten
    
    j exit

adicao:     # Adi��o
    # Exibe qual opera��o est� sendo realizada
    li $v0, 4
    la $a0, soma
    syscall

    # Chamando o primeiro n�mero
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo n�mero
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

subtracao:  # Subtra��o
    # Chamando o primeiro n�mero
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo n�mero
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

divisao:    # Divis�o
    # Chamando o primeiro n�mero
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo n�mero
    li $v0, 4
    la $a0, num2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    # Verifica se o divisor � zero
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

multi:      # Multiplica��o
    # Chamando o primeiro n�mero
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo n�mero
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

poten:      # Potencia��o
    # Chamando o primeiro n�mero
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Chamando o segundo n�mero
    li $v0, 4
    la $a0, num2
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    # Inicializando o resultado com 1
    li $t3, 1

    cont_pot:
    beqz $t2, end   # Se o expoente � zero, sair do loop

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
    li $v0, 10
    syscall
