close all
clear all


IM=imread('unnamed.jpg');

IM = rgb2gray(IM); %imagem em escala de cinza

M = fftshift(IM); %Aqui ocorre a translação

M = fft2(M)

Ab = real(M);

minimun = min(min(Ab));
maximun = max(max(Ab));

Ab = (Ab - minimun)./(maximun).*255;

Mask = imread('espectro-mascara.png');

Mask = (Mask)./(65536).*255;

Mask = uint8(Mask);

Ab = immultiply(Mask,Ab);

minimun = min(min(Ab));
maximun = max(max(Ab));

Ab = (Ab - minimun)./(maximun).*255;

Ab = uint8(Ab);

Z = complex(Ab,imag(M));

Z = ifft2(Z);

Z = ifftshift(Z);

Z = real(Z);

minimun = min(min(Z));
maximun = max(max(Z));

Z = (Z - minimun)./(maximun).*255;

figure(1);
imshow(uint8(Z));




