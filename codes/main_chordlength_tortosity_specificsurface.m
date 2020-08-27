clc;
clear all;
close all;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  pore-scle parameters%%%%%%%%%%%%%%
% chord length  tortosity  specific surface


% INPUTS
A=imread('1.bmp');
A=double(A);
A=imadjust(A,[0 1],[1 0]);

Resolution=8.68; % micron/pixel


% CALCULATIONS
if size(A,3)==3
A=im2bw(A,graythresh(A));
end
Conn=8; 
[s1,s2]=size(A);
A=~bwmorph(A,'majority',10);
Poro=sum(sum(~A))/(s1*s2);
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
[Pr_L,Pr_n]=bwlabel(Pr,Conn); %%%
V=zeros(Pr_n,1);
for I=1:s1
    for J=1:s2
        if Pr_L(I,J)~=0
            V(Pr_L(I,J))=V(Pr_L(I,J))+1;
        end
    end
end
R=Resolution.*(V./pi).^.5; 
RR=(V./pi).^.5; 
SR=6./R;
%Outputs
Average_grain_radius_micron=mean(R);
Standard_deviation_of_grain_radius_micron=std(R);

RGB=label2rgb(Pr_L,'jet', 'w', 'shuffle');

%%%%%%%%%%%%%%%%%__________________________________
%%%%%%%%%%%%%%%%% show image

CC=Pr_L;
[m,n]=size(CC);
CC1=reshape(CC,[m*n 1]);
CC2=unique(CC);
CC3=tabulate(CC1);
CC4=CC3(2:end,1:2);
[m1,n1]=size(CC4);

for i=1:m1
    [r1,c1]=find(CC==CC4(i,1));
    a1=min(r1);
    a2=max(r1);
    b1=min(c1);
    b2=max(c1);
    CL1(i)=abs(a2-a1);                         
    CL2(i)=abs(b2-b1);                         
    CL3(i)=sqrt(CL1(i)^2+CL2(i)^2);            
    CL4(i)=(CL1(i)+CL2(i)+CL3(i))/3;           
    Tortuosityd4(i)=RR(i)*pi/CL4(i);            
    Tortuosityd14=Tortuosityd4';
end


NN=Pr_n;
Porimg=Pr_L;
PRimg=Pr_L;
SRimg=Pr_L;
for kk=1:NN
    index=find(Pr_L==kk);
    RR=CL4(kk)*14;
    RRR=Tortuosityd14(kk);
    RRRR=SR(kk);
    Porimg(index)=RR;
    PRimg(index)=RRR;
    SRimg(index)=RRRR;
end
Porimg(find(Porimg==0))=NaN;
PRimg(find(PRimg==0))=NaN;
SRimg(find(SRimg==0))=NaN;

 
A=Porimg;  
figure;
set(0,'defaultfigurecolor','w'); 
h=imagesc(A);
set(h,'alphadata',~isnan(A));
colormap hsv
c=colorbar;
digits(3);
c.FontSize=12;
grid on
shading interp


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

%
A2=SRimg;  
figure;
set(0,'defaultfigurecolor','w'); 
h=imagesc(A2);
set(h,'alphadata',~isnan(A2));
colormap hsv
c=colorbar;
digits(3);
c.FontSize=12;
grid on
shading interp

