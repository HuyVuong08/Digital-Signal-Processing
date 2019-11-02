
clear all;
close;
clc;


function y = Delay (x, n0, k)
len = length(x);
right = len - n0;
left = right - len + 1;
tx = [left:right];
ty = [left + k:right + k];
y = x;
plot (tx, x, 'b-.>d');
plot (ty, y, 'r-.>d'); 
endfunction



function y = Advance (x, n0, k)
len = length(x);
right = len - n0;
left = right - len + 1;
tx = [left:right];
ty = [left - k:right - k];
y = x;
plot (tx, x, 'b-.>d');
plot (ty, y, 'r-.>d'); 
endfunction



function y = Fold (x, n0)
lenX = length (x);
right = lenX - n0;
left = right - lenX + 1;
disparity = abs(left) - right;

if (disparity > 0) then
    right = right + disparity;
    while(disparity ~= 0)
        x = [x 0];
        disparty = disparity - 1;
    end
else
    left = left + disparity;
    n0 = n0 - disparity;
    while(disparity ~= 0)
        x = [0 x];
        disparity = disparity + 1;
    end
end

for i = left:right
y(i + n0) = x(-i + n0);
end

y = y';
t = [left:right];

plot (t, x, 'b-.>d');
plot (t, y, 'r-.>d'); 
endfunction



function y = Add (xn, n0, xm, m0)
lenXn = length (xn);
rightXn = lenXn - n0;
leftXn = rightXn - lenXn + 1;

lenXm = length (xm);
rightXm = lenXm - m0;
leftXm = rightXm - lenXm + 1;

leftDisparity = leftXn - leftXm;
rightDisparity = rightXn - rightXm;

if (leftDisparity > 0) then
    leftXn = leftXn - leftDisparity;
    n0 = n0 + leftDisparity;
    while(leftDisparity ~= 0)
        xn = [0 xn];
        leftDisparity = leftDisparity - 1;
    end
else
    leftXm = leftXm + leftDisparity;
    n0 = n0 - leftDisparity;
    while(leftDisparity ~= 0)
        xm = [0 xm];
        leftDisparty = leftDisparity + 1;
    end
end

if (rightDisparity > 0) then
    rightXm = rightXm + rightDisparity;
    while(rightDisparity ~= 0)
        xm = [xm 0];
        rightDisparity = rightDisparity - 1;
    end
else
    rightXn = rightXn - rightDisparity;
    while(rightDisparity ~= 0)
        xn = [xn 0];
        rightDisparity = rightDisparity + 1;
    end
end

for i = leftXn:rightXn
y(i + n0) = xn(i + n0) + xm(i + n0);
end

y = y';
t = [leftXn:rightXn];

plot (t, xn, 'b-.>d');
plot (t, xm, 'g-.>d');
plot (t, y, 'r-.d'); 

disp (y, "y = ");
disp (xn, "xn = ");
disp (xm, "xm = ");
endfunction



function y = Multiply (xn, n0, xm, m0)
lenXn = length (xn);
rightXn = lenXn - n0;
leftXn = rightXn - lenXn + 1;

lenXm = length (xm);
rightXm = lenXm - m0;
leftXm = rightXm - lenXm + 1;

leftDisparity = leftXn - leftXm;
rightDisparity = rightXn - rightXm;

if (leftDisparity > 0) then
    leftXn = leftXn - leftDisparity;
    n0 = n0 + leftDisparity;
    while(leftDisparity ~= 0)
        xn = [0 xn];
        leftDisparity = leftDisparity - 1;
    end
else
    leftXm = leftXm + leftDisparity;
    m0 = m0 - leftDisparity;
    while(leftDisparity ~= 0)
        xm = [0 xm];
        leftDisparty = leftDisparity + 1;
    end
end

if (rightDisparity > 0) then
    rightXm = rightXm + rightDisparity;
    while(rightDisparity ~= 0)
        xm = [xm 0];
        rightDisparity = rightDisparity - 1;
    end
else
    rightXn = rightXn - rightDisparity;
    while(rightDisparity ~= 0)
        xn = [xn 0];
        rightDisparity = rightDisparity + 1;
    end
end

for i = leftXn:rightXn
y(i + n0) = xn(i + n0) * xm(i + n0);
end

y = y';
t = [leftXn:rightXn];

plot (t, xn, 'b-.>d');
plot (t, xm, 'g-.>d');
plot (t, y, 'r-.d'); 

disp (y, "y = ");
disp (xn, "xn = ");
disp (xm, "xm = ");
endfunction



x0 = [4 2 1 3 4 0];
n0 = 2;
x1 = [1 0 2 1 3 4 1];
n1 = 5;



subplot (231);
y0 = Delay (x0, n0, 2);

subplot (232);
y0 = Advance (x0, n0, 2);

subplot (233);
y0 = Fold (x0, n0);

subplot (234);
y0 = Add (x0, n0, x1, n1);

subplot (236);
y0 = Multiply (x0, n0, x1, n1);

