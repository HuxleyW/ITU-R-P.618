clear
clc
R001 = importdata('ProcessedData/R001.mat');
step = 1/12;
latitudes = -90:step:90;
longitudes = -180:step:180;
num_lat = length(latitudes);
num_lon = length(longitudes);
values_matrix = zeros(num_lat, num_lon);
for i = 1:num_lat
    for j = 1:num_lon
        lat = latitudes(i);
        lon = longitudes(j);
        
        values_matrix(i, j) = ITUR_P837(lon, lat, R001);
    end
end
% save('R001_1/12deg.mat','values_matrix')