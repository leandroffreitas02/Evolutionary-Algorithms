function f = DE_F(fun, N, dim, max_eval, lb, ub, F_max, F_min, Cr, randomize, prob, dist, random_lb, random_ub)

history = [];
F_history = [];
best_fit = inf;

pop = lb + (ub - lb) .* rand(dim, N);
pop_fit = zeros(1, N);

for i = 1:N
    xi = pop(:, i);
    pop_fit(i) = funct(xi, fun);
end

for eval = 1:max_eval
    [new_pop, new_fit, F_data, Cr_data] = pop_gen(fun, pop, pop_fit, F_min, F_max, Cr, Cr, randomize, prob, random_lb, random_ub);

    best_fit = min(best_fit, min(new_fit));

    improv = pop_fit - new_fit;
    improv_data = [];

    for i = 1:N
        if improv(i) > 0
            improv_data = [improv_data; improv(i), F_data(i)];
        end
    end

    F_mean = 0;

    if ~isempty(improv_data)
        improv_data = sortrows(improv_data, -1);
        improv_data = improv_data(1:ceil(size(improv_data, 1)/2), :);

        F_mean = mean(improv_data(:, 2));
        F_min = max(0.0001, F_mean - dist);
        F_max = min(1, F_mean + dist);
    end

    history = [history, best_fit];
    F_history = [F_history, (F_min + F_max)/2];

    pop = new_pop;
    pop_fit = new_fit;
end

f = history;