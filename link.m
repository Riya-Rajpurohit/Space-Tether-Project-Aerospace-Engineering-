classdef link
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        num %number that corresponds to the particular link
        R_cm %R_cm = rcb for the particular link 
        length  % dl
        width % dw
        poly %polyshape object
        Y % Y coordinates of the projection in the wind coordinates
        Z % 
        X
        wind 
        wind_x 
    end
    
    methods
        function obj = link(num,length, width, Y, Z, R, X)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.num = num;
            obj.length = length;
            obj.width = width;
            obj.Y = Y;
            obj.Z = Z;
            obj.X = X;
            obj.R_cm = R;
            obj.poly = polyshape(obj.Y, obj.Z);
            obj.wind = [];
            obj.wind_x = 0;
           
        end
        
        function obj = set_Y(obj, y_lst)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.Y = y_lst;
        end
        function obj = set_Z(obj, z_lst)
            obj.Z = z_lst;
        end
        function obj = set_wind(obj, wind_coord)
            obj.wind = wind_coord;
            obj.wind_x = wind_coord(1);
        end
        function print(obj)
            disp(obj.num);
        end
    end
end

