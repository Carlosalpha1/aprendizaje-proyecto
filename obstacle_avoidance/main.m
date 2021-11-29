clc; clear all; close all;

environment = Environment();

obst = Obstacle(0.5, 0.5);

environment.addObstacle(obst);

environment.show()
