function yout=coldnozzle(Po,Tt13,Ht13,Mwa,Waf,Wacl)


DWa=Waf-Wacl;
A19=1.439379;
Ao=A19;
T19ss= 0.833*Tt13;
for i=1:15
    Ht19=h(T19ss);
    Cp19=Cp(T19ss);
    Rg = 8314.16/ Mwa; 
    Gamma19=Cp19/(Cp19-(Rg/1000));
    a19=sqrt(Gamma19*Rg*T19ss);
    Ht19_static=(Ht13-(a19^2)/2000);
    deltaHt19_static=Ht19_static-Ht19;
    error_Ht19=deltaHt19_static/Ht19_static;
    if abs(error_Ht19) > 0.0005
        T19ss=T19ss+(deltaHt19_static/Cp19);
    else
        T19ss;
    end
end
V19=a19;
rho19=Po/(Rg*T19ss);
Ao_critical=DWa/(rho19*V19);
M19=1;
Pt19=Po*(Tt13/T19ss)^(Gamma19/(Gamma19-1));
DAo=Ao-Ao_critical;
% % Non-Design critical and super critical condition
if (DAo<=0)
    P19=Po*(Ao_critical/Ao);
    Pt19=Pt19*(Ao_critical/Ao);
    T19=T19ss;
% % Non-Design subsonic condition
else
    T19=0.85*T19ss;
    for j=1:15
        H19=h(T19);
        Cp19=Cp(T19);
        Rg = 8314.16/ Mwa; 
        Gamma19=Cp19/(Cp19-(Rg/1000));
        a19=sqrt(Gamma19*Rg*T19);
        rho19=Po/(Rg*T19);
        V19=DWa/(rho19*Ao);
        H19_static=(Ht13-(V19^2)/2000);
        deltaH19_static=H19_static-H19;
        error_H19=deltaH19_static/H19_static;
        if abs(error_H19) > 0.0005
           T19=T19+(deltaH19_static/Cp19);
        else
           T19;
        end
    end
    Pt19=Po*(Tt13/T19)^(Gamma19/(Gamma19-1));
    M19=V19/a19;
    P19=Po;
end

yout=[A19 V19 T19 P19 Pt19 M19];


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