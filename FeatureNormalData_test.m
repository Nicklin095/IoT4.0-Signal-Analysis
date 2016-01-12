clc
clear
%%------------------------
H_Feature_Result=[];
NH_Feature_Result=[];
%%------------------------
%load data
load('Data_Feature_test')

%%
%normal
%特徵值當作測試資料
DataArray_NH = [NH_Feature_test.NH_Total_Data(:,:)];%沒重量的資料丟進DataArray_NH
DataArray_H  = [H_Feature_test.H_Total_Data(:,:)];%沒重量的資料丟進DataArray_H

%補插植
NewDataArray_NH =[DataArray_NH  Information_test.Feature_max Information_test.Feature_min ];
NewDataArray_H  =[DataArray_H  Information_test.Feature_max Information_test.Feature_min ];

%對7*n矩陣裡面的資料做正規化
Normal_Data_Result_H  = normal_data(NewDataArray_H,NewDataArray_H,0.9,-0.9);
Normal_Data_Result_NH = normal_data(NewDataArray_NH,NewDataArray_NH,0.9,-0.9);
[Normal_Data_Result_NH_c Normal_Data_Result_NH_r ]=size(Normal_Data_Result_NH);
Normal_Data_Result_NH = Normal_Data_Result_NH(:,1:Normal_Data_Result_NH_r-5);
Normal_Data_Result_H = Normal_Data_Result_H(:,1:Normal_Data_Result_NH_r-5);
%H和NH 特徵值  3D
H_Feature_Result=[Normal_Data_Result_H(3,:);Normal_Data_Result_H(7,:)];
NH_Feature_Result=[Normal_Data_Result_NH(3,:);Normal_Data_Result_NH(7,:)];
%%
%save data
name=['Normal_Data_Feature_test'];
save(name,'H_Feature_Result','NH_Feature_Result');
save()
