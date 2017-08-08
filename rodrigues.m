function [rotation_matrix] = rodrigues(n1, n2)
%aligns vectors n2 to n1. Both are 3*1 matrices. Returns the rotation matrix


%find and normalise the axis of rotation
w = cross(n2,n1)/norm(cross(n1,n2));

%find the rotation angle
if dot(n2,n1) ~= 0
    theta = acos(dot(n1,n2)/(norm(n1)*norm(n2)));
else
    theta = pi/2;
end

%Find Euler-Rodrigue Matrix
w_matrix = [0, -w(3), w(2);
            w(3), 0, -w(1);
            -w(2), w(1), 0;];
        
%apply rodrigues formula
rotation_matrix = expm(w_matrix*theta);

end