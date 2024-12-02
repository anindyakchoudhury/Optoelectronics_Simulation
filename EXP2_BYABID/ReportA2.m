clc; clear; close all;

%% Plot of Transmittance vs Thickness
flienames = ["GaAs.txt","GaN.txt", "Si.txt"];
materials = ["GaAs","GaN", "Si"];

thickness = 1e-9:0.1e-11:600e-9; % Check from 1nm to 600nm
lambda_center = 550e-9; 
Max_thickness = zeros(1,length(flienames));

figure();
for i = 1:length(flienames)
    % import data
    data = importdata(flienames{i});
    lambda_nm = data(:,1);
    n = data(:,2);
    k = data(:,3);
    
    lambda = lambda_nm*1e-6; % SI unit
    alpha = 4*pi.*k./lambda;
   
    R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);
    % Calculate for a specific lamda 
    idx = find(abs(lambda - lambda_center) < 15e-9);
    R_fixed = R(idx(1));
    alpha_fixed = alpha(idx(1));
    
    T_sum = (exp(-alpha_fixed*thickness).*(1-R_fixed).^2)./(1-R_fixed.^2.*exp(-2*alpha_fixed*thickness));
    idx_t = find(T_sum >= 0.3);
    Max_thickness(i) = thickness(idx_t(end));

    figure(1);
    plot(thickness/1e-9, T_sum,'Linewidth',2,'DisplayName', materials{i});
    hold on;

    xlabel('thickness (nm)');
    ylabel('%');
    legend;
    grid on;
end
plot(thickness/1e-9, 0.3*ones(1,length(thickness)),'--','Linewidth',1,'DisplayName', "30% line");
title(sprintf("Transmittance vs Thickness at \\lambda = %.f nm", lambda_center/1e-9));

%% Print the maximum thickness for each of these materials

for i = 1:length(Max_thickness)
    fprintf('Maximum thickness for %s will be %0.2f nm\n',materials{i},Max_thickness(i)/1e-9);
end

%% Plot of transmittance for all wavelengths over the visible range at max thickness

figure(2);

for i = 1:length(Max_thickness)
    
    subplot(1,3,i);
    R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);
    T_sum = (exp(-alpha*Max_thickness(i)).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*Max_thickness(i)));
    
    plot(lambda*1e6, T_sum,'Linewidth',1.5);
    hold on;

    xlabel('\lambda \mum');
    ylabel('%');
    title(materials{i});
    subtitle(sprintf("Thickness = %.3f \\mum", Max_thickness(i)/1e-6));
    xlim([0.550 0.8]); % Visible Wavelength
    grid on;
end