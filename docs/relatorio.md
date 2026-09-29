# Sequências Female e Male de Hofstadter

Trabalho 01 - Organização e Arquitetura de Processadores

Desenvolvedores: Juarez Fernando Goncalves dos Santos, Theo e Allan.
Data: 28/09/2026.

## Objetivo e definição

O programa implementa as sequências mutuamente recursivas de Hofstadter em
Assembly MIPS, conforme o enunciado “Trabalho - Assembly do Processador MIPS -
Hofstadter_v2.pdf”, seções 1.1, 1.2 e 2.

- F(0) = 1; para n > 0, F(n) = n - M(F(n - 1)).
- M(0) = 0; para n > 0, M(n) = n - F(M(n - 1)).

Após o cabeçalho com data e desenvolvedores, main solicita um inteiro n.
Se n for negativo, encerra. Caso contrário, imprime três linhas: os índices
de 0 até n, seus valores Female e seus valores Male. Depois solicita outra
entrada. O algoritmo em português estruturado está em `algoritmo.md`; a
versão em C está em `trabalho1.c`.

## Organização do Assembly

`main` controla a entrada e os três laços de impressão. `$s0` guarda o limite
n e `$s1` guarda o índice da coluna. As funções `female` e `male` recebem o
parâmetro em `$a0` e devolvem o resultado em `$v0`. Elas não alteram `$s0`
ou `$s1`. `$t0` é temporário; não guarda um valor que precise sobreviver a
outra chamada recursiva.

As três macros são `print_string` (syscall 4), `print_int` (syscall 1) e
`read_int` (syscall 5). O encerramento usa o syscall 10. As macros de saída
utilizam `$v0` e `$a0`; por isso, main copia o resultado da função para `$t0`
antes de chamar `print_int`.

Female primeiro calcula F(n - 1), chama Male com esse resultado e subtrai
o retorno do n original. Male faz o processo correspondente: M(n - 1),
Female desse resultado e a subtração. Assim, ambas têm chamadas próprias e
cruzadas, preservando a recursividade exigida.

## Pilha e retorno

Cada chamada com n > 0 decrementa `$sp` em 8 bytes. O quadro é:

| Deslocamento em relação a `$sp` | Conteúdo |
| --- | --- |
| 0 | Parâmetro n original |
| 4 | Endereço de retorno `$ra` |

Depois das chamadas, n é carregado em `$t0` para a subtração. O endereço de
retorno é restaurado, `$sp` é incrementado em 8 e `jr $ra` retorna ao chamador.
O valor final de `$a0` não precisa ser preservado para o chamador. Os casos
n = 0 não fazem chamadas e retornam diretamente, sem reservar um quadro.

Em `pilha-female.png`, a execução de F(4) está dentro de F(3), antes de chamar
F(2). Há dois quadros, e `$sp = 0x7fffefec`, 16 bytes abaixo do valor inicial.

Em `pilha-male.png`, a cadeia ativa é F(4) → F(3) → F(2) → F(1) → M(1).
A próxima chamada será M(0). Os cinco quadros ocupam 40 bytes:

| Função ativa | Endereço do quadro | n salvo | `$ra` salvo |
| --- | --- | --- | --- |
| M(1) | 0x7fffefd4 | 1 | 0x00400174 |
| F(1) | 0x7fffefdc | 1 | 0x0040016c |
| F(2) | 0x7fffefe4 | 2 | 0x0040016c |
| F(3) | 0x7fffefec | 3 | 0x0040016c |
| F(4) | 0x7fffeff4 | 4 | 0x004000b4 |

## Execução e verificação

Ambiente: MARS 4.5, pseudoinstruções e macros habilitadas, delayed branching
desabilitado e configuração de memória padrão. O código não foi organizado
para executar com delay slots habilitados. Para entrada de texto não inteiro,
o tratamento é o do simulador; os testes seguem o domínio de inteiros do
trabalho. O C verifica falha de leitura e fim da entrada.

Os testes de `testes/verificar.py` compilam o C com `-std=c11 -Wall -Wextra
-Werror` e executam os dois programas. Os valores esperados foram transcritos
da tabela do enunciado; não são calculados pelas funções sob teste.

| Entradas, em ordem | Resultado obtido e esperado |
| --- | --- |
| 0, 1, 4, 19, -1 | Tabelas corretas para cada valor não negativo; encerramento em -1. |
| -5 | Cabeçalho e pedido de entrada, sem tabela; encerramento imediato. |
| 4, 0, 4, -2 | Tabelas corretas, inclusive ao repetir 4 e voltar a zero; encerramento em -2. |

Todos os cenários passaram no C e no MARS. O C compilou sem avisos. No MARS,
`$sp` terminou em `0x7fffeffc` nos três cenários, igual ao valor inicial.
A saída detalhada dos testes está em `testes/resultados.txt`.

Para n = 19, os resultados conferidos são:

```text
n     0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
F(n)  1 1 2 2 3 3 4 5 5 6  6  7  8  8  9  9 10 11 11 12
M(n)  0 0 1 2 2 3 4 4 5 6  6  7  7  8  9  9 10 11 11 12
```

A captura `execucao-registradores.png` mostra uma execução adicional na
interface gráfica com 0, 4, 19 e -1. Após o encerramento, `$s0 = 0xffffffff`
(-1), `$s1 = 0x00000014` (20), `$v0 = 10` e `$sp = 0x7fffeffc`.
O contador 20 resulta da última tabela, que incluiu o índice 19.

A implementação recalcula subproblemas e não usa memoização. Valores maiores
podem exigir muito mais tempo; a validação de resultados cobre n de 0 a 19.

## Material de entrega

O PDF reúne esta explicação, o algoritmo, o código C, o Assembly completo
comentado e as sete capturas do MARS. As quatro vistas `codigo-01.png` a
`codigo-04.png` cobrem o segmento de texto inteiro com sobreposição, de
0x00400000 a 0x004001c8 (115 instruções montadas). As demais capturas mostram
a execução e os registradores finais, a pilha em Female e a pilha em Male.

O arquivo compactado contém o PDF e `hofstadter.asm` separadamente, além das
fontes de documentação, do C, das imagens e dos testes. O simulador MARS e
o enunciado da disciplina não integram o pacote.

## Conferência dos requisitos

| Requisito | Evidência entregue |
| --- | --- |
| Funções principal, Female e Male | `main`, `female` e `male` em `hofstadter.asm`. |
| Pelo menos três macros | `print_string`, `print_int` e `read_int`. |
| Recursividade mútua | Chamadas próprias e cruzadas em Female e Male. |
| Preservação na pilha | n e `$ra` salvos e recuperados em quadros de 8 bytes. |
| Cabeçalho inicial | Título, data e três desenvolvedores na saída. |
| Leitura e laço até negativo | Leitura por syscall 5, teste de sinal e retorno à leitura. |
| Tabela de 0 até n | Três linhas horizontais, verificadas até n = 19. |
| Código comentado | Assembly completo reproduzido neste documento. |
| Algoritmo de alto nível | Português estruturado e implementação em C. |
| Área de código montada | Quatro capturas que cobrem todas as instruções. |
| Registradores finais e execução | Captura da sessão com 0, 4, 19 e -1. |
| Pilha durante Female e Male | Duas capturas com quadros ativos e explicação dos endereços. |
| Documentação e Assembly separado | PDF e arquivo `.asm` incluídos no pacote compactado. |
