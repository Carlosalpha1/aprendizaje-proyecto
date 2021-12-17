clc; clear all; close all;
load dataset.mat

environment = Environment();

obst1 = Obstacle(1, 5);
obst2 = Obstacle(-3, 7);
obst3 = Obstacle(-2, 2);
environment.addObstacle(obst1);
environment.addObstacle(obst2);
environment.addObstacle(obst3);

robot = Robot(0, 0);
environment.addRobot(robot)

laser = Laser(180, 2);

% -- Train Neural Network ---------
X = data(:, 1:2)'
Y = data(:, 3)'

net = fitnet(1, 'trainlm');
net.trainParam.epochs = 10000;
net.trainParam.goal = 0.000000000000001
net.trainParam.max_fail = 100;
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
net = train(net, X, Y);
% ----------------------------------

for i=1:100
    clf;
    laser.update(environment)
    v = laser.get_values();
    left_mean = mean_(v(1, 1:length(v)/2));
    right_mean = mean_(v(1, (length(v)/2+1):length(v)));
    az = sim(net, [left_mean; right_mean]);
    % fprintf("az: %f\n", az);
    environment.robot.move(0.1, az)
    environment.show();
    laser.show();
    pause(0.01);
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