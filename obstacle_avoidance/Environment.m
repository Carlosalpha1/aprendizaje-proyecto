
classdef Environment
    properties
        robot
        obstacles = []
        road
       

    end
    methods
        function self=Environment()
            self.road = plot([-2 -2],[0 10], [2 2], [0 10]);
            axis([-5 5 0 10]);
            hold on

        end

%         function addRobot(self, robot)
%             
%         end

        function addObstacle(self, obstacle)
            self.obstacles = [self.obstacles, obstacle];
        end

        function show(self)
            for i=1:length(self.obstacles)
                self.obstacles(i).show()
            end
        end

    end
 end
