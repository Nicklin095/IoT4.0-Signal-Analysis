clc
clear
close all
%-------------------------------
Information.max=0.6; %�ե� max
Information.min=-0.7; %�ե� min
Information.plot_img=0 %��X�Ϥ�
Information.input_data_sum=5;%��X��ƭӼ�
H_Feature.H_Total_Data=[];
NH_Feature.NH_Total_Data=[];
Information.Feature_max=0;
Information.Feature_min=0;
%-------------------------------
for i=1:5
    H_Orig_Data = ['HZ10m_' num2str(i) '.mat'];
    load(H_Orig_Data);
    NH_Orig_Data = ['NHZ10m_' num2str(i) '.mat'];
    load(NH_Orig_Data);
    
    %�ɮt��
    H_Data=[Data' Information.max Information.min];
    NH_Data=[NH_Data' Information.max Information.min];
    
    %�靈�����εL��������ư����W��
    Normal_H_Data = normal_data(H_Data,H_Data,1,0);
    Normal_NH_Data = normal_data(NH_Data,NH_Data,1,0);
    
    %�������εL������ư��S�x�ȴ���
    [ Feature_H_data, Information]=FeaturePlot_Function(Normal_H_Data,Information);    
    H_Feature.H_Total_Data = [H_Feature.H_Total_Data Feature_H_data ];

    [Feature_NH_data, Information]=FeaturePlot_Function(Normal_NH_Data,Information);
    NH_Feature.NH_Total_Data = [NH_Feature.NH_Total_Data Feature_NH_data ];
end
Information.Feature_max=max(H_Feature.H_Total_Data')';
Information.Feature_min=min(H_Feature.H_Total_Data')';
%[DataTemp_r,DataTemp_c]=size(DataTemp_1);
%%
%save data
name=['Data_Feature'];
save(name,'NH_Feature','H_Feature','Information');

%%
%��X�Ϥ�
if (Information.plot_img == 1)
% T1{i}=data;
    %�S�x�ȥ���
    subplot(7,2,1)
    plot(NH_Total_Data_Feature_1)
    title('�S�x��:����')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,-0.02,0.02])
    subplot(7,2,2)
    plot(H_Total_Data_Feature_1)
    title('�S�x��:����')
    xlabel('Data length')
    ylabel('A')

    %�S�x�ȯ�q
    subplot(7,2,3)
    plot(NH_Total_Data_Feature_2)
    title('�S�x��:��q')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,4*10^-3])

    subplot(7,2,4)
    plot(H_Total_Data_Feature_2)
    title('�S�x��:��q')
    xlabel('Data length')
    ylabel('A')


    %�S�x�ȧ����
    subplot(7,2,5)
    plot(NH_Total_Data_Feature_3)
    title('�S�x��:�����')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.1])

    subplot(7,2,6)
    plot(H_Total_Data_Feature_3)
    title('�S�x��:�����')
    xlabel('Data length')
    ylabel('A')

    %�S�x���ܤ��
    subplot(7,2,7)
    plot(NH_Total_Data_Feature_4)
    title('�S�x��:�ܤ��')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.01])

    subplot(7,2,8)
    plot(H_Total_Data_Feature_4)
    title('�S�x��:�ܤ��')
    xlabel('Data length')
    ylabel('A')

    %�S�x�ȼзǮt
    subplot(7,2,9)
    plot(NH_Total_Data_Feature_5)
    title('�S�x��:�зǮt')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.1])

    subplot(7,2,10)
    plot(H_Total_Data_Feature_5)
    title('�S�x��:�зǮt')
    xlabel('Data length')
    ylabel('A')

    %�S�x�ȥ������ﰾ�t
    subplot(7,2,11)
    plot(NH_Total_Data_Feature_6)
    title('�S�x��:�������ﰾ�t')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.1])
    subplot(7,2,12)
    plot(H_Total_Data_Feature_6)
    title('�S�x��:�������ﰾ�t')
    xlabel('Data length')
    ylabel('A')

    %�S�x�ȳ̤j��
    subplot(7,2,13)
    plot(NH_Total_Data_Feature_7)
    title('�S�x��:�̤j��')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.2])
    subplot(7,2,14)
    plot(H_Total_Data_Feature_7)
    title('�S�x��:�̤j��')
    xlabel('Data length')
    ylabel('A')
end
%%