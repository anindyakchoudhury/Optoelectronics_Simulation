%data GaAs

data = importdata('GaAs2.txt');
lambda = data(:,1);
lambda = lambda.*1e-6; %m
n = data(:,2);
k = data(:,3);

% physical constants
me      = 0.063*m0;
mh      = 0.5*m0;
mr      = me*mh/(me+mh);

fcv     = 23*q;
fcvf    = fcv/1000;

eps     = 12.9*eps0;

Eg      = 1.424*q;                   % 300K
nr      = mean(n);                   % GaAs index Kasap

Eg0     = 1.5326; %eV
A       = 8.872e-4;
B       = 572;


