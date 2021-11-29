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
        x
        y
        side = 0.75
    end
    
    properties (Access=private)
        x1
        x2
        y1
        y2
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
        
        function show(self)
            X = [self.x1, self.x2, self.x2, self.x1, self.x1];
            Y = [self.y1, self.y1, self.y2, self.y2, self.y1];
            plot(X, Y, '-b', 'LineWidth', 2);
            hold on;
        end
    end
end