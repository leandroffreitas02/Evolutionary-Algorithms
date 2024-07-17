function [best_fit, best_sol, history] = DE_FCr(N, dim, max_evaluations, obj_funct)    
    minF = 0.5;
    maxF = 0.9;

    minCr = 0.75;
    maxCr = 0.9;

    % Pré-alocar history
    history = zeros(1, max_evaluations);
    historyF = zeros(1, max_evaluations);
    historyCr = zeros(1, max_evaluations);

    % Best inicial
    best_fit = inf;
    best_sol = zeros(dim, 1);

    % Define limites baseados em dim
    lower_bound = -20 * ones(dim, 1);
    upper_bound = 20 * ones(dim, 1);

    % Build Population
    population = lower_bound + (upper_bound - lower_bound) .* rand(dim, N);

    % Evaluate all fitness functions of the initial population
    population_fitness = zeros(N, 1);
    for i = 1:N
        xi = population(:, i);
        population_fitness(i) = obj_funct(xi);
    end

    % DE loop
    for evaluations = 1:max_evaluations
        population2 = zeros(dim, N);
        fitness2 = zeros(N, 1);

        archiveF = zeros(1, N);
        archiveCr = zeros(1, N);

        archiveImprov = zeros(1, N);

        for i = 1:N  % Para cada indivíduo da população
            F = rand * (maxF - minF) + minF;
            Cr = rand * (maxCr - minCr) + minCr;
            idx = randperm(N - 1, 3);

            candidates = 1:N;
            candidates(i) = [];

            i2 = candidates(idx(1));
            i3 = candidates(idx(2));
            i4 = candidates(idx(3));

            x1 = population(:, i);
            x2 = population(:, i2);
            x3 = population(:, i3);
            x4 = population(:, i4);

            A = crossover(Cr, dim);
            nA = 1 - A;

            trial = nA.x1 + A.(x2 + F*(x3 - x4));
            trial_fitness = obj_funct(trial);

            fitness_old = population_fitness(i); 
            fitness_new = trial_fitness;

            if fitness_new < fitness_old % melhorou
                population2(:, i) = trial;
                fitness2(i) = fitness_new;
                % arquivar melhoria
                improv_step = population_fitness(i) - trial_fitness; % norm(x1 - trial);
                archiveImprov(i) = improv_step;
            else
                population2(:, i) = x1;
                fitness2(i) = fitness_old;
            end

            % Salvar o Cr do indivíduo
            archiveF(i) = F; 
            archiveCr(i) = Cr; 

            if fitness_new < best_fit
                best_sol = trial;
                best_fit = fitness_new;
            end

        end % fim da pop e encontrou best fit
        history(evaluations) = best_fit + 1e-55;

        % média dos 50% melhores F que deram melhor passo
        new = find(archiveImprov > 0);
        if(~isempty(new))
            [M, I] = sort(archiveImprov(new));
            bestF = archiveF(I(ceil(length(new)/2):length(new)));
            mediaF = mean(bestF);
            bestCr = archiveCr(I(ceil(length(new)/2):length(new)));
            mediaCr = mean(bestCr);
        end 

        historyCr(evaluations) = mediaCr; % pega a última média
        minCr_new = max(0.0001, mediaCr - 0.01);
        maxCr_new = min(1, mediaCr + 0.01);
    
        minCr = minCr_new;
        maxCr = maxCr_new;
        
        historyF(evaluations) = mediaF; % pega a última média
        minF_new = max(0.0001, mediaF - 0.01);
        maxF_new = min(1, mediaF + 0.01);
    
        minF = minF_new;
        maxF = maxF_new;
        
        % Update population and fitness for the next iteration
        population = population2;
        population_fitness = fitness2;

    end % fim do loop do DE

    % Imprime a solução
    %fprintf('Best value found: %f\n', best_fit);

    %figure(3);
    %plot(historyCr(1:evaluations));
    % disp(Cr)

end % fim da função

function A = crossover(Cr, dim)
    A = zeros(dim, 1);
    for d = 1:dim
        if rand() < Cr
            A(d) = 1;  % Trocar
        else
            A(d) = 0;  % Não trocar
        end
    end
end