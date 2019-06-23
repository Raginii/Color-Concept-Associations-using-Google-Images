function OutputMat = MatRowsColsRepeat(InputMat, scale)
%MatRowsColsRepeat repeats rows and cols of a matrix N times.
%
% Inputs
%   InputMat  the input matrix to be scaled.
%   scale     the number of times each row and column to be repeated.
%
% Outputs
%   OutputMat  the scaled matrix.
%

[rows, cols, chns] = size(InputMat);
OutputMat = zeros(rows * scale, cols * scale, chns);

for i = 1:chns
  chn1 = kron(InputMat(:, :, i), ones(1, scale));
  OutputMat(:, :, i) = kron(chn1, ones(scale, 1));
end

end
