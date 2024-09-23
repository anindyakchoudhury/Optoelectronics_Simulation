clc; 
clear;
close all;

format long;
set(0,'DefaultAxesFontName', 'Latex');
set(0,'DefaultAxesFontSize', 13);


% physical constants
q       = 1.6e-19;
m0      = 9.11e-31;
h       = 6.626e-34;
hcut    = h/(2*pi);
eps0    = 8.854e-12;
c       = 3e8;
kB      = 1.38e-23;

%% Task 2(a): Plot using data extracted from paper

data = importdata('Si_paper.txt');
E = data(:,1); % eV
sqrt_alpha_hu_eV = data(:,2); % cm^-1/2 eV^1/2
sqrt_alpha_hu_J=sqrt_alpha_hu_eV.*sqrt(q);  % cm^-1/2 J^1/2
figure(1)
plot(E,sqrt_alpha_hu_J,'Linewidth', 2)
xlabel ('h\nu (eV)');
ylabel('\surd\alpha h\nu (paper)  cm^{-1/2}J^{1/2}');
title(sprintf("Energy-dependent \\alpha^{1/2} %s",string));
subtitle("Due to phonon emission/absorption");
grid on
hold on

%% Finding Proportionality Constant of Indirect Tansistion in Si
 
Energy=E.*q; % J

% Finding Bandgap at 291K using Vrashni's Equation
string = "Si";
data_Si();
T=291;
Eg_V    = @(T) (Eg0 - A*T^2/(B + T))*q; % Vashni's law, unit in J
Ep      = 0.03*q;     % Typical phonon energy 20-30meV, unit in J
EgT = Eg_V(T); % unit in J

constant=(sqrt_alpha_hu_J.^2)./((Energy>EgT-Ep).*(Energy - EgT + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
            + (Energy>EgT+Ep).*(Energy - EgT - Ep).^2./(1 - exp(-Ep./(kB*T))));  %(cm-J)^-1

figure(2)
plot(E, constant,'Linewidth', 2) 
xlabel ('h\nu (eV)');
ylabel('proportionality constant');
grid on
title('Proportionality Constant VS Energy');

%% 
% Comparison at 291K between the experimental plot from paper and from 
% equation using proportionality constant

constant_final=2.7e22;
alpha_corrected   = constant_final.*((Energy>EgT-Ep).*(Energy - EgT + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
                  + (Energy>EgT+Ep).*(Energy - EgT - Ep).^2./(1 - exp(-Ep./(kB*T)))); %cm^-1 J

figure(3);
plot(E, sqrt(alpha_corrected),E ,sqrt_alpha_hu_J,'Linewidth', 2);
xlabel ('E (eV)');
ylabel('\alpha^{1/2} cm^{-1/2}J^{1/2}');
title(sprintf("Energy-dependent \\alpha^{1/2} %s",string));
subtitle("Due to phonon emission/absorption");
grid on;
legend('Using Proportionality Constant','From Paper');


%% Task 2(c)

Ts      = [291, 350, 415];     
E = linspace(Eg-0.1*q,Eg+0.2*q,1000);
figure(4);

for T = Ts
    EgT = Eg_V(T); %From Vashni's law
    alpha_corrected   = constant_final*((E>EgT-Ep).*(E - EgT + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
            + (E>EgT+Ep).*(E - EgT - Ep).^2./(1 - exp(-Ep./(kB*T)))); 

    plot(E/q, sqrt(alpha_corrected),'Linewidth', 2,...
        'DisplayName',sprintf('T = %d K',T));
    hold on;
end

xlabel ('E (eV)');
ylabel('\alpha^{1/2} cm^{-1/2}J^{1/2}');
title(sprintf("Energy-dependent \\alpha^{1/2} %s",string));
subtitle("Due to phonon emission/absorption");
grid on;
legend('Box','off');

%% Task 2(b)

Ts      = [291, 350, 415];     
E = linspace(Eg-0.1*q,Eg+0.2*q,1000);
figure(5);

for T = Ts
        alpha_corrected   = constant_final*((E>Eg-Ep).*(E - Eg + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
            + (E>Eg+Ep).*(E - Eg - Ep).^2./(1 - exp(-Ep./(kB*T)))); 

    plot(E/q, sqrt(alpha_corrected),'Linewidth', 2,...
        'DisplayName',sprintf('T = %d K',T));
    hold on;
end

xlabel ('E (eV)');
ylabel('\alpha^{1/2} cm^{-1/2}J^{1/2}');
title(sprintf("Energy-dependent \\alpha^{1/2} %s",string));
subtitle("Due to phonon emission/absorption");
grid on;
legend('Box','off');








