%--------------------------------------------------------------------------
% 模擬水哥論文的遞回類神經網路網路更新數據程式
%--------------------------------------------------------------------------

function [brnn]=network_update(brnn, input_data)

% 更新w3矩陣
w3_temp=brnn.w3;
w1_temp=brnn.w1;

% 決定誤差
activation.delta_s=(input_data-brnn.Y)*(brnn.Y*brnn.Y*(1-brnn.Y));

for j=1:brnn.number_of_output
    for i=1:brnn.number_of_neural1
        brnn.w3(j,i)=brnn.w3(j,i)+brnn.eta_wbb*activation.delta_s(j,1)*brnn.oq(i,1);
    end
end
% 更新w1矩陣
for j=1:brnn.number_of_output
    for i=1:brnn.number_of_neural1
        activation.delta_q(i,1)=w3_temp(j,i)*activation.delta_s(j,1)*(brnn.w1(j,i)*(1-brnn.w1(j,i)))
    end
end
brnn.w1=w3_temp+brnn.eta_wbb*activation.delta_q;




