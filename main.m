clear;
clc;
colorSet = matingalecolor();     
edgeSet = matingaleedge();
unionSet = union(colorSet, edgeSet);
for i = 1 : length(unionSet)
    fprintf('Detected at frame %d\n', unionSet(i));
end