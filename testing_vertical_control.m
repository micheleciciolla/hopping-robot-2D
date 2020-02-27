%% ROBOT PARAMS

% see robot_model.m

%% STATE VARIABLES

% angle of leg and angle of the body wrt normal to field
[theta1, theta2] = deal(0,0);

% coordinates of foot
[x0,y0] = deal(0,1);

% leg extension
w = 0.5; % starting at minimum value

%% VERTICAL HOPPING CONTROL

% the goal of vertical hopper is to keep robot hopping at the same heght H
% controlling total energy of the system (+/-)

% desired height
H_desired = 0.4;
% desired energy to reach height H
desired_energy = m1*g*(H_desired+r1) + m2*g*(H_desired+k0+r2);

% 1,2,3,4 = [top, touchdown, bottom, lift-off]
state = 1;

for i=1:100
    
    %% here we read values with Fabian simulink system
    foot = [x0;y0; velx0;vely0; accx0;accx0];
    hip = [x1;y1; velx1;vely1; accx1;accx1];
    body = [x2;y2; velx2;vely2; accx2;accx2];

    % when touchdown occurs
    if state==2      
        
        % energy in STANCE (7)
        E_stance = robot_model.getStanceEnergy(foot,hip,body,w,x);
        % total energy (13)
        E_tot = found_efficienty*E_stance;
        
        % how much energy i need to compensate to bouncing at H
        delta_energy = desired_energy - E_tot;
        
        % current extension of leg
        current_extension = x-w+robot_model.k0;
        % (15) linear actuator must be extended
        actuator_command = -(current_extension) + sqrt(current_extension^2 + 2*delta_energy/robot_model.Kl);
        
    end
    
    
end

fprintf(2,"Process ended \n");




