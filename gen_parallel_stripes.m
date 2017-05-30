function [ img ] = gen_parallel_stripes( dpi,mpi,range_in_mm,period_in_mm,repeats )

range = uint32(range_in_mm / mpi * dpi);
period = uint32(period_in_mm / mpi * dpi);
if nargin < 5
    repeats = floor(range_in_mm(2)/period_in_mm);
end
repeats = uint32(repeats);

img = uint8(zeros(range) + 255);
for i = 1:repeats
    sp = double([ 1, (i-1)*period+1 ]);
    ep = sp + double([range(1), period/2]) - [1,1];
    img(sp(1):ep(1), sp(2):ep(2)) = 0;
end

end

