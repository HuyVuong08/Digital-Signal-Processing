clear all;
close;
clc;

function [quantizedNorData, quantizedOriData] = scilab_fQuantizeData (data,noBits);
    max_data = max(abs(data));
    data = data./max_data;
    ln = length(data);
    for i = 1:ln
        if noBits > 1
            step_size = 2/(2^noBits);
        end
    end
endfunction

bits = 3;
f = 1;
fs = 5;
t = 0:%pi/64:2*%pi;
ts = 0:1/fs:2*%pi;


x = sin(2*%pi*f*t);
subplot(211);
plot2d(t,x); xgrid(3);

//Samplling
y = sin(2*%pi*f*ts);
subplot(211);
plot(ts,y,'rd'); xgrid(2);

//Quantizing
Amplitude = max(abs(y));
noSamples = length(y);
quantizedData = zeros(1,noSamples);
step_size = 2*Amplitude/(2^bits);
Llow = -Amplitude + step_size/2;
Lhigh = Amplitude -step_size/2;
for i = Llow:step_size:Lhigh
    for j = 1:noSamples
        if (((i-step_size/2)<=y(j))&&(y(j)<=(i+step_size/2)))
            quantizedData(j) = i;
        end
    end
end

subplot(211);
plot(ts,quantizedData,'bd'); xgrid(4);

//Coding
signe = uint8((sign(quantizedData)'+1)/2)
codedData = [signe dec2bin(abs(quatizedData),bits)]

disp(codedData);
