function [train_datau_V,V_type]=SVC_noml(temparray,V_mane)

train_datau=temparray;

% information.SVC_input=1; % 1 = I=eigenvectors*eigenvectors' , 2 = SVM eigenvectors 
% % -------------------------------------------
% % 正規畫
% % -------------------------------------------
% information.max_d=0.9;
% information.min_d=0.1;
% % [norm_skyline]=normal_data(norm_skyline,datau,information.max_d,information.min_d);% 原資料正規劃
% [norm_datau]=normal_data(datau,datau,information.max_d,information.min_d);% 原資料正規劃
% % -------------------------------------------
% % 特徵值
% % -------------------------------------------
% V_mane={'min' ,'rms' ,'var' ,'sum' ,'mean' ,'mad' ,'std'};
% train_datau=[min(norm_datau);rms(norm_datau);var(norm_datau);sum(norm_datau);mean(norm_datau); mad(norm_datau);std(norm_datau)];
% [row, col]=size(train_datau);
% data_max1=max(train_datau')'; %a=[1 2 3 ; 4 5 6 ; 7 8 9] max(a')'=[3 6 9]'
% data_min1=min(train_datau')';
% data_max=repmat(data_max1,1,col);  %[3 3 3;6 6 6;9 9 9]
% data_min=repmat(data_min1,1,col);
% train_datau=((train_datau-data_min)./(data_max-data_min).*((information.max_d-information.min_d)*ones(row,col))) + information.min_d*ones(row,col);
% % -------------------------------------------
% PCA
%    V: eigenvectors;  
%    D: eigenvalues;
% -------------------------------------------
X=train_datau;
N1=size(X,1); N2=size(X,2);
m=mean(X,2);
Y=X-repmat(m, [1 N2]); % Y is centered training data
if N1>N2
    [v1 D]=eig(Y'*Y);
    V=Y*v1;
else
    [V D]=eig(Y*Y');
end
% Compute the length of each eigenvectors
lenv=sqrt(sum(V.*V));
% Normalize eigenvectors according to its length
V=V./repmat(lenv, [size(V,1)   1]);
% sort V and D so that the largest eigenvalues are in the front
[D I]=sort(abs(diag(D)), 'descend');
V=V(:,I);
% -------------------------------------------
% within 70%~90%.
% -------------------------------------------
D_number=0;
P=sum(D)*0.8;
U=[];
for i=1:max(I)
    if(D_number <= P)
        D_number=D_number+D(i);
        U=[U V(:,i)];
    end
end
% -------------------------------------------
% Computing CPCA
% -------------------------------------------
H=U*U';
% -------------------------------------------
% SVD
% -------------------------------------------
[svd_U,svd_S,svd_V] = svd(H);
H=svd_V*svd_S*svd_V';
% -------------------------------------------
% SVC
% -------------------------------------------
% if information.SVC_input == 1
    data.X=H;
    options=struct('method','CG','ker','rbf','arg',0.88,'C',0.19);% 
% elseif information.SVC_input == 2
%     data.X=svd_V'; 
%     options=struct('method','CG','ker','rbf','arg',0.88,'C',0.19); %0.88,'C',0.19
% end
model=svc(data,options);
%plotsvc(data,model);
% -------------------------------------------
% 特徵值提取
% -------------------------------------------
% train_datau2=[min(norm_datau);rms(norm_datau);var(norm_datau);sum(norm_datau);mean(norm_datau); mad(norm_datau);std(norm_datau)];
% [train_datau]=normal_data(train_datau2,train_datau2,information.max_d,information.min_d);% 原資料正規劃

%  figure(1)
%     plot(train_datau(2,:),train_datau(3,:),'b.')
%     hold on
%     plot(text_skyline(2,:),text_skyline(3,:),'r*')
    
j=0;
train_datau_V=[];
for i =1:size(model.cluster_labels,2)
    if model.cluster_labels(i)==1
          train_datau_V=[train_datau_V ; train_datau(i,:)];
          j=j+1;
         V_type{j}=V_mane{i};
    end
end

% show=1;
% if show==1
%     count=2;
%     for i=1:j-1
%         for k=2:j      
%             if(i<k)
%                 count=count+1;
%                 save_name=[name '_' V_typr{i} '_' V_typr{k} ];
%                 %train_datau_V=get_some_point(train_datau_V,information.choose_ratio); 
%                 figure(count)
%                 plot(train_datau_V(i,:),train_datau_V(k,:),'b*')
%                 hold on
%                 plot(text_skyline_V(i,:),text_skyline_V(k,:),'r*')
%     %             for l=1:size(text_skyline_V,2) %顯示座標
%     %                 point= [num2str(norm_skyline(1,l)),'-',num2str(norm_skyline(2,l))];
%     %                 text(text_skyline_V(i,l),text_skyline_V(k,l),point);
%     %             end
%                 hold off
%                 title(save_name)
%                 if information.save_data == 1
%                     saveas( figure(count) , [ save_name, '.png' ] )
%                 end
%             end
%         end
%     end
% 
% end
