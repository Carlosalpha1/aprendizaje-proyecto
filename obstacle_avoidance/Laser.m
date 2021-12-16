% -----------------------------------------------
% -- from Obstacle Avoidance
% --    Authors:    Javier Martinez
% --                Irene Bandera
% --                Veronica Tornero
% --                Carlos Caminero
% --
% -- class Laser:
% --    * Laser(environment) -> Constructor
% --    * update() -> None
% --    * show() -> None
% --
% -- Offers laser distances in laser attribute 
% -- and plots them (now only from [0,0])
% -----------------------------------------------

classdef Laser < handle
    properties (Access=public)
        laser = zeros([1 180]);
    end
    
    properties (Access=private)
        x0
        y0
        max_angle = 180
        increment = 4
        laser_length = 5;
        infinity = 6; % must be larger than laser_lenght
    end
    
    methods (Access=public)
        function self = Laser()
        end
        
        % -- Update laser values
        function update(self, environment)
            syms x;
            obstacles = environment.obstacles;
            self.x0 = environment.robot.px;
            self.y0 = environment.robot.py;
            
            index_beam = 1;
            self.init_laser_values();
            for angle = 1:self.increment:self.max_angle
                rad = deg2rad(angle);
                ybeam = tan(rad)*(x-self.x0)+self.y0;   % -- y = mx + n
                
                % -- check if beam intersects with the obstacles
                for i = 1:length(obstacles)
                    [xo_in, yo_in] = self.obs_intersect(ybeam, rad, obstacles(i));
                    dist = self.distance(self.x0,self.y0,xo_in,yo_in);
                    if dist < self.laser(index_beam) && dist ~= 0
                        self.laser(index_beam) = dist;
                    end
                end
                index_beam = index_beam+1;
            end
        end
        
        
        % -- Plot laser values
        function show(self)
            index_beam = 1;
            for angle = 1:self.increment:self.max_angle
                rad = deg2rad(angle);
                length = self.laser(index_beam);
                if length == self.infinity
                    length = self.laser_length;
                end
                x = self.x0:0.001:length*cos(rad)+self.x0;
                if rad > deg2rad(90)
                    x = -length*cos(deg2rad(180)-rad)+self.x0:0.001:self.x0;
                end
                y = tan(rad)*(x-self.x0)+self.y0;
                plot(x,y);
                hold on;
                index_beam = index_beam+1;
            end
        end
    end
    
    methods (Access=private)
        % Init laser values to infinity
        function init_laser_values(self)
            num_values = self.max_angle/self.increment;
            for i = 1:num_values
                self.laser(i) = self.infinity;
            end
        end
        
        % Return axis x values for given angle from x = 0
        function xinterval = calc_xinterval(self, rad)
            xinterval = [self.x0 self.laser_length*cos(rad)+self.x0];
            if rad > 1.57
                xinterval = [-self.laser_length*cos(deg2rad(180)-rad)+self.x0 self.x0];
            end
        end
        
        % Return distance between two points 
        function d = distance(self, x1, y1, x2, y2)
            d = sqrt((x2-x1)^2+(y2-y1)^2);
        end
        
        % Return the intersection point with the given obstacle
        % Otherwise return [0,0]
        function [xo_in, yo_in] = obs_intersect(self, ybeam, rad, obstacle)
            syms x;
            mside = obstacle.side/2;
            xi_obs = obstacle.x-mside;
            xf_obs = obstacle.x+mside;
            xinterval = self.calc_xinterval(rad);
            
            if rad < 1.57
                [xp,yp] = self.intersect_y(rad, xi_obs, obstacle);
            else
                [xp,yp] = self.intersect_y(rad, xf_obs, obstacle);
            end
            if xp == self.x0 && yp == self.y0
                [xp,yp] = self.intersect_x(rad, obstacle);
            end
            xo_in = xp;
            yo_in = yp;
        end
        
        % Return intersection point with axix Y of obstacle
        % Otherwise return [x0,y0]
        function [xp,yp] = intersect_y(self, rad, xo, obstacle)
            syms x;
            mside = obstacle.side/2;
            yi_obs = obstacle.y-mside;
            yf_obs = obstacle.y+mside;
            xp = self.x0;
            yp = self.y0;
            
            %ys = subs(ybeam, x, xo);
            ys = tan(rad)*(xo-self.x0)+self.y0;
            xs = xo;
            if (ys >= yi_obs && ys <= yf_obs)
                xp = xs;
                yp = ys;
            end
        end
        
        % Return intersection point with axix X of obstacle
        % Otherwise return [x0,y0]
        function [xp,yp] = intersect_x(self, rad, obstacle)
            syms x;
            mside = obstacle.side/2;
            xi_obs = obstacle.x-mside;
            yi_obs = obstacle.y-mside;
            xf_obs = obstacle.x+mside;
            xp = self.x0;
            yp = self.y0;
            
            xs = (yi_obs + tan(rad).*self.x0 - self.y0)/tan(rad);
            ys=yi_obs;
            if (xs >= xi_obs && xs <= xf_obs)
                xp = xs;
                yp = ys;
            end
        end
    end
end