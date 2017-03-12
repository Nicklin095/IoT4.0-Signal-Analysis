
%--------------------------------------------------------------------------
% 馬達預測模型
%--------------------------------------------------------------------------
clc;
clear;
close all;
warning off;
%--------------------------------------------------------------------------
% 資料資訊
%--------------------------------------------------------------------------
load('C:\Users\nick\Desktop\dataProcess\NN_Data.mat');
run_index1=[1];

train_datau=train_data;%值
train_datay=Train_datay1;%符號
test_datau=test_data;%值
test_datay=Test_datay1;

sum = 0;

for run_index=run_index1
    information.epoch=100;
    information.number_of_neural1=2;
    information.number_of_input=2;%輸入維度大小
[row, train_col]=size(train_datau); %row列 

[row, test_col]=size(test_datau); %row列 
%--------------------------------------------------------------------------
% 資料正規化
%--------------------------------------------------------------------------
% information.max_d=0.9;  %範圍 0.9~-0.9
% information.min_d=-0.9;
% data_max1=max(datau')'; %a=[1 2 3 ; 4 5 6 ; 7 8 9] max(a')'=[3 6 9]'
% data_min1=min(datau')';
% data_max=repmat(data_max1,1,col);  %[3 3 3;6 6 6;9 9 9]
% data_min=repmat(data_min1,1,col);
% norm_datau=((datau-data_min)./(data_max-data_min).*((information.max_d-information.min_d)*ones(row,col))) + information.min_d*ones(row,col);
% data_max=repmat(data_max1,1,col_correct);
% data_min=repmat(data_min1,1,col_correct);
% norm_correct_skyline=((correct_skyline-data_min)./(data_max-data_min).*((information.max_d-information.min_d)*ones(row,col_correct))) + information.min_d*ones(row,col_correct);
%--------------------------------------------------------------------------
% 程式參數設定區（依天際線區分）
%--------------------------------------------------------------------------
% %選擇哪些方法或是要不要秀出什麼東西
show_plot=0; 
speed_up=1; % 是否要加速搜尋過程
% %儲存優秀參數
% overall.lost=col;
% overall.skyline_candidata_count=col*1;
%--------------------------------------------------------------------------
% search_good迴圈
%--------------------------------------------------------------------------
for examine_time=1:1000
now_check_time=examine_time    
information.final_check=0;
super_super_filter_flag=0;
%--------------------------------------------------------------------------
% 給予網路資訊
%--------------------------------------------------------------------------
information.number_of_output=1;
% information.number_of_neural1=2;
information.w1=rand(information.number_of_neural1,information.number_of_input)*2-1;  %產生 rand(row, col)隨意數值矩陣
information.w3=rand(information.number_of_output,information.number_of_neural1)*2-1; % *2-1 產生負值
information.d1=rand(information.number_of_neural1,1)*2-1;
% information.epoch=1;
information.goal=zeros(1,row);   %目標    
information.eta_wbb=0.001;     
% information.choose_ratio=0.01;
information.small_ratio=0.1;  

%--------------------------------------------------------------------------
% 建立網路
%--------------------------------------------------------------------------
brnn.number_of_input = information.number_of_input;
brnn.number_of_output = information.number_of_output;
brnn.number_of_neural1 = information.number_of_neural1;
brnn.w1=information.w1;
brnn.w3=information.w3;
brnn.d1=information.d1;
brnn.eta_wbb=information.eta_wbb;
brnn.op=[];
brnn.fq=[];
brnn.oq=[];
%--------------------------------------------------------------------------
% 輸入訊號進行訓練
%--------------------------------------------------------------------------
%     if information.epoch~=0
        for i=1:information.epoch
            for j=1:train_col
                brnn.op=train_datau(:,j);
                brnn.fq=brnn.w1*brnn.op+brnn.d1;%隱藏層的計算
                for k=1:brnn.number_of_neural1
                    brnn.pos_exp=exp(brnn.fq(k,1));
                    brnn.minu_exp=exp(-brnn.fq(k,1));
                    brnn.oq(k,1)=(brnn.pos_exp-brnn.minu_exp)/(brnn.pos_exp+brnn.minu_exp);
                end
                brnn.Y=brnn.w3*brnn.oq;%輸出
                [brnn]=network_update(brnn, train_datay(:,j));
            end
        end
%     else
%         if information.characteristic_number==0
%             row_check=row;
%         else
%             row_check=2;
%         end
%         epoch=0;
%         while sum(information.goal)~=row_check && epoch<=100
%             information.epoch=information.epoch+1;
%             epoch=information.epoch
%             for j=1:train_col
%                 brnn.op=train_datau(:,j);
%                 brnn.fq=brnn.w1*brnn.op+brnn.d1;
%                 for k=1:brnn.number_of_neural1
%                     brnn.pos_exp=exp(brnn.fq(k,1));
%                     brnn.minu_exp=exp(-brnn.fq(k,1));
%                     brnn.oq(k,1)=(brnn.pos_exp-brnn.minu_exp)/(brnn.pos_exp+brnn.minu_exp);
%                 end
%                 brnn.Y=brnn.w3*brnn.oq;
%                 [brnn]=network_update(brnn, train_datay(:,j));
%             end
%             % 終止條件之檢查
%             for i=1:row_check
%                 brnn.fq=brnn.w1*smallest_skyline(:,i)+brnn.d1;
%                 for j=1:brnn.number_of_neural1
%                     pos_exp=exp(brnn.fq(j,1));
%                     minu_exp=exp(-brnn.fq(j,1));
%                     brnn.oq(j,1)=(pos_exp-minu_exp)/(pos_exp+minu_exp);
%                 end
%                 goal_final(:,i)=brnn.w3*brnn.oq;
%                 if goal_final(:,i)>information.final_check
%                     information.goal(1,i)=1;
%                 else
%                     information.goal(1,i)=0;
%                 end
%             end
%         end
%     end
%--------------------------------------------------------------------------
% 訓練完成，輸入輸入訊號
%--------------------------------------------------------------------------
sucessH=0;
sucessNH=0;
final=[];
        brnn.oq=[];
        for i=1:test_col
            brnn.fq=brnn.w1*test_datau(:,i)+brnn.d1;
            for j=1:brnn.number_of_neural1
                pos_exp=exp(brnn.fq(j,1));
                minu_exp=exp(-brnn.fq(j,1));
                brnn.oq(j,1)=(pos_exp-minu_exp)/(pos_exp+minu_exp);
            end

            final(:,i)=brnn.w3*brnn.oq;
            if(test_datay(:,i)==0.9 && final(:,i)>0)
                sucessNH=sucessNH+1;
            elseif(test_datay(:,i)==-0.9 && final(:,i)<=0)
                sucessH=sucessH+1;
            end
        end

            name=['brnn_',num2str(test_col),'_',num2str(sucessNH+sucessH),'_',num2str(sucessNH),'_',num2str(sucessH)];
            save(name,'brnn','train_datau','test_datay','test_datau','train_datay','final');
            sum = sucessNH+sucessH;
%         end
    end
end



