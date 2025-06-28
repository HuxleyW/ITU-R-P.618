function value = ITUR_P837(lon, lat, R001)
[X, Y] = meshgrid(-180 : 1/8 : 180 , -90 : 1/8 : 90);
value = interp2(X , Y , R001 , lon , lat , "linear");
end