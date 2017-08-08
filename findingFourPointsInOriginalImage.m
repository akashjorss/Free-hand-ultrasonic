load('C:\Users\Laser\Desktop\0621\data\leaf_data.csv');
original_points = [0,-30,0;
                   0,0,0;
                   38,0,0;  
                   38,-30,0;];
leftVectorS = [-21.7267 -69.1302 45.6120].';
rightVectorS = [-25.5204 -42.3735  23.9988].';

original_points = original_points.';

BC = original_points(:,3) - original_points(:,2);
R = rodrigues(rightVectorS - leftVectorS, BC);
original_points = R*original_points;
original_points = original_points + repmat(leftVectorS,1,4);
% plot3([0 leftVectorS(1)],[0 leftVectorS(2)],[0 leftVectorS(3)],'b' )
% hold on
% plot3([0 rightVectorS(1)],[0 rightVectorS(2)],[0 rightVectorS(3)],'g' )
% hold on
% plot3(original_points(1,:),original_points(2,:),original_points(3,:),'r' )
% xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');
% hold on    
original_points = repmat(original_points,1,1,400);
count = 0;
for i = 471:2:1270
    count = count + 1;
    rdata(count,:) = leaf_data(i,4:6);
    tdata(count,:) = leaf_data(i,7:9);
end
rdata = rdata*pi/180;
for i=1:400
    %calculate R
    Alpha = rdata(i,1); Beta = rdata(i,2); Gamma = rdata(i,3);
    R = [cos(Alpha)*cos(Beta),cos(Alpha)*sin(Beta)*sin(Gamma)-sin(Alpha)*cos(Gamma),cos(Alpha)*sin(Beta)*cos(Gamma)+sin(Alpha)*sin(Gamma);
    sin(Alpha)*cos(Beta),sin(Alpha)*sin(Beta)*sin(Gamma)+cos(Alpha)*cos(Gamma),sin(Alpha)*sin(Beta)*cos(Gamma)-cos(Alpha)*sin(Gamma);
    -sin(Beta),cos(Beta)*sin(Gamma),cos(Beta)*cos(Gamma)];
    rotatedLeftS(:,i) = R*leftVectorS;
    translatedLeftS(:,i) = rotatedLeftS(:,i) + tdata(i,:).';
    rotatedRightS(:,i) = R*rightVectorS;
    translatedRightS(:,i) = rotatedRightS(:,i) + tdata(i,:).';
    original_points(:,:,i) = R*original_points(:,:,i);
    original_points(:,:,i) = original_points(:,:,i)+ repmat(tdata(i,:).',1,4);
end


for i=1:400
    plot3(original_points(1,:,i),original_points(2,:,i),original_points(3,:,i),'r' )
    xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis')
    grid on
    pbaspect([1 1 1])
    hold on    
end

    