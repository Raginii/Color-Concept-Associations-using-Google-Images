function listofsquares = GenerateMondrianSquares(Image_Parameters, Mondrian_Parameters)
%   Given one image and one set of features return a list of
%   squares, specificating location and half size lenght for each axe.
%
%   INPUT:  Argument description:
%   Image_Parameters: Structure with fields: width,height,center.
%   Mondrian_Parameters: Structure with fields:
%       squares_number : number of squares.
%       squares_meansize: inicial meansize of the squares.
%       first_level_rate: big number of squares over squares_number
%       second_level_rate: medium number of squares over squares_number
%       third_level_rate: small number of squares over squares_number
%
%   OUTPUT:
%   The resulting listofsquares is arranged as follows:
%   for each square: posx posy sizex sizey

%   Parameters:
first_level_rate = 1.0;
second_level_rate = 0.5;   %rate of square size reduction between frist and second level.
third_level_rate = 0.5;    %rate of square size reduction between second and third level.

listofsquares = [];

% first level
listofsquares = MondrianSquaresLevelX(listofsquares, Image_Parameters, Mondrian_Parameters, Mondrian_Parameters.first_level_rate, first_level_rate);

% second level
listofsquares = MondrianSquaresLevelX(listofsquares, Image_Parameters, Mondrian_Parameters, Mondrian_Parameters.second_level_rate, second_level_rate);

% third level
listofsquares = MondrianSquaresLevelX(listofsquares, Image_Parameters, Mondrian_Parameters, Mondrian_Parameters.third_level_rate, third_level_rate);

end

function listofsquares = MondrianSquaresLevelX(listofsquares, Image_Parameters, Mondrian_Parameters, levelrate, meanrate)

%   Number of squares.
number_of_elements = floor(Mondrian_Parameters.SquareNumber * levelrate);
%   Squares size.
meansize = Mondrian_Parameters.MeanSize * meanrate;
%   Square Size Rank.
a = meansize / 2;
b = meansize * 2;

Sizes = round(a + (b - a) * rand(number_of_elements, 2));
%   Square Position.
Centers_x = round(0 + (Image_Parameters.Width - 0) * rand(number_of_elements, 1));
Centers_y = round(0 + (Image_Parameters.Height - 0) * rand(number_of_elements, 1));
%   Final List.
listofsquares = [listofsquares; Centers_x, Centers_y, Sizes];

end
