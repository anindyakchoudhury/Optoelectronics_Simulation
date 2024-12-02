clc; 
clear;
close all;

%% the transmittance and reflectivity of Si, GaN, GaAs
% Data input
flienames = [ "Si.txt","GaN.txt","GaAs.txt"];
materials = ["Si","GaN", "GaAs"];
thickness = 2e-6; % film thickness in meter

figure;
for i = 1:length(flienames)
    data = importdata(flienames{i});
    lambda_um = data(:,1);
    n = data(:,2);
    k = data(:,3);
    lambda = lambda_um*1e-6;
    alpha = 4*pi.*k./lambda;
    
    R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);
    R_sum = R.*(1 + ((1-R).^2.*exp(-2*alpha*thickness))./(1-R.^2.*exp(-2*alpha*thickness)));
    T_sum = (exp(-alpha*thickness).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*thickness));
    
    subplot(1,3,i);
    plot(lambda*1e6, T_sum,'Linewidth',1.5,'DisplayName', 'Transmittance');
    hold on;
    plot(lambda*1e6, R_sum,'Linewidth',1.5,'DisplayName','Reflectance');
    hold on;
    xlabel('\lambda \mum');
    ylabel('%');
    title(materials{i});
    xlim([0.2 0.8]); % Given wavelength range of 200 nm to 800 nm
    grid on;
    legend();
end
