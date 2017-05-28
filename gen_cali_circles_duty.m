function [ img ] = gen_cali_circles_duty( dpi,mpi,centerr_in_mm,duties,linewidth_in_mm )

linewidthf = linewidth_in_mm ./ mpi .* dpi;
linewidth = uint32(linewidthf);
linegapf = linewidth_in_mm .* duties ./ (1-duties) ./ mpi .* dpi;
linegap = uint32(linegapf);
centerrf = centerr_in_mm ./ mpi .* dpi;
centerr = uint32(centerrf);

count = max(size(duties));
half_size = centerr + sum(linewidth + linegap);
total_size = 2 * half_size;

r = centerr;
rmin = zeros(1,count);
rmax = zeros(1,count);
for i = 1:count
    rmin(i) = r;
    r = r + linewidth;
    rmax(i) = r;
    r = r + linegap(i);
end

img = zeros(total_size,total_size) + 255;
for i = 1:total_size
    for j = 1:total_size
        r = sqrt(sum((double([i,j])-double(half_size)-0.5).^2));
        for k = 1:count
            if (r >= rmin(k)) && (r < rmax(k))
                img(i,j) = 0;
            end
        end
    end
end

end

