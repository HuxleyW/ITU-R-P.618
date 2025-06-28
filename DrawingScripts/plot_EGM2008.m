clear
clc
load ProcessedData/EGM2008.mat EGM2008;
AAA = EGM2008(3:end-2,3:end-2);
AAA = flipud(AAA);
lat = linspace(-90, 90, 2161);
lon = linspace(-180, 180, 4321);

[Lon, Lat] = meshgrid(lon, lat);
figure;
axesm('MapProjection', 'robinson');
framem on;
gridm on;
mlabel on;
plabel on;

geoshow(Lat, Lon, AAA, 'DisplayType', 'texturemap');

land = shaperead('landareas.shp', 'UseGeoCoords', true);
geoshow(land, 'FaceColor', 'none', 'EdgeColor', 'black');

colormap(jet);
colorbar
title('EGM2008(m)')
