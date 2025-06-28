clear
clc
h0 = importdata('ProcessedData/h0.mat');
step = 0.5;
latitudes = 90:-step:-90;
longitudes = 0:step:360;
num_lat = length(latitudes);
num_lon = length(longitudes);
values_matrix = zeros(num_lat, num_lon);
for i = 1:num_lat
    for j = 1:num_lon
        lat = latitudes(i);
        lon = longitudes(j);
        
        values_matrix(i, j) = ITUR_P839(lon, lat, h0);
    end
end
% save('hR_0.5deg.mat','values_matrix')