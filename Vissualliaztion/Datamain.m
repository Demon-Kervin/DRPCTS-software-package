clc;
clear all;
close all;
load 1porosity.mat
E=A;
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