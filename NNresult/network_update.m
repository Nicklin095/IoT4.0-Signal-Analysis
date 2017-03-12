%--------------------------------------------------------------------------
% ���������פ媺���^�����g����������s�ƾڵ{��
%--------------------------------------------------------------------------

function [brnn]=network_update(brnn, input_data)

% �M�w�~�t
% activation.error=input_data-brnn.Y;

% ��sw3�x�}
w3_temp=brnn.w3;
% w2_temp=brnn.w2;
w1_temp=brnn.w1;

% activation.delta_s=activation.error;
activation.delta_s=input_data-brnn.Y;
for j=1:brnn.number_of_output
    for i=1:brnn.number_of_neural1
        brnn.w3(j,i)=brnn.w3(j,i)+brnn.eta_wbb*activation.delta_s(j,1)*brnn.oq(i,1);
    end
end

activation.delta_q=zeros(brnn.number_of_neural1,1);
% ��sw1 and d1 �x�}
for j=1:brnn.number_of_output
    for i=1:brnn.number_of_neural1
        activation.delta_q(i,1)=activation.delta_q(i,1)+activation.delta_s(j,1)*w3_temp(j,i)*4/(brnn.pos_exp+ brnn.minu_exp)^2;
    end
end
brnn.d1=brnn.d1+brnn.eta_wbb*activation.delta_q;
for j=1:brnn.number_of_neural1
    for i=1:brnn.number_of_input
        brnn.w1(j,i)=brnn.w1(j,i)+brnn.eta_wbb*activation.delta_q(j,1)*brnn.op(i,1);
    end
end



