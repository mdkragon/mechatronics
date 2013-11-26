close all
clc
m = length(rawStarData);

figure
hold on

n=1;
Ax1 = rawStarData(1:m,n);
n=5;
Ay1 = rawStarData(1:m,n);
plot(Ax1,Ay1,'k');

n=2;
Ax2 = rawStarData(1:m,n);
n=6;
Ay2 = rawStarData(1:m,n);
plot(Ax2,Ay2,'b');

n=3;
Ax3 = rawStarData(1:m,n);
n=7;
Ay3 = rawStarData(1:m,n);
plot(Ax3,Ay3,'g');

n=4;
Ax4 = rawStarData(1:m,n);
n=8;
Ay4 = rawStarData(1:m,n);
plot(Ax4,Ay4,'r');


%From diagram. Order is bd > cd > ac > ad > ab > bc
ab = 256;
ad = 400;
ac = 533;
bc = 169;
bd = 841;
cd = 676;

%Numbered alphabetically
AB = (Ax1-Ax2).^2+(Ay1-Ay2).^2;
AC = (Ax1-Ax3).^2+(Ay1-Ay3).^2;
AD = (Ax1-Ax4).^2+(Ay1-Ay4).^2;
BC = (Ax2-Ax3).^2+(Ay2-Ay3).^2;
BD = (Ax2-Ax4).^2+(Ay2-Ay4).^2;
CD = (Ax3-Ax4).^2+(Ay3-Ay4).^2;

%Sorting Code
for i=1:length(AB)
    rank(i,1) = AB(i);
    rank(i,2) = AC(i);
    rank(i,3) = AD(i);
    rank(i,4) = BC(i);
    rank(i,5) = BD(i);
    rank(i,6) = CD(i);
    
    
    for j=1:12
        %put stuff in position
        for z = 1:12
            if(z < 7)
                sorted(i,z) = z;
            else
                sorted(i,z) = rank(i,z-6);
            end
        end
        
        %sort the poop
        if(j>7)
            for k=7:12
                for q=7:12
                    if(sorted(i,k) > sorted(i,q))
                        var = sorted(i,k);
                        sorted(i,k) = sorted(i,q);
                        sorted(i,q) = var;
                        
                        pos = sorted(i,q-6);
                        sorted(i,q-6) = sorted(i,k-6);
                        sorted(i,k-6) = pos;
                    end
                end
            end
        end
    end
end

theta = atan2(Ay2-Ay4,Ax2-Ax4);
if(Ax2 > Ax4)
    center_x = (Ax2-Ax4)/2+Ax4;
    us_x = (center_x-512)+512;
else
    center_x = (Ax4-Ax2)/2+Ax2;
    us_x = (center_x-512)+512;
end

if(Ay2 > Ay4)
    center_y = (Ay2-Ay4)*.6882+Ay4;
    us_y = (512-center_y)+512;
else
    center_y = (Ay4-Ay2)*.6882+Ay2;
    us_y = -(center_y-512)+512;
end

plot(center_x,center_y, '-.o');
plot(us_x, us_y, '-.r');
axis equal
