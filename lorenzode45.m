r=[28];
figure;
for rho=r
    init=[[5;-5;3],[-5;3;3]];
    for y0=init
        y0
        disp('rho')
        disp(rho);
       sigma = 10;
       beta = 8/3;
       eta = sqrt(beta*(rho-1));
       A = [ -beta  , 0  ,eta; 0 , -sigma  , sigma; -eta ,  rho ,   -1  ];
       %disp('hello')
       % The critical points are the null vectors of A.
       % The initial value of y(t) is near one of the critical points.

       J=[-sigma,sigma,0;rho,-1,0;0,0,-b];
    [V,D]=eig(J);
    disp(V)

       yc = [rho-1; eta; eta];
       %y0=-yc+[0;1;1];
       %y0=V(:,2)*-0.001;
       %y0 = [3,3,3];



       % Integrate forever, or until the stop button is toggled.
       tspan = [0 500];
       opts = odeset('reltol',1.e-6,'outputfcn',@lorenzplot,'refine',4);
       [t,y]=ode45(@(t,y) lorenzeqn(t,y,A), tspan, y0);
       plot3(y(:,2),y(:,3),y(:,1),'LineWidth',1)
       hold on;

       xlabel('X-axis')
       ylabel('Y-axis')
       zlabel('Z-axis')
   title('Parameter r>1')
    end
end