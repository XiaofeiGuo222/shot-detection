framenum=297;
filename='frame';
I=imread('frame0000.jpeg');  % �ļ����Լ���
siz=size(I);
I1=reshape(I,siz(1)*siz(2),siz(3));  % ÿ����ɫͨ����Ϊһ��
I1=double(I1);
[N,X]=hist(I1, [0:1:255]);    % �����ҪС���ο�һ�㣬���������ٵ㣬���԰Ѳ����Ĵ󣬱���0:5:255
bar(X,N(:,3), 'r');    % ����ͼ��Ĭ�ϻ�ͼ��ʱ����õ���ɫ˳��Ϊb,g,r,c,m,y,k,����3,2,1�ֱ��ӦR,G,B
hold on
bar(X,N(:,2), 'g'); 
hold on
bar(X,N(:,1), 'b'); 
xlim([0 255])
hold on
plot(X,N(:,3) ,'r', X,N(:,2) ,'g', X,N(:,1) ,'b');    % �ϱ߽�����
hold off