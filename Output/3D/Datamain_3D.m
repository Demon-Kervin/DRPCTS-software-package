clc;clear; close all;
% load D.mat
clc;clear; close all;
load 1Por.mat
[m,n,p]=size(D);


%%%%%%%%%% 3D display %%%%%%%%%%%%%
sx=1:100;
sy=1:100;
sz=1:100;
figure;
slice(D,sx,sy,sz);
shading interp
colormap hsv
axis equal
view(-216,70);