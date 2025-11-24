
function yout=datatables(Tt2,Pt2,Tt13,Pt13,Tt25,Pt25,Tt3,Pt3,Tt4,Pt4,Tt45,Pt45,Tt5,Pt5,waf,wacl,To,Po,cNcl,cFnet,wf,Ncf)
Tsls=288;
Psls=101325;
theta2=sqrt(Tt2/Tsls);
delta2=Pt2/Psls;
cTt13=Tt13/theta2;
cPt13=(Pt13/delta2)*1E-05;
cTt25=Tt25/theta2;
cPt25=(Pt25/delta2)*1E-05;
cTt3=Tt3/theta2;
cPt3=(Pt3/delta2)*1E-05;
cTt4=Tt4/theta2;
cPt4=(Pt4/delta2)*1E-05;
cTt45=Tt45/theta2;
cPt45=(Pt45/delta2)*1E-05;
cTt5=Tt5/theta2;
cPt5=(Pt5/delta2)*1E-05;
cwf=wf/(sqrt(Tt2/Tsls)*(Pt2/Psls));
beta=(waf-wacl)/wacl;
  
yout=[cTt13 cPt13 cTt25 cPt25 cTt3 cPt3 cTt4 cPt4 cTt45 cPt45 cTt5 cPt5 cwf Ncf cNcl cFnet beta waf wacl];
