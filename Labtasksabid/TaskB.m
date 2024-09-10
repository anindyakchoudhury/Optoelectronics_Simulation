clc; 
clear;
close all;
format long;
set(0,'DefaultAxesFontName', 'Latex');
set(0,'DefaultAxesFontSize', 13);

%% Loading data
data = importdata('GaAs2.txt');
lambda = data(:,1);
lambda = lambda.*1e-6; %m
n = data(:,2);
k = data(:,3);
m0=9.11e-31;
q=1.6e-19;
eps0=8.854e-12;


%% physical constants
me      = 0.063*m0;
mh      = 0.5*m0;
mr      = me*mh/(me+mh);
h=6.624e-34;
hcut=h/(2*pi);
c=3e8;
Eg=1.42*q;
fcv     = 23*q;
fcvf    = fcv/1000;
kB      = 1.38e-23;
eps     = 12.9*eps0;
T = 300; 

%% Numerically calculate the total spontaneous emission rate
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
title("total spontaneous emission rate of GaAs R_{sp}");
grid on;

subplot(212)
plot(E/q,real(rsp)/100,'Linewidth', 1.5)
xlabel('E (eV)');
ylabel('R_{sp} (1/cm)');
grid on;


% %% Experimental comparison
% % Experimental spectra from k
% alpha_exp   = 4*pi*k./lambda;   
% 
% alpha_exp = real(alpha_exp);
% P = alpha_exp .* (c./n);
% phi = 8*pi.*(E/h).^3.*n.^3./c^3   .*  (1./(exp(E/(kB*T)) - 1));
% 
% 
% 
% rsp = P.*phi;
% 
% 
% figure(2);
% subplot(211);
% plot(lambda/1e-9,real(rsp)/100,'Linewidth', 1.5);
% xlabel('\lambda (nm)');
% ylabel('R_{sp} (1/cm)');
% title('alpha = 4\pi k/\lambda');
% grid on;
% 
% 
% subplot(212)
% plot(E/q,real(rsp)/100,'Linewidth', 1.5)
% xlabel('E (eV)');
% ylabel('R_{sp} (1/cm)');
% grid on;
% 
% 
% 
% %% Rsp for different Temperature
% %  interp1(E,alpha,,method)
% 
% nr      = mean(n);   
% Ts = 200:10:250;
% A = 0.54/1000;
% B = 204;
% lambda = linspace(200,1000,10000)*1e-9;
% E_ = h*c./lambda;
% 
% figure(3);
% for T = Ts
%     
%     Eg_ = (1.519 - A*T^2/(B+T))*q;
%     alpha = q^2*sqrt(m0)./(4*pi*hcut^2*eps*c.*nr) ...
%             .*(2*mr/m0)^1.5 .*(fcv./E_).*sqrt((E_-Eg_));
%     P = alpha .* (c./nr);
%     phi = 8*pi.*(E_/h).^3.*nr.^3./(c^3*exp(E_/(kB*T)) - 1);
%     rsp = P.*phi;
%     plot(lambda/1e-9,real(rsp)/100,'DisplayName',...
%         sprintf('T = %d',T));
%     hold on
% end
% xlabel('\lambda (nm)');
% ylabel('R_{sp} (1/cm)');
% title('Dispersive n');



