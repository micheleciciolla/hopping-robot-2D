function [] = drawRobot(foot,leg,body,hip)
% draws the model given coordinates of joints and CoM
% !! doesnt take care of 'chi' value (to-do)

[ini_x0,ini_y0] = deal(foot(1),foot(2));
[ini_x1,ini_y1] = deal(leg(1),leg(2));
[ini_x2,ini_y2] = deal(body(1),body(2));
[ini_xH,ini_yH] = deal(hip(1),hip(2));



figure(); hold on;
% foot
plot(ini_x0,ini_y0,'Color','black',"Marker","^",'LineWidth',3);
% leg
plot(ini_x1,ini_y1,'Color','red',"Marker","x",'LineWidth',3);
% body
plot(ini_x2,ini_y2,'Color','blue',"Marker","square",'LineWidth',17);
% hip
plot(ini_xH,ini_yH,'Color','black',"Marker","o",'LineWidth',1.5);

% skeleton
plot([ini_x0,ini_x1,ini_xH,ini_x2],[ini_y0,ini_y1,ini_yH,ini_y2],'-','LineWidth',1,'Color','k');


legend("(x0,y0) Foot","(x1,y1) Leg","(x2,y2) Body","Hip Joint");
title("Current Configuration"); xlim([-1,1]); ylim([0,3]); xlabel("x - Ground"); ylabel("y - Height");


end
