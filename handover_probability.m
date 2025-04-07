clc
clear all
close all

cellRadius = 0.5;
holdingTime = 1/20;
speed = 5:5:50;

u = 1/holdingTime;
n = (2.*speed)/(pi*cellRadius);

handoffProb = n./(n+u);

figure(1);
plot(speed, handoffProb, 'LineWidth', 2);
title ('Speed vs Handoff Probability'); xlabel ('Speed (km/h)'); ylabel('Handoff Probability');

speed = 60;
holdingTime = 1/20;
cellRadius = 0.1:0.1:1;

u = 1/holdingTime;
n = (2*speed)./(pi.*cellRadius);

handoffProb = n./(n+u);

figure(2);
plot(cellRadius, handoffProb, 'LineWidth', 2);
title ('Cell Radius vs Handoff Probability'); xlabel ('Cell Radius (km)'); ylabel('Handoff Probability');