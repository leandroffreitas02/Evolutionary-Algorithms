
% =====================================================
% Indica o número da função (um número entre 1 e 10):
fi = 3;  % escolhemos a função número 3

% =====================================================
% Define o comando para chamar a função-objetivo:
fobj = @(x) cec20_func(x, fi);  % notar que fi deve estar definido 

% =====================================================
% Exemplo de chamada da função objetivo:

% O vetor de entrada deve ter dimensão 2, 5, 10, 15 ou 20:
x0 = ones(10,1);   % escolhemos a dimensão 10

% Cálculo do valor da função-objetivo para a função 3, com dimensão 10, no
% ponto x0:
y = fobj(x0)
