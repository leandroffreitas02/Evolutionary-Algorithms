function y = funct(x, fun)

n = length(x);
Q = matpi(n);

if fun==1  % Quadratic function
    phi = 1e-3;
    v1 = ones(n,1)/sqrt(n);
    v2 = null(v1');
    V = [v1 v2];
    d = ones(1,n);
    d(1) = phi;
    D = diag(d);
    Q = V'*D*V/phi;
    y = x'*Q*x;
elseif fun==2  % Sphere function
    y = x'*x;
elseif fun==3 % Rosenbrock function
    y = 0;
    for i=1:n-1
        y = y + 100*(x(i+1) - x(i)^2)^2 + (x(i) - 1)^2;
    end
elseif fun==4  % rotated Rastrigin function
    z = Q*x;
    y = 0;
    for i=1:n
        y = y + z(i)^2 - 10*cos(2*pi*z(i)) + 10;
    end
elseif fun==5  % rotated Ackley function
    z = Q*x;
    cz = cos(2*pi*z);
    y = -20*exp(-0.2*sqrt(z'*z/n)) - exp(sum(cz)/n) + 20 + exp(1);
elseif fun==6  % Schwefel function
    y = 0;
    for i=1:n
        y = y + (sum(x(1:i)))^2;
    end
elseif fun==7  % new function
    y = 0;
    for k = -10:10
        y = y + exp(-(x(1)-x(2))^2 - 2*x(1)^2)*cos(x(2))*sin(2*x(2));
    end
 
elseif fun==8  % BentCigar function
    y = x(1)^2 + 10^6 * sum(x(2:end).^2);

elseif fun==9  % Ackley function
    a = 20;
    b = 0.2;
    c = 2 * pi;
    sum1 = 0;
    sum2 = 0;
    
    for i = 1:n
        sum1 = sum1 + x(i)^2;
        sum2 = sum2 + cos(c * x(i));
    end

    term1 = -a * exp(-b * sqrt(sum1 / n));
    term2 = -exp(sum2 / n);
    y = term1 + term2 + a + exp(1);

end


% ================================================================
function M = matpi(n)
% matriz n x n contendo os digitos das potencias inteiras de pi
% M é uma matriz construída de maneira determinística

npi = ceil(n^2/15);
a = [];
for i=1:npi
    a = [a num2str(pi^i,17)];
end
posp = find(a=='.');
a(posp) = [];
M = zeros(n);
for i=1:n
    for j=1:n
        ind = (i-1)*n + j;
        M(i,j) = str2num(a(ind));
    end
end
M = M'*M;
M = M/norm(M);
