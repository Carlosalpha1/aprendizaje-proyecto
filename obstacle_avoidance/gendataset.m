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

NSIM = 3000;  % -- simulations
FACTOR = 0.08;

% -- main ----------------------
data = [];
laser_values = zeros([1, 90]);

environment = Environment();

obst1 = Obstacle(1, 5);
obst2 = Obstacle(-3, 7);
obst3 = Obstacle(-2, 2);
environment.addObstacle(obst1);
environment.addObstacle(obst2);
environment.addObstacle(obst3);

laser = Laser(180, 2);

for i=1:NSIM
    robot = Robot(-5 + 10*rand(), 5*rand());
    environment.addRobot(robot)
    laser.update(environment)
    laser_values = laser.get_values();
    
    [lm, rm, az] = velocity_from_laser(laser_values, FACTOR);
    data = [data; lm, rm, az];
end
save('dataset.mat', 'data');

% --------------------------------


function [lm, rm, az] = velocity_from_laser(values, factor)
    n = length(values);
    lm = mean_(values(1, 1:n/2));
    rm = mean_(values(1, (n/2+1):n));
    az = factor * (-lm + rm);
end

function m = mean_(arr)
    [~, n] = size(arr);
    m = 0;
    for i=1:n
        m = m + arr(i);
    end
    m = m/n;
end