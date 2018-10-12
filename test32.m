clear;
frameCount = 914;
alpha = zeros(frameCount:1);
p = zeros(frameCount:1);
typeCount = zeros(frameCount,5);
for i = 0:(frameCount-1)

    fileName = ['frame' num2str(i) '.jpeg'];
     clear imgName;
            % µÃµ½file name
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
    currentFrame = imread(imgName);
    grayCurrentFrame = rgb2gray(currentFrame);
    sizeGray = size(grayCurrentFrame);
    row = sizeGray(1);
    column = sizeGray(2);
    blockRow = fix(row/16);
    blockColumn = fix(column/16);
    devidePoint = zeros(17:2);
    for j = 1:16
        devidePoint(j,1) = blockRow * (j-1);
        devidePoint(j,2) = blockColumn * (j-1);
    end
    devidePoint(17,1) = row;
    devidePoint(17,2) = column;
    for x = 1:16
        for y = 1:16
            subDevidePointX = fix((devidePoint(x+1,1)-devidePoint(x,1))/2)+devidePoint(x,1);
            subDevidePointY = fix((devidePoint(y+1,2)-devidePoint(y,2))/2)+devidePoint(y,2);
            sumSubSubBlock1 = sum(sum(int8(grayCurrentFrame((devidePoint(x,1)+1):subDevidePointX,(devidePoint(y,2)+1):subDevidePointY))));
            sumSubSubBlock2 = sum(sum(int8(grayCurrentFrame((subDevidePointX+1):devidePoint(x+1,1),(devidePoint(y,2)+1):subDevidePointY))));
            sumSubSubBlock3 = sum(sum(int8(grayCurrentFrame((devidePoint(x,1)+1):subDevidePointX,(subDevidePointY+1):devidePoint(y+1,2)))));
            sumSubSubBlock4 = sum(sum(int8(grayCurrentFrame((subDevidePointX+1):devidePoint(x+1,1),(subDevidePointY+1):devidePoint(y+1,2)))));
            avg1 = sumSubSubBlock1/((subDevidePointX-devidePoint(x,1))*(subDevidePointY-devidePoint(y,2)));
            avg2 = sumSubSubBlock2/((devidePoint(x+1,1)-subDevidePointX)*(subDevidePointY-devidePoint(y,2)));
            avg3 = sumSubSubBlock3/((subDevidePointX-devidePoint(x,1))*(devidePoint(y+1,2)-subDevidePointY));
            avg4 = sumSubSubBlock4/((devidePoint(x+1,1)-subDevidePointX)*(devidePoint(y+1,2)-subDevidePointY));
            vertical = abs(avg1+avg2-avg3-avg4);
            horizontal = abs(avg1-avg2+avg3-avg4);
            diagonal45 = abs(sqrt(2)*avg1-sqrt(2)*avg4);
            diagonal135 = abs(sqrt(2)*avg3-sqrt(2)*avg2);
            nonDirectional = abs(2*avg1-2*avg2-2*avg3+2*avg4);
            max = vertical;
            edgeType = 1;
            if horizontal > max
                max = horizontal;
                edgeType = 2;
            end
            if diagonal45 > max
                max = diagonal45;
                edgeType = 3;
            end
            if diagonal135 > max
                max = diagonal135;
                edgeType = 4;
            end
            if nonDirectional > max
                max = nonDirectional;
                edgeType = 5;
            end
            %threshold check
            if max > 10
                typeCount(i+1,edgeType) = typeCount(i+1,edgeType)+1;
            end
        end
    end
    alpha(i+1) = sqrt(typeCount(i+1,1)^2+typeCount(i+1,2)^2+typeCount(i+1,3)^2+typeCount(i+1,4)^2+typeCount(i+1,5)^2);
    count1 = 0;
    count2 = 0;
    for j = 0: i
        if alpha(j+1) > alpha(i+1)
            count1 = count1 + 1;
        end
        if alpha(j+1) == alpha(i+1)
            count2 = count2 + 1;
        end
    end
    p(i+1) = (count1 + count2*rand())/(i+1);   
end
Sn = 0;
for i = 1:frameCount
    Sn = Sn + 1/2 - p(i);
end
windowSize = 5;
significance_level = 0.085;
resultEdge = zeros(frameCount:1);
k=0;
for i = (windowSize):frameCount
    max = 0;
    sum = 0;
    for j = (i - windowSize + 1):i
        sum = sum + 1/2 - p(j);
        if abs(sum) > max
            max = abs(sum);
        end
    end
    if abs(max) >= sqrt(windowSize/(12*significance_level))
        k=k+1;
        resultEdge(k)=i;
    end
end

clearvars -EXCEPT resultEdge typeCount;
frameCount = 914;
alpha = zeros(frameCount:1);
p = zeros(frameCount:1);
for i = 0:(frameCount-1)

    fileName = ['images2/' num2str(i) '.jpeg'];
    currentFrame = imread(fileName);
    currentFrameR = double(currentFrame(:,:,1));
    currentFrameG = double(currentFrame(:,:,2));
    currentFrameB = double(currentFrame(:,:,3));
    countR = zeros(1,256);
    countG = zeros(1,256);
    countB = zeros(1,256);
    sumX = 0;
    sizeFrame = size(currentFrame);
    for x = 1:sizeFrame(1)
        for y = 1:sizeFrame(2)
            countR(currentFrameR(x,y)+1) = countR(currentFrameR(x,y)+1) + 1;
            countG(currentFrameG(x,y)+1) = countG(currentFrameG(x,y)+1) + 1;
            countB(currentFrameB(x,y)+1) = countB(currentFrameB(x,y)+1) + 1;
        end
    end
    for j = 1:256
        sumX = sumX + countR(j)^2 + countG(j)^2 + countB(j)^2;
    end
    alpha(i+1) = sqrt(sumX);
    count1 = 0;
    count2 = 0;
    for j = 0: i
        if alpha(j+1) > alpha(i+1)
            count1 = count1 + 1;
        end
        if alpha(j+1) == alpha(i+1)
            count2 = count2 + 1;
        end
    end
    p(i+1) = (count1 + count2*rand())/(i+1);   
end
Sn = 0;
for i = 1:frameCount
    Sn = Sn + 1/2 - p(i);
end
windowSize = 5;
significance_level = 0.085;
k = 0;
resultRGB = zeros(frameCount:1);
for i = (windowSize):frameCount
    max = 0;
    sum = 0;
    for j = (i - windowSize + 1):i
        sum = sum + 1/2 - p(j);
        if abs(sum) > max
            max = abs(sum);
        end
    end
    if abs(max) >= sqrt(windowSize/(12*significance_level))
        k=k+1;
        resultRGB(k)=i;
    end
end
result = [resultRGB,resultEdge];
result = unique(result,'sorted');
