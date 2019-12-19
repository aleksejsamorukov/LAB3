%Lab2
clear;
x = 0.1:1/22:1;
d = ((1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2);
eta = 0.15;
n = 1;
c_1 = 0.2;
c_2 = 0.9;
r_1 = 0.25;
r_2 = 0.2;
plot(x,d,'r*');

w_0(n) = randn(1);
w_1(n) = randn(1);
w_2(n) = randn(1);

y = zeros(1,20);
e_total=ones(1,20);
step = 1;
steps = 0;


y_11 = exp(-(x(1)-c_1)^2/(2*r_1^2));
y_12 = exp(-(x(1)-c_2)^2/(2*r_2^2));
y_first = y_11*w_1(n) + y_12*w_2(n) + w_0(n);
e = d(1) - y_first;

while max(e_total) > 0.15
     for id = 1:20
        y_11 = exp(-(x(id)-c_1)^2/(2*r_1^2));
        y_12 = exp(-(x(id)-c_2)^2/(2*r_2^2));

        y(id) = y_11*w_1(n) + y_12*w_2(n) + w_0(n);

        w_1(n+1) = w_1(n) + eta*e*x(id);
        w_2(n+1) = w_2(n) + eta*e*x(id);
        w_0(n+1) = w_0(n) + eta*e;

        e = d(id) - y(id);
        n = n+1;
        e_total(id) = abs(e);
    end %for
    step = step + 1;
    if step > 1000000
        step = 1;
        n = 1;
        e = randn(1);
        w_0(n) = randn(1);
        w_1(n) = randn(1);
        w_2(n) = randn(1);
        steps = steps+ 1;
    end %if
end %while

y_out = zeros(20,1);

for idx = 1:20 
    y_11 = exp(-(x(idx)-c_1)^2/(2*r_1^2));
    y_12 = exp(-(x(idx)-c_2)^2/(2*r_2^2));
    
    y(idx) = y_11*w_1(n) + y_12*w_2(n) + w_0(n);

    y_out(idx) = y(idx);
end %for

plot(x,d,'r*', x, y_out, 'g*');
