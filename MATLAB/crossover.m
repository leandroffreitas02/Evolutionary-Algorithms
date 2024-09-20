function A = crossover(dim, Cr)

A = zeros(dim, 1);

for d = 1:dim
    if rand() < Cr
        A(d) = 1;
    else
        A(d) = 0;
    end
end