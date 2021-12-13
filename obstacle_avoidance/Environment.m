
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
%                 hold on
            end
            self.robot.show()
        end

    end
 end
