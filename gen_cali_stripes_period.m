function [img] = gen_cali_stripes(dpi,mpi,periods_in_mm, repeats, gaps_in_mm, caps_in_mm)

periods = uint32(periods_in_mm / mpi * dpi);
repeats = uint32(repeats);
gaps =    uint32(gaps_in_mm / mpi * dpi);
caps =    uint32(caps_in_mm / mpi * dpi);

count = max(size(periods));

half_size = sum(periods.*repeats) + sum(gaps);
total_size = 2*half_size;
img = uint8(zeros(total_size, total_size)) + 255;

tocenter = uint32(0);
for i = 1:count
    %figure(1);imshow(img);
    tocenter = tocenter + gaps(i);
    toleft = half_size - tocenter;
    totop = half_size - tocenter + caps(i);
    blkw = periods(i) / 2;
    for j = 1:repeats(i)
        img((totop+1):(total_size-totop), (toleft-blkw+1):(toleft)) = 0;
        img((totop+1):(total_size-totop), (total_size-toleft+1):(total_size-toleft+blkw)) = 0;
        img((toleft-blkw+1):(toleft), (totop+1):(total_size-totop)) = 0;
        img((total_size-toleft+1):(total_size-toleft+blkw), (totop+1):(total_size-totop)) = 0;
        toleft = toleft - periods(i);
    end
    tocenter = tocenter + periods(i)*repeats(i);
end

tocenter = 0;
for i = 1:count
    tocenter = tocenter + gaps(i) + periods(i)*repeats(i);
    toedge = half_size - tocenter;
    fontsize = uint32(periods(i)*repeats(i)*0.7);
    fontmargin = uint32((periods(i)*repeats(i)-fontsize)/2);
    img = draw_text(img, [toedge+fontmargin,toedge+fontmargin], periods_in_mm(i), 'AnchorPoint', 'LeftTop', 'FontSize', fontsize);
end



