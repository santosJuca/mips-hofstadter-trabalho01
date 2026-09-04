# Algoritmo em alto nível

## Programa principal

```text
início
    mostrar o título do programa
    mostrar os nomes dos desenvolvedores

    repetir
        pedir um número inteiro n
        ler n

        se n for negativo
            encerrar o programa
        senão
            mostrar os valores de 0 até n
            calcular e mostrar Female para cada valor
            calcular e mostrar Male para cada valor
        fim se
    até o programa ser encerrado
fim
```

## Função Female

```text
função Female(n)
    se n for igual a 0
        retornar 1
    senão
        retornar n - Male(Female(n - 1))
    fim se
fim função
```

## Função Male

```text
função Male(n)
    se n for igual a 0
        retornar 0
    senão
        retornar n - Female(Male(n - 1))
    fim se
fim função
```
