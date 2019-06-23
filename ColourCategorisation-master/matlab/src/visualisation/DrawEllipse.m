function [] = DrawEllipse(ellipse, varargin)
%DrawEllipse Summary of this function goes here

cx = ellipse(1);
cy = ellipse(2);
ax = ellipse(3);
ay = ellipse(4);
rx = ellipse(5);

ntheta = 32;
PlotAlpha = 0.1;

% default set of options for drawing meshes
options = {'linestyle', '-'};

% extract input arguments
while length(varargin) > 1
  switch lower(varargin{1})
    case 'nphi'
      ntheta = varargin{2};
      
    case 'alpha'
      PlotAlpha = varargin{2};
      
    otherwise
      % assumes this is drawing option
      options = [options, varargin(1:2)]; %#ok<AGROW>
  end
  
  varargin(1:2) = [];
end

crx = cos(rx);
srx = sin(rx);
theta = linspace(0, 2 * pi, ntheta);
cth = cos(theta);
sth = sin(theta);
h = line(ax * cth * crx - srx * ay * sth +cx, ax * cth * srx + crx * ay * sth + cy);
set(h, options{:});

alpha(PlotAlpha);

end
