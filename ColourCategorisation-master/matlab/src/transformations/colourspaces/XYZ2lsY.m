function lsY = XYZ2lsY(XYZ, choice)
%This function attempts to make sense of the multitude of XYZ-LMS space
%transfromations. They are all derived form the xyz colour matching
%functions and the lms cone sensitivity mechanisms, using external
%hypothesis such as the Konig hypothesis (confusion points arise from the
%lack of one of the cone receptor types) and some others (see below). Some
%transformations produce very small S values (this seems to be quite
%arbitrary) while others are normalised to produce equal responses to D65
%light, etc.

if nargin < 2
  choice = 'macleod-boynton1986'; %this is the flavour of the day
end
choice = lower(choice);
switch choice
  case 'wyszecki-stiles'
    % Taken from G. Wyszecki and W.S. Stiles, "Color Science: Concepts and
    % Methods, Quantitative Data and Formulate", 2nd ed., John Wiley and Sons,
    % New York, 1982.
    T = ...
      [
      0.3897  0.6890 -0.0787;
      -0.2298 1.1834 0.0464;
      0       0      1;
      ];
  case 'hpe'
    % Hunt-Pointer-Estevez transformation from cone
    % to XYZ, normalized for D65 (LMS=[100 100 100] for D65).
    T = ...
      [
      0.4002  0.7076 -0.0808;
      -0.2263 1.1653 0.0457;
      0       0      0.9182;
      ];
  case 'macleod-boynton1986'
    %This matrix defined the Boynton Space fundamentals.
    %Assumes the following condition:
    %L(498)+M(498)=S(498)
    %S-values are scaled so that S/(L+M)=1 for an equal energy white
    %(or a monochromatic light of 498 nm)
    T = ...
      [
      0.15516  0.54308 -0.03287;
      -0.15516 0.45692 0.03287;
      0        0       1.0066;
      ];
  case 'vos-valraven'
    %Includes the condition that Y= L+M+S
    %XYZ is derived from the Judd-modified CIE 2-deg color matching
    %functions (1951)
    T = ...
      [
      0.15516  0.54308 -0.03702;
      -0.15516 0.45692 0.02969;
      0        0       0.00732;
      ];
  case 'smith-pokorny'
    %They include the condition that Y = L+M
    %They also include following consitions on the cone fundamentals:
    %L(570)- 2*M(570)= 0;
    %L(475.5)+M(475.5) = 16*S(475.5);
    %which were based on the invariant hues observed by Valraven (1961)
    T = ...
      [
      0.15514  0.54312 -0.03286;
      -0.15514 0.45684 0.03286;
      0        0       0.00801;
      ];
  case 'macleod-boynton1979'
    %They assume the condition that
    %L(400)+M(400)=S(400)
    % and XYZ is derived from the Judd-modified CIE 2-deg color matching
    %functions (1951)
    T = ...
      [
      0.15514  0.54312 -0.03286;
      -0.15514 0.45684 0.03286;
      0        0       0.01608;
      ];
  case 'evenly_ditributed_stds'
    %This option uses the same parameters as Mcleod-Boynton except for
    %the s-scaling parameter (last number in the matrix) which has been
    %calculated so that the variance in the s/(l+m) axis is equal to the
    %variance in the l/(l+m) axis for the categorization of achromatic
    %patches.
    T = ...
      [
      0.15516  0.54307 -0.03287;
      -0.15516 0.45692 0.03287;
      0        0       0.05930;
      ];
  otherwise
    error('Transfromation matrix poorly specified');
end

[n, m, p] = size(XYZ);

if p == 3
  XYZ = reshape(XYZ, n * m, p);
end

LMS = XYZ * T';

lsY = LMS2lsY(LMS);

% TODO: choose the scale more accurately trying to rescale l and s to be similar to Y
lsY(:, 1:2) = lsY(:, 1:2) * 100;

lsY = reshape(lsY, n, m, p);

end
