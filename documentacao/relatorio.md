# Documentação do Trabalho 01

## Organização e Arquitetura de Processadores

### Assembly do Processador MIPS
### Sequências Female e Male de Hofstadter

**Desenvolvedores:** preencher nomes do grupo  
**Data:** preencher data da entrega

## 1. Objetivo

Implementar, em linguagem Assembly MIPS e no ambiente MARS, as sequências Female e Male de Hofstadter utilizando funções, macros, recursividade mútua, pilha e chamadas ao sistema.

## 2. Definição das sequências

As sequências são definidas por:

- F(0) = 1
- F(n) = n - M(F(n - 1)), para n > 0
- M(0) = 0
- M(n) = n - F(M(n - 1)), para n > 0

A implementação utiliza duas funções mutuamente recursivas, `female` e `male`.

## 3. Algoritmo de alto nível

Usar como base o conteúdo de `algoritmo.md`.

O programa:
1. apresenta o título e os desenvolvedores;
2. solicita um número inteiro `n`;
3. encerra quando `n` é negativo;
4. caso contrário, imprime os valores de `0` até `n`;
5. calcula e imprime `F(i)` para cada valor;
6. calcula e imprime `M(i)` para cada valor;
7. retorna ao início do laço para uma nova entrada.

## 4. Implementação em Assembly MIPS

O arquivo principal é `hofstadter.asm`.

### 4.1 Macros

O programa utiliza pelo menos três macros:
- `print_string`
- `print_int`
- `read_int`

### 4.2 Função Female

A função `female` implementa:
- caso base `F(0) = 1`;
- caso recursivo `F(n) = n - M(F(n - 1))`.

Antes das chamadas recursivas, o parâmetro original e o registrador `$ra` são preservados na pilha.

### 4.3 Função Male

A função `male` implementa:
- caso base `M(0) = 0`;
- caso recursivo `M(n) = n - F(M(n - 1))`.

Assim como em `female`, o parâmetro original e o registrador `$ra` são preservados na pilha.

## 5. Uso da pilha

Cada chamada recursiva reserva espaço na pilha para preservar:
- o valor original de `n`;
- o endereço de retorno `$ra`.

Ao final da função, os valores são recuperados e o ponteiro da pilha é restaurado.

## 6. Testes

Antes da entrega, registrar testes no MARS para:
- n = 0
- n = 1
- n = 2
- n = 3
- n = 4
- n = 10
- n = 19

Para `n = 4`, o resultado esperado é:

```text
n       0   1   2   3   4
F(n)    1   1   2   2   3
M(n)    0   0   1   2   2
```

## 7. Evidências do MARS

Inserir no PDF final as imagens da pasta `capturas/`:

1. código montado;
2. registradores ao final de uma execução;
3. pilha durante uma chamada recursiva;
4. exemplo de execução completa.

## 8. Conclusão

Preencher após a validação final no MARS, descrevendo brevemente que a implementação demonstrou o uso de recursividade mútua, chamadas de função, macros e gerenciamento manual da pilha no MIPS.
