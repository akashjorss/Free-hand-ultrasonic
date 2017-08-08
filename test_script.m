
%Vector in the elevator direction
elevator_vector = [-0.0941466876951209 -0.267047192323384 0.959073614624151].';

%Rotation matrix for transformation of elevator angle to z axis
elevatorR = rodrigues([0 0 1].', elevator_vector.');

%rotate points to align with elevator plane then rotate whole system to
%align with xy
for i = 1:400      
    rotated_points(:,:,i) = original_points(:,:,i) - repmat(original_points(:,2,i),1,4);
    r1 = rotated_points(:,1,i) - rotated_points(:,2,i);
    r2 = rotated_points(:,3,i) - rotated_points(:,2,i);
    n = cross(r1,r2)/norm(cross(r1,r2));
    R = rodrigues([0 0 1],n);
    rotated_points(:,:,i) = R*rotated_points(:,:,i);
    rotated_points(:,:,i) = rotated_points(:,:,i) + repmat(original_points(:,2,i),1,4);
end
%Centering the data
for i=1:400
    meanx = mean(rotated_points(1,:,i));
    meany = mean(rotated_points(2,:,i));
    rotated_points(:,:,i) = rotated_points(:,:,i) - [repmat(meanx, [1 4]); repmat(meany, [1 4]); [0 0 0 0]];
    original_points(:,:,i) = original_points(:,:,i) - [repmat(meanx, [1 4]); repmat(meany, [1 4]); [0 0 0 0]]; 
end
% for i=1:400
%     rotated_points(:,:,i) = elevatorR*rotated_points(:,:,i);
%     original_points(:,:,i) = elevatorR*original_points(:,:,i);
% end

for i=1:400
    %focal length
    f = rotated_points(3,1,i);
    X2(:,:,i) = rotated_points(:,:,i);
    %Find Homogenous Coordinates
    for j=1:4
        X1(:,j,i) = original_points(:,j,i)*f/original_points(3,j,i);
%         X1(3,j,i) = 1;
%        X2(3,j,i) = 1;
    end

end

for i=1:400
     plot3(X1(1,:,i),X1(2,:,i),X1(3,:,i),'r' )
     hold on    
     plot3(X2(1,:,i),X2(2,:,i),X2(3,:,i),'b' )
%     plot3(rotated_points(1,:,i),rotated_points(2,:,i),rotated_points(3,:,i),'b' )
%     plot3(original_points(1,:,i),original_points(2,:,i),original_points(3,:,i),'r' )
%     pbaspect([1 1 1])
    xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis')
    hold on
end
% 
% %plot3([0 elevator_vector(1)],[0 elevator_vector(2)],[0 elevator_vector(3)],'b' )
% 
% 
% 
