function hs = ITUR_P1511(lon, lat, TOPO)
% load EGM2008.mat EGM2008;
% [X1, Y1] = meshgrid(-180 - 1/6 : 1/12 : 180 + 1/6 , 90 + 1/6 : -1/12 : -90 - 1/6);
% EGM_value = interp2(X1 , Y1 , EGM2008 , lon , lat , 'cubic');
[X, Y] = meshgrid(-179.875 - 1/4 : 1/12 : 179.875 + 1/4 , 89.875 + 1/4 : -1/12 : -89.875 - 1/4);
hs = interp2(X , Y , TOPO , lon , lat , 'cubic');
hs = hs/1000;
end