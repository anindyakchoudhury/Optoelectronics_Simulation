clc; clearvars; close all;

%% Data import
W = [100e-9 1e-2]; % films having thicknesses of  100 nm and 1 cm
data = importdata('GaAs.txt');
lambda_um = data(:,1);
n = data(:,2);
k = data(:,3);

lambda = lambda_um*1e-6;
alpha = 4*pi.*k./lambda;
R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);

%% Reflectance Calculation
subplot(311);
% Calculate for W = 100nm
thickness_index = 1;
R_sum1 = R.*(1 + ((1-R).^2.*exp(-2*alpha*W(thickness_index)))./(1-R.^2.*exp(-2*alpha*W(thickness_index))));
plot(lambda*1e6, R_sum1,'DisplayName','W = 100nm');
xlim([0.2 0.8])
hold on;

% Calculate for W = 1cm
thickness_index = 2;
R_sum2 = R.*(1 + ((1-R).^2.*exp(-2*alpha*W(thickness_index)))./(1-R.^2.*exp(-2*alpha*W(thickness_index))));
plot(lambda*1e6, R_sum2,'DisplayName','W = 1cm');
xlabel('wavelenth (um)');
ylabel('percentage');
%xlim([0.2 0.8])
title("Reflectance");
grid on;
legend();
legend box off;

%% Transmittance Calculation
subplot(312);
% Calculate for W = 100nm
thickness_index = 1;
T_sum1 = (exp(-alpha*W(thickness_index)).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*W(thickness_index)));
plot(lambda*1e6, T_sum1,'DisplayName','W = 100nm');
xlim([0.2 0.8])
hold on;

% Calculate for W = 1cm
thickness_index = 2;
T_sum2 = (exp(-alpha*W(thickness_index)).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*W(thickness_index)));
plot(lambda*1e6, T_sum2,'DisplayName','W = 1cm');
xlabel('wavelenth (um)');
ylabel('percentage');
title("Transmittance");
grid on;
legend();
legend box off;

%% Absorption Calculation
subplot(313);
% Calculate for W = 100nm
A_sum1 = 1 - R_sum1 - T_sum1;
plot(lambda*1e6, A_sum1,'DisplayName','W = 100nm');
xlim([0.2 0.8])
hold on;

% Calculate for W = 1cm
A_sum2 = 1 - R_sum2 - T_sum2;
plot(lambda*1e6, A_sum2,'DisplayName','W = 1cm');
xlabel('wavelenth (um)');
ylabel('percentage');
title("Absorption");
grid on;
legend();
legend box off;