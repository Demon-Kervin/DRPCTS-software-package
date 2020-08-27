clc;clear; close all;

%%%%%%%%%%%%%% pore_scale_parameter %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% grain size
% INPUTS
A=imread('E:\1PHD\Paper\DRPP\1Chengxu\DRPCTS-software-package\Data\1.bmp');
A=double(A);
A=imadjust(A,[0 1],[1 0]);

Resolution=8.68; 
Number_of_categories=20; 

% CALCULATIONS
if size(A,3)==3
A=im2bw(A,graythresh(A));
end
Conn=8;
[s1,s2]=size(A);
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


% % % %Outputs


NN=max(max(Pr_L));
Porimg=Pr_L;
PRimg=Pr_L;
Perimg=Pr_L;
pormum=length(find(Pr_L>0));
porosity=double(pormum/s1/s2)*100;
Per=332;
for kk=1:NN
    index=find(Pr_L==kk);
    RR=R(kk);
    Por=double(length(index)/pormum);
    Porimg(index)=Por*porosity;
    Perimg(index)=Per*Por;
    PRimg(index)=RR;
end
PRimg(find(PRimg==0))=NaN;   
Ra=mean(R);

%
A1=PRimg;
figure;
set(0,'defaultfigurecolor','w'); 
h=imagesc(A1);
set(h,'alphadata',~isnan(A1));
colormap hsv
c=colorbar;
digits(3);
c.FontSize=12;
grid on
shading interp






