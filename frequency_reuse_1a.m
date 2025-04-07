clc
clear all
close all

B=30e6;b=50e3; %B - total BW and b - channel BW
N = [1 3 4 7 9 12 19];
% N = [1 3 4 7 9 12 13 16 19 21];


area = 2000; cellArea = 2;

nChannels=B/b; % Number of channels
disp('Number of Channels');
disp(nChannels);

aCap = zeros(1, length(N));
    
for i = 1:length(N)
    
    clusterSize = N(i);
    clusterArea = cellArea * clusterSize;
   
    
    if N(i) == 1
        nClusters = 1;
    else
        nClusters = round(area/clusterArea);
    end

    capacity = nClusters*nChannels;
    aCap(i) = capacity;
    
    disp('Cluster size');
    disp(N(i)); 
    disp('Capacity');
    disp(capacity);
    disp('-----------------------------------------------');
end

stem (N, aCap, 'r', 'LineWidth', 2);
xlabel ('N'); ylabel ('Capacity'); title ('Cluster Size vs Capacity');
