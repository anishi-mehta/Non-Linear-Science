function lorenzgui
%LORENZGUI   Plot the orbit around the Lorenz chaotic attractor.
%   This function animates the integration of the three coupled
%   nonlinear differential equations that define the Lorenz Attractor,
%   a chaotic system first described by Edward Lorenz of MIT.
%   As the integration proceeds you will see a point moving in
%   an orbit in 3-D space known as a strange attractor.
%   The orbit ranges around two different critical points, or attractors.
%   The orbit is bounded, but may not be periodic and or convergent.
%
%   The mouse and arrow keys change the 3-D viewpoint.  Uicontrols
%   provide "pause", "resume", "stop", "restart", "clear", and "close".
%
%   A listbox provides a choice among five values of the parameter rho.
%   The first value, 28, is the most common and produces the chaotic
%   behavior.  The other four values values produce periodic behaviors
%   of different complexities.  A change in rho becomes effective only
%   after a "stop" and "restart".
%
%   Reference: Colin Sparrow, "The Lorenz Equations: Bifurcations,
%   Chaos, and Strange Attractors", Springer-Verlag, 1982.

%   Copyright 2013 - 2015 The MathWorks, Inc.
% 
% if ~isequal(get(gcf,'name'),'Lorenzgui')
%    
%    % This is first entry, just initialize the figure window.
% 
%    rhos = [28 99.65 100.5 160 350];
%    shg
%    clf reset
%    p = get(gcf,'pos');
%    set(gcf,'color','black','name','Lorenzgui', ...
%       'menu','none','numbertitle','off', ...
%       'pos',[p(1) p(2)-(p(3)-p(4))/2 p(3) p(3)])
% 
%    % Callback to erase comet by jiggling figure position
% 
%    klear = ['set(gcf,''pos'',get(gcf,''pos'')+[0 0 0 1]), drawnow,' ...
%             'set(gcf,''pos'',get(gcf,''pos'')-[0 0 0 1]), drawnow'];
% 
%    % Uicontrols
% 
%    paws = uicontrol('style','toggle','string','start', ...
%       'units','norm','pos',[.02 .02 .10 .04],'value',0, ...
%       'callback','lorenzgui');
%    stop = uicontrol('style','toggle','string','close', ...
%       'units','norm','pos',[.14 .02 .10 .04],'value',0, ...
%       'callback','cameratoolbar(''close''), close(gcf)');
%    clear = uicontrol('style','push','string','clear', ...
%       'units','norm','pos',[.26 .02 .10 .04], ...
%       'callback',klear);
%    rhostr = sprintf('%6.2f|',rhos);
%    rhopick = uicontrol('style','listbox','tag','rhopick', ...
%       'units','norm','pos',[.82 .02 .14 .14], ...
%       'string',rhostr(1:end-1),'userdata',rhos,'value',1);
% 
% else

   % The differential equation is ydot = A(y)*y
   % With this value of eta, A is singular.
   % The eta's in A will be replaced by y(2) during the integration.

%   rhopick = findobj('tag','rhopick');
%     rhos = get(rhopick,'userdata');
%     rho = rhos(get(rhopick,'value'));
    rho=[1];
    disp('rho')
    disp(rho);
   sigma = 10;
   beta = 8/3;
   eta = sqrt(beta*(rho-1));
   A = [ -beta  , 0  ,eta; 0 , -sigma  , sigma; -eta ,  rho ,   -1  ];
   disp('hello')
   % The critical points are the null vectors of A.
   % The initial value of y(t) is near one of the critical points.
   
   yc = [rho-1; eta; eta];
   y0 = yc + [0; 0; 3];
   
   % Integrate forever, or until the stop button is toggled.
   
   tspan = [0 Inf];
   opts = odeset('reltol',1.e-6,'outputfcn',@lorenzplot,'refine',4);
   ode45(@lorenzeqn, tspan, y0, opts, A);

end


% ------------------------------


