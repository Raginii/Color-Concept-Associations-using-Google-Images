function FrontierTable = LuminanceFrontiers()
%LuminanceFrontiers the luminance frontiers of the experiment
%   New borders can be added to this table, the experiment generates
%   borders based on the values in this table.
%
% Inputs
%
% Outputs
%   FrontierTable  each row contains one frontier to be tested.
%

FrontierTable = ...
  {
  %colour1     colour2      a       b       lum1     lum2
  'Black',     'Grey',      0.5,    0.5,    0.00,    0.50;
  'Grey',      'White',     0.5,    0.5,    0.50,    1.00;
  'Brown',     'Red',       1.0,    0.5,    0.00,    0.50;
  'Red',       'Pink',      1.0,    0.5,    0.30,    1.00;
  'Brown',     'Orange',    0.5,    1.0,    0.40,    0.80;
  'Orange',    'Yellow',    0.5,    1.0,    0.70,    1.00;
  
  % maybe
  %   'Red',       'Orange',    1.0,    1.0,    0.50,    1.00;
  %   'Brown',     'Green',     0.5,    1.0,    0.10,    1.00;
  %   'Green',     'Yellow',    0.5,    1.0,    0.10,    1.00;
  %   'Green',     'Blue',      0.5,    1.0,    0.10,    1.00;
  %   'Purple',    'Pink',      1.0,    0.5,    0.50,    0.75;
  };

end
