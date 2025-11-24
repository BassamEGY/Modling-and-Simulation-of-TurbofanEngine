function yout=HPT1(Ht45s,Ht45_old,Pt4,Cp4,F_A,S4)


Pr=0.5;
Pt45=Pr*Pt4;
for i=1:25
    Tt45s=Ht45s/Cp4;
    for j=1:25
        Cp45=((Cp(Tt45s)+(F_A)*CCp(Tt45s))/(1+F_A));
        Ht45sc=((h(Tt45s)+(F_A)*hh(Tt45s))/(1+F_A));
        Mw45 = 28.97 - 0.946186 * F_A;
        Rg = 8.31416/ Mw45; 
        Phi45s=((s(Tt45s)+(F_A)*sss(Tt45s))/(1+F_A));
        deltaHth1=Ht45s-Ht45sc;
        errorHth1=deltaHth1/Ht45sc;
        if abs(errorHth1)> 0.00001
            Tt45s=Tt45s+(deltaHth1/Cp45);

        end
        S45_old=Phi45s-(Rg*log(Pt45));
    end
   DeltaSth1=S45_old-S4;
   if abs(DeltaSth1)>abs(0.0005*S4)
      Pt45=Pt4*exp(DeltaSth1*(Mw45/8.31416)+log(Pt45/Pt4));

   end
end

Tt45=Ht45_old/Cp45;
for k=1:25
    Cp45=((Cp(Tt45)+(F_A)*CCp(Tt45))/(1+F_A));
    Ht45ss=((h(Tt45)+(F_A)*hh(Tt45))/(1+F_A));
    Phi45=((s(Tt45)+(F_A)*sss(Tt45))/(1+F_A));
    deltaHth2=Ht45_old-Ht45ss;
    errorHth2=deltaHth2/Ht45ss;
    if abs(errorHth2)>0.00001
        Tt45=Tt45+(deltaHth2/Cp45);
    end
    S45=Phi45-(Rg*log(Pt45));
    
   
end




yout=[Pt45 Tt45 S45 Cp45];


function outs_air=s(t)
Y = 1.8*t;
outs_air= 4.184* ((0.25020051*log(Y))+(1.4450767E-26*Y^7)-(2.4211288E-22*Y^6)+(1.5243153E-18*Y^5)-(3.782064E-15*Y^4)-(2.239279E-12*Y^3)+(3.2759743E-8*Y^2)-(5.1576879E-5*Y)+0.0454323);

function outs_fuel=sss(t)
Y = 1.8*t;
outs_fuel = 4.184* ((0.073816638 * log(Y))+(1.038267E-25 * Y^7)-(2.22261188D-21* Y^6)+(2.0425826D-17* Y^5)-(1.0512776D-13* Y^4)+( 3.3228928D-10* Y^3)-(6.8859505E-7* Y^2)+(1.225863E-03* Y)+ 0.688595);

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