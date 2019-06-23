classdef ColourCategory
  %ColourCategory  wrapper for the colour class.
  
  properties
    name        % the english name of the colour.
    rgb         % the rgb value of the colour.
    borders     % the borders in the lsY space.
    neighbours  % name of the neighbours in different luminanse levels.
  end
  
  methods
    function obj = ColourCategory(name)
      obj.name = name;
      obj.rgb = name2rgb(name);
      obj.borders = [];
      obj.neighbours = struct();
    end
    
    function obj = AddBorder(obj, border)
      obj.borders = [obj.borders; border];
      obj = obj.AddNeighbour(border);
    end
    
    function obj = AddNeighbour(obj, border)
      ColourA = border.colour1.name;
      ColourB = border.colour2.name;
      if ~strcmpi(ColourA, obj.name)
        NeighbourName = ColourA;
      else
        NeighbourName = ColourB;
      end
      luminances = fieldnames(border.points);
      for i = 1:numel(luminances)
        if ~isempty(border.points.(luminances{i}))
          lumnum = str2double(luminances{i}(4:end));
          if ~isfield(obj.neighbours, NeighbourName)
            obj.neighbours.(NeighbourName) = [];
          end
          obj.neighbours.(NeighbourName) = unique([obj.neighbours.(NeighbourName), lumnum]);
        end
      end
    end
    
    function obj = SetBorder(obj, border)
      ColourA = border.colour1.name;
      ColourB = border.colour2.name;
      for i = 1:length(obj.borders)
        colour1 = obj.borders(i).colour1.name;
        colour2 = obj.borders(i).colour2.name;
        if (strcmpi(colour1, ColourA) || strcmpi(colour1, ColourB)) && ...
            (strcmpi(colour2, ColourA) || strcmpi(colour2, ColourB))
          obj.borders(i) = border;
          obj = obj.AddNeighbour(border);
          return;
        end
      end
    end
    
    function borders = GetBorder(obj, luminance)
      borders = [];
      for i = 1:length(obj.borders)
        for j = 1:length(luminance)
          LumName = ['lum', num2str(luminance(j))];
          if isfield(obj.borders(i).points, LumName)
            borders = [borders; obj.borders(i).points.(LumName)]; %#ok<AGROW>
          end
        end
      end
    end
    
    function borders = GetBorderWithColour(obj, luminance, colour)
      borders = [];
      for i = 1:length(obj.borders)
        colour1 = obj.borders(i).colour1.name;
        colour2 = obj.borders(i).colour2.name;
        if strcmpi(colour1, colour) || strcmpi(colour2, colour)
          for j = 1:length(luminance)
            LumName = ['lum', num2str(luminance(j))];
            if isfield(obj.borders(i).points, LumName)
              borders = [borders; obj.borders(i).points.(LumName)]; %#ok<AGROW>
            end
          end
        end
      end
    end
    
    function borders = GetAllBorders(obj)
      borders = [];
      for i = 1:length(obj.borders)
        luminance = fieldnames(obj.borders(i).points);
        for j = 1:numel(luminance)
          borders = [borders; obj.borders(i).points.(luminance{j})]; %#ok<AGROW>
        end
      end
    end
    
    function NeighbourNames = GetNeighbourNames(obj, luminance)
      AllNeighbourNames = fieldnames(obj.neighbours);
      NeighbourNames = cell(0);
      for i = 1:numel(AllNeighbourNames)
        if sum(obj.neighbours.(AllNeighbourNames{i}) == luminance)
          NeighbourNames{end + 1} =  AllNeighbourNames{i}; %#ok<AGROW>
        end
      end
    end
    
    function [] = PlotBorders(obj)
      for i = 1:length(obj.borders)
        obj.borders(i).PlotBorders();
      end
    end
  end
  
end
