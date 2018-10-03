b=8/3;
sigma=10;
rho=13.9000;

p=[1 (b+sigma+1) b*(sigma+rho) 2*b*sigma*(rho-1)];

roots(p)

J=[-sigma,sigma,0;rho,-1,0;0,0,-b];
[V,D]=eig(J);
disp(V)

