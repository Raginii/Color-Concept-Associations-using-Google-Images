classdef ColourBorder
  %ColourBorder  wrapper for the colour border class.
  
  properties
    colour1  % on side of the border
    colour2  % other side of the border
    points   % the points defining the border
    rgb      % rgb value of border for plotting
  end
  
  methods
    function obj = ColourBorder(colour1, colour2, points, luminances)
      obj.colour1 = colour1;
      obj.colour2 = colour2;
      obj.rgb = (obj.colour1.rgb + obj.colour2.rgb) / 2;
      obj.points = struct();
      for i = 1:length(luminances)
        obj.points.(['lum', num2str(luminances(i))]) = points(:, :, i);
      end
    end
    
    function obj = AddPoints(obj, points, luminances)
      for i = 1:length(luminances)
        lumi = ['lum', num2str(luminances(i))];
        CurrentPoints = [];
        if isfield(obj.points, lumi)
          CurrentPoints = obj.points.(lumi);
        end
        obj.points.(lumi) = [CurrentPoints; points(:, :, i)];
      end
    end
    
    function [] = PlotBorders(obj)
      luminances = fieldnames(obj.points);
      for i = 1:numel(luminances)
        obj.PlotBorderLuminance(luminances{i});
      end
    end
    
    function [] = PlotBorderLuminance(obj, luminance)
      p = obj.points.(luminance);
      if ~isempty(p)
        plot3(p(:, 1), p(:, 2), p(:, 3), '.', 'color', obj.rgb);
      end
    end
  end
  
end
