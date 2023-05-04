%换能器参数及设计
param.Nelements = 256;
param.fc = 5e6; 
param.pitch = 270e-6; 
param.kerf = 140e-6; 
param.width = 130e-6;
param.bandwidth = 60;
param.radius = Inf;
param.height = 130e-6; 
param.focus = 60e-3;

[xe,ye] = meshgrid(((1:16)-8.5)*param.pitch);
param.elements = [xe(:).'; ye(:).'];
apod = sin(pi*linspace(0,15,16)/16).^2;
apod = apod.'*apod;
param.TXapodization = apod(:);

figure
viewxdcr(param);
colormap parula
c = colorbar('SouthOutside');
c.Label.String = 'TX apodization';
title('256-element matrix array apodization')

%设计传输延时,选择焦点,计算传输延时时间,可视化
xf = 0; yf = 0; zf = 60e-3; 
txdel = txdelay3(xf,yf,zf,param); 

figure
p = viewxdcr(param);
p.FaceVertexCData = txdel(:)*1e9;
c = colorbar('SouthOutside');
c.Label.String = 'TX delays (ns)';
colormap([1-hot;hot])
title('256-element matrix array trasmit delay')

%Genscat,生成散射体
%PFILED3模拟声场
h = cos(linspace(-pi/4,pi/4,16));
h = h'*h;
param.TXapodization = h(:);

tiltX = 10/180*pi; 
tiltY = 10/180*pi; 
omega = 30/180*pi;
txdel = txdelay3(param,tiltX,tiltY,omega); 

figure
viewxdcr(param);
p.FaceVertexCData = txdel(:)*1e6;
c = colorbar('SouthOutside');
c.Label.String = 'TX delays (ms)';
colormap([1-hot;hot])
title('256-element matrix array delay check')

x = linspace(-200e-2,20e-2,200);
y = x;
z = linspace(0,20e-2,200);

[xaz,zaz] = meshgrid(x,z);
yaz = zeros(size(xaz));
Paz = pfield3(xaz,yaz,zaz,txdel,param);

[yel,zel] = meshgrid(y,z);
xel = zeros(size(yel));
Pel = pfield3(xel,yel,zel,txdel,param);

[xfo,yfo] = meshgrid(x,y);
zfo1 = ones(size(xfo))*3e-2;
zfo2 = ones(size(xfo))*5e-2;
zfo3 = ones(size(xfo))*7e-2;
Pfo1 = pfield3(xfo,yfo,zfo1,txdel,param);
Pfo2 = pfield3(xfo,yfo,zfo2,txdel,param);
Pfo3 = pfield3(xfo,yfo,zfo3,txdel,param);

Pmax = max(max(Paz(:)),max(Pel(:)));
surf(xaz*1e2,yaz*1e2,zaz*1e2,20*log10(Paz/Pmax)), shading flat
hold on
surf(xel*1e2,yel*1e2,zel*1e2,20*log10(Pel/Pmax)), shading flat
surf(xfo*1e2,yfo*1e2,zfo1*1e2,20*log10(Pfo1/Pmax)), shading flat
surf(xfo*1e2,yfo*1e2,zfo2*1e2,20*log10(Pfo2/Pmax)), shading flat
surf(xfo*1e2,yfo*1e2,zfo3*1e2,20*log10(Pfo3/Pmax)), shading flat

figure
plot3(xe*1e2,ye*1e2,xe*0,'k.')
hold off
axis equal
zlabel('[cm]')
set(gca,'ZDir','reverse')
title('3-D diverging wave ([-20,0] dB)')
clim([-20 0])
alpha color
colormap(flipud([hot;1-hot]))
xlabel('x')
ylabel('y')
view(-25,20)
% 
% %SIMUS3模拟RF信号生成了一个点扫描成像的图像
% x0 = 0; y0 = 0; z0 = 3e-2;
% txdel = txdelay3(x0,y0,z0,param);
% n = 24;
% [xi,yi,zi] = meshgrid(linspace(-5e-3,5e-3,n),linspace(-5e-3,5e-3,n),...
%  linspace(0,6e-2,4*n));
% RP = pfield3(xi,yi,zi,txdel,param);
% [RF,param] = simus3(x0,y0,z0,1,txdel,param);
% IQ = rf2iq(RF,param);
% lambda = 1540/param.fc;
% [xi,yi,zi] = meshgrid(-2e-2:lambda:2e-2,-2e-2:lambda:2e-2,...
%  2.5e-2:lambda/2:3.2e-2);
% IQb = das3(IQ,xi,yi,zi,txdel,param);
% env = abs(IQb);
% I = 20*log10(env/max(env(:)));
% 
% figure
% I(1:round(size(I,1)/2),1:round(size(I,2)/2),:) = NaN;
% for k = [-40:10:-10 -5 -1]
%  isosurface(xi*1e2,yi*1e2,zi*1e2,I,k)
% end
% view(-60,40)
% colormap([1-hot;hot])
% c = colorbar;
% c.Label.String = 'dB';
% box on, grid on
% zlabel('[cm]')
% title('PSF at the focal point [dB]')