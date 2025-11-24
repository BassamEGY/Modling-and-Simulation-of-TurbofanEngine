function yout=Adiabatic_compression_fan (Tt2,Pr,Pt2,Ht2,S2,etaf)
Mwa=28.97;
Ru=8.31416;
R=Ru/Mwa;
Pt13=Pr*Pt2;
Tt13=Tt2*Pr^0.28572;
for i=1:20 
    Cp13=Cp(Tt13);
    Ht13s=h(Tt13);
    Tt13s=Ht13s/Cp13;
    for j=1:25
        Ht13=h(Tt13s);
        DeltaH13=(Ht13s-Ht13);
        errorHf=DeltaH13/Ht13;
        if abs(errorHf)>0.00001
            Tt13s=Tt13s+DeltaH13/Cp13;
%         else
%             Tt13s;
        end
    end
    S13=s(Tt13s)-R*log(Pt13);
    deltaSf=S13-S2;
    if abs(deltaSf) > abs(0.0005*S2)
        Tt13s=Tt13s/exp(deltaSf/Cp(Tt13s));
%     else
%         Tt13s;
    end
end
Ht13s=h(Tt13s);
Ht13=Ht2+((Ht13s-Ht2)/etaf);
Tt13=Ht13/Cp13;
for k=1:25
    Ht13ss=h(Tt13);
    Cp13=Cp(Tt13);
    DeltaHsf=(Ht13-Ht13ss);
    errorHsf=DeltaHsf/Ht13ss;
    if abs(errorHsf)>0.00001
        Tt13=Tt13+DeltaHsf/Cp13;
%     else
%         Tt13;
    end
end
S13=s(Tt13)-R*log(Pt13);
    
    
yout=[Tt13 Pt13 S13 Ht13];

function outs=s(t)
Y = 1.8*t;
outs= 4.184* ((0.25020051*log(Y))+(1.4450767E-26*Y^7)-(2.4211288E-22*Y^6)+(1.5243153E-18*Y^5)-(3.782064E-15*Y^4)-(2.239279E-12*Y^3)+(3.2759743E-8*Y^2)-(5.1576879E-5*Y)+0.0454323);

function outh=h(t)
Y = 1.8*t;
outh=0.55555*4.184*((1.2644425E-26 * Y^8)-(2.0752522E-22*Y^7)+(1.270263E-18*Y^6)-(3.0256518E-15*Y^5)-(1.6794594E-12*Y^4)+(2.1839826E-8*Y^3)-(2.575844E-5*Y^2)+(0.2502*Y)-1.7558886);

function outCp=Cp(t)
Y = 1.8*t;
outCp=4.184*(((1.01554E-25*Y^7)-(1.452677E-21*Y^6)+(7.6215767E-18*Y^5)-(1.5128259E-14*Y^4)-(6.717836E-12*Y^3)+(6.5519486E-8*Y^2)-(5.1536079E-5*Y))+0.25);
