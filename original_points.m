% 0628 for 4 points

% R
% yezhan 0614 for rotation

clear all
clc
close all

syms x y

load C:\Users\USER\Desktop\0614\parecon01
c = dlmread('C:\Users\USER\Desktop\0614\061401_001.tsv', '\t','F447..K1246'); % start point ?38?
nf = 400;
% smoothn the data
Rx =  c(1:2:800,3);
Ry =  c(1:2:800,2); 
Rz =  c(1:2:800,1);
Tx = c(1:2:800,4);
Ty = c(1:2:800,5);
Tz = c(1:2:800,6);
Point_R = [Tx Ty Tz];

% S
vectorS = [ -37.5420  -73.5878   19.0405]';

% P
for i = 1:nf;
roll = (Rz(i)/180)*pi; % Rz
pitch = (Ry(i)/180)*pi; % Ry
yaw = (Rx(i)/180)*pi;% Rx
Alpha = roll;
Beta = pitch;
Gamma = yaw;
Rotation = [cos(Alpha)*cos(Beta),cos(Alpha)*sin(Beta)*sin(Gamma)-sin(Alpha)*cos(Gamma),cos(Alpha)*sin(Beta)*cos(Gamma)+sin(Alpha)*sin(Gamma);
    sin(Alpha)*cos(Beta),sin(Alpha)*sin(Beta)*sin(Gamma)+cos(Alpha)*cos(Gamma),sin(Alpha)*sin(Beta)*cos(Gamma)-cos(Alpha)*sin(Gamma);
    -sin(Beta),cos(Beta)*sin(Gamma),cos(Beta)*cos(Gamma)];
pointR = [Tx(i), Ty(i), Tz(i)]';
vecorSinW = inv(Rotation)\vectorS;
P = vecorSinW+pointR;
Point(:,i) = P'; 
end

% Get NS
vectorS1 = [ -32.6018  -70.5085   47.5540]';
vectorS2 = [ -31.3189  -52.7838   32.5567]';
vectorS3 = [ -33.7283  -39.2766   21.7804]';
vectorS = [vectorS1 vectorS2 vectorS3]'; 
for j = 1:3;
for i = 1:nf;
roll = (Rz(i)/180)*pi; % Rz
pitch = (Ry(i)/180)*pi; % Ry
yaw = (Rx(i)/180)*pi;% Rx
Alpha = roll;
Beta = pitch;
Gamma = yaw;
Rotation = [cos(Alpha)*cos(Beta),cos(Alpha)*sin(Beta)*sin(Gamma)-sin(Alpha)*cos(Gamma),cos(Alpha)*sin(Beta)*cos(Gamma)+sin(Alpha)*sin(Gamma);
    sin(Alpha)*cos(Beta),sin(Alpha)*sin(Beta)*sin(Gamma)+cos(Alpha)*cos(Gamma),sin(Alpha)*sin(Beta)*cos(Gamma)-cos(Alpha)*sin(Gamma);
    -sin(Beta),cos(Beta)*sin(Gamma),cos(Beta)*cos(Gamma)];
R(:,:,i) = Rotation;
vecorSinW = inv(Rotation)\(vectorS(j,:))';
P = vecorSinW+(Point_R(i,:))';
Point(:,i) = P'; 
end
Pointf(:,:,j)=Point; % four points after rotate
end
for j= 1:3;
for i = 1:nf
    original(:,i) = inv(R(:,:,i))\Pointf(:,i,j);
end
  PPoriginal(:,:,j) = original;
end
for i = 1:nf;
 P0 =  PPoriginal(:,i,1);
 P1 =  PPoriginal(:,i,2);
 P2 =  PPoriginal(:,i,3);
 normal_NS(:,i) = cross(P0-P1, P0-P2); 
end


% if we know the PB
for i = 1:nf;
 PB_1 = PPoriginal(:,i,1)-PPoriginal(:,i,2);
 PB(:,i) = PB_1;
end

% PB_2 = mean(PB');
% dis = norm(PB_2);

%%%PD  https://math.stackexchange.com/questions/408834/what-is-the-solution-to-this-parametric-equation-problem
for i = 1:nf
PD(:,i) = cross(normal_NS(:,i),PB(:,i));
% PD(:,i) = cross(normal_NS(:,i),PB_2);
end

%PB
for i = 1:nf;
S = solve (((( PB(1,i))*x)^2+( PB(2,i)*x)^2+( PB(3,i)*x)^2)^0.5 == 38,x);
S = vpa(S,3);
% PB_x(:,i) = S;
PB_final(:,i) = double(S);
end

%PD
for i = 1:nf;
S = solve (((( PD(1,i))*y)^2+( PD(2,i)*y)^2+( PD(3,i)*y)^2)^0.5 == 30,y);
S = vpa(S,3);
% PB_x(:,i) = S;
PD_final(:,i) = double(S);
end

% PB PD PC
PB_vector = PB * PB_final(2,1);
PD_vector = PD * PD_final(2,1);
PC_vector = PB_vector+PD_vector;



% points


vectorS1 = [ -37.5420  -73.5878   19.0405]';
vectorS2 = vectorS1+PB_vector(:,1);
vectorS3 = vectorS1+PC_vector(:,1);
vectorS4 = vectorS1+PD_vector(:,1);
vectorS = [vectorS1 vectorS2 vectorS3 vectorS4 ]'; 

for j = 1:4;
for i = 1:nf;
roll = (Rz(i)/180)*pi; % Rz
pitch = (Ry(i)/180)*pi; % Ry
yaw = (Rx(i)/180)*pi;% Rx
Alpha = roll;
Beta = pitch;
Gamma = yaw;
Rotation = [cos(Alpha)*cos(Beta),cos(Alpha)*sin(Beta)*sin(Gamma)-sin(Alpha)*cos(Gamma),cos(Alpha)*sin(Beta)*cos(Gamma)+sin(Alpha)*sin(Gamma);
    sin(Alpha)*cos(Beta),sin(Alpha)*sin(Beta)*sin(Gamma)+cos(Alpha)*cos(Gamma),sin(Alpha)*sin(Beta)*cos(Gamma)-cos(Alpha)*sin(Gamma);
    -sin(Beta),cos(Beta)*sin(Gamma),cos(Beta)*cos(Gamma)];
R(:,:,i) = Rotation;
vecorSinW = inv(Rotation)\(vectorS(j,:))';
P = vecorSinW+(Point_R(i,:))';
Point(:,i) = P'; 
end
Pointf(:,:,j)=Point; % four points after rotate
end

for j= 1:4;
for i = 1:nf
    original(:,i) = inv(R(:,:,i))\Pointf(:,i,j);
end
  PPoriginal(:,:,j) = original;
end

%%
figure
part = ones(4,1);
for i = 1:nf
plot3(squeeze(PPoriginal(1,i,:)),squeeze(PPoriginal(2,i,:)),i*part ,'b');
hold on
end
