function hR = ITUR_P839(lon, lat, h0)
% In h0, latitude ranges from +90 to -90, and longitude ranges from 0 to 360
% Input lat range is 90 to -90, lon range is -180 to 180

% Convert input longitude from -180 to 180 to 0 to 360
lon = mod(lon + 360, 360);
step = 1.5;
lat_sheet = flip(-90 : step : 90);
lon_sheet = 0 : step : 360;

% Determine the nearest latitude index
if lat == -90
    i_low = 120;
    i_high = i_low + 1;
else
    i_low = floor((90 - lat) / step) + 1;
    i_high = i_low + 1;
end

% Determine the nearest longitude index
j_low = floor(lon / step) + 1;
j_high = j_low + 1;
if xor(ismember(lat , lat_sheet) , ismember(lon , lon_sheet))
    % If XOR result is 1, it means one dimension can be found in the table, perform linear interpolation on the other dimension
    indice = [ismember(lat , lat_sheet) , ismember(lon , lon_sheet)];
    if find(indice == 0) == 1
        % Latitude linear interpolation
        col = find(lon == lon_sheet);
        lat_low = 90 - (i_low - 1) * step;
        lat_high = 90 - (i_high - 1) * step;
        y1 = h0(i_low , col);
        y2 = h0(i_high , col);
        value = y1 + (y2 - y1)/(lat_high - lat_low)*(lat - lat_low);
    elseif find(indice == 0) == 2
        % Longitude linear interpolation
        row = find(lat == lat_sheet);
        lon_low = (j_low - 1) * step;
        lon_high = (j_high - 1) * step;
        y1 = h0(row , j_low);
        y2 = h0(row , j_high);
        value = y1 + (y2 - y1)/(lon_high - lon_low)*(lon - lon_low);
    end
else
    % At this point, the target point is on the grid points or does not overlap with the grid lines.
    % The former is equivalent to taking the value of f11, and the latter performs bilinear interpolation.
    % Get the coordinates and values of the four grid points
    lat_low = 90 - (i_low - 1) * step;
    lat_high = 90 - (i_high - 1) * step;
    lon_low = (j_low - 1) * step;
    lon_high = (j_high - 1) * step;
    f11 = h0(i_low, j_low);
    f12 = h0(i_low, j_high);
    f21 = h0(i_high, j_low);
    f22 = h0(i_high, j_high);
    
    % Bilinear interpolation
    % h0 = (1 / ((lat_high - lat_low) * (lon_high - lon_low))) * ...
    %     (f11 * (lat_high - lat) * (lon_high - lon) + ...
    %     f21 * (lat - lat_low) * (lon_high - lon) + ...
    %     f12 * (lat_high - lat) * (lon - lon_low) + ...
    %     f22 * (lat - lat_low) * (lon - lon_low));
    value = (1 / ((lat_high - lat_low) * (lon_high - lon_low))) * ...
        [lat_high - lat lat - lat_low] * [f11 f12;f21 f22] * [lon_high - lon;lon - lon_low];
end
hR = value + 0.36;
end