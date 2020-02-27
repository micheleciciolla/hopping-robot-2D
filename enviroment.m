classdef enviroment
    % this class describes the enviroment
    properties
        % Support surface is modeled as two-dimensional spring
        % Spring stifness and damper 
        Kg = 10^4; Bg = 75;
    end
    
    methods
        function obj = enviroment(~,~)
            obj = null;
        end
        
    end
end

