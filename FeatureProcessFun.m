function [FeatureData2]=FeatureProcessFun(allData,InputData,featureNum,b_dataNum,dataLength,dataLength2) 

temp=[];normalFeature=[];FeatureData=[];FeatureData2=[];
[x y]=size(allData);
    %取最大最小值做補值
    [FeatureMaxMin]=DataMaxMin(allData);
    temp=[temp InputData FeatureMaxMin(1,:) FeatureMaxMin(2,:)];
    %做正規化
    normalFeature =[normalFeature normal_data(temp(1,:),temp(1,:),0.9,-0.9)];
    if dataLength==dataLength2
        for j=0:b_dataNum-1     
            for i=0:featureNum-1
                temp=[]; 
                temp=[temp normalFeature(1,((i*(dataLength/(featureNum*b_dataNum))+1+((dataLength/b_dataNum)*j)):((i+1)*(dataLength/(featureNum*b_dataNum))+((dataLength/b_dataNum)*j))))];
                FeatureData=[FeatureData;temp]; 
            end
            FeatureData2=[FeatureData2 FeatureData((((i+1)*j)+1):((i+1)*(j+1)),:)];
        end
    else
        for i=0:featureNum-1
                temp=[]; 
                temp=[temp normalFeature(1,(i*(dataLength/featureNum)+1:(i+1)*(dataLength/featureNum)))];     
                FeatureData2=[FeatureData2;temp]; 
        end
    end
end