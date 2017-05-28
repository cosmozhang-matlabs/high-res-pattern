function [  ] = do_gen_cali_pattern( dpi, draw_flags )

if nargin < 1
    dpi = 300;
end
mpi = 25.4;

if nargin < 2
    draw_flags = [1 0 0];
end

%% gen_cali_stripes_period
if draw_flags(1)
    periods =  [1   2   2.5    4    5    8   10];
    repeats =  [6   5     4    3    3    2    2];
    gaps =     [10  5     5    8    8    8    8];
    caps =     [4   8    12   12   12   12   15];

    img_stripes = gen_cali_stripes_period(dpi,mpi,periods,repeats,gaps,caps);
    img = img_stripes;
end

%% gen_cali_circles

if draw_flags(2)
    duties = [0.2, 0.4, 0.5, 0.6, 0.8];
    periods = [1   2   2.5    4    5];
    more_periods = [1  2  2.5  4  5  8  10];
    imcount = max(size(periods)) + 1;
    gap = round(5 ./ mpi .* dpi);
    msize = [2 3];
    img_circles = cell(1,imcount);
    fontsize = round(4 ./ mpi .* dpi);
    texts = cell(1,imcount);
    for i = 1:(imcount-1)
        img = gen_cali_circles_duty(dpi,mpi,4,duties,periods(i));
        img_circles{i} = img;
        texts{i} = periods(i);
    end
    img_circles{imcount} = gen_cali_circles_period(dpi,mpi,4,more_periods,0.5);
    txt = sprintf('%.1f', more_periods(1));
    for i = more_periods(2:end)
        txt = sprintf('%s %.1f', txt, i);
    end
    texts{imcount} = txt;

    img_circle = align_images(img_circles, texts, msize, gap, fontsize);
    img = img_circle;
end

%% gen_cali_chessboard
if draw_flags(3)
    periods = [1    2   2.5    4    5   8   10];
    repeats = [30  15    12    7    6   4    3];
    gap = round(5 ./ mpi .* dpi);
    fontsize = round(3 ./ mpi .* dpi);
    msize = [2 4];
    imcount = max(size(periods));
    img_chessboards = cell(1,imcount);
    texts = cell(1,imcount);
    for i = 1:imcount
        img_chessboards{i} = gen_cali_chessboard(dpi, mpi, [repeats(i),repeats(i)], [periods(i),periods(i)], 0.5);
        texts{i} = periods(i);
    end
    img_chessboard = align_images(img_chessboards, texts, msize, gap, fontsize);
    img = img_chessboard;
end

%% assemble images

%img = img_circle;

%% print informations

is = fliplr(size(img));
imsize_in_mm = is ./ dpi .* mpi;
fprintf('Image size: %.1f x %.1f\n', imsize_in_mm(1), imsize_in_mm(2));
imshow(img);
imwrite(img, 'res.tiff', 'Resolution', dpi);

end

