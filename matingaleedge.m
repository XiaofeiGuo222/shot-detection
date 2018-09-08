function egDetected = matingaleedge()
    frameNum = 913;
    egDetected = [];

    % 用一个array来存所以的alpha值
    alphas = zeros(1, frameNum);
    ps = zeros(1, frameNum);
    for i = 0:frameNum
        clear imgName;
        % 得到file name
        imgName = 'frame';
        if i < 10
            imgName = strcat(imgName,'000', int2str(i), '.jpeg'); 
        else
            if i < 100
                imgName = strcat(imgName,'00', int2str(i), '.jpeg'); 
            else
                if i < 1000
                    imgName = strcat(imgName,'0', int2str(i), '.jpeg'); 
                else
                    imgName = strcat(imgName, int2str(i), '.jpeg'); 
                end
            end
        end

        % 得到本帧的edge histogram
        eoh = edgeOrientationHistogram(imgName);

        %算本帧的alpha
        s = sum(sum(eoh, 1), 2);
        
        alpha_i = sqrt(s(1,1) * s(1,1) + s(1,2) * s(1,2) + s(1,3) * s(1,3) + s(1,4) * s(1,4) + s(1,5) * s(1,5));

        %存进alphas
        alphas(1, i + 1) = alpha_i;

        set1 = 0;
        set2 = 0;
        for j = 0:i
            alpha_j = alphas(1, j + 1);
            if alpha_j > alpha_i
                set1 = set1 + 1;
            end
            if alpha_j == alpha_i
                set2 = set2 + 1;
            end
        end 
        ps(1, i + 1) = (set1 + rand * set2) / (i + 1); 
    end


    for i = 1: frameNum
        temp = alarm(ps,i,10,0.07);
        if temp ~= -1
            egDetected(1, end + 1) = temp;
        end
    end    
end