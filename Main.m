clc
clear all
close all
global b_data g_data allData featureData allFeature
%資料長度切割(頭尾去掉)
StartLength = 50;
EndLength = 700;
StartLength_g = 50;
EndLength_g = 2650;
%load data
ImportData='bData_';
b_dataNum=12;%異常資料筆數
g_dataNum=1;%正常資料筆數
featureNum=7;%特徵值數量
axis=3;%三軸筆數
k=0;m=0;
%----------------------------------------------------------------------------
%load資料
for j=1:axis
    for i=1:b_dataNum
        k=k+1;
        Orig_Data=[ImportData num2str(i) '.mat'];
        load(Orig_Data);
        b_data = [b_data;r_data(StartLength:EndLength,j)'];  
        allData =[allData b_data(k,:)];
    end
end
ImportData='gData_';  
for j=1:axis
    for i=1:g_dataNum
        m=m+1;
        Orig_Data=[ImportData num2str(i) '.mat'];
        load(Orig_Data);
        [r c]=size(r_data);
        g_data=[g_data;r_data(StartLength_g:EndLength_g,j)'];
        allData =[allData g_data(m,:)]; 
    end
end
%--------------------------------------------------------------------------
%資料前處理
[c r]=size(b_data);
[o p]=size(g_data);
for i=1:axis
    temp=[];data_r=0;featureData=[];PreprocessData=[];PreprocessData2=[];
    temp=[allData(:,(r*b_dataNum)*(i-1)+1:r*(b_dataNum*i)) allData(:,((r*b_dataNum*3)+(p*(i-1)))+1:((r*b_dataNum*3)+(p*i)))];
    [MaxMin]=DataMaxMin(temp);%取最大最小值
    for j=1:b_dataNum
       ((i-1)*b_dataNum)+j
        [fundata]=DataProcessFun(b_data(((i-1)*b_dataNum)+j,:),MaxMin,r,r,b_dataNum);
        PreprocessData=[PreprocessData fundata];       
    end
    for k=1:g_dataNum
        [fundata2]=DataProcessFun(g_data(k,:),MaxMin,p,r,g_dataNum);
        PreprocessData2=[PreprocessData2 fundata2];  
    end   
    [h f]=size(PreprocessData);
    [h2 f2]=size(PreprocessData2);
    featureData=[PreprocessData PreprocessData2];
    [recallData]=FeatureProcessFun(featureData,PreprocessData,featureNum,b_dataNum,f,f);
    [recallData2]=FeatureProcessFun(featureData,PreprocessData2,featureNum,b_dataNum,f2,f);
    allFeature=[allFeature;recallData recallData2];
end

[c r]=size(recallData);
[c2 r2]=size(recallData2);
[Train_datay1,Test_datay1,W,test_data,train_data]=FeatureToLDA(allFeature,recallData,recallData2);
name=['NN_Data'];
save(name,'train_data','test_data','Test_datay1','Train_datay1');