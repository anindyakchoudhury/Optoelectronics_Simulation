%data GaN


%For Rsp, work with GaN3
data = importdata('GaN3.txt');
lambda = data(:,1);


%for GaN3
lambda = lambda.*1e-9; %m
% lambda = lambda.*1e-6; %m


n = data(:,2);
k = data(:,3);

% physical constants
me      = 0.27*m0;
mh      = 0.8*m0;
mr      = me*mh/(me+mh);


fcv     = 23*q;
fcvf    = fcv/1000;

eps     = 10.4*eps0;

Eg      = 3.44*q;                    % 300K
nr      = mean(n);                   % GaAs index Kasap

% Eg0     = 1.5326; %eV
% A       = 8.872e-4;
% B       = 572;


