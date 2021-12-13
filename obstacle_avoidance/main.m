clc; clear all; close all;

environment = Environment();

obst = Obstacle(0.5, 0.5);

obst1 = Obstacle(2, 4);

environment.addObstacle(obst);
environment.addObstacle(obst1);

robot_1 = Robot(0, 5);
environment.addRobot(robot_1);

environment.show()


% robot_1.move(3,5);
% robot_1.sayPosition();
