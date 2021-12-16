clc; clear all; close all;

environment = Environment();

obst1 = Obstacle(2, 5);
obst2 = Obstacle(-4, 7);
environment.addObstacle(obst1);
environment.addObstacle(obst2);

robot = Robot(-2, 3);
environment.addRobot(robot)

laser = Laser();
laser.update(environment)

environment.show()
laser.show()