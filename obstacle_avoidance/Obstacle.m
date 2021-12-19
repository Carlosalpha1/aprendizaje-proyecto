% -----------------------------------------------
% -- from Obstacle Avoidance
% --    Authors:    Javier Martinez
% --                Irene Bandera
% --                Veronica Tornero
% --                Carlos Caminero
% --
% -- class Obstacle:
% --    * Obstacle(x, y) -> Constructor
% --    * show() -> None
% -- It represents an Obstacle on Environment.
% -----------------------------------------------

classdef Obstacle < handle
    
    properties (Access=public)
        x               % -- pos x of the obstacle in the enviroment
        y               % -- pos y of the obstacle in the enviroment
        side = 0.75     % -- set the size of the obstacle
    end
    
    properties (Access=private)
        x1              % -- pos x of the lower left point of the obstacle
        x2              % -- pos x of the upper right point of the obstacle
        y1              % -- pos y of the lower left point of the obstacle
        y2              % -- pos y of the upper right point of the obstacle
    end
    
    methods
        function self = Obstacle(x, y)
            self.x = x;
            self.y = y;
            self.x1 = x-self.side/2;
            self.y1 = y-self.side/2;
            self.x2 = x+self.side/2;
            self.y2 = y+self.side/2;
        end
        
        % -- Plot obstacle in its position
        function show(self)
            X = [self.x1, self.x2, self.x2, self.x1, self.x1];
            Y = [self.y1, self.y1, self.y2, self.y2, self.y1];
            plot(X, Y, '-b', 'LineWidth', 2);
            hold on;
        end
    end
end