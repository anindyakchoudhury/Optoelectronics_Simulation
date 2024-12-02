format long;
clc; clearvars; close all;

% Importing Data
data = importdata('GaAs.txt');
lamda_all = data(:,1);
n = data(:,2);
k = data(:,3);

lamda_all = lamda_all*1e-6;
alpha = 4*pi.*k./lamda_all;
R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);

%s films having thicknesses varying from 1 nm to 0.7 μm
W = 1e-9:0.1e-7:7e-7;  

% For fixed wavelength 600nm
lamda = 600e-9;
idx = find(abs(lamda_all - lamda) < 20e-9);
R_fixed = R(idx(1));
alpha_fixed = alpha(idx(1));

% Calculation of reflectance, transmittance and absorbtion
R_w = R_fixed.*(1 + ((1-R_fixed).^2.* ...
    exp(-2*alpha_fixed*W))./(1-R_fixed.^2.*exp(-2*alpha_fixed*W)));

T_w = (exp(-alpha_fixed*W).*(1-R_fixed).^2)./(1-R_fixed.^2.*exp(-2*alpha_fixed*W));
A_w = 1-T_w-R_w;

% Ploting
figure(1);
plot(W/1e-9, R_w, 'Linewidth',2);
hold on;
plot(W/1e-9, T_w, 'Linewidth',2);
hold on;
plot(W/1e-9, A_w, 'Linewidth',2);

xlabel('Width (nm)');
ylabel("percentage");
legend('Reflectance', 'Transmittance','Absoprtion');
title("GaAs properties at light of wavelength 600 nm");
grid on;


