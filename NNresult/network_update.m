%--------------------------------------------------------------------------
% ���������פ媺���^�����g����������s�ƾڵ{��
%--------------------------------------------------------------------------

function [brnn]=network_update(brnn, input_data)

% ��sw3�x�}
w3_temp=brnn.w3;
w1_temp=brnn.w1;

% �M�w�~�t
activation.delta_s=(input_data-brnn.Y)*(brnn.Y*brnn.Y*(1-brnn.Y));

for j=1:brnn.number_of_output
    for i=1:brnn.number_of_neural1
        brnn.w3(j,i)=brnn.w3(j,i)+brnn.eta_wbb*activation.delta_s(j,1)*brnn.oq(i,1);
    end
end
% ��sw1�x�}
for j=1:brnn.number_of_output
    for i=1:brnn.number_of_neural1
        activation.delta_q(i,1)=w3_temp(j,i)*activation.delta_s(j,1)*(brnn.w1(j,i)*(1-brnn.w1(j,i)))
    end
end
brnn.w1=w3_temp+brnn.eta_wbb*activation.delta_q;




