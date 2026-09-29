"""Confere as saídas do C e do MARS com a tabela do enunciado (n=0..19)."""
import pathlib
import re
import subprocess
import sys
import tempfile

ROOT = pathlib.Path(__file__).resolve().parents[1]
FEMALE = [1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12]
MALE = [0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12]


def executar(comando, entrada):
    resultado = subprocess.run(comando, input=entrada, text=True,
                               capture_output=True, timeout=60)
    if resultado.returncode != 0:
        raise RuntimeError(resultado.stdout + resultado.stderr)
    return resultado.stdout


def conferir(nome, comando):
    for entradas in ([0, 1, 4, 19, -1], [-5], [4, 0, 4, -2]):
        saida = executar(comando, ''.join(f'{n}\n' for n in entradas))
        linhas = re.findall(r'(?:^|: )(n|F\(n\)|M\(n\))\t([^\n]*)', saida, re.M)
        obtido = [(rotulo, [int(v) for v in valores.split()])
                  for rotulo, valores in linhas]
        esperado = []
        for n in entradas:
            if n >= 0:
                esperado.extend([('n', list(range(n + 1))),
                                 ('F(n)', FEMALE[:n + 1]),
                                 ('M(n)', MALE[:n + 1])])
        if obtido != esperado:
            raise AssertionError(f'{nome}: entrada={entradas}; obtido={obtido}; esperado={esperado}')
        assert saida.count('Sequencias Female e Male de Hofstadter - 28/09/2026') == 1
        assert 'Desenvolvedores: Juarez Fernando Goncalves dos Santos, Theo e Allan' in saida
        assert saida.count('Digite n para calcular') == len(entradas)
        if nome == 'MARS':
            assert re.search(r'\$sp\s+0x7fffeffc', saida), saida
        print(f'{nome}: entrada={entradas}; obtido=saidas esperadas, encerramento normal; esperado=tabela do PDF e encerramento no negativo. OK')


if __name__ == '__main__':
    if len(sys.argv) != 2:
        sys.exit('Uso: python3 testes/verificar.py /caminho/Mars4_5.jar')
    mars = pathlib.Path(sys.argv[1]).resolve(strict=True)
    with tempfile.TemporaryDirectory(prefix='hofstadter-testes-') as pasta:
        executavel = str(pathlib.Path(pasta) / 'hofstadter-c')
        subprocess.run(['cc', '-std=c11', '-Wall', '-Wextra', '-Werror',
                        str(ROOT / 'trabalho1.c'), '-o', executavel], check=True)
        conferir('C', [executavel])
        conferir('MARS', ['java', '-jar', str(mars), 'nc', 'sm', 'ae1', 'se2',
                         'sp', str(ROOT / 'hofstadter.asm')])
    print('C compilado sem avisos. MARS 4.5: delayed branching desativado; pilha restaurada ao final dos tres cenarios.')
