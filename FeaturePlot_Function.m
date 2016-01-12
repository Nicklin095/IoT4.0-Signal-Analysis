function [Feature_data,Information]=FeaturePlot_Function(InputData,Information)
%��l��ƹL�o�]�w�Ѽ�
%�`�N�o�i��
length = 20000;
temp_x = 1000;
temp_y = 19000;

Fs = 40;
T =1/Fs;
L = length;
t = (0:L-1)*T;
x = fft(InputData);
P2 = abs(x/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

bandpassFilt = designfilt('bandpassfir', 'StopbandFrequency1', 6, 'PassbandFrequency1', 6.5, 'PassbandFrequency2', 7.5, 'StopbandFrequency2', 8, 'StopbandAttenuation1', 60, 'PassbandRipple', 1, 'StopbandAttenuation2', 60, 'SampleRate', 40);
y = filter(bandpassFilt,InputData);

A=750;%�_�l��
B=15;%�϶�
F=B-5;%���|�e�� �϶���e��

temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];
temp5 = [];
temp6 = [];
temp7 = [];
Information.Feature_type={'sum',' energy','rms','var','std','mad','max'};
    for i =1:1801

        temp1(1,i)=sum(y(1,A:A+B))/B;%�S�x��:����
        temp2(1,i)=sum(y(1,A:A+B).^2)/50; %�S�x��:��q
        temp3(1,i)=rms(y(1,A:A+B));%�S�x��:�����
        temp4(1,i)=var(y(1,A:A+B));%�ܤ��
        temp5(1,i)=std(y(1,A:A+B));%�зǮt
        temp6(1,i)=mad(y(1,A:A+B));%�������ﰾ�t
        temp7(1,i)=max(y(1,A:A+B));%�̤j��
        A=A+F;
              
        if(A>length)
            break;
        end
    end
    Feature_data=[temp1;temp2;temp3;temp4;temp5;temp6;temp7];