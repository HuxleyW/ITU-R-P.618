clear
clc
Data = struct( ...
    'TOPO' , [] , ...
    'h0' , [] , ...
    'R001' , [] , ...
    'EGM' , [] ...
    );
Data.h0 = importdata('ProcessedData/h0.mat');
Data.R001 = importdata('ProcessedData/R001.mat');
Data.TOPO = importdata('ProcessedData/TOPO.dat');
Data.EGM = importdata('ProcessedData/EGM2008.mat');

% userPos : User coordinates [longitude, latitude]
% satPos : Satellite coordinates [longitude, latitude]
% f: Frequency (GHz)
% height : Orbital height (km)
% p : percentage
satPos = [10 10];
f = 30;
p = 0.99;
height = 500;
latitude = 10;
longitude = 15;
userPos = [longitude latitude];

A_Rain = calculateRainAttenuation(userPos, satPos, f, height, p, Data);
disp(A_Rain)
