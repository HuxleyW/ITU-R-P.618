clear
clc

load('ProcessedData/hR_0.5deg.mat')
lat = linspace(-90, 90, 361);
lon = linspace(-180, 180, 721);
[Lon, Lat] = meshgrid(lon, lat);
figure;
axesm('MapProjection', 'robinson');
framem on;
gridm on;
mlabel on;
plabel on;

geoshow(Lat, Lon, A, 'DisplayType', 'texturemap');

land = shaperead('landareas.shp', 'UseGeoCoords', true);
geoshow(land, 'FaceColor', 'none', 'EdgeColor', 'black');

colorbar;
title('global precipitation heights (km)')
