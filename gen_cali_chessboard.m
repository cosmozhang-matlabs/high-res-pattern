function [ img ] = gen_cali_chessboard( dpi,mpi,repeats,periods_in_mm,duty )

gridsizef = periods_in_mm .* duty ./ mpi .* dpi;
gridsize = uint32(gridsizef);
gridgapf = periods_in_mm .* (1-duty) ./ mpi .* dpi;
gridgap = uint32(gridgapf);
repeats = uint32(repeats);

img = uint8(zeros((gridsize+gridgap).*repeats) + 255);

flg = 1;
for i = 1:repeats(1)
    for j = 1:repeats(2)
        sp = [i-1,j-1].*(gridsize+gridgap);
        if ~flg
            sp(2) = sp(2) + gridgap(2);
        end
        img((sp(1)+1):(sp(1)+gridsize(1)), (sp(2)+1):(sp(2)+gridsize(2))) = 0;
    end
end

end

