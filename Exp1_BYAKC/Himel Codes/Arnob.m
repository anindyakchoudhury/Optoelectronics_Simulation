clc; clear all;close all;
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

%% Task 2(a)
% At 300K
data = importdata('Si_paper.txt');
E = data(:,1); %eV
Energy=E*q; % J
alpha_paper=data(:,2); %(cm-eV)^-1/2
alpha_p=alpha_paper.*sqrt(q); %(cm-J)^-1/2
T=291;

figure(6);
plot(Energy/q,alpha_p,'Linewidth', 2); %ev vs %(cm-J)^-1/2
xlabel ('E (eV)');
ylabel('\alpha^{1/2} cm^{-1}');
title(sprintf("Energy-dependent \\alpha^{1/2} for %s",string));
subtitle("Due to phonon emission/absorption");
grid on;
legend('Box','off');

string = "Si";
data_Si();
Eg_V    = @(T) (Eg0 - A*T^2/(B + T))*q; %Vashni's law
Ep      = 0.03*q;     % Typical phonon energy 20-30meV
EgT = Eg_V(T);


constant=(alpha_p.^2)./((Energy>EgT-Ep).*(Energy - EgT + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
            + (Energy>EgT+Ep).*(Energy - EgT - Ep).^2./(1 - exp(-Ep./(kB*T))));

figure(1)
plot(E, constant,'Linewidth', 2)
xlabel ('h\nu (eV)');
ylabel('k');
xlim([0.8,1.2]);
hold on 
grid on
title('Constant k VS Energy of Si');

ConstantK=3e22;

%% match data
string = "Si";
data_Si();


Eg_V    = @(T) (Eg0 - A*T^2/(B + T))*q; %Vashni's law
Ep      = 0.03 * q;     % Typical phonon energy 20-30meV


% Task 3: Indirect bandgap
Ts      = [291, 350, 415];     
EnergyL       = linspace(Eg-0.2*q,Eg+0.2*q,1000);

% Direct Allowed transition
figure(2);
for T = Ts
    EgT = Eg_V(T); %From Vashni's law
    alpha_corrected   = ConstantK*((EnergyL>EgT-Ep).*(EnergyL - EgT + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
            + (EnergyL>EgT+Ep).*(EnergyL - EgT - Ep).^2./(1 - exp(-Ep./(kB*T)))); 

%     alpha=alpha.*(1.277e41);


    plot(EnergyL/q, sqrt(alpha_corrected),'Linewidth', 2,...
        'DisplayName',sprintf('T = %d K',T));
    hold on;
end
xlabel ('E (eV)');
ylabel('\alpha^{1/2} cm^{-1}');
title(sprintf("Energy-dependent \\alpha^{1/2} for %s",string));
subtitle("Due to phonon emission/absorption");
xlim([Eg/q-0.1,Eg/q+0.2]);
grid on;
legend('Box','off');

T=291;
EgT = Eg_V(T); %From Vashni's law
    alpha_corrected   = ConstantK*((EnergyL>EgT-Ep).*(EnergyL - EgT + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
            + (EnergyL>EgT+Ep).*(EnergyL - EgT - Ep).^2./(1 - exp(-Ep./(kB*T))));

figure(3);
plot(EnergyL/q, sqrt(alpha_corrected),Energy/q,alpha_p,'Linewidth', 2);
xlabel ('E (eV)');
ylabel('\alpha^{1/2} cm^{-1}');
title(sprintf("Energy-dependent \\alpha^{1/2} for %s",string));
subtitle("Due to phonon emission/absorption");
xlim([Eg/q-0.2,Eg/q+0.1]);
grid on;
legend('Box','off');



%% Load data
string = "Si";
data_Si();


Eg_V    = @(T) (Eg0 - A*T^2/(B + T))*q; %Vashni's law
Ep      = 0.03 * q;     % Typical phonon energy 20-30meV


% Task 3: Indirect bandgap
Ts      = [291, 350, 415];     
EnergyL       = linspace(Eg-0.1*q,Eg+0.2*q,1000);

% Direct Allowed transition
figure(4);
for T = Ts
    EgT = Eg_V(T); %From Vashni's law
    alpha   = (EnergyL>EgT-Ep).*(EnergyL - EgT + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
            + (EnergyL>EgT+Ep).*(EnergyL - EgT - Ep).^2./(1 - exp(-Ep./(kB*T))); 

%     alpha=alpha.*(1.277e41);


    plot(EnergyL/q, sqrt(alpha),'Linewidth', 2,...
        'DisplayName',sprintf('T = %d K',T));
    hold on;
end
xlabel ('E (eV)');
ylabel('\alpha^{1/2} cm^{-1}');
title(sprintf("Energy-dependent \\alpha^{1/2} for %s",string));
subtitle("Due to phonon emission/absorption");
xlim([Eg/q-0.1,Eg/q+0.2]);
grid on;
legend('Box','off');