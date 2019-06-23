function [FrontierTableLumX, conditions] = GetExperimentConditions(FrontierTable, ExperimentParameters)

luminance = ExperimentParameters.which_level;
nconditions = ExperimentParameters.numcolconditions;

if strcmp(luminance, 'all')
  FrontierTableLumX = FrontierTable;
else
  indeces = false(size(FrontierTable, 1), 1);
  for i = 1:length(luminance)
    indeces = indeces | ~cellfun('isempty', strfind(FrontierTable(:, 1), luminance{i}));
  end
  FrontierTableLumX = FrontierTable(indeces, :);
end

nfrontiers = size(FrontierTableLumX, 1);

conditions = zeros(1, nconditions * nfrontiers);
for i = 1:nconditions
  j = (i - 1) * nfrontiers;
  indeces = (j + 1):(j + nfrontiers);
  conditions(indeces) = ShuffleVector(1:nfrontiers);
end

end
