clc;
clearvars;
close all;

%For Rsp, work with GaN3
data = importdata('GaN3.txt');
lambda = data(:,1);


%for GaN3
lambda = lambda.*1e-9; %m
% lambda = lambda.*1e-6; %m


n = data(:,2);
k = data(:,3);

% physical constants
q       = 1.6e-19;
m0      = 9.11e-31;
h       = 6.626e-34;
hcut    = h/(2*pi);
eps0    = 8.854e-12;
c       = 3e8;
kB      = 1.38e-23;
me      = 0.27*m0;
mh      = 0.8*m0;
mr      = me*mh/(me+mh);


fcv     = 23*q;
fcvf    = fcv/1000;

eps     = 10.4*eps0;

Eg      = 3.44*q;                    % 300K
nr      = mean(n);                   % GaAs index Kasap

% physical constants

nr      = mean(n);


Eg_V    = @(T) (Eg0 - A*T^2/(B + T))*q; %Vashni's law
Ep      = 0.03 * q;     % Typical phonon energy 20-30meV

T = 300;

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

data = importdata('Rsp_GaN.txt');
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
plot(Energy/q, smooth(Rsp), 'Linewidth', 2);
ylabel('R_{sp}');
ylim([0,1]);
xlim([1 6])
hold on
legend('Theoretical', 'Experimental');
title('Spontaneous Emission Rate of GaN')
