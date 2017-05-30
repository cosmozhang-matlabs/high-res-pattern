function [  ] = do_gen_others( dpi, draw_flags )

if nargin < 1
    dpi = 300;
end
mpi = 25.4;

if nargin < 2
    draw_flags = [0 1];
end

%% gen_parallel_stripes
if draw_flags(1)
    img_stripes = gen_parallel_stripes(dpi,mpi,[150,230],5);
    img = img_stripes;
end

%% gen_bordered_grids
if draw_flags(2)
    img_stripes = gen_bordered_grids(dpi,mpi,[150,230],2,12);
    img = img_stripes;
end

%% assemble images

% img = img_circle;

%% print informations

is = fliplr(size(img));
imsize_in_mm = is ./ dpi .* mpi;
fprintf('Image size: %.1f x %.1f\n', imsize_in_mm(1), imsize_in_mm(2));
imshow(img);
imwrite(img, 'res.tiff', 'Resolution', dpi);

end

