function yout=performance1(V19,Mo,To,Po,Waf,Wacl,Wg5,Vj,P19,P9,Wf,Tt2,Pt2,Ncf,Nchc,Tt25,Pt13,Pt5,A19,A9,MFPch,F_A)
thet2d=0.9532186;
thet4d=1.1018;
theta2=sqrt(Tt2/288);
delta2=Pt2/101325;
theta25=sqrt(Tt25/288);
LHV=43095.2;

        ao=sqrt(1.4*287*To);
        Vo=Mo*ao;
        FMC=(Waf-Wacl)*V19;
        FMH=Wg5*Vj;
        FM=FMC+FMH;
        FPC=(P19-Po)*A19;
        FPH=(P9-Po)*A9;
        FP=FPC+FPH;
        FG=FM+FP;
        FR=Waf*Vo;
        Ft=FG-FR;
        SFC=(Wf/Ft)*3600;
        FS=Ft/Waf;
        cwf=Wf/(theta2*delta2);
        CFt=Ft/delta2;
        alfa=(Waf-Wacl)/Wacl;
        nf=Ncf*100*theta2/(thet2d);
        nch=Nchc*100*theta25/(thet4d);
        IEPR=(Pt13*A19+Pt5*A9)/(Pt2*(A9+A19)); 
%       according to Gas Turbine Performance,P.Walsh,
        etath= (0.5*((Wg5*Vj^2)+((Waf-Wacl)*V19^2)-(Waf*Vo^2)))/(Wf*LHV*1000);
        etapro= ((FM-FR)*Vo)/(0.5*((Wg5*Vj^2)+((Waf-Wacl)*V19^2)-(Waf*Vo^2)));
%         etapropulsive=(2*Mo*(((1+F_A)*(Vj/ao))+(beta*(V19/ao))-(Mo*(1+beta))))/(((1+F_A)*((Vj/ao)^2))+(beta*((V19/ao)^2))-((1+beta)*(Mo)^2))
        yout= [Ft CFt cwf FS SFC alfa nf nch IEPR MFPch];

   