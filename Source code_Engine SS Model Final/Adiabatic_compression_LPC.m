function yout=Adiabatic_compression_LPC (Tt13,Pr,Pt13,Ht13,S13,etacl)

Mwa=28.97;
Ru=8.31416;
R=Ru/Mwa;
Pt25=Pr*Pt13;
Tt25=Tt13*Pr^0.28572;
for i=1:20
    Cp25=Cp(Tt25);
    Ht25s=h(Tt25);
    Tt25s=Ht25s/Cp25;
    for j=1:25
        Ht25=h(Tt25s);
        DeltaHcl=(Ht25s-Ht25);
        errorHcl=DeltaHcl/Ht25;
        if abs(errorHcl)>0.00001
            Tt25s=Tt25s+DeltaHcl/Cp25;
%         else
%             Tt25s;
        end
    end
    S25=s(Tt25s)-R*log(Pt25);
    deltaScl=S25-S13;
    if abs(deltaScl) > abs(0.0005*S13)
        Tt25s=Tt25s/exp(deltaScl/Cp(Tt25s));
%     else
%         Tt25s;
    end
end
Ht25s=h(Tt25s);
Ht25=Ht13+((Ht25s-Ht13)/etacl);
Tt25=Ht25/Cp25;
for k=1:25
    Ht25ss=h(Tt25);
    Cp25=Cp(Tt25);
    DeltaHscl=(Ht25-Ht25ss);
    errorHscl=DeltaHscl/Ht25ss;
    if abs(errorHscl)>0.00001
        Tt25=Tt25+DeltaHscl/Cp25;
%     else
%         Tt25;
    end
end
S25=s(Tt25)-R*log(Pt25);


yout=[Tt25 Pt25 S25 Ht25];


function outs=s(t)
Y = 1.8*t;
outs= 4.184* ((0.25020051*log(Y))+(1.4450767E-26*Y^7)-(2.4211288E-22*Y^6)+(1.5243153E-18*Y^5)-(3.782064E-15*Y^4)-(2.239279E-12*Y^3)+(3.2759743E-8*Y^2)-(5.1576879E-5*Y)+0.0454323);

function outh=h(t)
Y = 1.8*t;
outh=0.55555*4.184*((1.2644425E-26 * Y^8)-(2.0752522E-22*Y^7)+(1.270263E-18*Y^6)-(3.0256518E-15*Y^5)-(1.6794594E-12*Y^4)+(2.1839826E-8*Y^3)-(2.575844E-5*Y^2)+(0.2502*Y)-1.7558886);

function outCp=Cp(t)
Y = 1.8*t;
outCp=4.184*(((1.01554E-25*Y^7)-(1.452677E-21*Y^6)+(7.6215767E-18*Y^5)-(1.5128259E-14*Y^4)-(6.717836E-12*Y^3)+(6.5519486E-8*Y^2)-(5.1536079E-5*Y))+0.25);
