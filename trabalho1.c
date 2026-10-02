#include <stdio.h>

int Female(int n);
int Male(int n);

int main(void)
{
    int n;

    printf("Sequencias Female e Male de Hofstadter - 28/09/2026\n");
    printf("Desenvolvedores: Juarez Fernando Goncalves dos Santos, Theo Carvalho Kirsch e Allan Rosa\n");

    for (;;) {
        printf("\nDigite n para calcular F(n) e M(n) ou numero negativo para abortar a execucao: ");
        int leitura = scanf("%d", &n);
        if (leitura == EOF)
            return 0;
        if (leitura != 1) {
            fprintf(stderr, "Entrada invalida: informe um inteiro.\n");
            return 1;
        }
        if (n < 0)
            return 0;

        printf("n\t");
        for (int i = 0; i <= n; i++)
            printf("%d\t", i);
        printf("\nF(n)\t");
        for (int i = 0; i <= n; i++)
            printf("%d\t", Female(i));
        printf("\nM(n)\t");
        for (int i = 0; i <= n; i++)
            printf("%d\t", Male(i));
        printf("\n");
    }
}

/* As funcoes recebem apenas valores naturais. */
int Female(int n)
{
    if (n == 0)
        return 1;
    return n - Male(Female(n - 1));
}

int Male(int n)
{
    if (n == 0)
        return 0;
    return n - Female(Male(n - 1));
}
