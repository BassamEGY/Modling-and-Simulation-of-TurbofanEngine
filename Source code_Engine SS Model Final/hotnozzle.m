function yout=hotnozzle(Po,Tt5,Ht5,Mw5,Wg5,F_A)

A9=0.5465888;
Ao=A9;
T9ss= 0.833*Tt5;
for i=1:15
    Ht9=((h(T9ss)+(F_A)*hh(T9ss))/(1+F_A));
    Cp9=((Cp(T9ss)+(F_A)*CCp(T9ss))/(1+F_A));
    Rg = 8314.16/ Mw5; 
    Gamma9=Cp9/(Cp9-(Rg/1000));
    a9=sqrt(Gamma9*Rg*T9ss);
    Ht9_static=(Ht5-(a9^2/2000));
    deltaHt9_static=Ht9_static-Ht9;
    error_Ht9=deltaHt9_static/Ht9_static;
    if abs(error_Ht9) > 0.0005
        T9ss=T9ss+(deltaHt9_static/Cp9);
    else
        T9ss;
    end
end
Vj=a9;
rho9=Po/(Rg*T9ss);
Ao_critical=Wg5/(rho9*Vj);
M9=1;
Pt9=Po*(Tt5/T9ss)^(Gamma9/(Gamma9-1));
DAo=Ao-Ao_critical;
% % Non-Design critical and super critical condition
if (DAo<=0)
    P9=Po*(Ao_critical/Ao);
    Pt9=Pt9*(Ao_critical/Ao);
    T9=T9ss;
% % Non-Design subsonic condition
else
    T9=0.85*T9ss;
    for j=1:15
        H9=((h(T9)+(F_A)*hh(T9))/(1+F_A));
        Cp9=((Cp(T9)+(F_A)*CCp(T9))/(1+F_A));
        Rg = 8314.16/Mw5; 
        Gamma9=Cp9/(Cp9-(Rg/1000));
        a9=sqrt(Gamma9*Rg*T9);
        rho9=Po/(Rg*T9);
        Vj=Wg5/(rho9*Ao);
        H9_static=(Ht5-(Vj^2)/(2000));
        deltaH9_static=H9_static-H9;
        error_H9=deltaH9_static/H9_static;
        if abs(error_H9) > 0.0005
          T9=T9+(deltaH9_static/Cp9);
        else
            T9;
        end
    
    end
    Pt9=Po*(Tt5/T9)^(Gamma9/(Gamma9-1));
    M9=Vj/a9;
    V9=Vj;
    P9=Po;
end



yout=[A9 Vj T9 P9 Pt9 M9];


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