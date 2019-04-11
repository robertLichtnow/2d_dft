clc 
close all
clear all


IM=imread('passaro.jpg'); %lê a imagem

IM = rgb2gray(IM); %imagem em escala de cinza

subplot(2,3,1); 
imshow(IM); %plota imagem em escala de cinza

IM_FFT2 = fft2(IM); %A transformada ocorre aqui

IM_FFT2 = fftshift(IM_FFT2); %Aqui ocorre a translação, 
                             %matlab sugere que a translação seja feita sempre após a FFT2

Amplitude = abs(IM_FFT2); %Gera a imagem de amplitude para plotar
                          %imagem utilizada para gerar o filtro posteriormente

minimun = min(min(Amplitude));
maximun = max(max(Amplitude));

Amplitude = (Amplitude - minimun)./(maximun-minimun)*255; %Clamping da imagem da amplitude

subplot(2,3,2);
imshow(Amplitude); %plot da imagem da amplitude

%Mascara = imread('mascara-1.png'); %Mascara 1 é a correta
%Mascara = im2bw(Mascara, 0.8); %Treshhold de 0.8 apenas para garantir imagem binária
%Mascara = (1-Mascara).^2; %Inversão do filtro, descomente esta linha para inverter o filtro

%{
[x,y] = size(IM);

fator = 50;

Mascara = zeros(x,y);
Mascara(x/2 - fator: x/2 + fator, y/2 - fator:y/2 + fator) = 1;
%}
%Bloco do filtro passa baixa


[x,y] = size(IM);

fator = 50;

Mascara = ones(x,y);
Mascara(x/2 - fator: x/2 + fator, y/2 - fator:y/2 + fator) = 0;



subplot(2,3,3);
imshow(Mascara); %plotando o filtro


Im_multi = Mascara.*IM_FFT2; %Multiplicação em arranjo matricial

subplot(2,3,4);
imshow(Im_multi); %plotando resultado, mas somente da parte real

Saida = ifftshift(Im_multi); %Translação inversa
Saida = ifft2(Saida); %Transformada inversa
Saida = real(Saida);  %Devido a precisão de pontos flutuantes o resultado possui resquiciios imaginarios

minimun = min(min(Saida));
maximun = max(max(Saida));

Saida = (Saida - minimun)./(maximun-minimun)*255; %Clamping da saida
Saida = uint8(Saida); %transformando em imagem de 8bits

subplot(2,3,5);
imshow(Saida); %plotando imagem de saida

Compare = Saida - IM; %fazendo diff da imagem filtrada com a imagem original

subplot(2,3,6);
imshow(Compare); %plotando diff





