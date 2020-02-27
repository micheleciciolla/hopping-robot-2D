classdef robot_model
    % costant values and parameters of the robot
    
    properties
        % leg mass and body mass
        M1 = 1; M2 = 10;
        % inertia matrices
        I1 = 1; I2 = 10;
        % distance foot-center of mass leg / distance hip-center of mass
        % body
        r1 = 0.5; r2 = 0.4;
        % rest lenght of leg spring
        k0 = 1;
        % stifness of the leg spring
        Kl = 10^3;
        % spring costant and damping coefficient of mechanical stop
        Kl2 = 10^5; Bl2 = 125;
        
        % natural frequency of the spring-mass oscillator
        wn = sqrt(Kl/M2);
        
        % stance interval duration
        T_st = pi/wn;
        
        % foudamental efficiency of leg
        found_efficienty = M2/(M1+M2);
        
    end
    
    methods
        function T = getFullHoppingCycle(H)
            %% full hopping cycle duration given height
            
            T = robot_model.T_st + sqrt(8*H/9.81);
        end
        
        function max_w_compression = getMaxLegCompression(H)
            %% maximum compression of leg spring during stance
            
            max_w_compression = (M2*9.81/Kl) + sqrt( (M2^2*9.81^2/Kl^2) + 2*(M1+M2)^2*9.81*H/M2*Kl );
        end
        
        function [pot1,pot2] = getPotential(y1,y2)
            %% get potential energy of both masses
            
            pot1 = robot_model.M1*9.81*y1;
            pot2 = robot_model.M2*9.81*y2;
        end
        
        function [kin1,kin2] = getKinetic(vel1,vel2)
            %% get kinetic energy of both masses
            
            kin1 = 0.5*robot_model.M1*vel1^2;
            kin2 = 0.5*robot_model.M2*vel2^2;
        end
        
        function [elas1,elas2] = getElastic(extension1,y0)
            %% get elastic energy of both masses
            %  when foot is touching the ground M2 has no elastic energy
            
            elas1 = 0.5*robot_model.Kl*(extension1)^2;
            elas2 = 0;
            if y0<=0 % (?==0)
                elas2 = 0.5*enviroment.Kg*y0^2;
            end
        end
        
        function E_stance = getStanceEnergy(foot,hip,body,w,x)
            %% get energy during stance phase
            
            [y0]    = deal(foot(2));
            [y1,vel1] = deal(hip(2),hip(4));
            [y2,vel2] = deal(body(2),body(4));          
            
            [pot1,pot2] = getPotential(y1,y2);
            [kin1,kin2] = getKinetic(vel1,vel2);
            extension = k0 - w +x;
            [elas1,elas2] = getElastic(extension,y0);
            E_stance = pot1+pot2+kin1+kin2+elas1+elas2;
        end
        
        
    end
end

