function [k, alpha] = ITUR_P838(polarisation, theta, latitude, f)
% ITUR_P838 calculates the attenuation and phase shift for a given 
% polarisation, elevation angle, latitude, and frequency.
% Inputs:
%   polarisation: 'H' (horizontal), 'V' (vertical), 'linear', or 'circular'
%   theta_deg: Elevation angle in degrees
%   latitude: Latitude of the location in degrees
%   f: Frequency in Hz

% Coefficients for horizontal polarisation
aj_kH = [-5.33980 , -0.35351 , -0.23789 , -0.94158];
bj_kH = [-0.10008 ,  1.26970 ,  0.86036 ,  0.64552];
cj_kH = [ 1.13098 ,  0.45400 ,  0.15354 ,  0.16817];
m_kH = -0.18961;
c_kH =  0.71147;

% Coefficients for vertical polarisation
aj_kV = [-3.80595 , -3.44965 , -0.39902 ,  0.50167];
bj_kV = [ 0.56934 , -0.22911 ,  0.73042 ,  1.07319];
cj_kV = [ 0.81061 ,  0.51059 ,  0.11899 ,  0.27195];
m_kV = -0.16398;
c_kV =  0.63297;

% Coefficients for alpha (phase shift) for horizontal polarisation
aj_alphaH = [-0.14318 , 0.29591 , 0.32177 , -5.37610 ,  16.1721];
bj_alphaH = [ 1.82442 , 0.77564 , 0.63773 , -0.96230 , -3.29980];
cj_alphaH = [-0.55187 , 0.19822 , 0.13164 ,  1.47828 ,  3.43990];
m_alphaH = 0.67849;
c_alphaH = -1.95537;

% Coefficients for alpha (phase shift) for vertical polarisation
aj_alphaV = [-0.07771 , 0.56727 , -0.20238 , -48.2991   , 48.5833];
bj_alphaV = [ 2.33840 , 0.95545 ,  1.14520 ,   0.791669 ,  0.791459];
cj_alphaV = [-0.76284 , 0.54039 ,  0.26809 ,   0.116226 ,  0.116479];
m_alphaV = -0.053739;
c_alphaV = 0.83433;

% Convert latitude to radians
phi = latitude;

% Calculate tau (angle of incidence on the ionosphere)
tau_deg  =  theta + phi;

% Determine the polarisation and calculate k and alpha
if strcmp(polarisation, 'H') % Horizontal polarisation
    k = 10.^(sum(aj_kH.*exp(-(((log10(f)-bj_kH)./cj_kH).^2))) + m_kH*log10(f) + c_kH);
    alpha = (sum(aj_alphaH.*exp(-(((log10(f)-bj_alphaH)./cj_alphaH).^2))) + m_alphaH*log10(f) + c_alphaH);
elseif strcmp(polarisation, 'V') % Vertical polarisation
    k = 10.^(sum(aj_kV.*exp(-(((log10(f)-bj_kV)./cj_kV).^2))) + m_kV*log10(f) + c_kV);
    alpha = (sum(aj_alphaV.*exp(-(((log10(f)-bj_alphaV)./cj_alphaV).^2))) + m_alphaV*log10(f) + c_alphaV);
elseif strcmp(polarisation, 'linear') % Linear polarisation
    kH = 10.^(sum(aj_kH.*exp(-(((log10(f)-bj_kH)./cj_kH).^2))) + m_kH*log10(f) + c_kH);
    alphaH = (sum(aj_alphaH.*exp(-(((log10(f)-bj_alphaH)./cj_alphaH).^2))) + m_alphaH*log10(f) + c_alphaH);
    kV = 10.^(sum(aj_kV.*exp(-(((log10(f)-bj_kV)./cj_kV).^2))) + m_kV*log10(f) + c_kV);
    alphaV = (sum(aj_alphaV.*exp(-(((log10(f)-bj_alphaV)./cj_alphaV).^2))) + m_alphaV*log10(f) + c_alphaV);
    k = (kH + kV + (kH - kV) * ((cosd(theta))^2) * cosd(2*tau_deg))/2;
    alpha = (kH * alphaH + kV * alphaV + (kH * alphaH - kV * alphaV) * ((cosd(theta))^2) * cosd(2*tau_deg))/(2*k);
elseif strcmp(polarisation, 'circular') % Circular polarisation
    tau_deg = 45; % Fixed angle for circular polarisation
    kH = 10.^(sum(aj_kH.*exp(-(((log10(f)-bj_kH)./cj_kH).^2))) + m_kH*log10(f) + c_kH);
    alphaH = (sum(aj_alphaH.*exp(-(((log10(f)-bj_alphaH)./cj_alphaH).^2))) + m_alphaH*log10(f) + c_alphaH);
    kV = 10.^(sum(aj_kV.*exp(-(((log10(f)-bj_kV)./cj_kV).^2))) + m_kV*log10(f) + c_kV);
    alphaV = (sum(aj_alphaV.*exp(-(((log10(f)-bj_alphaV)./cj_alphaV).^2))) + m_alphaV*log10(f) + c_alphaV);
    k = (kH + kV + (kH - kV) * ((cosd(theta))^2) * cosd(2*tau_deg))/2;
    alpha = (kH * alphaH + kV * alphaV + (kH * alphaH - kV * alphaV) * ((cosd(theta))^2) * cosd(2*tau_deg))/(2*k);
end
end
