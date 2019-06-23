function lms = xyz2lms(xyz, norm)
%XYZ2LMS  transforms XYZ colour space to LMS one.
% transforms from the Judd-Vos-modified CIE 2-deg color matching functions (XYZ) into
% the Smith and Pokorny (1975) cone fundamentals (LMS)
% norm defines the normalisation applied to the LMS fundamentals
%
%
% Revision History...
%
% V 1.0001      8th October 2004
%
% PGL : Added a 'getoptions' argument to the norm switchyard. Use xyztolms([], 'getoptions')
%       to retrieve the available normalisation vectors for the Smith and Pokorny LMS cone sensitivity functions...
%
% 'unity'           : normalisation is such that the max value is 1 for all fundamentals
%
% 'crossing'        : Normalisation is such that crossings occur near 505 nm for the
%                     blue and yellow and 580 for the red and green fundamentals
%
% 'crossingandarea' : This is an attempt to keep the areas the same while trying to
%                     consistent with the above. Not very good.
%
% 'none'          : Uses the unnormalised S&P LMS fundamentals.
% V 1.002 11th October 2004
%
% CAP : Mapping between the white locus in XYZ space and LMS space added instead of the 'crossingandarea' option
%       To do so I attempted to make the rows of transfromation matrix Trans multiplied by each coefficient of
%       Equaliser to add up to the same number. The label 'crossingandarea' is kept for consistency.
%

transformation = ...
  [
  +0.15514,	 0.54312,  -0.03286;
  -0.15514,  0.45684,  +0.03286;
  +0.00000,  0.00000,  +0.00801;
  ];

if nargin < 2
  norm = 'unity';
end

switch lower(norm)
  case 'unity'
    equaliser = [1.569459091, 2.551291018, 77.2253704]; % normalisation is such that the max value is 1 for all fundamentals
  case 'crossing'
    equaliser = [0.415460518,	1, 188.4430366];% normalisation is such that crossings occur near 505 nm for the
    % blue and yellow and 580 for the red and green fundamentals
  case 'crossingandwhitepoint'
    equaliser = [0.415460749, 1, 41.76786682]; % this is an attempt to map both white point locus while trying to
    % be consistent with the above. Not 100% accurate.
  case 'none'
    equaliser = [1, 1, 1]; % uses the unnormalised S&P LMS fundamentals.   
  case 'getoptions'
    lms = [];
    lms.names    = {};
    lms.tooltips = {};
    
    lms.names{1}    = 'crossingandwhitepoint';
    lms.tooltips{1} = 'A compromise between mapping the white locus while trying to be consistent with crossings.';
    
    lms.names{2}    = 'unity';
    lms.tooltips{2} = 'normalisation is such that the max value is 1 for all fundamentals';
    
    lms.names{3}    = 'crossing';
    lms.tooltips{3} = 'Normalisation is such that crossings occur near 505 nm for the blue and yellow and 580 for the red and green fundamentals';
    
    lms.names{4}    = 'none';
    lms.tooltips{4} = 'Uses the unnormalised S&P LMS fundamentals.';
    return;
  otherwise
    error(['Unrecognised argument (' norm ')']);
end


lms(:, :, 1) = (xyz(:, :, 1) .* transformation(1, 1) + xyz(:, :, 2) .* transformation(1, 2) + xyz(:, :, 3) .* transformation(1, 3)) .* equaliser(1);
lms(:, :, 2) = (xyz(:, :, 1) .* transformation(2, 1) + xyz(:, :, 2) .* transformation(2, 2) + xyz(:, :, 3) .* transformation(2, 3)) .* equaliser(2);
lms(:, :, 3) = (xyz(:, :, 1) .* transformation(3, 1) + xyz(:, :, 2) .* transformation(3, 2) + xyz(:, :, 3) .* transformation(3, 3)) .* equaliser(3);

lms = lms .* (lms > 0);

end
