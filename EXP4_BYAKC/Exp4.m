clc;
close all;
clearvars;
set(0, 'DefaultAxesFontName', 'Latex');
set(0, 'DefaultAxesFontSize', 20);

%% Constants

tau_sp=300e-9;
R1=1;R2=0.9;
gamma=0.05;
del_v=1.5e9;
L=50e-2;
d=1.5e-9;
lambda_0=623.8e-9;
n=1;
c=3e8;
delN=4e15;
v_0=c/lambda_0;
del_lambda=(c/v_0^2)*del_v;
v=linspace(v_0-5*del_v,v_0+5*del_v,1000);
lambda=c./v;

%% g(v) (problem 1)

g_v0= (delN*n*c^2)/(8*pi*tau_sp*del_v*v_0^2);
x=(v-v_0)/(del_v);
g=g_v0*exp(-0.5.*x.^2);

m=(2*L*n/lambda_0);
del_lambda_m=(2*L/m^2);
mode_lambda=lambda_0-15*del_lambda_m:del_lambda_m:lambda_0+15*del_lambda_m;
mode_v=c./mode_lambda;
mode_x=(mode_v-v_0)/del_v;
mode_g=g_v0*exp(-0.5*mode_x.^2);

figure(1);
plot(lambda*1e9,g,'Linewidth',2,'DisplayName','Gain lineshape');
hold on;
s=stem(mode_lambda*1e9,mode_g,'r','LineWidth',2,'DisplayName','Cavity Modes');
xlabel('\lambda (nm)');
ylabel('Gain (a)');
grid on;
legend;

%% gth (problem 2)

R2_1=1;R2_2=0;
gth1=gamma+(1/(2*L))*log(1/(R1*R2_1));
gth2=gamma+(1/(2*L))*log(1/(R1*R2_2));
disp(gth1);
disp(gth2);

R2_3=0.1:0.01:0.9;
gth3=gamma+(1/(2*L))*log(1./(R1*R2_3));

figure(2);
plot(R2_3,gth3,'Linewidth',2);
xlabel('R2');
ylabel('Threshold Gain');
grid on;

R2_4=0.6;
L_2=0.1:0.01:1;
gth4=gamma+(1./(2*L_2))*log(1/(R1*R2_4));

figure(3);
plot(L_2,gth4,'Linewidth',2);
xlabel('Cavity Length');
ylabel('Threshold Gain');
grid on;

%% Number of Modes (Problem 3)

delN1=linspace(1e15,1e17,1000);
modes_number=zeros(1,length(delN1));

for i=1:1:length(delN1)
    gth=gamma+(1/(2*L)*log(1/(R1*R2)));
    g_v0_1= (delN1(i)*n*c^2)/(8*pi*tau_sp*del_v*v_0^2);

    m=(2*L*n/lambda_0);
    del_lambda_m=(2*L/m^2);
    mode_lambda=lambda_0-15*del_lambda_m:del_lambda_m:lambda_0+15*del_lambda_m;
    mode_v=c./mode_lambda;
    mode_x=(mode_v-v_0)/del_v;
    mode_g_1=g_v0_1*exp(-0.5*mode_x.^2);

    modes_number(i)=sum(mode_g_1>gth);
end

figure(4);
plot(delN1,modes_number,'b','LineWidth',2);
xlabel('N_{2}-N_{1}');
ylabel('Number of modes');
grid on;