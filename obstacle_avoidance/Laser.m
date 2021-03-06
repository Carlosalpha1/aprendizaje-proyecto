% -----------------------------------------------
% -- from Obstacle Avoidance
% --    Authors:    Javier Martinez
% --                Irene Bandera
% --                Veronica Tornero
% --                Carlos Caminero
% --
% -- class Laser:
% --    * Laser(max_angle, increment) -> Constructor
% --    * update(environment) -> None
% --    * show() -> None
% --
% -- Offer array of distances. Customizable from 1 to 180.
% -----------------------------------------------

classdef Laser < handle    
    properties (Access=private)
        laser;             % -- array of distances
        
        x0                 % -- pos x of laser in world
        y0                 % -- pos y of laser in world
        max_angle          % -- max angle of laser
        increment          % -- increment of angle beams
        laser_length = 5;  % -- max laser length
        infinity = 5.1;    % -- must be larger than laser_lenght
    end
    
    methods (Access=public)
        function self = Laser(max_angle, increment)
            self.max_angle = max_angle;
            self.increment = increment;
            self.laser = zeros([1 self.max_angle/self.increment]);
            self.init_laser_values();
        end
        
        % -- Update laser values
        function update(self, environment)
            obstacles = environment.obstacles;
            self.x0 = environment.robot.px;
            self.y0 = environment.robot.py;
            
            index_beam = 1;
            self.init_laser_values();
            for angle = 1:self.increment:self.max_angle
                rad = deg2rad(angle);            
                % -- check if beam intersects with the obstacles
                for i = 1:length(obstacles)
                    [xo_in, yo_in] = self.obs_intersect(rad, obstacles(i));
                    dist = self.distance(self.x0,self.y0,xo_in,yo_in);
                    if dist < self.laser(index_beam) && dist ~= 0
                        self.laser(index_beam) = dist;
                    end
                end
                index_beam = index_beam+1;
            end
        end
        
        % -- Return array of distances
        function v = get_values(self)
            v = self.laser;
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
                x = self.calc_xinterval(rad, length);
                y = tan(rad)*(x-self.x0)+self.y0;
                plot(x,y);
                hold on;
                index_beam = index_beam+1;
            end
        end
    end
    
    methods (Access=private)
        % -- Init laser values to infinity
        function init_laser_values(self)
            num_values = self.max_angle/self.increment;
            for i = 1:num_values
                self.laser(i) = self.infinity;
            end
        end
        
        % -- Return axis x values [x0, laser_length] or [-laser_length, x0] 
        % -- for given angle
        function xinterval = calc_xinterval(self, rad, length)
            xinterval = [self.x0 length*cos(rad)+self.x0];
            if rad > 1.57
                xinterval = [-length*cos(deg2rad(180)-rad)+self.x0 self.x0];
            end
        end
        
        % -- Return distance between two points 
        function d = distance(~, x1, y1, x2, y2)
            d = sqrt((x2-x1)^2+(y2-y1)^2);
        end
        
        % -- Return the intersection point with the given obstacle
        % -- Otherwise return [x0,y0]
        function [xo_in, yo_in] = obs_intersect(self, rad, obstacle)
            mside = obstacle.side/2;
            xi_obs = obstacle.x-mside;
            xf_obs = obstacle.x+mside;
            % -- xinterval = self.calc_xinterval(rad)
            
            if rad < 1.57
                [xp,yp] = self.intersect_y(rad, xi_obs, obstacle);
            elseif rad >= 1.57
                [xp,yp] = self.intersect_y(rad, xf_obs, obstacle);
            end
            if xp == self.x0 && yp == self.y0
                [xp,yp] = self.intersect_x(rad, obstacle);
            end
            xo_in = xp;
            yo_in = yp;
        end
        
        % -- Return intersection point with axix Y of obstacle
        % -- Otherwise return [x0,y0]
        function [xp,yp] = intersect_y(self, rad, xo, obstacle)
            mside = obstacle.side/2;
            yi_obs = obstacle.y-mside;
            yf_obs = obstacle.y+mside;
            xp = self.x0;
            yp = self.y0;
            
            ys = tan(rad)*(xo-self.x0)+self.y0;
            xs = xo;
            if (ys >= yi_obs && ys <= yf_obs)
                if (rad < 1.57 && xs >= self.x0) || (rad >= 1.57 && xs <= self.x0)
                    xp = xs;
                    yp = ys;
                end
            end
        end
        
        % -- Return intersection point with axix X of obstacle
        % -- Otherwise return [x0,y0]
        function [xp,yp] = intersect_x(self, rad, obstacle)
            mside = obstacle.side/2;
            xi_obs = obstacle.x-mside;
            yi_obs = obstacle.y-mside;
            xf_obs = obstacle.x+mside;
            xp = self.x0;
            yp = self.y0;
            
            xs = (yi_obs + tan(rad).*self.x0 - self.y0)/tan(rad);
            ys=yi_obs;
            
            if (xs >= xi_obs && xs <= xf_obs)
                if (ys > self.y0)
                    xp = xs;
                    yp = ys;
                end
            end
        end
    end
end