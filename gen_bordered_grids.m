function [ img ] = gen_bordered_grids( dpi,mpi,range_in_mm,border_in_mm,gridsize_in_mm,repeats )

range = uint32(range_in_mm / mpi * dpi);
border = uint32(border_in_mm / mpi * dpi);
if max(size(border)) == 1
    border = uint32([border,border]);
end
gridsize = uint32(gridsize_in_mm / mpi * dpi);
if max(size(gridsize)) == 1
    gridsize = uint32([gridsize,gridsize]);
end
if nargin < 6
    repeats = floor(double(range-border)./double(gridsize+border));
end
repeats = uint32(repeats);

img = uint8(zeros(range) + 255);
for i = 1:repeats(1)
    for j = 1:repeats(2)
        sp = double([i-1,j-1] .* (gridsize+border)) + [1,1];
        ep = sp + double([gridsize(1)+border(1),border(2)]) - [1,1];
        img(sp(1):ep(1), sp(2):ep(2)) = 0;
        ep = sp + double([border(1),gridsize(2)+border(2)]) - [1,1];
        img(sp(1):ep(1), sp(2):ep(2)) = 0;
    end
end
sp = double([repeats(1)*(gridsize(1)+border(1))+1, 1]);
ep = sp + double([border(1),repeats(2)*(gridsize(2)+border(2))+border(2)]) - [1,1];
img(sp(1):ep(1), sp(2):ep(2)) = 0;
sp = double([1, repeats(2)*(gridsize(2)+border(2))+1]);
ep = sp + double([repeats(1)*(gridsize(1)+border(1))+border(1),border(2)]) - [1,1];
img(sp(1):ep(1), sp(2):ep(2)) = 0;

end

