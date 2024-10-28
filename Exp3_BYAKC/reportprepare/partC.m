clc;
clearvars;
close all;

%% Choose data/Task no

Task_no = 2; % Task 1: GaAs, Task 2: GaN

switch (Task_no)
    case 1
        material = 'GaAs';
        % Mobility in cm2/Vs
        u_n = 8500;
        u_p = 400;

        % Doping concentrations in (cm-3)
        Na = 1e15;
        Nd = 5e17;

        ni = 1.79e6; % intrinsic carrier concentration (cm-3)

        A = 1*(1/10)^2;       % Cross section Area in cm2
        nf = 1.5;

        lamda0 = 860e-9; %Peak Wavelength from Exp1

    case 2
        material = 'GaN';
        % Mobility in cm2/Vs
        u_n = 1800;
        u_p = 30;

        % Doping concentrations in (cm-3)
        Na = 1e15;
        Nd = 1e18;

        ni = 1.9e-10; % intrinsic carrier concentration (cm-3)

        A = 0.5*(1/10)^2;       % Cross section Area in cm2
        nf = 1;

        lamda0 = 360e-9; %Peak Wavelength from Exp1
end
% Peak Wavelength(nm) = 1243/Bandgap(eV)

% Constants in SI unit
h = 6.626e-34;
k_B = 1.38e-23;
T = 300;
q = 1.6e-19;

deln = 1e17; % excess minority carrier concentration

%% Calculation
npo = ni^2/Na;
pno = ni^2/Nd;

% cm2/s
Dn = (k_B*T*u_n)/q;
Dp = (k_B*T*u_p)/q;
Br = 1e-10;

%tau_n means lifetime of minority electron in p-region
tau_n = 1/(Br*(Na+npo+deln));
tau_p = 1/(Br*(pno+Nd+deln));

Ln = (Dn*tau_n)^0.5;
Lp = (Dp*tau_p)^0.5;

V = linspace(0,3,10000); % Voltage (X-axis)

% Current Density (A/cm2)
Js = q*((Dn*npo/Ln)+(Dp*pno/Lp));

Is = A*Js;
I = Is*exp(((q*V)./(nf*k_B*T))-1);

%% Ploting

plot(V,I/1e-6, "LineWidth",2);
xlabel('V (V)');
ylabel('I (\muA)');
title(sprintf('I-V characteristics for %s LED',material));

ylim([0 10]);
% title('I-V characteristics of GaAs');
grid on;


% Save the plot as a PNG file
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\Exp3_BYAKC\reportprepare\partC_task2.png');