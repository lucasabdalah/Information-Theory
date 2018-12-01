function [H,P] = simul_bsc(p)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMULATION OF A COMMUNICATION SYSTEM CONSIDERING A BINARY SYMETRIC CHANNEL (BSC) 
% AUTHOR: WALTER FREITAS JR.
% 
% INTRODUÇÃO A TEORIA DA INFORMAÇÃO 2012.1
%
% INPUTS:
% 1) image - signal to be transmitted through the system
% 2) p - error probability of the BSC channel  
%
% OUTPUTS:
% 1) image of the received bits 
% 2) PSNR metric  
%
% Last modification: 10/05/2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clean display, workspace and etc.
clc
close all

% Read image as a matrix w/ apropriated resolution X per Y
% by default is a % X x Y x 3 - 3 is the number of colors components 
% We will disregard the other two components, considering just the
% luminance
%im1 = imread('bw_1.jpg'); % read image
im1 = imread('lena.jpg'); % read image
im1 = im1(:,:,1); % takes the luminance component

figure(1) 
imshow(im1); % show image
title('Imagem Original')

figure(2);
imhist(im1,256); % show  histogram of the image
title(['Histogram of image Black and White']);
ylabel('Pixel Count');

% Entropy
H = entropy(im1); % calculates the entropy

% Symbols and probabilities to support advanced statistic source coding schemes
im1 = double(im1); % make input double
symb = hist(im1(:),256);
P = symb / sum(symb(:));
alf = [0:255];

% source coding
im1_b = de2bi(im1'); % decimal to binary convertion - CAUTION - the convertion transforms the matrix to vector reading column per column

% bsc channel w/ error probability p
%p = 0.5; % error probability 
im1_n = bsc(im1_b,p); % add errors

%%% TODOs possible other channels
% 1) AWGN 
% 2) Rayleigh fading channel

% If p = 1 (deterministic) invertion to recover the channel capacity 
%im1_n = ~im1_n;

% binary signal received after pass through the channel
im1_vec = bi2de(im1_n); % binary to decimal convertion 

% rearrange of the bits to matrix
im1_rec = vec2mat(im1_vec,size(im1,2));

figure(3)
imshow(im1_rec,[0 255]); % show recovery image
title(['Imagem Recuperada para p_{e} = ',num2str(p)])

% PSNR metric
%PSNR = psnr_calc(im1,im1_rec); % calculates the PSNR metric


% EOF