function [PreprocessData]=DataProcessFun(InputData,MaxMin,DataLength,CheckdataLength,datanum)

global FeatureData normalData NewFeatureData data
PreprocessData=[];
[c r]=size(InputData);
normalData=[];
data=[];
%�ɳ̤j�̤p��
    data = [data InputData MaxMin(1,:) MaxMin(2,:)];
%���W��
normalData =[normalData normal_data(data(1,:),data(1,:),1,0)];
if DataLength==CheckdataLength
    %�p�ⲧ�`��ƯS�x��
    [FeatureData]=FeatureFunction(normalData(:,:));    
%     %������I�üƦ�m
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
    %���`��ƨ��S�x��
    [FeatureData]=FeatureFunction2(normalData(:,:)); 
    for j=1:7
        PreprocessData=[PreprocessData FeatureData(j,:)];
    end
end
end
