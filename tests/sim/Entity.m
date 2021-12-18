classdef Entity < handle
    properties (Access=public)
        x
        y
    end
    
    properties (Access=private)
        x0 = 0;
    end
    
    methods
        function self = Entity(x, y)
            self.x = x;
            self.y = y;
        end
        
        function move(self, vel_x, dt)
            x0 = self.x;
            self.x = vel_x*dt + x0; % Euler Method
        end
            
        
        function pos = get_pos(self)
            pos = [];
            pos(1, 1) = self.x;
            pos(1, 2) = self.y;
        end
    end
end