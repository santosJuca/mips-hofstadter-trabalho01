# Capturas do MARS

Capturas da interface do MARS 4.5, obtidas com `hofstadter.asm` em 28/09/2026.
A montagem usa pseudoinstruções habilitadas e delayed branching desabilitado.
Os valores dos registradores são mostrados em hexadecimal.

| Arquivo | Evidência |
| --- | --- |
| `codigo-01.png` a `codigo-04.png` | Toda a área de código montada, em quatro vistas sobrepostas. As 115 instruções ocupam os endereços 0x00400000 a 0x004001c8. |
| `execucao-registradores.png` | Entradas 0, 4, 19 e -1 na mesma execução; saída completa e registradores após o encerramento. |
| `pilha-female.png` | Pausa em `jal female`, linha 117, durante F(4). Dois quadros ativos: F(4) e F(3). `$sp = 0x7fffefec`. |
| `pilha-male.png` | Pausa em `jal male`, linha 143, dentro de M(1), chamada por F(1) durante F(4). Cinco quadros ativos; `$sp = 0x7fffefd4`. |

## Reproduzir as pausas

1. Monte o programa e marque um breakpoint na linha 117 (`jal female`).
2. Execute e informe 4. Continue com F5 até `$s1 = 4` e `$sp = 0x7fffefec`.
3. Na área **Data Segment**, selecione **current $sp**. A próxima chamada é F(2);
   F(3) já salvou n e `$ra` na pilha.
4. Retire esse breakpoint e marque a linha 143 (`jal male`). Continue com F5.
   A pausa seguinte está em M(1), prestes a chamar M(0), com `$sp = 0x7fffefd4`.
5. Para a execução completa, remova os breakpoints, reinicie com **Run > Reset**
   e informe 0, 4, 19 e -1. Ao final, `$sp` volta a `0x7fffeffc`.

Na captura de Male, os cinco quadros ocupam 40 bytes. Cada quadro contém n
no deslocamento 0 e o endereço de retorno no deslocamento 4.
