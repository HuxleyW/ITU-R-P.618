clear
clc

R001_sheet = load('ProcessedData/R001.mat');
R001_sheet = R001_sheet.R001;
lat = linspace(-90, 90, 1441);
lon = linspace(-180, 180, 2881);
[Lon, Lat] = meshgrid(lon, lat);
figure;
axesm('MapProjection', 'robinson');
framem on;
gridm on;
mlabel on;
plabel on;

geoshow(Lat, Lon, R001_sheet, 'DisplayType', 'texturemap');

land = shaperead('landareas.shp', 'UseGeoCoords', true);
geoshow(land, 'FaceColor', 'none', 'EdgeColor', 'black');

colorbar;
% clim([0 , 140])
title('Distribution of rainfall exceeding 0.01% of the annual average rainfall (mm/hr)')
