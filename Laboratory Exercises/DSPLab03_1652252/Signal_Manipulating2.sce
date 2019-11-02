

clear all;
close;
clc;


function y = get_even_component (x, n0)
len = length(x);
right = len - n0;
left = right - len + 1;

y = zeros(1, len);

for i=1:len
    if (modulo(x(i), 2) == 0) then
        y(i) = x(i);
    else
        y(i) = 0;
    end
end

t = [left:right];

plot (t, x, 'b-.>d');
plot (t, y, 'r-.>d'); 
endfunction



function y = get_odd_component (x, n0)
len = length(x);
right = len - n0;
left = right - len + 1;

y = zeros(1, len);

for i=1:len
    if (modulo(x(i), 2)) then
        y(i) = x(i);
    else
        y(i) = 0;
    end
end

t = [left:right];

plot (t, x, 'b-.>d');
plot (t, y, 'r-.>d'); 
endfunction



function y = Convolution (x, n0, h, h0)
lenX = length(x);
rightX = lenX - n0;
leftX = rightX - lenX + 1;

lenH = length(h);
rightH = lenH - h0;
leftH = rightH - lenH + 1;

leftY = leftX + leftH;
rightY = rightX + rightH;
lenY = -leftY + rightY + 1;
y0 = 1 - leftY;

y = zeros(1, lenY);

for i = leftY:rightY
    for j = leftY:rightY
        if (j < leftX | j > rightX | i - j < leftH | i - j > rightH) then
            continue;
        else
            y(i + y0) = y(i + y0) + x(j + n0) * h(i - j + h0);
        end
    end
end

disp (y, "y = ");
disp (x, "x = ");
disp (h, "h = ");

tX = [leftX:rightX];
tH = [leftH:rightH];
tY = [leftY:rightY];

plot (tX, x, 'b-.>d');
plot (tH, h, 'g-.>d'); 
plot (tY, y, 'r-.>d'); 
endfunction



x0 = [4 2 1 3 4];
n0 = 2;
x1 = [1 0 2 1 3 4 1];
n1 = 5;



subplot (221);
y0 = get_even_component (x0, n0);

subplot (222);
y0 = get_odd_component (x0, n0);

subplot (223);
y0 = Convolution (x0, n0, x1, n1);
