clear all;
close all;
clc;


%% p-type GaAs data
q = 1.6e-19;
m0 = 9.11e-31;
me      = 0.067*m0;
mh      = 0.47*m0;
mr      = me*mh/(me+mh);


h_cut = 6.626e-34/(2*pi);
kB = 1.38e-23;

c = 3e8;
ni300 = 1.79e6; % 1/cm3 at 300K

sr = 10e-15;    %cm2
Br = 10e-11;                %cm3 1/s    direct bg material

%varshini for GaAs
A = 5.41e-4;    %eV / K
B = 204;        %K
Eg0 = 1.52;     %eV


%% Data
Na=1e18; % doping concentration
Nt=1e2; % defect density
del_E=0.2*q; % trap energy located 0.2eV above the fermi energy level





T = 10:10:300;                  %K
Eg =  (Eg0-A.*T.^2./(B+T))*q;   %J


Eg300 = (Eg0-A.*300.^2./(B+300))*q;

nis = (ni300)^2  * (T/300).^3   .* exp(  -Eg./(kB*T)  + Eg300/(kB*300)  );

ni = nis.^0.5;
po = Na;
no = (ni.*ni)/po;
%%  1st injection level
deln = [1e15 1e16 1e17];



for i = 1:length(deln)
    n = no + deln(i);
    p = po + deln(i);

    vth = sqrt(3*T*kB/mr)*100;  %cm/2

    Rnr=sr*vth*Nt.*(n.*p-ni.^2)./(n+p+2.*ni.*cosh(del_E./(kB*T)));

    semilogy(T, Rnr,"LineWidth",2,'DisplayName',sprintf("deln = %.2e", deln(i)));
    hold on;
end

xlabel('T (K)');
ylabel('R_{nr}');
grid on;
title('non-radiative recombination rate as vs T');
legend();











T = 10:10:300;                  %K
Eg =  (Eg0-A.*T.^2./(B+T))*q;   %J


Eg300 = (Eg0-A.*300.^2./(B+300))*q;

nis = (ni300)^2  * (T/300).^3   .* exp(  -Eg./(kB*T)  + Eg300/(kB*300)  );

ni = nis.^0.5;
po = Na;
no = (ni.*ni)/po;
%%  1st injection level
deln = [1e15 1e16 1e17];



for i = 1:length(deln)
    n = no + deln(i);
    p = po + deln(i);

    vth = sqrt(3*T*kB/mr)*100;  %cm/2

    Rnr=sr*vth*Nt.*(n.*p-ni.^2)./(n+p+2.*ni.*cosh(del_E./(kB*T)));

    semilogy(T, Rnr,"LineWidth",2,'DisplayName',sprintf("deln = %.2e", deln(i)));
    hold on;
end

xlabel('T (K)');
ylabel('R_{nr}');
grid on;
title('non-radiative recombination rate as vs T');
legend();








