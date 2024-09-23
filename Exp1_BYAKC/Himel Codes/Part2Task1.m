clc;
clear;
close all;
%%
% physical constants
q       = 1.6e-19;
m0      = 9.11e-31;
h       = 6.626e-34;
hcut    = h/(2*pi);
eps0    = 8.854e-12;
c       = 3e8;
kB      = 1.38e-23;



% Load data
string = "GaAs";

switch(string)
    case "GaAs"
        data_GaAs();
    case "InP"
        data_InP();
    case "GaN"
        data_GaN();
end


Eg_V    = @(T) (Eg0 - A*T^2/(B + T))*q; %Vashni's law
Ep      = 0.03 * q;     % Typical phonon energy 20-30meV


T = 300;                %K

%% Task 1

E       = h*c./lambda;

alpha   = q^2*sqrt(m0)./(4*pi*hcut^2*eps*c.*n) ...
            .*(2*mr/m0)^1.5 .*(fcv./E).*sqrt((E-Eg));   
% alpha = real(alpha);
P = alpha .* (c./n);
phi = 8*pi.*(E/h).^3.*n.^3./c^3   .*  (1./(exp(E/(kB*T)) - 1));



rsp = P.*phi;


figure(1);
subplot(211)
plot(lambda/1e-9,real(rsp),'Linewidth', 1.5);
xlabel('\lambda (nm)');
ylabel('R_{sp}');
title("R_{sp}");
subtitle(sprintf(string));
grid on;

subplot(212)
plot(E/q,real(rsp),'Linewidth', 1.5)
xlabel('E (eV)');
ylabel('R_{sp}');
subtitle(sprintf(string));
grid on;

%% Experimental comparison

data = importdata('Rsp_GaAs.txt');
% Energy = data(:,1); % eV
lamda = data(:,1);
Rsp = data(:,2); 
Energy =h*c./lamda ;

figure(2)
yyaxis left;
plot(E/q,real(rsp)/max(real(rsp)),'Linewidth', 2)
xlabel('E (eV)');
ylabel('R_{sp}'); %m^{-1/3}s^{-1}
subtitle(sprintf(string));
grid on
hold on


yyaxis right;
plot(Energy/q, Rsp, 'Linewidth', 2);
ylabel('R_{sp}');
ylim([0,1]);
hold on
legend('Theoretical', 'Experimental');






