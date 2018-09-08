function [eoh] = edgeOrientationHistogram(Img)
    eoh = zeros(4,4,5);

    % define the filters for the 5 types of edges
    im = imread(Img);
    im = rgb2gray(im);

    height = size(im,1);
    width = size(im,2);

    % divide into 4*4 sub blocks
    subblock_height = height / 4; %60
    subblock_width = width / 4; %80

    for b = 1:4
        for a = 1:4
            % divide sub blocks into 30 * 40 image blocks
            for j = 1:30
                for i = 1:40
                    block_one = int8(im((b - 1) * subblock_height + (j - 1) * 2 + 1, (a - 1) * subblock_width + (i - 1) * 2 + 1));
                    block_two = int8(im((b - 1) * subblock_height + (j - 1) * 2 + 1, (a - 1) * subblock_width + (i - 1) * 2 + 2));
                    block_three = int8(im((b - 1) * subblock_height + (j - 1) * 2 + 2, (a - 1) * subblock_width + (i - 1) * 2 + 1));
                    block_four = int8(im((b - 1) * subblock_height + (j - 1) * 2 + 2, (a - 1) * subblock_width + (i - 1) * 2 + 2));

                    edge_filter = zeros(1,5);
                    edge_filter(1) = abs(block_one - block_two + block_three - block_four); %vertical
                    edge_filter(2) = abs(block_one + block_two - block_three - block_four); %horizontal
                    edge_filter(3) = abs(block_one * sqrt(2) - block_four * sqrt(2)); %45 diagonal
                    edge_filter(4) = abs(block_two * sqrt(2) - block_three * sqrt(2)); %135 diagonal
                    edge_filter(5) = abs(block_one * 2 - block_two * 2 - block_three * 2 + block_four * 2); %non-directional

                    [max_num, index] = max(edge_filter);
                    if max_num > 10
                        eoh(b, a, index) = eoh(b, a, index) + 1;
                    end
                end
            end
        end
    end

end