function [PlaneHistograms, BorderNames] = PlotPlaneHistogram(ColourFrontiers, luminance)
%PlotPlaneHistogram Summary of this function goes here
%
% inputs
%   ColourFrontiers  colour frontiers in the lab space
%   luminance        the desired luminance plane.
%
% outputs
%   PlaneHistograms  the histograms of each frontiers.
%   BorderNames      name of frontiers.
%

ColourNames = fieldnames(ColourFrontiers);

BorderNames = cell(0, 0);
PlaneHistograms = zeros(0, 0);

for i = 1:numel(ColourNames)
  CurrentColour = ColourFrontiers.(ColourNames{i});
  CurrentBorderNames = CurrentColour.GetNeighbourNames(luminance);
  for j = 1:length(CurrentBorderNames)
    if isempty(BorderNames)
      DuplicateBorder = false;
    else
      PreviousBorders = ~cellfun('isempty', strfind(BorderNames(:, 2), ColourNames{i}));
      if ~PreviousBorders
        DuplicateBorder = false;
      else
        DuplicateBorder = ~cellfun('isempty', strfind(BorderNames(PreviousBorders, 1), CurrentBorderNames{j}));
      end
    end
    if ~DuplicateBorder
      PlaneHistograms(end + 1, :) = PlotFrontierHistogram(CurrentColour.GetBorderWithColour(luminance, CurrentBorderNames{j})); %#ok
      BorderNames(end + 1, :) = {ColourNames{i}, CurrentBorderNames{j}}; %#ok
    end
  end
end

end
