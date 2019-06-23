function shuffled = ShuffleVector(ordered)
%ShuffleVector shuffles the data in the input vector.
%
% Inputs
%   ordered  the input vector.
%
% Outputs
%   shuffled  the shuffled version of input vector, with the same size.
%

ordsize = length(ordered);
shuffled = zeros(size(ordered));

permut = randperm(ordsize);
for i = 1:ordsize
  shuffled(i) = ordered(permut(i));
end

end
