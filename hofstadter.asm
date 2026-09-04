# Trabalho 01 - Sequencias Female e Male de Hofstadter
# Disciplina: Organizacao e Arquitetura de Processadores
# Desenvolvedores: preencher os nomes do grupo
#
# Arquivo inicial para desenvolvimento e testes no MARS.

.data
titulo:  .asciiz "Sequencias Female e Male de Hofstadter\n"
autores: .asciiz "Desenvolvedores: preencher os nomes do grupo\n"
prompt:  .asciiz "\nDigite n para calcular F(n) e M(n) ou um numero negativo para sair: "
aviso:   .asciiz "Calculo ainda em desenvolvimento.\n"

.text
.globl main

main:
    # Exibe o titulo
    li $v0, 4
    la $a0, titulo
    syscall

    # Exibe os desenvolvedores
    li $v0, 4
    la $a0, autores
    syscall

leitura:
    # Solicita o valor de n
    li $v0, 4
    la $a0, prompt
    syscall

    # Le um numero inteiro
    li $v0, 5
    syscall
    move $t0, $v0

    # Numero negativo encerra o programa
    bltz $t0, fim

    # A implementacao das sequencias sera adicionada aqui
    li $v0, 4
    la $a0, aviso
    syscall

    j leitura

fim:
    li $v0, 10
    syscall

# TODO: implementar a funcao recursiva Female
female:
    jr $ra

# TODO: implementar a funcao recursiva Male
male:
    jr $ra
