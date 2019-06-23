function mypic = lms2opponency(LMSimage, map_type, show)
% This function creates opponent representations from the LMS values. It
% uses the following definitions of opponent channels:

%Lum = L+M
%Red-green = (L-M) / (Lum)
%Blue-Yellow = (S - (Lum/2)) / (S + (Lum/2))

% it accepts the following parameters:
% 1- map_type controls the output, which can be 'l', 'm', 's', 'lum', 'r-g'
% or 'b-y' according to the wishes of the user.
% 2- show controls the graphic output showing a composite image of all the
% channels, just the output or nothing.


if nargin < 3
  show = 'noshow';
end

inv_Gamma = 1/2.2;

[ydim, xdim] = size(LMSimage);

minv =min(LMSimage(:));
maxv = max(LMSimage(:));
pict = LMSimage;
%pict=(LMSimage-minv)/(maxv-minv);

%These weights were obtained using the conditions stated in my PhD thesis
%see details in:

% D:\Camera calibration\cone sensitivities\Stockman and Sharpe (2000) 2-deg cone sensitivities in 1nm steps.xls

MLB_weights = [0.659, 1, 5.315];
LMSimage(:,:,1) = LMSimage(:,:,1).* MLB_weights(1);
LMSimage(:,:,3) = LMSimage(:,:,3).* MLB_weights(3);

switch lower(map_type)
  case 'lum'        % Luminance
    mypic(:,:,1) = pict(:,:,1) + pict(:,:,2) ;
  case 'l'    %  red
    mypic = pict(:,:,1);
  case 'm'        %  green
    mypic = pict(:,:,2);
  case 's'        %  blue
    mypic = pict(:,:,3);
  case 'r-g'        %  green-red opponent
    mypic = (pict(:,:,1) - pict(:,:,2))./(pict(:,:,1) + pict(:,:,2));
    %mypic = (mypic - min(mypic(:)))./(max(mypic(:))-min(mypic(:)));
  case 'b-y'        % Yellow - blue opponent
    mypic = (pict(:,:,3) - (pict(:,:,1)+ pict(:,:,2))./2) ./(pict(:,:,3) + (pict(:,:,1)+pict(:,:,2))./2);
    %mypic = (mypic - min(mypic(:)))./(max(mypic(:))-min(mypic(:)));
  otherwise
    error('Option not supported');
end

switch lower(show)
  case 'show_all'
    figure;
    title('LMS and Opponent Channels');
    pict(1,1,:) = 1;
    pict(1,2,:) = 0;
    %axis equal
    axis([1 ydim 1 xdim]);
    subplot(2,3,1);
    imagesc(pict(:,:,1).^inv_Gamma); colormap(gray);
    title('Plane L');
    
    subplot(2,3,2);
    imagesc(pict(:,:,2).^inv_Gamma); colormap(gray);
    title('Plane M');
    
    subplot(2,3,3);
    imagesc(pict(:,:,3).^inv_Gamma); colormap(gray);
    title('Plane S');
    
    rgb = LMSimage(:,:,1)+LMSimage(:,:,2);
    rg = (LMSimage(:,:,1) - LMSimage(:,:,2))./rgb;
    by = (LMSimage(:,:,3) - rgb ./2) ./(LMSimage(:,:,3) + rgb ./2);
    
    rg = (rg - min(rg(:)))./(max(rg(:))-min(rg(:)));
    by = (by - min(by(:)))./(max(by(:))-min(by(:)));
    
    
    subplot(2,3,4);
    imagesc((rgb).^inv_Gamma); colormap(gray);
    title('Luminance');
    
    rg_rep = zeros(size(LMSimage));
    rg_rep(:,:,1) = rg;
    rg_rep(:,:,2) = max(rg(:)) - rg;
    rg_rep(:,:,3) = 0;
    subplot(2,3,5);
    image(((rg_rep - min(rg_rep(:)))./(max(rg_rep(:))-min(rg_rep(:)))).^inv_Gamma);
    title('Red-Green');
    
    by_rep = zeros(size(LMSimage));
    by_rep(:,:,1) = max(by(:)) - by;
    by_rep(:,:,2) = by_rep(:,:,1);
    by_rep(:,:,3) = by;
    subplot(2,3,6);
    image(((by_rep - min(by_rep(:)))./(max(by_rep(:))-min(by_rep(:)))).^inv_Gamma);
    title('Blue-Yellow');
  case 'show_one'
    imagesc(mypic); colormap(gray);
    axis equal;
    axis([1 xdim 1 ydim]);
    drawnow;
end

end
