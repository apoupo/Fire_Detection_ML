clear; clc; close all;

load test1.mat
[fire1, noFire1] = split(images, length(images)/24);
load test2.mat
[fire2, noFire2] = split(images, 20);
load test3.mat
[fire3, noFire3] = split(images, 10);
load test4.mat
[fire4, noFire4] = split(images, 9);
load test5.mat
[fire5, noFire5] = split(images, 10);
load test6.mat
[fire6, noFire6] = split(images, 9);
% load test7.mat
% [fire7, noFire7] = split(images, length(images)/24);
load test8.mat
[fire8, noFire8] = split(images, 9);

%%
fire = cat(1, fire8, fire6, fire5, fire4, fire3, fire2, fire1);
noFire = cat(1, noFire8, noFire6, noFire5, noFire4, noFire3, noFire2, noFire1);

writematrix(fire, 'fire.csv')
writematrix(noFire, 'noFire.csv')

%%
function [fire, noFire] = split(images, splitIndex)
    noFire = images(1:splitIndex*24,:);
    fire = images(splitIndex*24+1:end,:);
end