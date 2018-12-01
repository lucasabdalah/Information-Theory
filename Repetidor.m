function [im1_b] = Repetidor(n)


im1 = imread('lena.jpg'); % read image
im1 = im1(:,:,1); % takes the luminance component

im1 = double(im1); % make input double
symb = hist(im1(:),256);
P = symb / sum(symb(:));
alf = [0:255];

% source coding
im1_b = de2bi(im1'); % decimal to binary convertion - CAUTION - the convertion transforms the matrix to vector reading column per column

a = size(im1_b);
a = a(1)*a(2);

im1_b = reshape(im1_b', [1 a]);

im1_b = repmat(im1_b,n,1);

b = size(im1_b);
b = b(1)*b(2);

im1_b = reshape(im1_b, [1 b]);

% bsc channel w/ error probability p
%p = 0.5; % error probability 
%im1_n = bsc(im1_b,p); % add errors

% binary signal received after pass through the channel
%im1_vec = bi2de(im1_n); % binary to decimal convertion 

% rearrange of the bits to matrix
%im1_rec = vec2mat(im1_vec,size(im1,2));
