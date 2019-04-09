clc 
close all
clear all


IM=imread('passaro.jpg');

IM = rgb2gray(IM); %imagem em escala de cinSaidaa

subplot(2,3,1); 
imshow(IM);

IM_FFT2 = fft2(IM); %A transformada ocorre aqui

IM_FFT2 = fftshift(IM_FFT2); %Aqui ocorre a translação, matlab sugere que a translação seja feita sempre após a FFT2

Amplitude = abs(IM_FFT2); %Gera a imagem de amplitude para plotar

minimun = min(min(Amplitude));
maximun = max(max(Amplitude));

Amplitude = (Amplitude - minimun)./(maximun-minimun)*255; %Clamping

subplot(2,3,2);
imshow(Amplitude);

Mascara = imread('mascara-1.png'); %Mascara 1 é a melhor opção
Mascara = im2bw(Mascara, 0.8); %Treshhold de 0.8 apenas para garantir imagem binária
%Mascara = (1-Mascara).^2; %Inversão do filtro

subplot(2,3,3);
imshow(Mascara);


Im_multi = times(Mascara,real(IM_FFT2)); %Multiplicação em arranjo matricial

subplot(2,3,4);
imshow(Im_multi);

Saida = complex(Im_multi,imag(IM_FFT2)); %Gera matrix complexa novamente
Saida = ifftshift(Saida); %Translação inversa
Saida = ifft2(Saida); %Transformada inversa
Saida = real(Saida);  %Devido a precisão de pontos flutuantes o resultado possui resquiciios imaginarios

minimun = min(min(Saida));
maximun = max(max(Saida));

Saida = (Saida - minimun)./(maximun-minimun)*255; %Clamping
Saida = uint8(Saida);

subplot(2,3,5);
imshow(Saida);

Compare = Saida - IM;

subplot(2,3,6);
imshow(Compare);





