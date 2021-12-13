% -----------------------------------------------
% -- from Obstacle Avoidance
% --    Authors:    Javier Martinez
% --                Irene Bandera
% --                Veronica Tornero
% --                Carlos Caminero
% --
% -- class Robot:
% --    * Robot(x, y) -> Constructor
% --    * showMovement(v_10, w_10) -> None
% --    * move(v, w) -> None
% --    * sayPosition() -> None
% --    * show() -> None
% -- It represents an Obstacle on Environment.
% -----------------------------------------------

classdef Robot < handle % handle para que me deje px y py en las funciones de la clase
    
    properties (Access=public)
      px
      py
      % orientation = 0;
    end
   
    methods
      function self = Robot(x, y)
          self.px = x;
          self.py = y;
      end
      
      function showMovement(self, v_10, w_10)
         trajectory = animatedline('Color',[0 .7 .7]);
         pos_robot = animatedline('Marker','o');
         axis([0 20 0 20])
         
         for i = 1:100
            x_ = self.px + (w_10 * i);
            y_ = self.py + (v_10 * i);
            
            addpoints(trajectory,x_,y_);
            
            % update screen
            drawnow limitrate
            pause(0.01)
         end 
         addpoints(pos_robot,x_,y_);
            
         % update screen
         drawnow limitrate
         pause(0.01)
         
         self.px = x_;
         self.py = y_;
      end
      
      function move(self, v, w)
         v_10 = v / 100;
         w_10 = w / 100;
         self.showMovement(v_10, w_10);
      end
      
      function sayPosition(self)
          fprintf("Hi, my position is (%d,%d)\n", self.px, self.py);
      end
      
      function show(self)
          plot(self.px, self.py, '-m', 'Marker','o','MarkerSize',15,'LineWidth', 3);
          hold on;
      end
      
    end
   
end