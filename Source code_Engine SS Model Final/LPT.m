function yout=LPT(Ht5s,Ht5,Pt45,Cp45,F_A,S45)


Pr=0.5;
Pt5=Pr*Pt45;
for i=1:25
    Tt5s=Ht5s/Cp45;
    for j=1:25
        Cp5=((Cp(Tt5s)+(F_A)*CCp(Tt5s))/(1+F_A));
        Ht5sc=((h(Tt5s)+(F_A)*hh(Tt5s))/(1+F_A));
        Mw5 = 28.97 - 0.946186 * F_A;     
        Rg = 8.31416/ Mw5; 
        gamma5=Cp5/(Cp5-Rg);
        Phi5s=((s(Tt5s)+(F_A)*sss(Tt5s))/(1+F_A));
        deltaHtl1=Ht5s-Ht5sc;
        errorHtl1=deltaHtl1/Ht5sc;
        if abs(errorHtl1)> 0.00001
            Tt5s=Tt5s+(deltaHtl1/Cp5);
        end
        S5_old=Phi5s-(Rg*log(Pt5));
    end
   DeltaStl=S5_old-S45;
   if abs(DeltaStl)> abs(0.0005*S45)
      Pt5=Pt45*exp(DeltaStl*(Mw5/8.31416)+log(Pt5/Pt45));
   end
end

Tt5=Ht5/Cp5;
for k=1:25
    Cp5=((Cp(Tt5)+(F_A)*CCp(Tt5))/(1+F_A));
    Ht5ss=((h(Tt5)+(F_A)*hh(Tt5))/(1+F_A));
    gamma5=Cp5/(Cp5-Rg);
    Phi5=((s(Tt5)+(F_A)*sss(Tt5))/(1+F_A));
    deltaHtl2=Ht5-Ht5ss;
    errorHtl2=deltaHtl2/Ht5ss;
    if abs(errorHtl2)>0.00001
        Tt5=Tt5+(deltaHtl2/Cp5);
    end
    S5=Phi5-(Rg*log(Pt5));

end




yout=[Pt5 Tt5 S5 Cp5 gamma5 Mw5];


function outs_air=s(t)
Y = 1.8*t;
outs_air= 4.1868* ((0.25020051*log(Y))+(1.4450767E-26*Y^7)-(2.4211288E-22*Y^6)+(1.5243153E-18*Y^5)-(3.782064E-15*Y^4)-(2.239279E-12*Y^3)+(3.2759743E-8*Y^2)-(5.1576879E-5*Y)+0.0454323);

function outs_fuel=sss(t)
Y = 1.8*t;
outs_fuel = 4.1868* ((0.073816638 * log(Y))+(1.038267E-25 * Y^7)-(2.22261188D-21* Y^6)+(2.0425826D-17* Y^5)-(1.0512776D-13* Y^4)+( 3.3228928D-10* Y^3)-(6.8859505E-7* Y^2)+(1.225863E-03* Y)+ 0.688595);

function outh_air=h(t)
Y = 1.8*t;
outh_air=0.55555*4.184*((1.2644425E-26 * Y^8)-(2.0752522E-22*Y^7)+(1.270263E-18*Y^6)-(3.0256518E-15*Y^5)-(1.6794594E-12*Y^4)+(2.1839826E-8*Y^3)-(2.575844E-5*Y^2)+(0.2502*Y)-1.7558886);

function outh_fuel=hh(t)
Y = 1.8*t;
outh_fuel=0.55555*4.184*((9.0848388D-26*Y^8)-(1.9050949D-21*Y^7)+(1.7021525D-17*Y^6)-(8.4102208D-14*Y^5)+(2.4921698D-10*Y^4)-(4.5906332E-7*Y^3)+(6.129315E-04*Y^2)+(0.073816638*Y)+30.058153);

function outCp_air=Cp(t)
Y = 1.8*t;
outCp_air=4.184*(((1.01554E-25*Y^7)-(1.452677E-21*Y^6)+(7.6215767E-18*Y^5)-(1.5128259E-14*Y^4)-(6.717836E-12*Y^3)+(6.5519486E-8*Y^2)-(5.1536079E-5*Y))+0.25);

function outCp_fuel=CCp(t)
Y = 1.8*t;
outCp_fuel = 4.184*(((7.26787E-25 * Y^7)-(1.3335668D-20*Y^6)+(1.0212913D-16*Y^5)-(4.2051104D-13*Y^4)+(9.968792E-10*Y^3)-(1.3771901E-6*Y^2)+(1.225863E-03*Y))+0.073816638);