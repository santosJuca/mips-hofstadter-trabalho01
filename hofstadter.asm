# Trabalho 01 - Sequencias Female e Male de Hofstadter
# Disciplina: Organizacao e Arquitetura de Processadores
# Desenvolvedores: preencher os nomes do grupo
#
# Implementacao equivalente ao algoritmo em C usando recursividade,
# macros e pilha para preservar o endereco de retorno e o parametro n.

.data
titulo:   .asciiz "Sequencias Female e Male de Hofstadter - 09/09/2026\n"
autores:  .asciiz "Desenvolvedores: preencher os nomes do grupo\n"
prompt:   .asciiz "\nDigite n para calcular F(n) e M(n) ou numero negativo para abortar a execucao: "
linha_n:  .asciiz "n\t"
linha_f:  .asciiz "F(n)\t"
linha_m:  .asciiz "M(n)\t"
tab:      .asciiz "\t"
nova_linha: .asciiz "\n"

# Macro para imprimir uma string
.macro print_string(%rotulo)
    li $v0, 4              # codigo do syscall para imprimir string
    la $a0, %rotulo        # endereco da string
    syscall
.end_macro

# Macro para imprimir um inteiro
.macro print_int(%reg)
    li $v0, 1              # codigo do syscall para imprimir inteiro
    move $a0, %reg         # valor que sera impresso
    syscall
.end_macro

# Macro para ler um inteiro
.macro read_int(%reg)
    li $v0, 5              # codigo do syscall para ler inteiro
    syscall
    move %reg, $v0         # guarda o valor lido
.end_macro

.text
.globl main

main:
    print_string(titulo)   # exibe o titulo
    print_string(autores)  # exibe os desenvolvedores

leitura:
    print_string(prompt)   # solicita o valor de n
    read_int($s0)          # $s0 guarda n

    bltz $s0, fim          # numero negativo encerra o programa

    # Mostra a primeira linha: n 0 1 2 ... n
    print_string(linha_n)
    li $s1, 0              # contador inicia em zero

imprime_n:
    bgt $s1, $s0, fim_n    # termina quando contador > n
    print_int($s1)         # imprime o contador
    print_string(tab)
    addi $s1, $s1, 1       # contador++
    j imprime_n

fim_n:
    print_string(nova_linha)

    # Mostra a segunda linha: F(n)
    print_string(linha_f)
    li $s1, 0              # volta o contador para zero

imprime_f:
    bgt $s1, $s0, fim_f    # termina quando contador > n
    move $a0, $s1          # passa o contador como parametro
    jal female             # calcula F(contador)
    move $t0, $v0          # guarda o resultado retornado
    print_int($t0)         # imprime F(contador)
    print_string(tab)
    addi $s1, $s1, 1       # contador++
    j imprime_f

fim_f:
    print_string(nova_linha)

    # Mostra a terceira linha: M(n)
    print_string(linha_m)
    li $s1, 0              # volta o contador para zero

imprime_m:
    bgt $s1, $s0, fim_m    # termina quando contador > n
    move $a0, $s1          # passa o contador como parametro
    jal male               # calcula M(contador)
    move $t0, $v0          # guarda o resultado retornado
    print_int($t0)         # imprime M(contador)
    print_string(tab)
    addi $s1, $s1, 1       # contador++
    j imprime_m

fim_m:
    print_string(nova_linha)
    j leitura              # volta para uma nova entrada

fim:
    li $v0, 10             # codigo do syscall para encerrar
    syscall

# F(n) = 1, se n = 0
# F(n) = n - M(F(n - 1)), se n > 0
female:
    beq $a0, $zero, female_base  # caso base F(0)

    addi $sp, $sp, -8      # reserva duas palavras na pilha
    sw $a0, 0($sp)         # salva o n original
    sw $ra, 4($sp)         # salva o endereco de retorno

    addi $a0, $a0, -1      # prepara n - 1
    jal female             # calcula F(n - 1)

    move $a0, $v0          # passa F(n - 1) para Male
    jal male               # calcula M(F(n - 1))

    lw $t0, 0($sp)         # recupera o n original
    sub $v0, $t0, $v0      # retorna n - M(F(n - 1))

    lw $ra, 4($sp)         # recupera o endereco de retorno
    addi $sp, $sp, 8       # libera o espaco usado na pilha
    jr $ra                  # retorna para quem chamou

female_base:
    li $v0, 1              # F(0) = 1
    jr $ra

# M(n) = 0, se n = 0
# M(n) = n - F(M(n - 1)), se n > 0
male:
    beq $a0, $zero, male_base  # caso base M(0)

    addi $sp, $sp, -8      # reserva duas palavras na pilha
    sw $a0, 0($sp)         # salva o n original
    sw $ra, 4($sp)         # salva o endereco de retorno

    addi $a0, $a0, -1      # prepara n - 1
    jal male               # calcula M(n - 1)

    move $a0, $v0          # passa M(n - 1) para Female
    jal female             # calcula F(M(n - 1))

    lw $t0, 0($sp)         # recupera o n original
    sub $v0, $t0, $v0      # retorna n - F(M(n - 1))

    lw $ra, 4($sp)         # recupera o endereco de retorno
    addi $sp, $sp, 8       # libera o espaco usado na pilha
    jr $ra                  # retorna para quem chamou

male_base:
    li $v0, 0              # M(0) = 0
    jr $ra
