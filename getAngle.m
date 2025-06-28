function theta = getAngle(userPos, satPos, height)
Re = 6371.393;
dlat = deg2rad(satPos(2) - userPos(2));
dlon = deg2rad(satPos(1) - userPos(1));
a = sin(dlat / 2)^2 + cos(deg2rad(userPos(2))) * cos(deg2rad(satPos(2))) * sin(dlon / 2)^2;
c = 2 * atan2(sqrt(a), sqrt(1 - a));
distance = Re * c;

fai = distance/Re;
x = sqrt(Re^2 + (Re + height)^2 - 2*Re*(Re + height)*cos(fai));
cos_theta = (x^2 + Re^2 - (Re + height)^2)/(2*Re*x);
theta = real(acosd(cos_theta) - 90);
end