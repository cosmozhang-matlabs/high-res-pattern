function [ img ] = draw_text( in_img, position, content, varargin )

fontsize = 12;
anchorpointtext = 'LeftTop';

for i = 1:max(size(varargin))
    key = varargin{i};
    if strcmpi(key,'AnchorPoint')
        i = i+1;
        anchorpointtext = varargin{i};
    elseif strcmpi(key,'FontSize')
        i = i+1;
        fontsize = varargin{i};
    end
end

anchorpoint = [0 0]; % 0:left|1:center|2:right   0:top|1:center|2:bottom
if strcmpi(anchorpointtext, 'LeftTop')
    anchorpoint = [0,0];
elseif strcmpi(anchorpointtext, 'CenterTop')
    anchorpoint = [0,0];
elseif strcmpi(anchorpointtext, 'RightTop')
    anchorpoint = [0,0];
elseif strcmpi(anchorpointtext, 'LeftCenter')
    anchorpoint = [0,0];
elseif strcmpi(anchorpointtext, 'Center')
    anchorpoint = [0,0];
elseif strcmpi(anchorpointtext, 'RightCenter')
    anchorpoint = [0,0];
elseif strcmpi(anchorpointtext, 'LeftBottom')
    anchorpoint = [0,0];
elseif strcmpi(anchorpointtext, 'CenterBottom')
    anchorpoint = [0,0];
elseif strcmpi(anchorpointtext, 'RightBottom')
    anchorpoint = [0,0];
end

img = in_img;
nchan = ndims(img);
if nchan ~= 3
    img = repmat(img,[1,1,3]);
end

if fontsize < 72
    img = insertText(img, position, content, 'BoxOpacity', 0, 'AnchorPoint', anchorpointtext, 'FontSize', fontsize);
else
    fontmask = repmat(zeros(72,size(img,2)) + 255, [1,1,3]);
    fontmask = insertText(fontmask, [0,0], content, 'BoxOpacity', 0, 'AnchorPoint', anchorpointtext, 'FontSize', 72);
    fontmaskpos = find(sum(255-fontmask(:,:,1),1) > 0);
    left = fontmaskpos(1);
    right = fontmaskpos(end);
    fontmask = fontmask(:,left:right,:);
    fontmask = imresize(fontmask, double(fontsize)/72);
    fmsize = size(fontmask);
    sp = [0 0];
    if anchorpoint(1) == 0
        sp(2) = position(1);
    elseif anchorpoint(1) == 1
        sp(2) = position(1) - fmsize + 1;
    elseif anchorpoint(1) == 2
        sp(2) = position(1) - ceil(fmsize/2) + 1;
    end
    if anchorpoint(2) == 0
        sp(1) = position(2);
    elseif anchorpoint(2) == 1
        sp(1) = position(2) - fmsize + 1;
    elseif anchorpoint(2) == 2
        sp(1) = position(2) - ceil(fmsize/2) + 1;
    end
    for i = 1:fmsize(1)
        for j = 1:fmsize(2)
            for k = 1:3
                if fontmask(i,j,k) < 255
                    img(sp(1)+i-1,sp(2)+j-1,k) = fontmask(i,j,k);
                end
            end
        end
    end
end

if nchan == 2
    img = img(:,:,1);
end

end

