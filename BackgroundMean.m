%% Finished
function bgMean = BackgroundMean( centerX,centerY,DT,X,Y,im )

    minEUD = Inf;
    numtri=size(DT);
    tempSum=0;

    for i =1:numtri(2)
        col=DT(:,i);
        EUDsum = 0;
        for j=1:3
            position = col(j);
            xcoor = X(position);
            ycoor = Y(position);
            EUDsum = EUDsum+(centerX-xcoor)^2+(centerY-ycoor)^2;
        end
        if EUDsum < minEUD
           minEUD=EUDsum;
           best=DT(:,i);
        end
    end

    
    for j=1:3
        position=best(j);
        xcoor=X(position);
        ycoor=Y(position);
        tempSum=tempSum+im(xcoor,ycoor);
    end
    bgMean = tempSum/3;

end