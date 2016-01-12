clc
clear 
%-------------------------------
Information_test.max=0.6; %�ե� max
Information_test.min=-0.7; %�ե� min
Information_test.plot_img=1 %��X�Ϥ�
Information_test.input_data_sum=3;%��X��ƭӼ�
H_Feature_test.H_Total_Data=[];
NH_Feature_test.NH_Total_Data=[];
Information_test.Feature_max=0;
Information_test.Feature_min=0;
%-------------------------------
for i=1:3
    H_Orig_Data = ['HZ10m_B' num2str(i) '.mat'];
    load(H_Orig_Data);
    NH_Orig_Data = ['NHZ10m_B' num2str(i) '.mat'];
    load(NH_Orig_Data);
    
    %�ɮt��
    H_Data_test=[H_Data_test' Information_test.max Information_test.min];
    NH_Data_test=[NH_Data_test' Information_test.max Information_test.min];
    
    %�靈�����εL��������ư����W��
    Normal_H_Data = normal_data(H_Data_test,H_Data_test,1,0);
    Normal_NH_Data = normal_data(NH_Data_test,NH_Data_test,1,0);
    
    %�������εL������ư��S�x�ȴ���
    [ Feature_H_data, Information_test]=FeaturePlot_Function(Normal_H_Data,Information_test);    
    H_Feature_test.H_Total_Data = [H_Feature_test.H_Total_Data Feature_H_data ];

    [Feature_NH_data, Information_test]=FeaturePlot_Function(Normal_NH_Data,Information_test);
    NH_Feature_test.NH_Total_Data = [NH_Feature_test.NH_Total_Data Feature_NH_data ];
end
Information_test.Feature_max=max(H_Feature_test.H_Total_Data')';
Information_test.Feature_min=min(H_Feature_test.H_Total_Data')';
%[DataTemp_r,DataTemp_c]=size(DataTemp_1);
%%
%save data
name=['Data_Feature_test'];
save(name,'NH_Feature_test','H_Feature_test','Information_test');

%%
%��X�Ϥ�
if (Information_test.plot_img == 1)
% T1{i}=data;
    %�S�x�ȥ���
    subplot(7,2,1)
    plot(NH_Feature_test.NH_Total_Data(1,:))
    title('�S�x��:����')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,-0.02,0.02])
    subplot(7,2,2)
    plot(H_Feature_test.H_Total_Data(1,:))
    title('�S�x��:����')
    xlabel('Data length')
    ylabel('A')

    %�S�x�ȯ�q
    subplot(7,2,3)
    plot(NH_Feature_test.NH_Total_Data(2,:))
    title('�S�x��:��q')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,4*10^-3])

    subplot(7,2,4)
    plot(H_Feature_test.H_Total_Data(2,:))
    title('�S�x��:��q')
    xlabel('Data length')
    ylabel('A')


    %�S�x�ȧ����
    subplot(7,2,5)
    plot(NH_Feature_test.NH_Total_Data(3,:))
    title('�S�x��:�����')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.1])

    subplot(7,2,6)
    plot(H_Feature_test.H_Total_Data(3,:))
    title('�S�x��:�����')
    xlabel('Data length')
    ylabel('A')

    %�S�x���ܤ��
    subplot(7,2,7)
    plot(NH_Feature_test.NH_Total_Data(4,:))
    title('�S�x��:�ܤ��')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.01])

    subplot(7,2,8)
    plot(H_Feature_test.H_Total_Data(4,:))
    title('�S�x��:�ܤ��')
    xlabel('Data length')
    ylabel('A')

    %�S�x�ȼзǮt
    subplot(7,2,9)
    plot(NH_Feature_test.NH_Total_Data(5,:))
    title('�S�x��:�зǮt')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.1])

    subplot(7,2,10)
    plot(H_Feature_test.H_Total_Data(5,:))
    title('�S�x��:�зǮt')
    xlabel('Data length')
    ylabel('A')

    %�S�x�ȥ������ﰾ�t
    subplot(7,2,11)
    plot(NH_Feature_test.NH_Total_Data(6,:))
    title('�S�x��:�������ﰾ�t')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.1])
    subplot(7,2,12)
    plot(H_Feature_test.H_Total_Data(6,:))
    title('�S�x��:�������ﰾ�t')
    xlabel('Data length')
    ylabel('A')

    %�S�x�ȳ̤j��
    subplot(7,2,13)
    plot(NH_Feature_test.NH_Total_Data(7,:))
    title('�S�x��:�̤j��')
    xlabel('Data length')
    ylabel('A')
    axis([0,10000,0,0.2])
    subplot(7,2,14)
    plot(H_Feature_test.H_Total_Data(7,:))
    title('�S�x��:�̤j��')
    xlabel('Data length')
    ylabel('A')
end
%%