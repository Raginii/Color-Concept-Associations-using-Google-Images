function [] = DrawEllipsoid(ellipsoid, varargin)
%DrawEllipsoid drwaing an ellipsoid in 3D.
%

% number of meridians
nphi = 32;

% number of parallels
ntheta = 16;

PlotAlpha = 0.1;

% default set of options for drawing meshes
options = {'linestyle', '-'};

% extract input arguments
while length(varargin) > 1
  switch lower(varargin{1})
    case 'nphi'
      nphi = varargin{2};
      
    case 'ntheta'
      ntheta = varargin{2};
      
    case 'alpha'
      PlotAlpha = varargin{2};
      
    otherwise
      % assumes this is drawing option
      options = [options, varargin(1:2)]; %#ok<AGROW>
  end
  
  varargin(1:2) = [];
end

cx = ellipsoid(:, 1);
cy = ellipsoid(:, 2);
cz = ellipsoid(:, 3);
ax = ellipsoid(:, 4);
ay = ellipsoid(:, 5);
az = ellipsoid(:, 6);
rx = ellipsoid(:, 7);
ry = ellipsoid(:, 8);
rz = ellipsoid(:, 9);

% spherical coordinates
theta = linspace(0, pi, ntheta + 1);
phi = linspace(0, 2 * pi, nphi + 1);

% convert to cartesian coordinates
sintheta = sin(theta);
MeshPoints = zeros(length(phi), length(theta), 3);
MeshPoints(:, :, 1) = cos(phi') * sintheta;
MeshPoints(:, :, 2) = sin(phi') * sintheta;
MeshPoints(:, :, 3) = ones(length(phi), 1) * cos(theta);

% Coordinates computation

% convert unit basis to ellipsoid basis
sca  = CreateScaling3(ax, ay, az);
rotx = CreateRotationX(rx);
roty = CreateRotationY(ry);
rotz = CreateRotationZ(rz);
tra  = CreateTranslation3(cx, cy, cz);

% concatenate transforms
trans = tra * rotz * roty * rotx * sca;

% transform mesh vertices
MeshPoints = TransformPoint3(MeshPoints, trans');

% drawing
mesh(MeshPoints(:, :, 1), MeshPoints(:, :, 2), MeshPoints(:, :, 3), options{:});

alpha(PlotAlpha);

end
