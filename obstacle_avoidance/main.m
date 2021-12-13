clc; clear all; close all;

environment = Environment();

obst = Obstacle(1, 2);

robot = Robot(-2, 0.5);

environment.addObstacle(obst);

environment.addRobot(robot);

environment.show()
