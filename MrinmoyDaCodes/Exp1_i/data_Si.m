%data Si

data = importdata('Si.txt');
lambda = data(:,1);
lambda = lambda.*1e-6; %m
n = data(:,2);
k = data(:,3);

% physical constants
eps     = 11.9*eps0;
me      = 0.98*m0;
mh      = 0.16*m0;
mr      = me*mh/(me+mh);
fcv     = 23*q;
fcvf    = fcv/1000;


Eg      = 1.12*q;
nr      = mean(n);                   % Si index Kasap

Eg0     = 1.17; %eV
A       = 7.021e-4;
B       = 1108;

