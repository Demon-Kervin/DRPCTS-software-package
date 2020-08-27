clc;
clear all;
close all;
load 3grainsize.mat
E=A1;
figure;
h=imagesc(E);
set(h,'alphadata',~isnan(E));
set(0,'defaultfigurecolor','w'); 

colormap hsv;
c=colorbar;
digits(3);

axis equal
axis tight
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])