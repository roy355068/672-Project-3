%% Finished
function [DT,x,y] = DelaunayTriangulation(localMin)  

% get the size of matrix of local mininum
a = size(localMin);
rows = a(1);
cols = a(2);
% number of local minimum in the matrix
% num = sum(sum(localmin));
num = sum(localMin(:));
% column vector for x coordinates for local minimum
x=zeros(num,1);
% column vector for y coordinates for local minimum
y=zeros(num,1);

% index for x and y vector
index = 1;
for i = 1 : rows
    for j = 1 : cols
        if (localMin(i,j)==1)
            % Record the coodination of the triangles
            x(index)=i;
            y(index)=j;
            index = index+1;
        end
    end
end

DT = delaunayTriangulation(x, y);
