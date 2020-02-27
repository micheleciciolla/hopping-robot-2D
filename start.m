%% SYSTEM PARAMS

[m1,m2] = deal(1,10); % mass
found_efficienty = m2/(m2+m1);
g = 9.8; % gravity
k0 = 1; % default leg lenght
[r1,r2] = deal(0.5, 0.4);
[KL,KG] = deal(10^3,10^4);


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
H = 0.4;
% desired energy to reach height H
desired_energy = m1*g*(H+r1) + m2*g*(H+k0+r2);

% 1,2,3,4 = [top, touchdown, bottom, lift-off]
state = 1;

for i=1:100
    
    % here you should get y0, y1, y2, y0_dot, y1_dot, y2_dot
    
    if state==2
        
        
        % contribute of first mass to total energy
        energy_stance1 = getPotential(M1,y1) + getElastic1(k0-w+x) + getKinetic(M1,y1_dot);
        
        % contribute of second mass to total energy
        energy_stance2 = getPotential(M2,y2) + getElastic2(y0) + getKinetic(M2,y2_dot);
        
    end
    
    tot_energy = found_efficienty*energy;
    
end

fprintf(2,"Process ended \n");
function pot = getPotential(mass,y)
pot = mass*g*y;
end

function kin = getKinetic(mass,vel)
kin = 0.5*mass*vel^2;
end

function elas = getElastic1(extension)
elas = 0.5*KL*(extension)^2;
end

function elas = getElastic2(y0)
% KG = 0 when y0>0
elas = 0;
if y0<=0 % (?==0)
    elas = 0.5*KG*y0^2;
end
end



