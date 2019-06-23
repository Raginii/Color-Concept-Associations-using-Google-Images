function ChipsTable = WcsResults(sources)
%WcsResults  the colour naming results of different articles on Munsell.
%
% Inputs
%   sources  the desired articles.
%
% Outputs
%   ChipsTable  the probability map of each colour in 10x41x11 matrix.
%

if nargin < 1
  sources = {'berlin', 'sturges', 'joost', 'robert', 'arash'};
end

ChipsTable = 0;

sources = lower(sources);
nsources = length(sources);
for i = 1:nsources;
  switch sources{i}
    case {'berlin'}
      TmpTable = BerlinKayColourBoundries(true);
      TmpTable(TmpTable > 0) = 1;
      ArashTable = ArashColourBoundries();
      TmpTable([1, 10], 2:41, 9:11) = ArashTable([1, 10], 2:41, 9:11);
      ChipsTable = ChipsTable + TmpTable;
    case {'sturges'}
      TmpTable = SturgesWhitfielColourBoundries();
      TmpTable(TmpTable > 0) = 1;
      ArashTable = ArashColourBoundries();
      TmpTable([1, 10], 2:41, 9:11) = ArashTable([1, 10], 2:41, 9:11);
      ChipsTable = ChipsTable + TmpTable;
    case {'joost'}
      ChipsTable = ChipsTable + ColourNamingTestImage(WcsChart(), 'joost', 0);
    case {'robert'}
      ChipsTable = ChipsTable + ColourNamingTestImage(WcsChart(), 'robert', 0);
    case {'arash'}
      ChipsTable = ChipsTable + ArashColourBoundries();
    otherwise
      disp(['Wrong category: ', sources{i}]);
  end
end

ChipsTable = ChipsTable / nsources;

end
