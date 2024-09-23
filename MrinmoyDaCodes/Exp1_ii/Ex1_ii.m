clc;
clear all;
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
string = "GaN";

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

% allowed transition
% nr for fixed refractive index
% n for dispersion 
alpha   = q^2*sqrt(m0)./(4*pi*hcut^2*eps*c.*n) ...
            .*(2*mr/m0)^1.5 .*(fcv./E).*sqrt((E-Eg));   
alpha = real(alpha);
P = alpha .* (c./n);
phi = 8*pi.*(E/h).^3.*n.^3./c^3   .*  (1./(exp(E/(kB*T)) - 1));



rsp = P.*phi;


figure(1);
subplot(211)
plot(lambda/1e-9,real(rsp)/100,'Linewidth', 1.5);
xlabel('\lambda (nm)');
ylabel('R_{sp} (1/cm)');
title("R_{sp}");
subtitle(sprintf(string));
grid on;

subplot(212)
plot(E/q,real(rsp)/100,'Linewidth', 1.5)
xlabel('E (eV)');
ylabel('R_{sp} (1/cm)');
subtitle(sprintf(string));
grid on;

%% Experimental comparison
% Experimental spectra from k
alpha_exp   = 4*pi*k./lambda;   

alpha_exp = real(alpha_exp);
P = alpha_exp .* (c./n);
phi = 8*pi.*(E/h).^3.*n.^3./c^3   .*  (1./(exp(E/(kB*T)) - 1));



rsp = P.*phi;


figure(2);
subplot(211);
plot(lambda/1e-9,real(rsp)/100,'Linewidth', 1.5);
xlabel('\lambda (nm)');
ylabel('R_{sp} (1/cm)');
title('alpha = 4\pi k/\lambda');
grid on;


subplot(212)
plot(E/q,real(rsp)/100,'Linewidth', 1.5)
xlabel('E (eV)');
ylabel('R_{sp} (1/cm)');
grid on;



%% Task 3
%  interp1(E,alpha,,method)

Ts = 200:10:250;
A = 0.54/1000;
B = 204;
lambda = linspace(200,1000,10000)*1e-9;
E_ = h*c./lambda;

figure(3);
for T = Ts
    
    %Eg_ = (1.519 - A*T^2/(B+T))*q;
    alpha = q^2*sqrt(m0)./(4*pi*hcut^2*eps*c.*nr) ...
            .*(2*mr/m0)^1.5 .*(fcv./E_).*sqrt((E_-Eg));
    P = alpha .* (c./nr);
    phi = 8*pi.*(E_/h).^3.*nr.^3./(c^3*exp(E_/(kB*T)) - 1);
    rsp = P.*phi;
    plot(lambda/1e-9,real(rsp)/100,'DisplayName',...
        sprintf('T = %d',T));
    hold on
end
xlabel('\lambda (nm)');
ylabel('R_{sp} (1/cm)');
title('Dispersive n');






