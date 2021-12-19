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
% -- It represents a Robot on Environment.
% -----------------------------------------------

classdef Robot < handle % handle para que me deje px y py en las funciones de la clase
    
    properties (Access=public)
      px                 % -- pos x of the robot in the enviroment
      py                 % -- pos y of the robot in the enviroment
    end
   
    methods
      function self = Robot(x, y)
          self.px = x;
          self.py = y;
      end
      
      % -- Change the position of the robot
      function move(self, v, w)
         self.px = self.px + w;
         self.py = self.py + v; 
      end
      
      % -- Print position of the robot
      function sayPosition(self)
          fprintf("Hi, my position is (%d,%d)\n", self.px, self.py);
      end
      
      % -- Plot robot in its position
      function show(self)
          plot(self.px, self.py, '-m', 'Marker','o','MarkerSize',15,'LineWidth', 3);
          hold on;
      end
      
    end
   
end