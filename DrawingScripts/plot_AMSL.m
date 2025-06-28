clear
clc
load('ProcessedData/TOPO.dat')
AAA = TOPO(3:end-2,3:end-2);
AAA = flipud(AAA);
lat = linspace(-90, 90, 2160);
lon = linspace(-180, 180, 4320);

[Lon, Lat] = meshgrid(lon, lat);
figure;
axesm('MapProjection', 'robinson');
framem on;
gridm on;
mlabel on;
plabel on;

geoshow(Lat, Lon, AAA/1000, 'DisplayType', 'texturemap');

land = shaperead('landareas.shp', 'UseGeoCoords', true);
geoshow(land, 'FaceColor', 'none', 'EdgeColor', 'black');

% colormap(jet);
colorbar
title('height of the Earth station above mean sea level(km)')
