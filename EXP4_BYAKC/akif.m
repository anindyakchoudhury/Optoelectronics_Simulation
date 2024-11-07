% Task 1: Gain Lineshape and Cavity Modes Analysis
clc;
clearvars;
close all;

% Constants and parameters
c = 3e8;
n = 1;
tau_sp = 300e-9;
lambda0 = 623.8*1e-9;
f0 = c/lambda0; %Hz
del_f = 1.5e9; %1.5GHz
del_lambda = del_f*c/f0^2;
L = 50*1e-2; %m
gamma = 0.05;
R1 = 1;
R2 = 0.9;
gth = gamma + log(1./(R1.*R2))/(2*L);

% Frequency and wavelength calculations
f = linspace(f0-5*del_f,f0+5*del_f,1000);
lambda = c./f;
x = (f-f0)/(del_f);

% Gain calculations
dn = 4e15;
g0 = dn*n*c^2/(8*pi*f0^2*tau_sp*del_f);
fprintf('g0 --> %f\n',g0);
g = g0*exp(-0.5.*x.^2);

% Plot gain lineshape
figure(1);
plot(lambda*1e9,g,'Linewidth',2);
xlabel('$\lambda$ (nm)', 'Interpreter', 'latex')
ylabel('Gain');
grid on;

% Save the plot as a PNG file
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP4_BYAKC\exp3_task1_lineshape.png');

% Plot cavity modes
figure(2);
plot(lambda*1e9,g,'Linewidth',2,'DisplayName','g');
hold on;

Nmode = 20;
m = floor(2*L/lambda0);
dlambda = 2*L*(1/m - 1/(m+1));
lambda_cavity_mode = (lambda0-Nmode*dlambda):dlambda:(lambda0+Nmode*dlambda);
f_cavity_mode = c./lambda_cavity_mode;
x_cavity_mode = (f_cavity_mode-f0)/(del_f);
g_cavity_mode = g0*exp(-0.5.*x_cavity_mode.^2);
g_line = (g_cavity_mode >= g0/2).*g_cavity_mode;
fprintf('Number of modes within LineWidth --> %d\n',sum((g_cavity_mode >= g0/2)));
stem(lambda_cavity_mode*1e9,g_line,'LineWidth',2,'DisplayName','Cavity Modes');
hold on;
plot(lambda*1e9,ones(1,length(lambda))*g0/2,'Linewidth',2,'DisplayName','g_{max}/2');
xlabel('Wavelength (nm)');
ylabel('Gain (m^{-1})');
legend;

% Save the plot as a PNG file
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP4_BYAKC\exp3_task1_cavitymodes.png');

% Task 2: Threshold Gain Analysis
figure(3);
clearvars -except c n tau_sp lambda0 f0 del_f;
gamma = 0.05;
R2 = 0.1:0.1:0.9;
R1 = ones(1,length(R2));
L = (10:10:100)*1e-2;
legendEntries = cell(1, length(L));

for i = 1:length(L)
    gth = gamma + log(1./(R1.*R2))./(2*L(i));
    plot(R2,gth,'Linewidth',2);
    hold on
    legendEntries{i} = ['L = ', num2str(L(i)), ' cm'];
end

title('Variation of g_{th} with R2 and L');
xlabel('R2');
ylabel('gth');
legend(legendEntries, 'Location', 'best');


% Save the plot as a PNG file
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP4_BYAKC\exp3_task2_variationof_g.png');

% Task 3: Lasing Modes Analysis
figure(4);
clearvars -except c n tau_sp lambda0 f0 del_f;
L = 50*1e-2; %m
gamma = 0.05;
R1 = 1;
R2 = 0.9;
gth = gamma + log(1./(R1.*R2))/(2*L);
f = linspace(f0-5*del_f,f0+5*del_f,1000);
lambda = c./f;
x = (f-f0)/(del_f);

% Case 2: N2 - N1 = 7e15 (modify dn value for Case 1)
dn = 7e15;
g0 = dn*n*c^2/(8*pi*f0^2*tau_sp*del_f);
g = g0*exp(-0.5.*x.^2);

plot(lambda*1e9,g,'Linewidth',2,'DisplayName','g');
hold on;

Nmode = 20;
m = floor(2*L/lambda0);
dlambda = 2*L*(1/m - 1/(m+1));
lambda_cavity_mode = (lambda0-Nmode*dlambda):dlambda:(lambda0+Nmode*dlambda);
f_cavity_mode = c./lambda_cavity_mode;
x_cavity_mode = (f_cavity_mode-f0)/(del_f);
g_cavity_mode = g0*exp(-0.5.*x_cavity_mode.^2);
g_line = (g_cavity_mode >= gth).*g_cavity_mode;
fprintf('Number of modes participating in Lasing --> %d\n',sum((g_cavity_mode >= gth)));

stem(lambda_cavity_mode*1e9,g_line,'LineWidth',2,'DisplayName','Lasing Modes');
hold on;
plot(lambda*1e9,ones(1,length(lambda))*gth,'Linewidth',2,'DisplayName','gth');
xlabel('Wavelength (nm)');
ylabel('Gain (m^{-1})');
title('Lasing Modes for (N_2 - N_1) = 7e15');
legend;
grid on

% Save the plot as a PNG file
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP4_BYAKC\exp3_task3_lasing.png');