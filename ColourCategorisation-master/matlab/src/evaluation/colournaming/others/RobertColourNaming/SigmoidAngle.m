% SigmoidAngle: Computes the oriented 2D-sigmoid values at each sample in vector s
% s      - Input samples
% tx, ty - Column vectors of translations from the origin
% alfa   - Column vector of rotation angles with respect to the axis
% b      - Column vector of beta parameters of the Sigmoid function
% u      - Vector controlling the orientation of the 2D-Sigmoid ([1 0 0] or [0 1 0])

function y=SigmoidAngle(s,tx,ty,alfa,b,u)

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
if (numel(alfa)==1)
    alfa=repmat(alfa,[1 1 np]);
else
    alfa=reshape(alfa,1,1,np);
end
% First, R is a set of matrices concatenated in z direction: 3 x 3 x np
R=[cos(alfa) sin(alfa) zeros(1,1,np) ; -sin(alfa) cos(alfa) zeros(1,1,np) ; zeros(1,1,np) zeros(1,1,np) ones(1,1,np)];
% Then R is reshaped to 3np x 3
R=[reshape(R(:,1,:),3*np,1) reshape(R(:,2,:),3*np,1) reshape(R(:,3,:),3*np,1)];


% Apply translation to samples
s=[reshape(repmat(s(:,1)',3,1),3*np,1) reshape(repmat(s(:,2)',3,1),3*np,1) ones(np*3,1)];
s1=reshape(sum(T.*s,2),3,np);

% Apply rotation to samples
s=[reshape(repmat(s1(1,:),3,1),3*np,1) reshape(repmat(s1(2,:),3,1),3*np,1) ones(np*3,1)];
s1=reshape(sum(R.*s,2),3,np)';


if (u(1)==1)            % Sigmoid oriented on the x axis
    s2=s1(:,1);
else                    % Sigmoid oriented on the y axis
    s2=s1(:,2);
end

y=1./(1+exp(-b.*s2));

