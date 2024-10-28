clc;
clear all;
close all;


%% Choose data

i = 2;
switch (i)
    case 1 
        GaAs_Data()
        lamda0 = 860e-9;
    case 2 
        GaN_Data()
        lamda0 = 360e-9;
end


% SI unit
h = 6.626e-34;
h_cut = h/(2*pi);
c = 3e8;
k_B = 1.38e-23;

%%


A = 0.5*(1/10)^2;       % 0.5 mm2 in cm2
nf = 1;
V = linspace(0,3,10000);


% A/cm2
Js = q*((Dn*npo/Ln)+(Dp*pno/Lp))

Is = A*Js;
I = Is*exp(((q*V)./(nf*k_B*T))-1);

plot(V,I/1e-6, "LineWidth",2);
xlabel('V (V)');
ylabel('I (\muA)');
title('I-V characteristics of GaN');

ylim([0 10]);
% title('I-V characteristics of GaAs');
grid on;


