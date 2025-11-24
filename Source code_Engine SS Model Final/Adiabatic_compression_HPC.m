function yout=Adiabatic_compression_HPC (Tt25,Pr,Pt25,Ht25,S25,etach)

Mwa=28.97;
Ru=8.31416;
R=Ru/Mwa;
Pt3=Pr*Pt25;
Tt3=Tt25*Pr^0.28572;
for i=1:20
    Cp3=Cp(Tt3);
    Ht3s=h(Tt3);
    Tt3s=Ht3s/Cp3;
    for j=1:25
        Ht3=h(Tt3s);
        DeltaHch=(Ht3s-Ht3);
        errorHch=DeltaHch/Ht3;
        if abs(errorHch)>0.00001
            Tt3s=Tt3s+DeltaHch/Cp3;
%         else
%             Tt3s;
        end
    end
    S3=s(Tt3s)-R*log(Pt3);
    deltaSch=S3-S25;
    if abs(deltaSch) > abs(0.0005*S25)
        Tt3s=Tt3s/exp(deltaSch/Cp(Tt3s));
%     else
%         Tt3s;
    end
end
Ht3s=h(Tt3s);
Ht3=Ht25+((Ht3s-Ht25)/etach);
Tt3=Ht3/Cp(Tt3s);
for k=1:25
    Ht3ss=h(Tt3);
    Cp3=Cp(Tt3);
    DeltaHsch=(Ht3-Ht3ss);
    errorHsch=DeltaHsch/Ht3;
    if abs(errorHsch)>0.00001
        Tt3=Tt3+DeltaHsch/Cp3;
%     else
%         Tt3;
    end
end
S3=s(Tt3)-R*log(Pt3);


yout=[Tt3 Pt3 S3 Ht3 Cp3];


function outs=s(t)
Y = 1.8*t;
outs= 4.184* ((0.25020051*log(Y))+(1.4450767E-26*Y^7)-(2.4211288E-22*Y^6)+(1.5243153E-18*Y^5)-(3.782064E-15*Y^4)-(2.239279E-12*Y^3)+(3.2759743E-8*Y^2)-(5.1576879E-5*Y)+0.0454323);

function outh=h(t)
Y = 1.8*t;
outh=0.55555*4.184*((1.2644425E-26 * Y^8)-(2.0752522E-22*Y^7)+(1.270263E-18*Y^6)-(3.0256518E-15*Y^5)-(1.6794594E-12*Y^4)+(2.1839826E-8*Y^3)-(2.575844E-5*Y^2)+(0.2502*Y)-1.7558886);

function outCp=Cp(t)
Y = 1.8*t;
outCp=4.184*(((1.01554E-25*Y^7)-(1.452677E-21*Y^6)+(7.6215767E-18*Y^5)-(1.5128259E-14*Y^4)-(6.717836E-12*Y^3)+(6.5519486E-8*Y^2)-(5.1536079E-5*Y))+0.25);
