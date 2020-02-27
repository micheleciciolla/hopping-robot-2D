% Init file for Hopping Robot.
%
% Guy Rouleau
% Copyright 2008-2009, The MathWorks, Inc.
%
%

%% Body
body.mass = 16;         % kg
body.inertia = [0.9 0 0; 0 0.85 0; 0 0 .91];   % kg-m^2
body.ydim = 0.1;        % m
body.xdim = 0.2;        % m
body.zdim = 0.15 ;       % m


%% Leg
leg.mass = 0.5;        % kg
leg.inertia = eye(3)*0.0111;    % kg-m^2
leg.length = 0.75;
leg.hip.friction = 100;
leg.actuator.kp = 100000;
leg.actuator.c = 2000;
leg.actuator.MaxLength = 0.08;
leg.actuator.Threshold = .1;

leg.NatFreq = 3*2*pi; % Rad/sec
leg.zeta = 0.1;
leg.stiffness = leg.NatFreq^2*(leg.mass + body.mass);
leg.damping = 2* leg.zeta * leg.NatFreq * (leg.mass + body.mass);


%% Ground
ground.stiffness = 100000;  % N/m
ground.damping = 4000;        % N.m/s


%% Controller
ctrl.MaxHipTorque = 500;
ctrl.angle.Kp = 1000;
ctrl.angle.Kv = 20;
ctrl.vel.Kp = 0.04;
ctrl.vel.Ki = 0.01;
ctrl.vel.hip.Kp = 5000;





%% Trajectories
Traj.circle.radius = 5;
Traj.circle.vel =.3;
Traj.circle.T = 2*pi*Traj.circle.radius/Traj.circle.vel;
Traj.circle.omega = 2*pi/Traj.circle.T;
Traj.circle.A=Traj.circle.radius*Traj.circle.omega;
Traj.circle.starttime=Traj.circle.T/4;

Traj.square=[   0   0   0
    5   0   0
    10  .3  0
    25  .3  0
    30  0   .3
    45  0   .3
    50  -.3 0
    65  -.3 0
    70  0   -.3
    85  0   -.3
    90  0   0
    100 0   0 ];


