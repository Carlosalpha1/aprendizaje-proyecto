% -----------------------------------------------
% -- from Obstacle Avoidance
% --    Authors:    Javier Martinez
% --                Irene Bandera
% --                Veronica Tornero
% --                Carlos Caminero
% --
% -- Dataset Generator
% -----------------------------------------------

clear all; close all; clc;

NSIM = 30000;  % -- simulations

laser_values = zeros([1, 180]);

data = [];

for i=1:NSIM
    % -- read laser lecture simulation
    for j=1:length(laser_values)
        laser_values(j) = (-1 + 21)*rand();
    end
    
    [lm, rm, vx, az] = velocity_from_laser(laser_values);
    data = [data; lm, rm, vx, az];
end

save('dataset.mat', 'data');

function [lm, rm, vx, az] = velocity_from_laser(values)
    factor = 0.8;
    n = length(values);
    left_mean = mean_(values(1, 1:n/2));
    right_mean = mean_(values(1, (n/2+1):n));
    
    vx = 0.3;
    az = factor / (-left_mean + right_mean);
    lm = left_mean;
    rm = right_mean;
end

function m = mean_(arr)
    [~, n] = size(arr);
    m = 0;
    c = 0;
    for i=1:n
        if arr(i) > 0
            m = m + arr(i);
            c = c + 1;
        end
    end
    m = m/c;
end