function [ img ] = align_images( imgs, texts, msize, gap, fontsize )

fontsize = min(fontsize,gap);
imcount = max(size(imgs));

max_widths = zeros(1,msize(2));
max_heights = zeros(1,msize(1));
iter = 1;
for i = 1:msize(1)
    for j = 1:msize(2)
        if iter > imcount
            break;
        end
        max_widths(j) = max(max_widths(j), size(imgs{iter},2));
        max_heights(i) = max(max_heights(i), size(imgs{iter},1));
        iter = iter + 1;
    end
end
img = uint8(zeros([sum(max_heights),sum(max_widths)] + gap.*msize) + 255);
iter = 1;
start_point = [0 0];
for i = 1:msize(1)
    for j = 1:msize(2)
        if iter > imcount
            break;
        end
        % place image
        max_imsize = [max_heights(i),max_widths(j)];
        img_item = imgs{iter};
        is = size(img_item);
        pd = floor((max_imsize-is)/2);
        sp = start_point + [1,1] + pd;
        img(sp(1):(sp(1)+is(1)-1), sp(2):(sp(2)+is(2)-1)) = img_item;
        % place text
        if ~isempty(texts{iter})
            sp = start_point + [floor(max_imsize(1)/2+is(1)/2+(gap-fontsize)/2), floor(max_imsize(2)/2)] + [1,1];
            img = draw_text(img, fliplr(sp), texts{iter}, 'AnchorPoint', 'Center', 'FontSize', fontsize);
        end
        % iterate
        start_point(2) = start_point(2) + max_imsize(2) + gap;
        iter = iter+1;
    end
    start_point(2) = 0;
    start_point(1) = start_point(1) + max_imsize(1) + gap;
end

end

