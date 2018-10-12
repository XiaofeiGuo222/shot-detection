clear;
clc;
motionSet = load('dat.txt');
colorSet = martingalecolor();     
edgeSet = martingaleedge();

twoSet = union(colorSet, edgeSet);
threeSet = deleteNeighbors(3,union(twoSet, motionSet));
diffTwoThree = setdiff(threeSet, twoSet);

%% test difference

%ocolorSet = load('ocolor.txt');
%oedgeSet = load('oedge.txt');
%otwoSet = union(ocolorSet, oedgeSet);

%twodiff = setdiff(twoSet, otwoSet) % in ours twoset but not in theirs

%otwodiff = setdiff(otwoSet, twoSet) % in their twoset but not in ours





