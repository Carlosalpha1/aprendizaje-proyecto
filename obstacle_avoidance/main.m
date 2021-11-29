clc; clear all; close all;

environment = Environment();

obst = Obstacle(0.5, 0.5);

obst1 = Obstacle(2, 4);

environment.addObstacle(obst);
environment.addObstacle(obst1);


environment.show()
