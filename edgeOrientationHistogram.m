% block_num���������Ϊ8*8��4*4��ϸ��һ�Σ�����block_numΪ8���������Ϊ16*16(4*4��ϸ������)����block_numΪ16
function [eoh] = edgeOrientationHistogram(Img, block_num)

    im = imread(Img);
    im = rgb2gray(im);

    height = size(im,1);
    width = size(im,2);
    subblock_num = block_num * 2;
    
    % ��ÿ��subblock�ĳ���
    subblock_height = fix(height / subblock_num);
    subblock_width = fix(width / subblock_num);
    
    % �½�һ��subblock_num * subblock_num��ͼ�񣬰�ÿ��subblock��ƽ���Ҷȴ��ȥ
    im_avg = zeros(subblock_num, subblock_num);
    for i = 1 : subblock_num
        for j = 1 : subblock_num
            sub_im = int8(im((i - 1) * subblock_height + 1:i * subblock_height, (j - 1) * subblock_width + 1:j * subblock_width));
            im_avg(i, j) = sum(sum(sub_im)) / (subblock_height * subblock_width);
        end
    end
    
    % ����
    eoh = zeros(block_num,block_num,5);
    for b = 1:block_num
        for a = 1:block_num
            edge_filter = zeros(1,5);
            block_one = im_avg((b - 1) * 2 + 1, (a - 1) * 2 + 1);
            block_two = im_avg((b - 1) * 2 + 1, (a - 1) * 2 + 2);
            block_three = im_avg((b - 1) * 2 + 2, (a - 1) * 2 + 1);
            block_four = im_avg((b - 1) * 2 + 2, (a - 1) * 2 + 2);
            
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