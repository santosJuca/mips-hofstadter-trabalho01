# Trabalho 01 - Hofstadter em Assembly MIPS

Repositório usado para desenvolver o Trabalho 01 da disciplina de Organização e Arquitetura de Processadores.

## Objetivo

Implementar no MARS as sequências Female e Male de Hofstadter usando Assembly MIPS, funções recursivas, macros e pilha.

O programa:
- lê um valor inteiro `n`;
- calcula as sequências Female e Male;
- mostra os valores de `0` até `n`;
- repete a execução até que seja digitado um número negativo.

## Arquivos

- `hofstadter.asm`: implementação Assembly MIPS.
- `algoritmo.md`: algoritmo em alto nível.
- `trabalho1.c`: implementação auxiliar em C.
- `capturas/`: evidências exigidas no MARS.
- `documentacao/relatorio.md`: base da documentação final.
- `ENTREGA.md`: checklist final antes de compactar e enviar.

## Requisitos principais

- [x] Função principal `main`.
- [x] Função recursiva `Female`.
- [x] Função recursiva `Male`.
- [x] Recursividade mútua entre Female e Male.
- [x] Pelo menos três macros.
- [x] Uso da pilha para preservar parâmetro e endereço de retorno.
- [x] Laço de leitura até entrada negativa.
- [x] Impressão das sequências de `0` até `n`.
- [x] Algoritmo em alto nível.
- [ ] Preencher os nomes reais dos desenvolvedores no `hofstadter.asm`.
- [ ] Executar e validar o programa no MARS.
- [ ] Adicionar as quatro capturas obrigatórias na pasta `capturas/`.
- [ ] Finalizar a documentação em PDF.
- [ ] Gerar o ZIP final contendo o PDF e o mesmo `.asm` documentado.

## Validação esperada

Para `n = 4`:

```text
n       0   1   2   3   4
F(n)    1   1   2   2   3
M(n)    0   0   1   2   2
```

Também é recomendado testar `n = 0`, `1`, `2`, `3`, `10` e `19` antes da entrega.
