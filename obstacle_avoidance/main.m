clc; clear all; close all;

environment = Environment();

obst1 = Obstacle(2, 5);
obst2 = Obstacle(-4, 7);
environment.addObstacle(obst1);
environment.addObstacle(obst2);

robot = Robot(-2, 3);
environment.addRobot(robot)

laser = Laser();

for i=1:20
    clf;
    environment.robot.move(0.3, 0)
    laser.update(environment)
    environment.show()
    laser.show()
    pause(0.001);
end