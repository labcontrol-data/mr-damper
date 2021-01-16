%forc(:) = -(forc(:));

distMax = abs(max(dist));
distMin = abs(min(dist));
distMin1 = abs(0-distMin);
distMedia = ((distMax - distMin)/2);
distA = distMedia + distMin1;

forcMax = abs(max(forc));
forcMin = abs(min(forc));
% forcMin1 = abs(0-forcMin);
forcMedia = ((forcMax + forcMin)/2); %sem carga - com carga +
% forcMin1 = abs(0-forcMedia);
forcA = forcMedia - forcMin;
forcMin1 = abs(0-forcA);


i = 1;
j=0;
for i=1:(Tf/Ts)+1
    dist1(i,1)=j;
    dist1(i,2) = dist(i)-distA;
    j=j+Ts;
end

i = 1;
j=0;
for i=1:(Tf/Ts)+1
    forc1(i,1)=j;
    forc1(i,2) = forc(i)-forcMin1;
    j=j+Ts;
end

