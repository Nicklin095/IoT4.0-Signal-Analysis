function [Train_datay1,Test_datay1,W,train_data,test_data]=FeatureToLDA(allData,data1,data2)
[c1 r1]=size(data1);
[c2 r2]=size(data2);
X_1=[];X_2=[];X=[];New_Z=[];Train_datay1=[];Test_datay1=[];
X_1=[X_1 allData(:,1:r1)];
X_2=[X_2 allData(:,r1+1:r1+r2)];
lab_length_c = size(X_1,2);
lab_length_r = size(X_2,2);
X = [X X_1 X_2];
Y=[1*ones(1,lab_length_c) 2*ones(1,lab_length_r)];
r=2;
[Z,W] = FDA(X,Y',r);

figure();
NH=[];H=[];
NH=W'*X_2;
H=W'*X_1;

plot(H(1,:),H(2,:),'ro');
hold on
plot(NH(1,:),NH(2,:),'bo');

[o p]=size(NH);
%交叉放
for i=1:size(NH,2)
   New_Z = [New_Z NH(:,i) H(:,i)];
end
[c r]=size(New_Z);

train_data=[New_Z(:,1:r*0.8) ];
test_data=[New_Z(:,(r*0.8)+1:r)];

%訓練資料符號
for i=1:((r*0.8)/2)
   Train_datay1 = [Train_datay1 0.9 -0.9];

end

%測試資料符號
for i=1:((r*0.2)/2)
   Test_datay1 = [Test_datay1 0.9 -0.9];
end

end
