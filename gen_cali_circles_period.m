function [ img ] = gen_cali_circles_period( dpi,mpi,centerr_in_mm,periods_in_mm,duty )

linewidthf = periods_in_mm .* duty ./ mpi .* dpi;
linewidth = uint32(linewidthf);
linegapf = periods_in_mm .* (1-duty) ./ mpi .* dpi;
linegap = uint32(linegapf);
centerrf = centerr_in_mm ./ mpi .* dpi;
centerr = uint32(centerrf);

count = max(size(periods_in_mm));
half_size = centerr + sum(linewidth + linegap);
total_size = 2 * half_size;

r = centerr;
rmin = zeros(1,count);
rmax = zeros(1,count);
for i = 1:count
    rmin(i) = r;
    r = r + linewidth(i);
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

