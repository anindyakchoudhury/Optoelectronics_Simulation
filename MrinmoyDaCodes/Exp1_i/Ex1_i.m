clc; clear all;
format long;
set(0,'DefaultAxesFontName', 'Latex');
set(0,'DefaultAxesFontSize', 13);


%%
% physical constants
q       = 1.6e-19;
m0      = 9.11e-31;
h       = 6.626e-34;
hcut    = h/(2*pi);
eps0    = 8.854e-12;
c       = 3e8;
kB      = 1.38e-23;

% Load data
string = "GaAs";

switch(string)
    case "GaAs"
        data_GaAs();
    case "InP"
        data_InP();
    case "Si"
        data_Si();
    case "SiO2"
        data_SiO2();
end


Eg_V    = @(T) (Eg0 - A*T^2/(B + T))*q; %Vashni's law
Ep      = 0.03 * q;     % Typical phonon energy 20-30meV


%% Task 1: n_fixed

E       = h*c./lambda;
% allowed transition
alpha   = q^2*sqrt(m0)/(4*pi*hcut^2*eps*c*nr) ...
            .*(2*mr/m0)^1.5 .*(fcv./E).*(E-Eg).^0.5;   %1/m

% forbidden transition
alphaf   = q^2*sqrt(m0)/(6*pi*hcut^2*eps*c*nr) ...
            .*(2*mr/m0)^2.5 .*(fcvf./E).*(E-Eg).^1.5;  %1/m        

figure(1)
title('GaAs');
% Direct Allowed transition
subplot(221)
% semilogy(E./q, alpha/100,'Linewidth', 2);
% xlabel ('h\nu (eV)');
plot(lambda/1e-6, alpha/100,'Linewidth', 1.5);
xlabel ('\lambda (\mum)');
ylabel('\alpha  cm^{-1}');
title('Direct Allowed transition');
subtitle(sprintf(string));
grid on;


subplot(223)
plot(E./q, alpha/100,'Linewidth', 1.5);
xlabel ('h\nu (eV)');
ylabel('\alpha cm^{-1}');
grid on;


% Direct Forbidden Transition
subplot(222)
plot(lambda/1e-6, alphaf/100,'Linewidth', 1.5);
xlabel ('\lambda (\mum)');
ylabel('\alpha_f  cm^{-1}');
title('Direct Forbidden Transition');
subtitle(sprintf(string));
grid on;
 
subplot(224)
plot(E./q, alphaf/100,'Linewidth', 1.5);
xlabel ('h\nu (eV)');
ylabel('\alpha_f cm^{-1}');
grid on;
%% Task 2: Compare 'alpha' from 'k' with 'alpha' obtained from formula (using 'n') 

E       = h*c./lambda;
% allowed transition
alpha   = q^2*sqrt(m0)./(4*pi*hcut^2*eps*c.*n) ...
            .*(2*mr/m0)^1.5 .*(fcv./E).*(E-Eg).^0.5;
        
figure(2);
yyaxis left;
plot(lambda/1e-6, alpha/100,'Linewidth', 1.5);
ylabel('\alpha  cm^{-1}');
hold on;


yyaxis right;
plot(lambda/1e-6, 4*pi*k./lambda/100,'x','Linewidth', 1);
xlabel ('\lambda (\mum)');
ylabel('\alpha  cm^{-1}');
grid on;
title(sprintf("Comparison of \\alpha for %s", string));

legend('Theoretical \alpha','Experimental \alpha = 4\pi\kappa /\lambda');
%% Task 3: Indirect bandgap
Ts      = [100, 200, 300, 400];     
E       = linspace(Eg-0.1*q,Eg+0.2*q,1000);

% Direct Allowed transition
figure(3);
for T = Ts
    EgT = Eg_V(T); %From Vashni's law
    alpha   = (E>EgT-Ep).*(E - EgT + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
            + (E>EgT+Ep).*(E - EgT - Ep).^2./(1 - exp(-Ep./(kB*T))); 

  
    plot(E/q, sqrt(alpha),'Linewidth', 2,...
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

