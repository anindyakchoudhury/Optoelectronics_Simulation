clc;
clear;
close all;

%% Data input for p-type GaAs
q = 1.6e-19;
m0 = 9.11e-31;
me      = 0.067*m0;
mh      = 0.47*m0;
mr      = me*mh/(me+mh);

kB = 1.38e-23;
ni300 = 1.79e6; 
sr = 10e-15;   

% Temperature Range
T = 10:10:300;  

%Varshini Equation
A = 5.41e-4;    
B = 204;        
Eg0 = 1.52;    

Eg =  (Eg0-A.*T.^2./(B+T))*q;  
EgT = (Eg0-A.*300.^2./(B+300))*q;

Na=1e18; 
Nt=1e2; 
del_E=0.2*q;

nis = (ni300)^2  * (T/300).^3   .* exp(  -Eg./(kB*T)  + EgT/(kB*300)  );
ni = nis.^0.5;
po = Na;
no = (ni.*ni)/po;

%% Calculations for different injection level

deln = [1e12 1e15 1e18];

for i = 1:length(deln)
    n = no + deln(i);
    p = po + deln(i);

    vth = sqrt(3*T*kB/mr)*100;  
    Rnr=sr*vth*Nt.*(n.*p-ni.^2)./(n+p+2.*ni.*cosh(del_E./(kB*T)));

    semilogy(T, Rnr,"LineWidth",2,'DisplayName',sprintf(" \\Deltan %.2e (1/cm^3)", deln(i)));
    hold on;
end

xlabel('T (K)');
ylabel('R_{nr}');
grid on;
title('Non-radiative recombination rate as vs T');
legend();
