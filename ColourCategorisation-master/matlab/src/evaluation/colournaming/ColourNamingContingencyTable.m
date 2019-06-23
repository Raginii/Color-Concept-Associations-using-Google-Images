function [] = ColourNamingContingencyTable(DirPath, method)

if nargin < 2
  DirPath = '/home/arash/Software/Repositories/neurobit/data/dataset/ColourNameDataset/ebay/';
  method = 'our';
end

method = lower(method);
disp(['Reading results for method ', method]);

SubFolders = GetSubFolders(DirPath);

nSubFolder = length(SubFolders);
ErrorMatsAll = zeros(nSubFolder, 8);
for j = 1:nSubFolder
  DirPathJ = [DirPath, SubFolders{j}, '/'];
  
  SubSubFolders = GetSubFolders(DirPathJ);
  nSubSubFolder = length(SubSubFolders);
  
  ErrorMatsCat = zeros(nSubSubFolder, 8);
  for k = 1:nSubSubFolder
    DirPathJK = [DirPathJ, SubSubFolders{k}, '/'];
    ResultDirectory = [DirPathJK, method, '_results/'];
    FolderResultMat = load([ResultDirectory, 'ErrorMats.mat']);
    nimages = length(FolderResultMat.ErrorMats);
    CurrentErrorMat = zeros(nimages, 8);
    for l = 1:nimages
      CurrentErrorMat(l, :) = struct2array(FolderResultMat.ErrorMats{l});
    end
    ErrorMatsCat(k, :) = mean(CurrentErrorMat, 1);
  end
  ErrorMatsAll(j, :) = mean(ErrorMatsCat, 1);
  fprintf('%s\t- Sensitivity: %0.2f Specificity %0.2f Positive predictive %0.2f Negative predictive %0.2f\n', SubFolders{j}, ErrorMatsAll(j, :));
  SaveResults(DirPathJ, method, ErrorMatsCat);
end
SaveResults(DirPath, method, ErrorMatsAll);

fprintf('All\t- Sensitivity: %0.2f Specificity %0.2f Positive predictive %0.2f Negative predictive %0.2f\n', mean(ErrorMatsAll, 1));

end

function [] = SaveResults(DirPathJ, method, ErrorMats) %#ok

save([DirPathJ, method, 'ErrorMats.mat'], 'ErrorMats');

end
