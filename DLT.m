function [ H ] = DLT( P1, P2 )
%P1: points on orignal image
%P2: points on transformed image
%Both are 4*2 matrices

M1 = zeros(8,8);
M2 = zeros(8,1);
for i = 1:2:7
    j = (i+1)/2;
    M1(i,:) = [P1(j,1) P1(j,2) 1 0 0 0 -P2(j,1)*P1(j,1) -P2(j,1)*P1(j,2)];
    M1(i+1,:) = [0 0 0 P1(j,1) P1(j,2) 1 -P2(j,2)*P1(j,1) -P2(j,2)*P1(j,2)];
    M2(i,1) = P2(j,1);
    M2(i+1,1) = P2(j,2);
end

H = inv(M1.'*M1)*(M1.'*M2);
H(9) = 1;

H = reshape(H,[3,3]);

           
end

