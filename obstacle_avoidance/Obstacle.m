classdef Obstacle
    properties
        x1
        x2
        y1
        y2
        side=1
    end
    
    methods
        function self = Obstacle(x, y)
            self.x1 = x-self.side/2;
            self.y1 = y-self.side/2;
            self.x2 = x+self.side/2;
            self.y2 = x+self.side/2;
        end
        
        function show(self)
            x = [self.x1, self.x2, self.x2, self.x1, self.x1];
            y = [self.y1, self.y1, self.y2, self.y2, self.y1];
            plot(x, y, '-b', 'LineWidth', 3);
            hold on;
        end
    end
end