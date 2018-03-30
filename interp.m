function [ number,centerX, centerY ] = interp( localMax, I, noiseMean )
    %vector to store the x and y coordinate of the center 
    centerX = [];
    centerY = [];

    tmp = size(localMax);
    rol = tmp(1);
    col = tmp(2);
    X=[];
    Y=[];

    % Append the local max points into X and Y vectors for further usage
    num = 0;
    for i = 1 : rol
        for j = 1 : col
            if (localMax(i,j) == 1) 
                X = [X j];
                Y = [Y i];
                num = num+1;
            end
        end
    end
    
    % Number of local maxs
    number = num;
    
    for k = 1 : num
        % Create
        [XI, YI] = meshgrid(X(k)-0.4:0.2:X(k)+0.4, Y(k)-0.4:0.2:Y(k)+0.4);
        XX = [X(k)-1,X(k),X(k)+1];
        YY = [Y(k)-1,Y(k),Y(k)+1];
        ZZ=zeros(3);
        
        for i = -1:1:1
            for j = -1:1:1
                ZZ(i+2,j+2) = I(Y(k)+i, X(k)+j) - noiseMean;
            end
        end
        zi = interp2(XX,YY,ZZ,XI,YI,'cubic');
        % Up-sampling and fit the image
        result = gaussianfit(1:5,1:5,zi);
        
        % The result format is [amp, b, x0, y0]
        x0 = (X(k)-0.4+(result(3)-1)*0.2); % the absolute x-coordinate of the center
        y0 = (Y(k)-0.4+(result(4)-1)*0.2); % the absolute y-coordinate of teh center
        centerX = [centerX x0];
        centerY = [centerY y0];
    end
end