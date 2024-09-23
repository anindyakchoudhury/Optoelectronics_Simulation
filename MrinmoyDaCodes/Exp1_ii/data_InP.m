%data InP

data = importdata('InP_big.txt');
lambda = data(:,1);
lambda = lambda.*1e-6; %m
n = data(:,2);
k = data(:,3);

% physical constants
eps     = 12.6*eps0;
me      = 0.077*m0;
mh      = 0.64*m0;
mr      = me*mh/(me+mh);
fcv     = 23*q;
fcvf    = fcv/1000;


Eg      = 1.35*q;
nr      = mean(n);                   % InP index Kasap

Eg0     = 1.42; %eV
A       = 4.9e-4;
B       = 327;

