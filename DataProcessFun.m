function [PreprocessData]=DataProcessFun(InputData,MaxMin,DataLength,CheckdataLength,datanum)

global FeatureData normalData NewFeatureData data
PreprocessData=[];
[c r]=size(InputData);
normalData=[];
data=[];
%補最大最小值
    data = [data InputData MaxMin(1,:) MaxMin(2,:)];
%正規化
normalData =[normalData normal_data(data(1,:),data(1,:),1,0)];
if DataLength==CheckdataLength
    %計算異常資料特徵值
    [FeatureData]=FeatureFunction(normalData(:,:));    
%     %取資料點亂數位置
%     randnum=randperm(30);
    NewFeatureData=[];
        for j=1:7
            rand=[];
                for l=1
                    for k=1:30
%                         rand=[rand FeatureData(j,randnum(k))];
                            rand=[rand FeatureData(j,k)];
                    end
                end
                NewFeatureData =[NewFeatureData ;rand(1,:)];
%         end
    PreprocessData=[PreprocessData NewFeatureData(j,:)];
    end
else
    %正常資料取特徵值
    [FeatureData]=FeatureFunction2(normalData(:,:)); 
    for j=1:7
        PreprocessData=[PreprocessData FeatureData(j,:)];
    end
end
end
