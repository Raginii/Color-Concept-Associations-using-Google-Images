function [tested, meanlum] = sample_lab_space(CRS, numsamples, reference)
%reference is the reference illuminant in XYZ tristimulus coordinates

if nargin < 2
  White_CIE1931 = crsSpaceToSpace( CRS.CS_RGB , [1 1 1 ] , CRS.CS_CIE1931  , 0 );
  reference = whitepoint('d65')./max(whitepoint('d65')) .* White_CIE1931(3);
end

mylimits_lab = [100 60 60; 0 -60, -60];
mylimits_radial_max = 60;
mylimits_radial_min = 10;
tested = ones(numsamples,3).*-1;
testedcols = 0;
biasfactor = 0.068;
% sample colours
% To Generate a random distribution with a specific mean and variance, do this:
% multiply the output of randn by the standard deviation (sigma), and then add the
% desired mean. For example, to generate a 5-by-5 array of random numbers with
%a mean of .6 that are distributed with a variance of 0.1,
% x = .6 + sqrt(0.1) * randn(5)
% the distribuition is biased towards high luminances. I've found
% empirically that a meanlum of .135 delivers mean luminance values of 50.

while (numsamples>testedcols)
  proposed = zeros(numsamples-testedcols,3);
  proposed(:,1)  = 2*biasfactor + sqrt(0.1) * randn(numsamples-testedcols,1);
  proposed(:,2)  = 2*biasfactor + sqrt(0.1) * randn(numsamples-testedcols,1);
  proposed(:,3)  = 2*biasfactor + sqrt(0.1) * randn(numsamples-testedcols,1);
  
  for i=1:(numsamples-testedcols)
    [junkcolXYZ, ~]= crsSpaceToSpace( CRS.CS_RGB , proposed(i,:) , CRS.CS_CIE1931  , 0 );
    junkcol =xyz2lab(xyLum2XYZ(junkcolXYZ), reference);
    %              The crsSpaceToSpace function may return a colour vector that is not
    %               reproducable on the VSG display. If this is the case, then a
    %               negative ErrorCode will be returned. (i.e. ErrorCode<0).
    mod = sqrt(junkcol(2).^2+junkcol(3).^2);
    if  ((junkcol(1)<mylimits_lab(1,1)) && (junkcol(1)>mylimits_lab(2,1))&&...
        (mod<mylimits_radial_max) && (mod> mylimits_radial_min))
      errcode = 1;
    else
      errcode = 0;
    end
    
    if errcode %the colour is OK
      tested(testedcols+1,:) = junkcol;
      testedcols = testedcols+1;
    end
    
  end;
  
end
meanlum = mean(tested(:,1));
disp(['The mean luminace of the colour list is: ', num2str(meanlum)]);

% check that the luminances have the correct mean value

% meanlum_Lab =xyz2lab(xyLum2XYZ(White_CIE1931), reference);
%
% score =  mean(tested(:,1))./(meanlum_Lab(1).*meanlum);
%
% if  (score <(1-tolerance))||(score >(1+tolerance))
%
%     %correct the bias!!!!!!!!!!!!
%     disp('kk');
%     score
%     (meanlum_Lab(1).*meanlum)
% end

end
