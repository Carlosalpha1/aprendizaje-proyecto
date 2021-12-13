clc; clear all; close all;

environment = Environment();
j = 0.5;
obst = Obstacle(1, 2);

robot = Robot(-2.5, 0.5);

environment.addObstacle(obst);

environment.addRobot(robot);

for i=1:20
    environment.robot.move(0.3, 0)
    environment.show()
end
