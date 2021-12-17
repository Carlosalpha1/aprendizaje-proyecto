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
    end
    
    methods
        function self=Environment()
        end

        function addRobot(self, robot)
            self.robot = robot;
        end

        function addObstacle(self, obstacle)
            self.obstacles = [self.obstacles, obstacle];
        end

        function show(self)
            plot([-4 -4],[0 20], [4 4], [0 20]); hold on;
            axis([-10 10 0 20])
            for i=1:length(self.obstacles)
                self.obstacles(i).show()
            end
            self.robot.show()
        end

    end
 end
