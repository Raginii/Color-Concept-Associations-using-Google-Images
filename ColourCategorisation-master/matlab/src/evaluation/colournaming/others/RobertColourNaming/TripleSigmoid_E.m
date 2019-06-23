% TripleSigmoid_E: Computes the value of the TSE function (Triple Sigmoid with 
%                  Elliptical centre) at each value in vector s
% s              - Input samples
% tx, ty         - Column vectors of translations from the origin
% alfa_x, alfa_y - Column vectors of rotation angles with respect to x and y axis of the two oriented 2D-Sigmoids
% bx, by         - Column vectors of beta values of the two oriented 2D-Sigmoids 
% be             - Column vector of beta values of the Elliptic Sigmoid
% ex, ey         - Column vectors of semi-minor and semi-major axis of the Elliptic Sigmoid
% angle_e        - Column vector of rotation angles of the Elliptic Sigmoid

function y=TripleSigmoid_E(s,tx,ty,alfa_x,alfa_y,bx,by,be,ex,ey,angle_e)

u1=[1 0 0];
u2=[0 1 0];

y=SigmoidAngle(s,tx,ty,alfa_x,bx,u2).*SigmoidAngle(s,tx,ty,alfa_y,by,u1).*EllipticalSigmoid(s,tx,ty,be,ex,ey,angle_e);

