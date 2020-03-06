% Código para Recuperação de Imagens por Sensoriamento Compressivo usando a
% lógica física do dispositivo de DMD
%
%_DESCRIÇÃO_
% Adaptação do código usado por Stuart Gibson para implementar o exemplo de
% sencoriamento compressivo proposto por R. Baraniuk em Compressive Sensing
% em IEEE Signal Processing Magazine, Julho 2007.
% A operação física entre os padrões aleatórios e a imagem orginal foi
% usada para "ler" o sinal original implementando o uso do dispositivo DMD
% na prática.
%
%_DEPENDÊNCIAS_
% Requer o conjunto de scripts l_1-magic: Recovery of Sparse Signals via
% convex programming, criado por E. Candès e J. Roberg, Caltech, 2005.
% Usa a estrutura de pastas propostas pelos autores do pacote l_1-magic.
%
%_VARIÁVEIS_
% A = imagem original (a x b); 
% n = tamanho de A vetorizado (vetor coluna);
% y = sinal comprimido (m x 1); 
% matrizPhi (m x n) = matriz de medidas aleatórias; 
% mdmd = padrão aleatório individual, extraído da matrizPhi;
% Theta (m x n) = matriz base de representação esparsa; 
% s (n x 1) = vetor de coeficientes esparsos a ser recuperado;
% x1 (n x 10 = vetor de coeficientes do sinal recuperado pelo algoritmo.
%
% criado em 28/08/2019
% por Carlos Fabbri Jr, Escola Politécnica da USP, Depto PEA.
% Modificado em 06/01/2020

%%=====================Inicialização====================================%%
path(path, './Optimization');               % Pasta Otimização
path(path, './Measurement');                % Pasta Medidas
path(path, './Data');                       % Pasta Dados
% mesma estrutura de pastas usadas pelo pacote l_1-magic
%
tic                                     % inicializar o contador de tempo

clear, close all;  clc;                 % apagar as variáveis do ambiente

A = imread('original128peb.bmp');            % Ler a imagem original
A = A([40:79],[20:79]);                      % selecionar a área da imagem
[a, b]= size(A);                             % obter as medidas da imagem
x = double(A(:));
n = length(double(A(:)));                    % vetorizar a imagem


y=[];                                % Inicializar a matriz de leituras y
m=1000;                           % número de amostras, leituras da imagem
Theta = zeros(m,n);                 % Inicializar a matriz Theta
x1 = zeros(n,1);                    % Inicializar o vetor x1

fprintf('Inicialização Efetuada....\n')



%%===============Gerar Marizes - Aleatória e Representação==============%%

matrizPhi = randi([0 1],m,n);        % Criar a matriz de padrões aleatórios
... ela será usada depois 
% Phi = orth(matrizPhi')'; 


Theta = matrizPhi*dct(eye(n));      % Popula a matriz com os valores da dct
... dos padrões aleatórios
% no código original, era criada a matriz Phi = dct(eye(n)) em um loop for;

%%=================Leitura da imagem via exposição ao DMD================%%

for ii =1:m
    mdmd=reshape(matrizPhi(ii,:),a,b);      % usar o padrão como matriz a x b
    leitura=immultiply(mdmd,A);            % "Ler" a imagem pelo padrão
    amostra=sum(sum(leitura));              % totalizar pixels da imagem
    y(ii)=[amostra];                        % armazenar em y
end

y = (y/(a*b))';                     % Normalização das leituras da imagem

fprintf('Compressão Efetuada....\n')

%%===================Solução pela Norma L2==============================%%
%s2 = Theta\y; %s2 = pinv(Theta)*y
s2 = pinv(Theta)*y;                 % Solução da inversão por norma L2

fprintf('Recuperando a imagem original usando o pacote l_1-magic...\n')

%%======================Solução por Basis Pursuit=======================%%

s1 = l1eq_pd(s2,Theta,Theta',y,5e-3,20); % L1-magic toolbox

fprintf('Solução encontrada...\n')

%%=================Reconstrução das Imagens=============================%%

psiinversodireto = idct(eye(n));    % Criar matriz de vetores dct inversos

for ii = 1:n;
    x1 = x1+psiinversodireto(:,ii)*s1(ii);      % recalcula o coeficiente
end

fprintf('Reconstrução Efetuada...\n')

fprintf('Efetuando a plotagem das imagens...\n')

figure('name','Reconstrução de Imagem por Compressive Sensing')
subplot(1,2,1), imagesc(A), xlabel('original'), axis image % imagem original
subplot(1,2,2), imagesc(reshape(x1,a,b)), xlabel('Imagem recuperada'), axis image
colormap gray

toc                                      % Interrompe o coontador de tempo


