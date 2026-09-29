# Trabalho 01 - Hofstadter em Assembly MIPS

Implementação das sequências Female e Male de Hofstadter para a disciplina de
Organização e Arquitetura de Processadores. O programa lê um inteiro n,
apresenta as três linhas `n`, `F(n)` e `M(n)` de 0 até n e pede uma nova entrada.
Um número negativo encerra a execução.

Desenvolvedores: Juarez Fernando Goncalves dos Santos, Theo e Allan.

## Executar no MARS

1. Abra `hofstadter.asm` no MARS 4.5.
2. Em **Settings**, mantenha habilitadas as pseudoinstruções e macros
   (**Permit extended (pseudo) instructions and formats**) e deixe
   **Delayed branching** desabilitado.
3. Monte com **Run > Assemble** (F3) e execute com **Run > Go** (F5).
4. Informe, por exemplo, `4`. Depois informe outro inteiro ou `-1` para sair.

```text
n       0   1   2   3   4
F(n)    1   1   2   2   3
M(n)    0   0   1   2   2
```

O código usa `main`, `female`, `male` e três macros de entrada/saída.
Cada chamada recursiva não básica reserva 8 bytes para n e `$ra`.
Os casos-base retornam diretamente. A avaliação é recursiva, sem memoização;
valores grandes de n podem demorar bastante. A entrada prevista é um inteiro.

## Arquivos

- [hofstadter.asm](hofstadter.asm): programa comentado para o MARS.
- [trabalho1.c](trabalho1.c): versão em C com a mesma interface para entradas inteiras.
- [algoritmo.md](algoritmo.md): descrição em português estruturado.
- [docs/relatorio.md](docs/relatorio.md): explicação da implementação e dos testes.
- [docs/relatorio.pdf](docs/relatorio.pdf): documentação com código completo e capturas.
- [capturas/](capturas/README.md): código montado, execução, registradores e pilha.
- [testes/verificar.py](testes/verificar.py): comparação com a tabela do enunciado.
- [testes/resultados.txt](testes/resultados.txt): registro dos testes realizados.

## Conferir os resultados

Com Python 3, Java e um compilador C instalados:

```sh
python3 testes/verificar.py /caminho/Mars4_5.jar
```

O teste compila o C com avisos tratados como erros, executa o C e o MARS e
compara as saídas com os valores do PDF para n até 19. Também confere o
cabeçalho, a repetição das entradas, o encerramento por negativo e o valor
final de `$sp` no MARS. O JAR do simulador não é distribuído neste repositório.

Para executar apenas o C:

```sh
cc -std=c11 -Wall -Wextra -Werror trabalho1.c -o /tmp/hofstadter-c
/tmp/hofstadter-c
```

## Entrega

O pacote `entrega/hofstadter-trabalho01.zip` reúne o PDF, o Assembly separado,
o C, o algoritmo, as capturas e os testes. O PDF contém a mesma versão do
Assembly incluída no pacote. Arquivos `.zip` são ignorados pelo Git;
para gerar o pacote novamente, execute na raiz do projeto:

```sh
mkdir -p entrega
zip -r entrega/hofstadter-trabalho01.zip README.md hofstadter.asm trabalho1.c algoritmo.md docs capturas testes
```
