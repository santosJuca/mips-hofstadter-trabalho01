#include <stdio.h>
#include <stdlib.h>

/*𝐹(𝑛) = {1, 𝑖 = 0
            𝑛 − 𝑀(𝐹(𝑛 − 1)), ∀ 𝑖 > 0

𝑀(𝑛) = {0, 𝑖 = 0
        𝑛 − 𝐹(𝑀(𝑛 − 1)), ∀ 𝑖 > 0
*/

int F(int n);
int M(int n);

int main () {

    int val = 0;
    printf("Insira um valor: ");
    scanf("%d", &val);

    printf("Resultado F(): %d\n", F(val));
    printf("Resultado M(): %d\n", M(val));

    return 0;
}

int F(int n)
{
    if (n == 0)
        return 1;
    if (n > 0)
        return n - M(F(n-1));
    else
        fprintf(stderr, "Erro: número negativo não permitido (%d)\n", n);
        exit(1);
}

int M(int n)
{
    if (n == 0)
        return 0;
    if (n > 0)
        return n - F(M(n-1));
    else
        fprintf(stderr, "Erro: número negativo não permitido (%d)\n", n);
        exit(1);
}