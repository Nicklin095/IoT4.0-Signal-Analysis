function [norm_datau]=normal_data(data,datau,max_d,min_d)
%
%[norm_datau]=normal(data,datau,max_d,min_d)
% data normal to max_d~min_d
% datau =find data base min and max
%
[row, col]=size(data);
data_max1=max(datau')'; 
data_min1=min(datau')'; 
data_max=repmat(data_max1,1,col);  
data_min=repmat(data_min1,1,col);
norm_datau=((data-data_min)./(data_max-data_min).*((max_d-min_d)*ones(row,col))) + min_d*ones(row,col);
