function [] = drawRobot(foot,leg,body,theta1,w)

% draws the model given coordinates of joints and CoM
% !! doesnt take care of 'chi' value (to-do)

[ini_x0,ini_y0] = deal(foot(1),foot(2));
[ini_x1,ini_y1] = deal(leg(1),leg(2));
[ini_x2,ini_y2] = deal(body(1),body(2));


hip(1,1) = ini_x0 + w*sin(theta1);
hip(2,1) = ini_y0 + w*cos(theta1);

figure(); hold on;
% foot
plot(ini_x0,ini_y0,'Color','black',"Marker","^",'LineWidth',3);
% leg
plot(ini_x1,ini_y1,'Color','red',"Marker","x",'LineWidth',3,'Linestyle','-.');
% body
plot(ini_x2,ini_y2,'Color','blue',"Marker","square",'LineWidth',17);
% hip
plot(hip(1,1),hip(2,1),'Color','black',"Marker","o",'LineWidth',1.5);


plot([ini_x0,ini_x1,hip(1,1),ini_x2],[ini_y0,ini_y1,hip(2,1),ini_y2],'-','LineWidth',1,'Color','k');

legend("(x0,y0)foot CoM","(x1,y1)leg CoM","(x2,y2)body CoM","hip joint");
title("current configuration"); xlim([-1,1]); ylim([0,3]); xlabel("x - terrain"); ylabel("y - height");

end
