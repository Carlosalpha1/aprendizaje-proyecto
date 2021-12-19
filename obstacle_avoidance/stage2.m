% -----------------------------------------------
% -- from Obstacle Avoidance
% --    Authors:    Javier Martinez
% --                Irene Bandera
% --                Veronica Tornero
% --                Carlos Caminero
% --
% -- stage2.m
% -----------------------------------------------
clc; clear all; close all;

STEPS=200;
load dataset.mat

% -- Environment settings 
environment = Environment();
obst1 = Obstacle(-1, 5);
obst2 = Obstacle(3, 15);
obst3 = Obstacle(0, 1);
obst4 = Obstacle(2.5, 3);
obst5 = Obstacle(3.25, 8);
obst6 = Obstacle(0, 9.5);
obst7 = Obstacle(-1, 12);
obst8 = Obstacle(3, 13);
obst9 = Obstacle(0.25, 17);
obst10 = Obstacle(-2, 19);
environment.addObstacle(obst1);
environment.addObstacle(obst2);
environment.addObstacle(obst3);
environment.addObstacle(obst4);
environment.addObstacle(obst5);
environment.addObstacle(obst6);
environment.addObstacle(obst7);
environment.addObstacle(obst8);
environment.addObstacle(obst9);
environment.addObstacle(obst10);

robot = Robot(2, 1);
laser = Laser(180, 2);
environment.addRobot(robot);

% -- Training Neural Network ---------
X = data(:, 1:2)';
Y = data(:, 3)';

net = fitnet(5, 'trainlm');
net.trainParam.epochs = 10000;
net.trainParam.goal = 0
net.trainParam.max_fail = 100;
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
net = train(net, X, Y);

% -- sim2sim
for i=1:STEPS
    clf;
    laser.update(environment)
    v = laser.get_values();
    
    % -- new input data
    right_mean = mean_(v(1, 1:length(v)/2));
    left_mean = mean_(v(1, (length(v)/2+1):length(v)));
    
    % -- predict angular velocity
    az = sim(net, [left_mean; right_mean]);
    environment.robot.move(0.1, az)
    
    % -- Show results
    environment.show();
    laser.show();
    pause(0.01);
end


function m = mean_(arr)
    [~, n] = size(arr);
    m = 0;
    for i=1:n
        m = m + arr(i);
    end
    m = m/n;
end