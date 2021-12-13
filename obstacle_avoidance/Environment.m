% -----------------------------------------------
% -- from Obstacle Avoidance
% --    Authors:    Javier Martinez
% --                Irene Bandera
% --                Veronica Tornero
% --                Carlos Caminero
% --
% -- class Environment:
% --    * Environment() -> Constructor
% --    * addObstacle(obstacle)
% --    * addRobot(robot)
% --    * show() -> None
% -- It represents the Environment with obstacles and the robot.
% -----------------------------------------------
classdef Environment < handle
    properties
        robot
        obstacles = []
        road
       

    end
    methods
        function self=Environment()
            self.road = plot([-7 -7],[0 10], [2 2], [0 10]);
            axis([-12 6 0 10]);
            hold on

        end

        function addRobot(self, robot)
            self.robot = robot;
        end

        function addObstacle(self, obstacle)
            self.obstacles = [self.obstacles, obstacle];
        end

        function show(self)
            for i=1:length(self.obstacles)
                self.obstacles(i).show()
            end

            self.robot.show()
        end

    end
 end
