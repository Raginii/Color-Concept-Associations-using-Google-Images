function contingency = ColourNamingComputeError(ImageMask, NamingImage, ColourName)

if strcmp(ColourName, 'all')
  ColourNames = {'green', 'blue', 'purple', 'pink', 'red', 'orange', 'yellow', 'brown', 'grey', 'white', 'black'};
  contingency = struct();
  for i = 1:numel(ColourNames)
    CurrentImageMask = ImageMask(:, :, 1) == i;
    contingency.(ColourNames{i}) = DoContingencyOneColour(CurrentImageMask, NamingImage, ColourNames{i});
  end
else
  contingency = DoContingencyOneColour(ImageMask, NamingImage, ColourName);
end

end

function contingency = DoContingencyOneColour(ImageMask, NamingImage, ColourName)

ColourName = lower(ColourName);

switch ColourName
  case {'g', 'green'}
    ImageResult = NamingImage == 1;
  case {'b', 'blue'}
    ImageResult = NamingImage == 2;
  case {'pp', 'purple'}
    ImageResult = NamingImage == 3;
  case {'pk', 'pink'}
    ImageResult = NamingImage == 4;
  case {'r', 'red'}
    ImageResult = NamingImage == 5;
  case {'o', 'orange'}
    ImageResult = NamingImage == 6;
  case {'y', 'yellow'}
    ImageResult = NamingImage == 7;
  case {'br', 'brown'}
    ImageResult = NamingImage == 8;
  case {'gr', 'grey'}
    ImageResult = NamingImage == 9;
  case {'w', 'white'}
    ImageResult = NamingImage == 10;
  case {'bl', 'black'}
    ImageResult = NamingImage == 11;
  otherwise
    warning(['Colour ', ColourName, ' is not supported, returning -1 for error mat.']);
    return;
end

contingency = ContingencyTable(ImageMask, ImageResult);

end
