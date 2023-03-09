subplot(2,1,1);
x=linspace(0,3);
v=x.^5/10;
plot(x,v);

subplot(2,1,1);
y=x*sin(x);
plot(x,y);

subplot(2,1,1);
z=cos(x);
plot(x,z);