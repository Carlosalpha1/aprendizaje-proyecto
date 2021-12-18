clear all; close all; clc;

NUM_OBSTACLES=5;

t = 0;
dt = 0.001;
frame = 0;
v = 3;        % 3 m/s

movil = Entity(0, 0);

obstacles = [];
for i=0:NUM_OBSTACLES
    obstacles = [obstacles Entity(-5 + 10*rand(), -5 + 10*rand())];
end

for t=0:dt:5
    
    movil.move(3, dt);
    
    movil_plot = nsidedpoly(1000, 'Center', movil.get_pos(), 'Radius', 0.5);
    
    frame = frame + 1;
    
    if frame == 15
        % -- update window
        clf;
        grid;
        axis([-10 10 -10 10]);
        hold on;
        
        % -- show environment
        plot(movil_plot, 'FaceColor', 'r');
        for i=1:length(obstacles)
            p = nsidedpoly(4, 'Center', obstacles(i).get_pos(), 'Radius', 0.5);
            plot(p, 'FaceColor', 'y');
        end
        frame = 0;
    end
    pause(dt);
end