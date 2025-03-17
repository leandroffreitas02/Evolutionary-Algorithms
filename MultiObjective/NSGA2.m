function a = NSGA2(funct_list, pop_size, n_dim)

    if nargin < 3
        n_dim = 2;
    end

    if nargin < 2
        pop_size = 10;
    end

    n_funct = length(funct_list);

    lower_bound = -20;
    upper_bound = 20;

    pop = lower_bound + (upper_bound - lower_bound) .* rand(n_dim, pop_size);
    pop_fit = zeros(n_funct, pop_size);

    for fun = 1:n_funct
        pop_fit(fun, :) = evaluate_function(funct_list(fun), pop);
    end

    disp(rank_solutions(pop_fit))

    function f = evaluate_function(fun, pop)

        pop_size = size(pop, 2);

        f = zeros(1, pop_size);

        for i = 1:pop_size
            xi = pop(:, i);
            f(i) = funct(xi, fun);
        end

        function A = rank_solutions(pop_fit)

            [n_funct, pop_size] = size(pop_fit);

            A = zeros(1, pop_size);

            for i = 1:pop_size
                pareto_optimal = true;

                for j = 1:pop_size
                    dominated = true;

                    for fun = 1:n_funct

                        if pop_fit(fun, i) < pop_fit(fun, j)
                            dominated = false;
                        end

                    end

                    if dominated
                        pareto_optimal = false;
                    end

                end

                if pareto_optimal
                    A(i) = 1;
                end

            end
