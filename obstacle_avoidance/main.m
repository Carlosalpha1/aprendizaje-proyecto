clc; clear all; close all;

environment = Environment();

obst1 = Obstacle(2, 5);
obst2 = Obstacle(-4, 7);
obst3 = Obstacle(-3, 2);
environment.addObstacle(obst1);
environment.addObstacle(obst2);
environment.addObstacle(obst3);

robot = Robot(0, 0);
environment.addRobot(robot)

laser = Laser(180, 2);

laser.update(environment)

for i=1:100
    clf;
    environment.robot.move(0.1, 0)
    laser.update(environment)
    environment.show()
    laser.show()
    v = laser.get_values();
    pause(0.001);
end