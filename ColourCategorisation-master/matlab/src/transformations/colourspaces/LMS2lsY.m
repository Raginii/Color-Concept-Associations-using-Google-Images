function lsY = LMS2lsY(LMS)

[n, m, p] = size(LMS);
lsY = zeros(n, m, p);

if p == 1
  %LMS = LMS + repmat([realmin realmin realmin], n, 1);
  for i = 1:n
    lsY(i, 3) = sum(LMS(i, 1:2)) + 1e-10; % to avoid division by 0
    lsY(i, 1) = LMS(i, 1) ./ lsY(i, 3);
    lsY(i, 2) = LMS(i, 3) ./ lsY(i, 3);
    %LMS(i,2);
  end
elseif p == 3
  %LMS = LMS + repmat(realmin, [n, m, p]);
  lsY(:, :, 3) = LMS(:, :, 1) + LMS(:, :, 2) + 1e-10; % to avoid division by 0;
  lsY(:, :, 1) = LMS(:, :, 1) ./ lsY(:, :, 3);
  lsY(:, :, 2) = LMS(:, :, 3) ./ lsY(:, :, 3);
else
  error('Wrong number of planes')
end

% TODO: there are many NaNs, what shall we do?
lsY(isnan(lsY)) = 0;

end
