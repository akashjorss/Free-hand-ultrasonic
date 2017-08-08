function[H] = homography(points,i)
%points is 3*4 matrix

%project points on a surface parallel to xy plane
rotated_points = rotate(points);

% plot3(points(1,:),points(2,:),points(3,:),'g' )
% hold on
% plot3(rotated_points(1,:),rotated_points(2,:),rotated_points(3,:),'r' )
% xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');
% hold on

%Calculating normal vector to the plane
% r1 = points(:,2) - points(:,1);
% r2 = points(:,3) - points(:,1);
% n = cross(r2,r1);


%Vector in the elevator direction
normal_vector = [-0.0941466876951209 -0.267047192323384 0.959073614624151];

%Rotation matrix for transformation of elevator angle to z axis
R = rodrigues([0 0 1].',normal_vector.');

%Rotate the points, to align elevator angle to z axis
rotated_points = R*rotated_points;
points = R*points;

%display the rotated points, overall pattern should be aligned to z axis
% plot3(rotated_points(1,:),rotated_points(2,:),rotated_points(3,:),'y' )
% hold on
% plot3(points(1,:),points(2,:),points(3,:),'b' )
% xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');
% hold on

%focal length
f = abs(mean(rotated_points(3,:)));

%Find Homogenous Coordinates
for i=1:4
    projected_points(:,i) = points(:,i)*f/points(3,i);
    rotated_points(:,i) = rotated_points(:,i)*f/rotated_points(3,i);
end

%display projected points
part = ones(4,1);
plot3(rotated_points(1,:),rotated_points(2,:),i*part,'y' )
hold on
plot3(projected_points(1,:),projected_points(2,:), i*part,'b' )
xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');
hold on









%rotated_2d = (rotated_points.')*null(normal_vector); % reduced the 3D into 2D 4*2 matrix
%projected_2d = (points.')*null(normal_vector); %4*2 matrix
% plot3(projected_2d(:,1),projected_2d(:,2),i*part,'r' )
% xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');
% hold on
% for i=1:4
%     points(:,i) = points(:,i)/abs(points(3,i));
%     rotated_points(:,i) = rotated_points(:,i)/abs(rotated_points(3,i));
% end

%projected_2d = points(1:2,:)
%rotated_2d = rotated_points(1:2,:)

% plot(projected_2d(:,1),projected_2d(:,2), 'r');
% hold on
% plot(rotated_2d(:,1),rotated_2d(:,2), 'g')

% plot3(projected_2d(:,1),projected_2d(:,2),i*part,'r' )
% hold on
% plot3(rotated_2d(:,1),rotated_2d(:,2),i*part,'g' )
% hold on

%H = DLT(projected_2d,rotated_2d);

% projected_2d(:,3) = ones(4,1);
% new_points = H*(projected_2d.');
% plot3(new_points(1,:),new_points(2,:),i*part,'r' )
% xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');
% hold on
end

