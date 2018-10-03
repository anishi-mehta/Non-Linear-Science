function fin = lorenzplot(t,y,job,A)
%LORENZPLOT   Plot the orbit of the Lorenz chaotic attractor.

persistent Y

if isequal(job,'init')

   % Initialize axis and comet, R = axis settings, L = length of comet.

   rho = A(3,2);
   switch rho
      case 28,    R = [  5  45  -20  20  -25  25];  L = 100;
      case 99.65, R = [ 50 150  -35  35  -60  60];  L = 240;
      case 100.5, R = [ 50 150  -35  35  -60  60];  L = 120;
      case 160,   R = [100 220  -40  40  -75  75];  L = 165;
      case 350,   R = [285 435  -55  55 -105 105];  L =  80;
      otherwise,  R = [100 250  -50  50 -100 100];  L = 150;
   end
   set(gcf,'pos',get(gcf,'pos')+[0 0 0 1])
   drawnow
   set(gcf,'pos',get(gcf,'pos')-[0 0 0 1])
   drawnow
   if get(gca,'userdata') ~= rho, delete(gca), end
   set(gca,'color','black','pos',[.03 .05 .93 .95],'userdata',rho)
   axis(R);
   axis off

   comet(1) = line(y(1),y(2),y(3),'linestyle','none','marker','.', ...
      'erasemode','xor','markersize',25);
   comet(2) = line(NaN,NaN,NaN,'color','y','erasemode','none');
   comet(3) = line(NaN,NaN,NaN,'color','y','erasemode','none');
   Y = y(:,ones(L,1));

   uics = flipud(get(gcf,'children'));
   disp(uics)
  % disp(uics(2))
   paws = uics(1);
   %stop = uics(2);
   set(paws,'string','pause','callback','','value',0);
   %set(stop,'string','stop','callback','','value',0);

   beta = -A(1,1);
   eta = sqrt(beta*(rho-1));
   yc = [rho-1; eta; eta];
   line(yc(1),yc(2),yc(3),'linestyle','none','marker','o','color','g')
   line(yc(1),-yc(2),-yc(3),'linestyle','none','marker','o','color','g')

   ax = [R(2) R(1) R(1) R(1) R(1)];
   ay = [R(3) R(3) R(4) R(3) R(3)];
   az = [R(5) R(5) R(5) R(5) R(6)];
   p = .9;
   q = 1-p;
   grey = [.4 .4 .4];
   line(ax,ay,az,'color',grey);
   text(p*R(1)+q*R(2),R(3),p*R(5),sprintf('%3.0f',R(1)),'color',grey)
   text(q*R(1)+p*R(2),R(3),p*R(5),sprintf('%3.0f',R(2)),'color',grey)
   text(R(1),p*R(3)+q*R(4),p*R(5),sprintf('%3.0f',R(3)),'color',grey)
   text(R(1),q*R(3)+p*R(4),p*R(5),sprintf('%3.0f',R(4)),'color',grey)
   text(R(1),R(3),p*R(5)+q*R(6),sprintf('%3.0f',R(5)),'color',grey)
   text(R(1),R(3),q*R(5)+p*R(6),sprintf('%3.0f',R(6)),'color',grey)
   fin = 0;

   cameratoolbar('setmode','orbit')
   uicontrol('style','text','units','norm','pos',[.38 .02 .34 .04], ...
      'foreground','white','background','black','fontangle','italic', ...
      'string','Click on axis to rotate view')

elseif isequal(job,'done')

   fin = 1;

else

   % Update comet

   L = size(y,2);
   Y(:,end+1:end+L) = y;
   comet = flipud(get(gca,'children'));
   set(comet(1),'xdata',Y(1,end),'ydata',Y(2,end),'zdata',Y(3,end));
   set(comet(2),'xdata',Y(1,2:end),'ydata',Y(2,2:end),'zdata',Y(3,2:end))
   set(comet(3),'xdata',Y(1,1:2),'ydata',Y(2,1:2),'zdata',Y(3,1:2))
   Y(:,1:L) = [];
   drawnow;

   % Pause and restart

   uics = flipud(get(gcf,'children'));
   paws = uics(1);
   stop = uics(2);
   rhopick = uics(4);
   rho = A(3,2);
   while get(paws,'value')==1 & get(stop,'value')==0
      set(paws,'string','resume');
      drawnow;
   end
   set(paws,'string','pause')
   fin = get(stop,'value') | get(rhopick,'value')==rho;
   if fin
      set(paws,'value',0,'string','restart','callback','lorenzgui')
      set(stop,'value',0,'string','close', ...
         'callback','cameratoolbar(''close''), close(gcf)')
   end
end
