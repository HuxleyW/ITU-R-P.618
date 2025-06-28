clear
clc
%% horizontal polarization
sheet = [];
for f = 1 :0.1: 1000
[k , alpha] = ITUR_P838('H' , 1 , 1 , f);
sheet = [sheet ; k , alpha];
end
% alpha
subplot(2,2,2)
x = 1:0.1:1000;
y = sheet(:,2);
semilogx(x, y);
grid on;
ax = gca;
ax.YTick = 0:0.2:max(y); 
ax.YMinorGrid = 'on';    
ax.YMinorTick = 'on';
title('horizontal polarization αH')
% k
subplot(2,2,1)
x = 1:0.1:1000;
y = sheet(:,1);
loglog(x, y);
grid on;
ax = gca;
ax.YMinorGrid = 'on';    
ax.YMinorTick = 'on';
title('horizontal polarization kH')
%% vertical polarization
sheet = [];
for f = 1 :0.1: 1000
[k , alpha] = ITUR_P838('V' , 1 , 1 , f);
sheet = [sheet ; k , alpha];
end
% alpha
subplot(2,2,4)
x = 1:0.1:1000;
y = sheet(:,2);
semilogx(x, y);
grid on;
ax = gca;
ax.YTick = 0:0.2:max(y); 
ax.YMinorGrid = 'on';    
ax.YMinorTick = 'on';
title('vertical polarization αV')
% k
subplot(2,2,3)
x = 1:0.1:1000;
y = sheet(:,1);
loglog(x, y);
grid on;
ax = gca;
ax.YMinorGrid = 'on';    
ax.YMinorTick = 'on';
title('vertical polarization kV')