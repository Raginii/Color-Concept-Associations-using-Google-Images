function PrintFittingResults(OptimisationOutput, ColourEllipsoid, RSS, ExitFlag, FittingDataStd)

switch ExitFlag
  case 1
    disp('fminsearch converged to a solution')
  case 0
    disp('Number of iterations exceeded options. MaxIter or number of function evaluations exceeded options.MaxFunEvals.');
  case -1
    disp('The algorithm was terminated by the output function');
end

disp (OptimisationOutput);
disp ('=======Results:=======');
disp (['centre (l,s,Y) = (', num2str(ColourEllipsoid(1)), ', ', num2str(ColourEllipsoid(2)), ', ', num2str(ColourEllipsoid(3)), ').']);
disp (['axes (a,b,c)   = (', num2str(ColourEllipsoid(4)), ', ', num2str(ColourEllipsoid(5)), ', ', num2str(ColourEllipsoid(6)), ').']);
disp (['rotation =  (', num2str(rad2deg(ColourEllipsoid(7))), ', ', num2str(rad2deg(ColourEllipsoid(8))), ', ', num2str(rad2deg(ColourEllipsoid(9))), ') deg.']);
disp (['RS1: ', num2str(RSS(1))]);
disp (['RS2: ', num2str(RSS(2))]);
disp (['RSS gain: ', num2str(RSS(1) - RSS(2))]);
disp (['Std Dev (l,s,Y) = (', num2str(FittingDataStd(1)), ', ', num2str(FittingDataStd(2)), ', ', num2str(FittingDataStd(3)), ')']);

end
