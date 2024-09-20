function f = classic_DE(fun, N, dim, F, Cr, max_eval, lb, ub)

% lower_bound = lb * ones(dim, 1);
% upper_bound = ub * ones(dim, 1);

history = [];
best_fit = inf;

pop = lb + (ub - lb) .* rand(dim, N);
pop_fit = zeros(1, N);

for i = 1:N
    xi = pop(:, i);
    pop_fit(i) = funct(xi, fun);
end

for eval = 1:max_eval

    [new_pop, new_fit, F_dt, Cr_dt] = pop_gen(fun, pop, pop_fit, F, F, Cr, Cr, false, 0, 0, 0);

    best_fit = min(best_fit, min(new_fit));

    for i = 1:N
        history = [history, best_fit];
    end

    pop = new_pop;
    pop_fit = new_fit;
end

f = history;