function [R,S]=prunikZnaku(znak)
% znak...vstupni znak pro prolozeni primek a propocet.
% R,S.. vektory hodnot souctu krizeni primek se znakem
% R...primka v radku, S...primka ve sloupci
% se znakem.
% IZnak ...vraci znak prolozeny vsemi reznymi primkami (pro
% prehled, co bylo presne riznuto)
%% vypocet radku a sloupcu urcenych provedeni rezu
sumaradky=sum(znak,2);
sumasloupce=sum(znak,1);
Sloupec1=1;%prvni sloupec s nenulovym souctem pixelu...zacina znak
while(sumasloupce(Sloupec1)==0)
    Sloupec1=Sloupec1+1;
end
Sloupec2=size(znak,2);%posledni sloupec s nenulovym souctem pixelu...konci znak
while(sumasloupce(Sloupec2)==0)
    Sloupec2=Sloupec2-1;
end
Radek1=1;
while(sumaradky(Radek1)==0)
    Radek1=Radek1+1;
end
Radek2=size(znak,1);
while(sumaradky(Radek2)==0)
    Radek2=Radek2-1;
end
krokR=fix((Radek2-Radek1)/9);
r1=Radek1+krokR;
r3=fix((Radek2-Radek1)/2)+Radek1;
r5=Radek2-krokR;
krokR=fix((Radek2-Radek1)/4);
r2=Radek1+krokR;
r4=Radek2-krokR;

krokS=fix((Sloupec2-Sloupec1)/5);
s1=Sloupec1+krokS;
s2=fix((Sloupec2-Sloupec1)/2)+Sloupec1;
s3=Sloupec2-krokS;
%% vypocet kolikrat protnu znak v radku
R=[0,0,0,0,0];
radek=[r1,r2,r3,r4,r5];
for j=1:5
pom=0;
i=Sloupec1;
while (i<Sloupec2)
    if znak(radek(j),i)==1
        while((znak(radek(j),i)==1 && (znak(radek(j),i)~=Sloupec2)))
        i=i+1;
        end
        pom=pom+1;
    end
    i=i+1;    
end
R(j)=pom;
end
%% pocitani kolikrat protnu cislici ve vybranem sloupci
S=[0,0,0];
sloupec=[s1,s2,s3];
for j=1:3
pom=0;
i=Radek1;
while (i<Radek2+1)
    if znak(i,sloupec(j))==1
        while(znak(i,sloupec(j))==1)
        i=i+1;
        end
        pom=pom+1;
    end
    i=i+1;    
end
S(j)=pom;
end
%% ilustrativni cast pro nasi zpetnou vazbu, jak vhodne jsou zvolene urovne rezu
figure
imshow(znak)
line([1,size(znak,2)],[r1,r1]);
line([1,size(znak,2)],[r2,r2]);
line([1,size(znak,2)],[r3,r3]);
line([1,size(znak,2)],[r4,r4]);
line([1,size(znak,2)],[r5,r5]);
line([s1,s1],[1,size(znak,1)]);
line([s2,s2],[1,size(znak,1)]);
line([s3,s3],[1,size(znak,1)]);
end