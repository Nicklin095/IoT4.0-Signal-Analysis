% clc
% clear 
% H_NH_FeatureArray_Cut = [];
ImportData = NH_Feature_Result;
% ImportData = H_FeatureArray_test;
[ImportData_c ImportData_r]=size(ImportData);
Frame_num=10;
y=1;
Frame_begin=ImportData_r/Frame_num;%對原本的資料長度/Frame_num丟給Frame_begin
Frame_end=Frame_begin;
sucess_count = 0;
fail_count = 0;
for i=1:Frame_num
   
    ImportData_Cut =ImportData(:,y:Frame_end);%取原本的資料長度1到Frame_end
    y=y+Frame_begin;%Frame_begin+1  為了下次回圈重下個區段開始
    Frame_end=Frame_end+Frame_begin;%為了下次回圈重下個區段的結尾結束
    [ImportData_Cut_c ImportData_Cut_r]=size(ImportData_Cut);

    test_datau = ImportData_Cut;%值
    
    [row, test_col]=size(test_datau); %row列 
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
            if(final(:,i)>0)
                sucessNH=sucessNH+1;
            elseif(final(:,i)<0)
                sucessH=sucessH+1;
            end
        end
%         for k=1:126
%             if (final(:,k)>0)
%                 sucessH=sucessH+1;
%             end
%         end
%         for k=127:252
%             if  (final(:,k)<0)
%                 sucessNH=sucessNH+1;
%             end
%         end        
        if sucessNH*1.9>sucessH
            sucess_count = sucess_count + 1;
        else
            fail_count = fail_count + 1;
        end
            sucessNH*1.9
    sucessH

    sucess_count
    fail_count
end
total_conut = 0;
total_conut = sucess_count + fail_count;

 total_conut