# Algoritmo em alto nível

O programa recebe inteiros e apresenta as sequências de 0 até n, inclusive.
Um valor negativo encerra o laço. A implementação em C está em `trabalho1.c`.

```text
função Female(n)
    se n = 0
        retornar 1
    retornar n - Male(Female(n - 1))
fim função

função Male(n)
    se n = 0
        retornar 0
    retornar n - Female(Male(n - 1))
fim função

função main()
    mostrar "Sequencias Female e Male de Hofstadter - 28/09/2026"
    mostrar "Desenvolvedores: Juarez Fernando Goncalves dos Santos, Theo Carvalho Kirsch e Allan Rosa"

    repetir
        mostrar "Digite n para calcular F(n) e M(n) ou numero negativo para abortar a execucao: "
        ler inteiro n
        se n < 0
            encerrar

        mostrar "n", sem mudar de linha
        para i de 0 até n, inclusive
            mostrar i, separado por tabulação
        mudar de linha

        mostrar "F(n)", sem mudar de linha
        para i de 0 até n, inclusive
            mostrar Female(i), separado por tabulação
        mudar de linha

        mostrar "M(n)", sem mudar de linha
        para i de 0 até n, inclusive
            mostrar Male(i), separado por tabulação
        mudar de linha
    fim repetir
fim função
```

As chamadas são mutuamente recursivas. Female calcula `Female(n - 1)` e
passa o resultado para Male; Male calcula `Male(n - 1)` e passa o resultado
para Female. O parâmetro original n precisa continuar disponível para a
subtração após essas chamadas.
