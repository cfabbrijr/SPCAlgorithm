% C�digo para Recupera��o de Imagens por Sensoriamento Compressivo usando a
% l�gica f�sica do dispositivo de DMD
%
%_DESCRI��O_
% Adapta��o do c�digo usado por Stuart Gibson para implementar o exemplo de
% sencoriamento compressivo proposto por R. Baraniuk em Compressive Sensing
% em IEEE Signal Processing Magazine, Julho 2007.
% A opera��o f�sica entre os padr�es aleat�rios e a imagem orginal foi
% usada para "ler" o sinal original implementando o uso do dispositivo DMD
% na pr�tica.
%
%_DEPEND�NCIAS_
% Requer o conjunto de scripts l_1-magic: Recovery of Sparse Signals via
% convex programming, criado por E. Cand�s e J. Roberg, Caltech, 2005.
% Usa a estrutura de pastas propostas pelos autores do pacote l_1-magic.
%
%_VARI�VEIS_
% A = imagem original (a x b); 
% n = tamanho de A vetorizado (vetor coluna);
% y = sinal comprimido (m x 1); 
% matrizPhi (m x n) = matriz de medidas aleat�rias; 
% mdmd = padr�o aleat�rio individual, extra�do da matrizPhi;
% Theta (m x n) = matriz base de representa��o esparsa; 
% s (n x 1) = vetor de coeficientes esparsos a ser recuperado;
% x1 (n x 10 = vetor de coeficientes do sinal recuperado pelo algoritmo.
%
% criado em 28/08/2019
% por Carlos Fabbri Jr, Escola Polit�cnica da USP, Depto PEA.
% Modificado em 06/01/2020

%%=====================Inicializa��o====================================%%
path(path, './Optimization');               % Pasta Otimiza��o
path(path, './Measurement');                % Pasta Medidas
path(path, './Data');                       % Pasta Dados
% mesma estrutura de pastas usadas pelo pacote l_1-magic
%
tic                                     % inicializar o contador de tempo

clear, close all;  clc;                 % apagar as vari�veis do ambiente

A = imread('original128peb.bmp');            % Ler a imagem original
A = A([40:79],[20:79]);                      % selecionar a �rea da imagem
[a, b]= size(A);                             % obter as medidas da imagem
x = double(A(:));
n = length(double(A(:)));                    % vetorizar a imagem


y=[];                                % Inicializar a matriz de leituras y
m=1000;                           % n�mero de amostras, leituras da imagem
Theta = zeros(m,n);                 % Inicializar a matriz Theta
x1 = zeros(n,1);                    % Inicializar o vetor x1

fprintf('Inicializa��o Efetuada....\n')



%%===============Gerar Marizes - Aleat�ria e Representa��o==============%%

matrizPhi = randi([0 1],m,n);        % Criar a matriz de padr�es aleat�rios
... ela ser� usada depois 
% Phi = orth(matrizPhi')'; 


Theta = matrizPhi*dct(eye(n));      % Popula a matriz com os valores da dct
... dos padr�es aleat�rios
% no c�digo original, era criada a matriz Phi = dct(eye(n)) em um loop for;

%%=================Leitura da imagem via exposi��o ao DMD================%%

for ii =1:m
    mdmd=reshape(matrizPhi(ii,:),a,b);      % usar o padr�o como matriz a x b
    leitura=immultiply(mdmd,A);            % "Ler" a imagem pelo padr�o
    amostra=sum(sum(leitura));              % totalizar pixels da imagem
    y(ii)=[amostra];                        % armazenar em y
end

y = (y/(a*b))';                     % Normaliza��o das leituras da imagem

fprintf('Compress�o Efetuada....\n')

%%===================Solu��o pela Norma L2==============================%%
%s2 = Theta\y; %s2 = pinv(Theta)*y
s2 = pinv(Theta)*y;                 % Solu��o da invers�o por norma L2

fprintf('Recuperando a imagem original usando o pacote l_1-magic...\n')

%%======================Solu��o por Basis Pursuit=======================%%

s1 = l1eq_pd(s2,Theta,Theta',y,5e-3,20); % L1-magic toolbox

fprintf('Solu��o encontrada...\n')

%%=================Reconstru��o das Imagens=============================%%

psiinversodireto = idct(eye(n));    % Criar matriz de vetores dct inversos

for ii = 1:n;
    x1 = x1+psiinversodireto(:,ii)*s1(ii);      % recalcula o coeficiente
end

fprintf('Reconstru��o Efetuada...\n')

fprintf('Efetuando a plotagem das imagens...\n')

figure('name','Reconstru��o de Imagem por Compressive Sensing')
subplot(1,2,1), imagesc(A), xlabel('original'), axis image % imagem original
subplot(1,2,2), imagesc(reshape(x1,a,b)), xlabel('Imagem recuperada'), axis image
colormap gray

toc                                      % Interrompe o coontador de tempo


