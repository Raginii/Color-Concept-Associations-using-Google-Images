function IsInBorderLine = BorderLine(x)
%BORDERLINE Summary of this function goes here
%   Detailed explanation goes here

IsInBorderLine = 0;

if x(5) == 1 && ismember(2, x)
  IsInBorderLine = 1;
elseif x(5) == 2 && ismember(1, x)
  IsInBorderLine = 2;
end

end
