function [ new_points ] = rotate(points)
%points is 3*4 matrix, set of 4 points. The coordinate plane is shifted to
%new_origin and the normal vector to the the plane in which points lie, is
%aligned with z axis. returns the transformed points

for i=1:4
    new_points(:,i) = points(:,i)-points(:,1);
end
% project on it's own plane
normal_vector = [-0.0941466876951209;-0.267047192323384;0.959073614624151];

%%%%%%%%

% 
r1 = new_points(:,2)-new_points(:,1);
r2 = new_points(:,3)-new_points(:,1);
n = cross(r2,r1);
% new_n = [0; 0; norm(n)];
new_n = normal_vector;
w = cross(n,new_n);
w = w/norm(w);
if dot(n,new_n) ~= 0
    theta = acos(dot(n,new_n)/(norm(n)*norm(new_n)));
else
    theta = pi/2;
end

w_matrix = [0, -w(3), w(2);
            w(3), 0, -w(1);
            -w(2), w(1), 0;];
%apply rodrigues formula
rotation_matrix = expm(w_matrix*theta);

new_points = rotation_matrix*new_points;

P = repmat(points(:,1),[1 4]);
new_points = new_points+P;

end

