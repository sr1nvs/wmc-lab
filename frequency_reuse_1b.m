clc
clear all
close all

% tBW = input("Enter total Bandwidth (MHz) : ");
tBW = 50;
tBW = tBW * 1000;
cBW = 20:20:200;
S = tBW ./ cBW;

N = [3, 4, 7, 9, 12];
area = 2000;
cellArea = 2;

figure; hold on;

for i = 1:length(N)
    clusterArea = N(i) * cellArea;
    M = area / clusterArea;    
    C = M .* S;                      
    plot(cBW, C, 'LineWidth', 2);
end

legend("N=3", "N=4", "N=7", "N=9", "N=12");
grid on;
xlabel("Channel Bandwidth (MHz)");
ylabel("Capacity");
title("Channel Bandwidth vs Capacity");
hold off;


%%

clc
clear all
close all

tBW = 1800e3;
cBW =200;

cellRadius = 100:100:1000;
totalArea = 2100;
cellArea = 2.59*cellRadius.^2;

N = [3, 4, 7, 9, 12];

figure; hold on;
for i = 1:length(N)
    clusterArea = N(i) * cellArea; 
    M = totalArea ./ clusterArea; 
    S = tBW ./ cBW;     
    C = M .* S;                      
    plot(cellRadius, C, 'LineWidth', 2);
end

legend("N=3", "N=4", "N=7", "N=9", "N=12");
grid on;
xlabel("Cell Radius");
ylabel("Capacity (MHz)");
title("Channel Bandwidth vs Cell Radius");
hold off;