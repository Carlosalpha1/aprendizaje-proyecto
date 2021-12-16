clc; clear all; close all;

environment = Environment();

obst1 = Obstacle(2, 5);
obst2 = Obstacle(-2, 7);
environment.addObstacle(obst1);
environment.addObstacle(obst2);

robot = Robot(0, 1);
environment.addRobot(robot)

laser = Laser();
laser.update(environment)

environment.show()
laser.show()