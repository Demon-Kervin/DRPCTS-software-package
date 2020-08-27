clc;clear; close all;

%%%%%%%%%%%%%%% thermal physicl parameters%%%%%%%%%%%%%%%%
% INPUTS

A=imread('E:\1PHD\Paper\DRPP\1Chengxu\DRPCTS-software-package\Data\1.bmp');
A=double(A);
    A1=A;
    A=imadjust(A,[0 1],[1 0]);

Resolution=8.68; 
Number_of_categories=20; 
% CALCULATIONS
if size(A,3)==3
A=im2bw(A,graythresh(A));
end
Conn=8;
[s1,s2]=size(A);
index11=find(A==1);
pporo=length(index11)/s1/s2*100;
nnnn=length(index11);
AA=A;
AA(index11)=100*rand(1,nnnn);

A=~bwmorph(A,'majority',10);
Poro=sum(sum(~A))/(s1*s2)*100;
D=-bwdist(A,'cityblock');
B=medfilt2(D,[3 3]);
B=watershed(B,Conn);
Pr=zeros(s1,s2);

for I=1:s1
    for J=1:s2
        if A(I,J)==0 && B(I,J)~=0
            Pr(I,J)=1;
        end
    end
end
Pr=bwareaopen(Pr,9,Conn);
[Pr_L,Pr_n]=bwlabel(Pr,Conn);
V=zeros(Pr_n,1);
for I=1:s1
    for J=1:s2
        if Pr_L(I,J)~=0
            V(Pr_L(I,J))=V(Pr_L(I,J))+1;
        end
    end
end
R=Resolution.*(V./pi).^.5; 

% CALCULATIONS
if size(A1,3)==3
A1=im2bw(A1,graythresh(A1));
end
Conn1=8;
[s11,s21]=size(A1);


A1=~bwmorph(A1,'majority',10);
D1=-bwdist(A1,'cityblock');
B1=medfilt2(D1,[3 3]);
B1=watershed(B1,Conn1);
Pr1=zeros(s11,s21);

for I1=1:s11
    for J1=1:s21
        if A1(I1,J1)==0 && B1(I1,J1)~=0
            Pr1(I1,J1)=1;
        end
    end
end
Pr1=bwareaopen(Pr1,9,Conn1);
[Pr_L1,Pr_n1]=bwlabel(Pr1,Conn1);
V1=zeros(Pr_n1,1);
for I1=1:s11
    for J1=1:s21
        if Pr_L1(I1,J1)~=0
            V1(Pr_L1(I1,J1))=V1(Pr_L1(I1,J1))+1;
        end
    end
end
pormum=length(find(Pr_L>0));
porosity=double(pormum/s1/s2)*100;

pormum1=length(find(Pr_L1>0));
porosity1=double(pormum1/s11/s21)*100;

% % % %Outputs

per=332;
STH=0.95*(1-porosity/100);
THC=5.91*(1-porosity/100)+porosity/100*0.025;
THD=4.5*(1-porosity/100);
THE=12.6*(1-porosity/100);

NN=max(max(Pr_L));
PSTHimg=Pr_L;
PTHCimg=Pr_L;
PTHDimg=Pr_L;
PTHEimg=Pr_L;


NN1=max(max(Pr_L1));
GSTHimg=Pr_L1;
GTHCimg=Pr_L1;
GTHDimg=Pr_L1;
GTHEimg=Pr_L1;




for kk=1:NN
    index=find(Pr_L==kk);
    Por=double(length(index)/pormum);
%     PSTHimg(index)=Por*STH;
    PTHCimg(index)=Por*THC;
%     PTHDimg(index)=Por*THD;
%     PTHEimg(index)=Por*THE;
end

for kk1=1:NN1
    index1=find(Pr_L1==kk1);
    Por1=double(length(index1)/pormum1);
    GSTHimg(index1)=Por1*STH;  
    GTHCimg(index1)=Por1*THC;  
    GTHDimg(index1)=Por1*THD;  
    GTHEimg(index1)=Por1*THE;  
end

GPTHCimg=GTHCimg+PTHCimg;
GSTHimg(find(GSTHimg==0))=NaN;
GPTHCimg(find(GPTHCimg==0))=NaN;
GTHDimg(find(GTHDimg==0))=NaN;
GTHEimg(find(GTHEimg==0))=NaN;


%%%%%%%%% out put%%%%%%%%%%%%%


% 
AD=GSTHimg;  % specific heat capacity
figure;
set(0,'defaultfigurecolor','w'); 
h=imagesc(AD);
set(h,'alphadata',~isnan(AD));
colormap hsv
c=colorbar;
digits(3);
c.FontSize=12;
grid on
shading interp


% % 
AD1=GPTHCimg; %%%% themal conductivity
figure;
set(0,'defaultfigurecolor','w'); 
h=imagesc(AD1);
set(h,'alphadata',~isnan(AD1));
colormap hsv
c=colorbar;
digits(3);
c.FontSize=12;
grid on
shading interp



% % 
AD2=GTHDimg;     
set(0,'defaultfigurecolor','w'); 
h=imagesc(AD2);
set(h,'alphadata',~isnan(AD2));
colormap hsv
c=colorbar;
digits(3);
c.FontSize=12;
grid on
shading interp


AD3=GTHEimg;    
figure;
set(0,'defaultfigurecolor','w'); 
h=imagesc(AD3);
set(h,'alphadata',~isnan(AD3));
colormap hsv
c=colorbar;
digits(3);
c.FontSize=12;
grid on
shading interp






















