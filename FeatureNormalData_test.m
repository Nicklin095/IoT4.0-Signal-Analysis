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
%�S�x�ȷ�@���ո��
DataArray_NH = [NH_Feature_test.NH_Total_Data(:,:)];%�S���q����ƥ�iDataArray_NH
DataArray_H  = [H_Feature_test.H_Total_Data(:,:)];%�S���q����ƥ�iDataArray_H

%�ɴ���
NewDataArray_NH =[DataArray_NH  Information_test.Feature_max Information_test.Feature_min ];
NewDataArray_H  =[DataArray_H  Information_test.Feature_max Information_test.Feature_min ];

%��7*n�x�}�̭�����ư����W��
Normal_Data_Result_H  = normal_data(NewDataArray_H,NewDataArray_H,0.9,-0.9);
Normal_Data_Result_NH = normal_data(NewDataArray_NH,NewDataArray_NH,0.9,-0.9);
[Normal_Data_Result_NH_c Normal_Data_Result_NH_r ]=size(Normal_Data_Result_NH);
Normal_Data_Result_NH = Normal_Data_Result_NH(:,1:Normal_Data_Result_NH_r-5);
Normal_Data_Result_H = Normal_Data_Result_H(:,1:Normal_Data_Result_NH_r-5);
%H�MNH �S�x��  3D
H_Feature_Result=[Normal_Data_Result_H(3,:);Normal_Data_Result_H(7,:)];
NH_Feature_Result=[Normal_Data_Result_NH(3,:);Normal_Data_Result_NH(7,:)];
%%
%save data
name=['Normal_Data_Feature_test'];
save(name,'H_Feature_Result','NH_Feature_Result');
save()
