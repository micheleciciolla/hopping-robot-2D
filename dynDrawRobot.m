function [] = dynDrawRobot(state,time)

r1=0.5; % [m]
r2=0.4; % [m]

%% getting coordinates at time t
[x0,y0] = deal(state.x(time),state.y(time));
w = state.w(time); 
[theta1,theta2] = deal(state.theta1(time),state.theta2(time));

%% obtaining non-state coordinates
W = w-r1;
[x1,y1] = deal(x0 + r1*cos(pi/2 - theta1), y0+r1*sin(pi/2 - theta1));
[xH,yH] = deal(x1 + W*cos(pi/2 - theta1),y1 + W*sin(pi/2 - theta1));
[x2,y2]= deal(xH + r2*cos(pi/2 - theta2), yH + r2*sin(pi/2 - theta2));

%% plotting 

% foot
plot(x0,y0,'Color','black',"Marker","^",'LineWidth',3);
% leg
plot(x1,y1,'Color','red',"Marker","x",'LineWidth',3);
% body
plot(x2,y2,'Color','blue',"Marker","square",'LineWidth',17);
% hip
plot(xH,yH,'Color','black',"Marker","o",'LineWidth',1.5);

% % skeleton
% plot(time,[y0,y1,yH,y2],'-k','LineWidth',1,'Color','k');


% legend("(x0,y0) Foot","(x1,y1) Leg","(x2,y2) Body","Hip Joint");
% title("Current Configuration"); xlim([-1,1]); ylim([0,3]); xlabel("x - Ground"); ylabel("y - Height");


end
