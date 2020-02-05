% TNM085 Modelleringsprojekt, Linköpings Universitet
% This is a simulation of a spring-mass-damper system.
% 2019-03-14
% Authors: Ebba Nilsson, Emil Edström, Ida Strandberg, Tim Cardell, Tobias
% Ryttlinger.

close all
clc
clear
% m = mass
m = 4;

% h = fix step
% k = spring coefficent
% b = damp coefficent
% l = spring length
h = 0.01;
g = 9.82;
k = 20;
b = 1.8;
l = 30;

%Number of samples
N = 3000;

%hej

%Initial position and velocity fot the masses
x(1,1) = 1;
x(1,2) = 1;
x(1,3) = 1;
x(1,4) = 1;
vx(1,1) = 0;
vx(1,2) = 0;
vx(1,3) = 0;
vx(1,4) = 0;

y(1,1) = 0;
y(1,2) = 1;
y(1,3) = 0;
y(1,4) = 0;
vy(1,1) = 0;
vy(1,2) = 0;
vy(1,3) = 0;
vy(1,4) = 0;

z(1,1) = 0;
z(1,2) = 1;
z(1,3) = 0;
z(1,4) = 0;
vz(1,1) = 0;
vz(1,2) = 0;
vz(1,3) = 0;
vz(1,4) = 0;

for n=2:N
         % Calculating the spring and damp forces for the masses.
         
         Fkx12 = k*((x(n-1,2)-x(n-1,1))-l);
         Fbx12 = b*(vx(n-1,2)-vx(n-1,1));
         
         Fkx21 = k*((x(n-1,1)-x(n-1,2))+l);
         Fbx21 = b*(vx(n-1,1)-vx(n-1,2));
         
         Fkx13 = k*((x(n-1,3)-x(n-1,1))-l);
         Fbx13 = b*(vx(n-1,3)-vx(n-1,1));
         
         Fkx31 = k*((x(n-1,1)-x(n-1,3))+l);
         Fbx31 = b*(vx(n-1,1)-vx(n-1,3));
         
         Fkx24 = k*((x(n-1,4)-x(n-1,2))-l);
         Fbx24 = b*(vx(n-1,4)-vx(n-1,2));
         
         Fkx42 = k*((x(n-1,2)-x(n-1,4))+l);
         Fbx42 = b*(vx(n-1,2)-vx(n-1,4));
         
         Fkx34 = k*((x(n-1,4)-x(n-1,3))-l);
         Fbx34 = b*(vx(n-1,4)-vx(n-1,3));
         
         Fkx43 = k*((x(n-1,3)-x(n-1,4))+l);
         Fbx43 = b*(vx(n-1,3)-vx(n-1,4));
         
         Fky12 = k*((y(n-1,2)-y(n-1,1))-l);
         Fby12 = b*(vy(n-1,2)-vy(n-1,1));
         
         Fky21 = k*((y(n-1,1)-y(n-1,2))+l);
         Fby21 = b*(vy(n-1,1)-vy(n-1,2));
         
         Fky13 = k*((y(n-1,3)-y(n-1,1))-l);
         Fby13 = b*(vy(n-1,3)-vy(n-1,1));
         
         Fky31 = k*((y(n-1,1)-y(n-1,3))+l);
         Fby31 = b*(vy(n-1,1)-vy(n-1,3));
         
         Fky24 = k*((y(n-1,4)-y(n-1,2))-l);
         Fby24 = b*(vy(n-1,4)-vy(n-1,2));
         
         Fky42 = k*((y(n-1,2)-y(n-1,4))+l);
         Fby42 = b*(vy(n-1,2)-vy(n-1,4));
         
         Fky34 = k*((y(n-1,4)-y(n-1,3))-l);
         Fby34 = b*(vy(n-1,4)-vy(n-1,3));
         
         Fky43 = k*((y(n-1,3)-y(n-1,4))+l);
         Fby43 = b*(vy(n-1,3)-vy(n-1,4));
         
         Fkz12 = k*((z(n-1,2)-z(n-1,1))-l);
         Fbz12 = b*(vz(n-1,2)-vz(n-1,1));
         
         Fkz21 = k*((z(n-1,1)-z(n-1,2))+l);
         Fbz21 = b*(vz(n-1,1)-vz(n-1,2));
                  
         Fkz13 = k*((z(n-1,3)-z(n-1,1))-l);
         Fbz13 = b*(vz(n-1,3)-vz(n-1,1));
         
         Fkz31 = k*((z(n-1,1)-z(n-1,3))+l);
         Fbz31 = b*(vz(n-1,1)-vz(n-1,3));
         
         Fkz24 = k*((z(n-1,4)-z(n-1,2))-l);
         Fbz24 = b*(vz(n-1,4)-vz(n-1,2));
         
         Fkz42 = k*((z(n-1,2)-z(n-1,4))+l);
         Fbz42 = b*(vz(n-1,2)-vz(n-1,4));
         
         Fkz34 = k*((z(n-1,4)-z(n-1,3))-l);
         Fbz34 = b*(vz(n-1,4)-vz(n-1,3));
         
         Fkz43 = k*((z(n-1,3)-z(n-1,4))+l);
         Fbz43 = b*(vz(n-1,3)-vz(n-1,4));
         
         %Acceleration
         a1x= (Fkx12+Fbx12+Fkx13+Fbx13)/m;
         a2x= (Fkx21+Fbx21+Fkx24+Fbx24)/m;
         a3x= (Fkx31+Fbx31+Fkx34+Fbx34)/m;
         a4x= (Fkx42+Fbx42+Fkx43+Fbx43)/m;
         
         a1y=(Fky12+Fby12+Fky13+Fby13-g)/m;
         a2y=(Fky21+Fby21+Fky24+Fby24-g)/m;
         a3y=(Fky31+Fby31+Fky34+Fby34-g)/m;
         a4y=(Fky42+Fby42+Fky43+Fby43-g)/m;
         
         a1z= (Fkz12+Fbz12+Fkz13+Fbz13)/m;
         a2z= (Fkz21+Fbz21+Fkz24+Fbz24)/m;
         a3z= (Fkz31+Fbz31+Fkz34+Fbz34)/m;
         a4z= (Fkz42+Fbz42+Fkz43+Fbz43)/m;
         
         %Euler explicit method
         vx(n,1) = vx(n-1,1) + a1x*h;
         x(n,1) = x(n-1,1) + vx(n,1)*h;
        
         vx(n,2) = vx(n-1,2) + a2x*h/m;
         x(n,2) = x(n-1,2) + vx(n,2)*h;
         
         vx(n,3) = vx(n-1,3) + a3x*h;
         x(n,3) = x(n-1,3) + vx(n,3)*h;
        
         vx(n,4) = vx(n-1,4) + a4x*h/m;
         x(n,4) = x(n-1,4) + vx(n,4)*h;
         
         vy(n,1) = vy(n-1,1) + a1y*h;
         y(n,1) = y(n-1,1) + vy(n,1)*h;
        
         vy(n,2) = vy(n-1,2) + a2x*h/m;
         y(n,2) = y(n-1,2) + vy(n,2)*h;
         
         vy(n,3) = vy(n-1,3) + a3y*h;
         y(n,3) = y(n-1,3) + vy(n,3)*h;
        
         vy(n,4) = vy(n-1,4) + a4x*h/m;
         y(n,4) = y(n-1,4) + vy(n,4)*h;
       
         vz(n,1) = vz(n-1,1) + a1z*h;
         z(n,1) = z(n-1,1) + vz(n,1)*h;
        
         vz(n,2) = vz(n-1,2) + a2z*h/m;
         z(n,2) = z(n-1,2) + vz(n,2)*h;
         
         vz(n,3) = vz(n-1,3) + a3z*h;
         z(n,3) = z(n-1,3) + vz(n,3)*h;
        
         vz(n,4) = vz(n-1,4) + a4z*h/m;
         z(n,4) = z(n-1,4) + vz(n,4)*h;       
end


x1=x(:,1);
x2=x(:,2);
z1=x(:,2);
z2=x(:,2);
y1=y(:,1);
y2=y(:,2);

plot(x);
ylabel('x-axis');
xlabel('h');
grid on
figure
plot(y);
ylabel('Y-axis');
xlabel('h');
grid on
figure
plot(z);
ylabel('Z-axis');
xlabel('h');
grid on
