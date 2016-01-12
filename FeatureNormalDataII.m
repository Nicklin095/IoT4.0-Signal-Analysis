clc
clear
close all
%%------------------------
plot_img =1;
H_NH_Test_Feature=[];
H_NH_Train_Feature=[];
H_NH_Test_Feature_Result=[];
H_NH_Train_Feature_Result=[];
Test_datay=[];
Train_datay=[];
%%------------------------
%load data
load('Data_Feature')
Feature_c=size(H_Feature.H_Total_Data,2);
DataTemp_c=Feature_c/Information.input_data_sum;
%%
%normal
%最後一筆特徵值當作測試資料
DataArray_NH_Test = [NH_Feature.NH_Total_Data(:,Feature_c-(DataTemp_c-1):Feature_c)];%沒重量的資料丟進DataArray_NH
DataArray_H_Test  = [H_Feature.H_Total_Data(:,Feature_c-(DataTemp_c-1):Feature_c)];%沒重量的資料丟進DataArray_H

%補插植
NewDataArray_NH_Test =[DataArray_NH_Test  Information.Feature_max Information.Feature_min ];
NewDataArray_H_Test  =[DataArray_H_Test  Information.Feature_max Information.Feature_min ];

%對7*n矩陣裡面的資料做正規化
Normal_Data_Test_Result_H  = normal_data(NewDataArray_H_Test,NewDataArray_H_Test,0.9,-0.9);
Normal_Data_Test_Result_NH = normal_data(NewDataArray_NH_Test,NewDataArray_NH_Test,0.9,-0.9);

%將正規化後的H和NH交叉放進H_NH_FeatureArray 
for j=1:size(Normal_Data_Test_Result_H,2) 
   H_NH_Test_Feature = [H_NH_Test_Feature Normal_Data_Test_Result_NH(:,j) Normal_Data_Test_Result_H(:,j)];   
end
%Test H和NH 特徵值  3D
% H_NH_Test_Feature_Result=[H_NH_Test_Feature(3,:);H_NH_Test_Feature(5,:);H_NH_Test_Feature(7,:)];
H_NH_Test_Feature_Result=[H_NH_Test_Feature(3,:);H_NH_Test_Feature(7,:)];
for i=1:size(H_NH_Test_Feature,2)/2 
    Test_datay = [Test_datay 0.9 -0.9];
end
%----------------------------------------訓練資料正規化/有重物無重物資料交叉/符號交叉---------------------------------------------------

%前四筆的NH特徵值當作訓練資料
DataArray_NH_Train = [NH_Feature.NH_Total_Data(:,1:Feature_c-DataTemp_c) ];%沒重量的資料丟進DataArray_NH
DataArray_H_Train  = [H_Feature.H_Total_Data(:,1:Feature_c-DataTemp_c)   ];%重量的資料丟進DataArray_H

%補插植
NewDataArray_NH_Train =[DataArray_NH_Train  Information.Feature_max Information.Feature_min ];
NewDataArray_H_Train  =[DataArray_H_Train   Information.Feature_max Information.Feature_min ];

%對7*n矩陣裡面的資料做正規化
Normal_Data_Train_Result_NH  = normal_data(NewDataArray_NH_Train,NewDataArray_NH_Train,0.9,-0.9);
Normal_Data_Train_Result_H = normal_data(NewDataArray_H_Train,NewDataArray_H_Train,0.9,-0.9);
    
for j=1:size(Normal_Data_Train_Result_NH,2) 
   H_NH_Train_Feature = [H_NH_Train_Feature Normal_Data_Train_Result_NH(:,j) Normal_Data_Train_Result_H(:,j)];   
end
    
%符號
for i=1:size(H_NH_Train_Feature,2)/2 
   Train_datay = [Train_datay 0.9 -0.9];
end

%Test H和NH 特徵值  3D
% H_NH_Train_Feature_Result=[ H_NH_Train_Feature(3,:); H_NH_Train_Feature(5,:); H_NH_Train_Feature(7,:)];
H_NH_Train_Feature_Result=[ H_NH_Train_Feature(3,:); H_NH_Train_Feature(7,:)];
name=['Normal_Data_Feature'];
save(name,'NH_Feature','H_Feature','Information','H_NH_Train_Feature','H_NH_Test_Feature','H_NH_Train_Feature_Result','H_NH_Test_Feature_Result','Train_datay','Test_datay');
save()

%將每個特徵值的圖印出來
if(plot_img == 1)
Count=1;
    for i=7:-1:2
        for j=i-1:-1:1     
            figure(Count)
            plot(Normal_Data_Train_Result_H(i,1:size(Normal_Data_Train_Result_NH,2)), Normal_Data_Train_Result_H(j,1:size(Normal_Data_Train_Result_NH,2)),'x',Normal_Data_Train_Result_NH(i,1:size(Normal_Data_Train_Result_NH,2)), Normal_Data_Train_Result_NH(j,1:size(Normal_Data_Train_Result_NH,2)),'o')
            Count=Count+1;
        end
    end

    figure,plot3(Normal_Data_Train_Result_H(3,1:size(Normal_Data_Train_Result_NH,2)),Normal_Data_Train_Result_H(5,1:size(Normal_Data_Train_Result_NH,2)),Normal_Data_Train_Result_H(7,1:size(Normal_Data_Train_Result_NH,2)),'x',Normal_Data_Train_Result_NH(3,1:size(Normal_Data_Train_Result_NH,2)),Normal_Data_Train_Result_NH(5,1:size(Normal_Data_Train_Result_NH,2)),Normal_Data_Train_Result_NH(7,1:size(Normal_Data_Train_Result_NH,2)),'o');
    xlabel('均方根')
    ylabel('標準差')
    zlabel('平均')
end
