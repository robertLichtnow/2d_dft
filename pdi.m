close all
clear all


IM=imread('passaro.jpg');

IM = rgb2gray(IM); %imagem em escala de cinSaidaa

figure(1);
imshow(IM);

IM_FFT2 = fft2(IM);

IM_FFT2 = fftshift(IM_FFT2); %Aqui ocorre a translação

ParteReal = abs(IM_FFT2);

minimun = min(min(ParteReal));
maximun = max(max(ParteReal));

ParteReal = (ParteReal - minimun)./(maximun-minimun).*255;

figure(2)
imshow(ParteReal);

Mascara = imread('mascara-full.png');
Mascara = im2bw(Mascara, 0.8);

figure(3)
imshow(Mascara);


Im_multi = immultiply(Mascara,ParteReal);
Im_multi = uint8(Im_multi);

Saida = complex(Im_multi,imag(IM_FFT2));
Saida = ifftshift(Saida);
Saida = ifft2(Saida);
Saida = abs(Saida);

minimun = min(min(Saida));
maximun = max(max(Saida));

Saida = (Saida - minimun)./(maximun-minimun).*255;

figure(4);
imshow(uint8(Saida));




