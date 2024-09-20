function [new_pop, new_fit, F_data, Cr_data] = pop_gen(fun, pop, pop_fit, F_min, F_max, Cr_min, Cr_max, randomize, prob, lb, ub)

[dim, N] = size(pop);

new_pop = zeros(dim, N);
new_fit = zeros(1, N);

F_data = zeros(1, N);
Cr_data = zeros(1, N);

for i = 1:N
    F = F_min + (F_max - F_min) * rand();
    Cr = Cr_min + (Cr_max - Cr_min) * rand();

    if randomize
        flag = rand();

        if flag < prob
            F = lb + (ub - lb) * rand();
        end
    end

    F_data(i) = F;
    Cr_data(i) = Cr;

    idx = randperm(N - 1, 3);
    candidates = 1:N;
    candidates(i) = [];

    i2 = candidates(idx(1));
    i3 = candidates(idx(2));
    i4 = candidates(idx(3));

    x1 = pop(:, i);
    x2 = pop(:, i2);
    x3 = pop(:, i3);
    x4 = pop(:, i4);

    A = crossover(dim, Cr);
    nA = 1 - A;

    trial = nA .* x1 + A .* (x2 + F * (x3 - x4));
    trial_fit = funct(trial, fun);

    if trial_fit < pop_fit(i)
        new_pop(:, i) = trial;
        new_fit(i) = trial_fit;

    else
        new_pop(:, i) = x1;
        new_fit(i) = pop_fit(i);
    end
end