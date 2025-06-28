function A_Rain = calculateRainAttenuation(userPos, satPos, f, height, p, Data)
% userPos : User coordinates [longitude, latitude]
% satPos : Satellite coordinates [longitude, latitude]
% f: Frequency (GHz)
% height : Orbital height (km)
Re = 8500;
hs = ITUR_P1511(userPos(1) , userPos(2) , Data.TOPO); % Height of the Earth station above mean sea level (km)
theta_deg = getAngle(userPos , satPos , height); % Elevation angle

%% step 1
hR = ITUR_P839(userPos(1) , userPos(2) , Data.h0);
%% step 2
if hR - hs > 0
    if theta_deg > 5
        Ls = (hR-hs)/sind(theta_deg);
    else
        Ls = 2*(hR-hs)/(sqrt(sind(theta_deg)^2 + 2*(hR-hs)/Re) + sind(theta_deg));
    end
    %% step 3
    LG = Ls*cosd(theta_deg);
    %% step 4
    R001 = ITUR_P837(userPos(1) , userPos(2) , Data.R001);
    if R001 ~= 0
        %% step 5
        [k , alpha] = ITUR_P838('H' , theta_deg , userPos(2) , f);
        gammaR = k*(R001)^(alpha);
        %% step 6
        r001 = 1 / (1 + 0.78 * sqrt((LG * gammaR)/f) - 0.38 * (1 - exp(-2*LG)));
        %% step 7
        zeta_rad = atan((hR - hs) / (LG * r001));
        zeta_deg = zeta_rad * 180 / pi;
        if zeta_deg > theta_deg
            LR = (LG * r001) / cosd(theta_deg);
        else
            LR = (hR - hs) / sind(theta_deg);
        end
        if  abs(userPos(2)) < 36
            chi = 36-abs(userPos(2));
        else
            chi = 0;
        end
        nu001 = 1/(1 + sqrt(sind(theta_deg))*(31*(1 - exp(-(theta_deg / (1 + chi)))) * ((sqrt(LR * gammaR))/(f^2)) - 0.45));
        %% step 8
        LE = LR * nu001;
        %% step 9
        A001 = gammaR * LE;
        %% step 10
        if p >= 0.01 || abs(userPos(2)) >= 36
            beta = 0;
        elseif p < 0.01 && abs(userPos(2)) < 36 && theta_deg >= 25
            beta = -0.005 * (abs(userPos(2)) - 36);
        else
            beta = -0.005 * (abs(userPos(2)) - 36) + 1.8 - 4.25*sind(theta_deg);
        end
        A_Rain = A001 * (p / 0.01)^(-(0.655 + 0.033 * log(p) - 0.045 * log(A001) - beta * (1 - p) * sind(theta_deg)));
        % A_Rain_linear = 10^(A_Rain / 10);
    end
end
end