
close all

%% --FIGURE PARAMETERS--
width = 1000;
height = 600;
sz = get( 0, 'ScreenSize');
x_figure = mean( sz( [1, 3]));
y_figure = mean( sz( [2, 4]));
figure('Position', [x_figure - width/2, y_figure - height/2, width, height]);
grid on, hold on
ylim([-1,max(y2.data)+1]);
xlim([-1,x0.data(end)+1]);


%% 
displacement_body = 0.1;
leg1 = animatedline;
leg2 = animatedline;
foot = animatedline;
hip = animatedline;
body = animatedline;

leg1.LineWidth = 5.0;
leg1.Color = '#0072BD';

leg2.LineWidth = 5.0;
leg2.Color = '#0072BD';

foot.MarkerSize = 10.0;
foot.Marker = 'v';
foot.MarkerFaceColor = '#A2142F';

hip.MarkerSize = 10.0;

% used to crate .gif
% theta = 0:0.01:50;
% y = theta.*exp(1i*theta);
% figure();
% h = animatedline(real(y(1)),imag(y(1)));
% axis equal;
% axis([-50,50,-50,50]);
% axis off

[A,map] = rgb2ind(frame2im(getframe),256);
imwrite(A,map,'experiment.gif','LoopCount',65535,'DelayTime',0.01);
% 
% for k = 2:length(theta)
%     addpoints(h,real(y(k)),imag(y(k)));
%     drawnow
%     if(mod(k,20)==0)
%         [A,map] = rgb2ind(frame2im(getframe),256);
%         imwrite(A,map,'experiment.gif','WriteMode','append','DelayTime',0.01);
%     end
% end





hip.Marker = 'o';
hip.MarkerFaceColor = '#A2142F';

body.MarkerSize = 30.0;
body.Marker = 'square';
body.MarkerFaceColor = 'blue';

ground = animatedline;
ground.Color = 'k';
ground.MarkerSize = 15.0;

des_height = animatedline;
des_height.Color = 'r';
des_height.LineStyle = '--';
des_height.MarkerSize = 2.0;


time = x0.time;

% add ground
for i = -1:1:1
    addpoints(ground,i,0);
    addpoints(des_height,i,.6);

end

title("Current Configuration"); xlabel("x - Ground"); ylabel("y - Height");
pause(0.1)
%%
for i = 1:20:size(time)
    
    clearpoints(leg1);
    clearpoints(leg2);
    clearpoints(foot);
    clearpoints(hip);
    clearpoints(body);
    

    x0_i = x0.data(i);
    % x1_i = x1.data(i);
    x1_i = x0.data(i) + r1*sin(theta1.data(i));
    x2_i = x2.data(i);
    
    y0_i = y0.data(i);
    % y1_i = y1.data(i);
    y1_i = x0.data(i) + r1*cos(theta1.data(i));
    y2_i = y2.data(i);
    
    theta1_i = theta1.data(i);
    theta2_i = theta2.data(i);
            
    % x_hip = x0_i+(w_i)*sin(theta1_i);
    x_hip = x2_i + r2*sin(theta2_i);
    % y_hip = y0_i+(w_i)*cos(theta1_i);
    y_hip = y2_i - r2*cos(theta2_i);

    
    addpoints(leg1,[x0_i, x_hip],[y0_i,y_hip]);  
    addpoints(leg2,[x_hip, x2_i],[y_hip,y2_i]);   
    addpoints(foot, x0_i, y0_i+0.01);  
    addpoints(hip, x_hip, y_hip);  
    addpoints(body, x2_i+displacement_body*sin(theta2_i), y2_i+displacement_body*cos(theta2_i));
    
    drawnow;
    
    if mod(i,3)==0
        [A,map] = rgb2ind(frame2im(getframe),256);
        imwrite(A,map,'experiment.gif','WriteMode','append','DelayTime',0.01);
    end
    
end

