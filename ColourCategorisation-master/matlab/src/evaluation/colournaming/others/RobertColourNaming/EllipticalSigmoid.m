% EllipticalSigmoid: Computes the value of an elliptic sigmoid at location s=[x,y]
% s       - Input samples
% tx, ty  - Column vectors of translations from the origin
% be      - Column vector of beta values of the Elliptic Sigmoid
% ex, ey  - Column vectors of semi-minor and semi-major axis of the Elliptic Sigmoid
% angle_e - Column vector of rotation angles of the Elliptic Sigmoid

function y=EllipticalSigmoid(s,tx,ty,be,ex,ey,angle_e)

np=size(s,1);           % Number of samples in s


% Translation matrix (set of matrices concatenated in column direction: 3np x 3)
T=repmat(eye(3),np,1);
if (numel(tx)==1)
    tx=repmat(tx,np,1);
end
if (numel(ty)==1)
    ty=repmat(ty,np,1);
end
T(:,3)=T(:,3)-reshape([tx ty zeros(np,1)]',np*3,1);


% Rotation matrix (set of matrices concatenated in column direction: 3np x 3)
if (numel(angle_e)==1)
    angle_e=repmat(angle_e,[1 1 np]);
else
    angle_e=reshape(angle_e,1,1,np);
end


% First, R is a set of matrices concatenated in z direction: 3 x 3 x np
R=[cos(angle_e) sin(angle_e) zeros(1,1,np) ; -sin(angle_e) cos(angle_e) zeros(1,1,np) ; zeros(1,1,np) zeros(1,1,np) ones(1,1,np)];
% Then R is reshaped to 3np x 3
R=[reshape(R(:,1,:),3*np,1) reshape(R(:,2,:),3*np,1) reshape(R(:,3,:),3*np,1)];


% Apply translation to samples
s=[reshape(repmat(s(:,1)',3,1),3*np,1) reshape(repmat(s(:,2)',3,1),3*np,1) ones(np*3,1)];
s1=reshape(sum(T.*s,2),3,np);

% Apply rotation to samples
s=[reshape(repmat(s1(1,:),3,1),3*np,1) reshape(repmat(s1(2,:),3,1),3*np,1) ones(np*3,1)];
s1=reshape(sum(R.*s,2),3,np)';

% If ex or ey are zero, they are set to 1, to avoid zero division.
% Functions using this function should control this case and discard the returned values.
ex=(ex==0.0)+ex;
ey=(ey==0.0)+ey;

y=1./(1+exp(-be.*((((s1(:,1).^2)./ex.^2) + ((s1(:,2).^2)./ey.^2) - 1))));



