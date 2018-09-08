framenum=297;
filename='frame';
I=imread('frame0000.jpeg');  % 文件名自己改
siz=size(I);
I1=reshape(I,siz(1)*siz(2),siz(3));  % 每个颜色通道变为一列
I1=double(I1);
[N,X]=hist(I1, [0:1:255]);    % 如果需要小矩形宽一点，划分区域少点，可以把步长改大，比如0:5:255
bar(X,N(:,3), 'r');    % 柱形图，默认绘图的时候采用的颜色顺序为b,g,r,c,m,y,k,所以3,2,1分别对应R,G,B
hold on
bar(X,N(:,2), 'g'); 
hold on
bar(X,N(:,1), 'b'); 
xlim([0 255])
hold on
plot(X,N(:,3) ,'r', X,N(:,2) ,'g', X,N(:,1) ,'b');    % 上边界轮廓
hold off