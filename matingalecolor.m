function chDetected = matingalecolor()

    frameNum = 913;
    chDetected = [];
    
    % ��һ��array�������Ե�alphaֵ
    alphas = zeros(1, frameNum);
    ps = zeros(1, frameNum);
    for i = 0:frameNum
        clear imgName;
        % �õ�file name
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

        % �õ���֡��color histogram
        I = imread(imgName);
        siz=size(I);
        I1 = reshape(I,siz(1)*siz(2),siz(3));  % ÿ����ɫͨ����Ϊһ��
        I1 = double(I1);
        [N,X]=hist(I1, [0:1:255]);  
        
        R = N(:, 1);
        G = N(:, 2);
        B = N(:, 3);
        %�㱾֡��alpha
        alpha_i = 0;
        for j = 1 : 256
            alpha_i = R(j) * R(j) + G(j) * G(j) + B(j) * B(j) + alpha_i;
        end
        alpha_i = sqrt(alpha_i);

        %���alphas
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
        temp = alarm(ps,i,5,0.085);
        if temp ~= -1
            chDetected(1, end + 1) = temp;
        end
    end    
end
