close all; clearvars; clc; format long;
lineProp = {'linew',2,'lineStyle','-'};
% titleProp = {'fontSize',16,'fontname','helvetica','color','black','fontWeight','bold'};
% labelProp = {'fontSize',12,'fontname','helvetica','Color','#444444','fontWeight','bold'};

%%
% This script calculates spontaneous emission coefficient of GaAs
% assuming direct transition using absorption coefficient values from task A1

% constants
q = 1.6e-19;
h = 6.624e-34;
hcut = h/2/pi;
kB = 1.38e-23;
m0 = 9.11e-31;
eps0 = 8.854e-12;
c = 3e8;

% parameters
me = 0.077*m0;
mh = 0.64*m0;
mr = (me*mh)/(me+mh);
Eg = 1.35*q;
fcv = 23*q;
fcvf = fcv/1000;
T = 298.16;

% load data
data = readmatrix('InP_big.txt');
n = mean(data(:,2));

data_exp = readmatrix('Rsp_InP.txt');
wl_exp = data_exp(:,1);
Rsp_exp = data_exp(:,2);

% calculate alpha
% E = h*c./wl;
E = linspace(Eg-0.5*q,Eg+2*q,1000);
freq = E/h;
wl = c./freq;
C0 = q^2*m0^(1/2)/4/pi/hcut^(2)/eps0/c*(2*mr/m0)^(3/2)*fcv;
alpha = C0./n./E.*((E-Eg).^(1/2)); % unit: m^-1

P_abs = alpha.*c./n;
phi = 8*pi*freq.^3.*n.^3/c^3.*(1./(exp(E./kB./T)-1));
R_sp = P_abs.*phi;

figure(1)
yyaxis left;
plot(h*c./((wl).*q),R_sp,lineProp{:});
title("Spontaneous Emission Rate of InP");
xlabel("Photon Energy (eV)");
ylabel("R_{sp}");
xlim([0.8,2])
grid on;

hold on;
yyaxis right;
plot(h*c./((wl_exp).*q),Rsp_exp,lineProp{:});
plot(wl_exp,Rsp_exp,lineProp{:});
xlabel("E (eV)");
ylabel("R_{sp}");
xlim([0.8,2])
ylim([0,1])
grid on;
legend('Theoretical', 'Experimental');
