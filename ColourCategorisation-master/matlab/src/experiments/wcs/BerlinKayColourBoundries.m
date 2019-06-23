function ChipsTable = BerlinKayColourBoundries(ConvertToEllipsoidColours)
%BerlinKayColourBoundries Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1
  ConvertToEllipsoidColours = false;
end

FunctionLocalPath = 'matlab/src/experiments/wcs/BerlinKayColourBoundries';
FunctionPath = mfilename('fullpath');
TermsPath = strrep(FunctionPath, FunctionLocalPath, 'data/ColourNaming/WCS-Data-20110316/BK-term.txt');
DicPath = strrep(FunctionPath, FunctionLocalPath, 'data/ColourNaming/WCS-Data-20110316/BK-dict.txt');
ChipsTablePath = strrep(FunctionPath, FunctionLocalPath, 'data/ColourNaming/WCS-Data-20110316/cnum-vhcm-lab-new.txt');

WcsTerms = tdfread(TermsPath);
WcsDic = tdfread(DicPath);
WcsChips = tdfread(ChipsTablePath);

ColourTerms = WcsColourTerms(WcsTerms, 6);
LanguageDic = WcsLanguageDic(WcsDic, 6);

nchips = size(WcsChips.x0x23cnum, 1);
ChipsColours = zeros(nchips, 11);

nexperiments = size(ColourTerms, 1);

ChipNumbers = WcsChips.x0x23cnum;
for i = 1:nexperiments
  index = ~cellfun('isempty', strfind(LanguageDic(:, 2), ColourTerms{i, 4}));
  ColourIndex = LanguageDic{index, 3};
  ChipIndex = ColourTerms{i, 3};
  ChipsColours(ChipNumbers == ChipIndex, ColourIndex) = ChipsColours(ChipIndex, ColourIndex) + 1;
end

% NOTE: it seems there are few mistakes in the txt file that are two times
% written.
ChipsColours(ChipsColours == 2) = 1;

ChipsTable = WcsChipsTable(WcsChips, ChipsColours);

if ConvertToEllipsoidColours
  EllipsoidDicMatPath = strrep(FunctionPath, FunctionLocalPath, 'matlab/data/mats/EllipsoidDic.mat');
  EllipsoidDicMat = load(EllipsoidDicMatPath);
  
  ChipsTableTmp = ChipsTable;
  for i = 1:11
    ChipsTable(:, :, EllipsoidDicMat.wcs2ellipsoid(i)) = ChipsTableTmp(:, :, i);
  end
end

% NOTE: I think by mistake in the txt files these are lablled as orange,
% however in the paper they are not labelled as orange.
ChipsTable(7:9, 9, 6) = 0;

% green
ChipsTable(6:7, 18, 1) = 1;

% blue
ChipsTable(6:7, 28:30, 2) = 1;

% purple
ChipsTable(8:9, 36, 3) = 1;

% pink
ChipsTable(4:5, 39, 4) = 1;

% red
ChipsTable(7:8, 4, 5) = 1;

% orange
ChipsTable(6, 5, 6) = 1;

% yellow
ChipsTable(3, 10, 7) = 1;

% brown
ChipsTable(9, 6:8, 8) = 1;

% grey
ChipsTable(6, 1, 9) = 1;

% white
ChipsTable(1:2, 1, 10) = 1;

% black
ChipsTable(10, 1, 11) = 1;

% calculating the distances
d = 0.05;

[rows, cols, ~] = size(ChipsTable);

for i = 1:8
  GradientMap = brushfire(ChipsTable(2:rows-1, 2:cols, i), 8, true, false);
  GradientMap(GradientMap > 0) = 1 - (GradientMap(GradientMap > 0) - 1) * d;
  ChipsTable(2:rows-1, 2:cols, i) = GradientMap;
end

end

function ColourTerms = WcsColourTerms(WcsTerms, LanguageNumber)

lterms = size(WcsTerms.x1, 1);
ColourTerms = cell(lterms, 4);
ColourTerms(:, 1) = num2cell(WcsTerms.x1);
ColourTerms(:, 2) = num2cell(WcsTerms.x11, [2, lterms]);
ColourTerms(:, 3) = num2cell(WcsTerms.x12, [2, lterms]);
ColourTerms(:, 4) = num2cell(WcsTerms.AZ, [2, lterms]);

if ~isempty(LanguageNumber)
  indeces = cellfun(@(x) x == LanguageNumber, ColourTerms(:, 1), 'UniformOutput', 1);
  ColourTerms = ColourTerms(indeces, :);
end

end

function LanguageDic = WcsLanguageDic(WcsDic, LanguageNumber)

ldic = size(WcsDic.x0x23lnum, 1);
LanguageDic = cell(ldic, 3);
LanguageDic(:, 1) = num2cell(WcsDic.x0x23lnum);
LanguageDic(:, 2) = num2cell(WcsDic.abbr, [2, ldic]);
for i = 1:ldic
  LanguageDic(i, 3) = num2cell(str2double(WcsDic.tnum(i, :)));
end

if ~isempty(LanguageNumber)
  indeces = cellfun(@(x) x == LanguageNumber, LanguageDic(:, 1), 'UniformOutput', 1);
  LanguageDic = LanguageDic(indeces, :);
end

end

function ChipsTable = WcsChipsTable(WcsChips, ChipsColours)

nchips = size(WcsChips.x0x23cnum, 1);
ChipsTable = zeros(10, 41, 11);

% NOTE: the current file only has one number per colour.
% converting the results to percentage
% for i = 1:nchips
%   MaxAll = max(ChipsColours(i, :));
%   if MaxAll > 0
%     ChipsColours(i, :) = ChipsColours(i, :) ./ MaxAll;
%   else
%     ChipsColours(i, :) = 0;
%   end
% end
ChipsColours = ChipsColours .* 2;

x = 2;
y = 1;
ChipsTable(1, 1, :) = ChipsColours(1, :);
for i = 2:nchips
  ChipsTable(x, y, :) = ChipsColours(i, :);
  y = y + 1;
  if y == 42
    y = 1;
    x = x + 1;
  end
end

end
