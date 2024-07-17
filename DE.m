classdef DE
    properties
        upper_bound
        lower_bound
        N
        dim
        F
        Cr
        max_evaluations
        best_fit
        best_sol
        population
        population_fitness
        obj_funct
        evaluations
        history
    end

    methods
        
        % Definindo as variáveis do DE
        function self = DE(ub, lb, N, dim, F, Cr, max_evaluations)

            arguments
                ub = 20
                lb = -20
                N = 50
                dim = 2
                F = 0.5
                Cr = 0.5
                max_evaluations = 300
            end

            self.upper_bound = ub;
            self.lower_bound = lb;
            self.N = N;
            self.dim = dim;
            self.F = F;
            self.Cr = Cr;
            self.max_evaluations = max_evaluations;
            self.evaluations = 0;
            self.best_fit = inf;
            self.best_sol = zeros(dim, 1);
            self.obj_funct = @(x) funct(x);
            self.history = zeros(1, max_evaluations);
           
            self.population = lb + (ub - lb) .* rand(dim, N);  
            self.population_fitness = zeros(N, 1);

            for i = 1:N
                xi = self.population(:, i);
                self.population_fitness(i) = self.obj_funct(xi);
            end
        end

        function x = classic_DE(self)

            while self.evaluations < self.max_evaluations
                [new_population, new_fitness] = generate_new_population(self);

                for i = 1:self.N
                    if new_fitness(i) < self.best_fit
                        self.best_sol = new_population(:, i);
                        self.best_fit = new_fitness(i);
                    end

                    self.evaluations = self.evaluations + 1;
                    self.history(self.evaluations) = self.best_fit;
                end

                self.population = new_population;
                self.population_fitness = new_fitness;
            end

            semilogy(self.history);
        end

        
        function [new_population, new_fitness] = generate_new_population(self)

            new_population = zeros(self.dim, self.N);
            new_fitness = zeros(self.N, 1);

            for i = 1:self.N
                idx = randperm(self.N - 1, 3);
                
                candidates = 1:self.N;
                candidates(i) = [];
    
                i2 = candidates(idx(1));
                i3 = candidates(idx(2));
                i4 = candidates(idx(3));

                x1 = self.population(:, i);
                x2 = self.population(:, i2);
                x3 = self.population(:, i3);
                x4 = self.population(:, i4);

                A = crossover(self);
                nA = 1 - A;

                trial = nA .* x1 + A .* (x2 + self.F * (x3 - x4));
                trial_fitness = self.obj_funct(trial);

                old_fitness = self.population_fitness(i);

                if trial_fitness < old_fitness
                    new_population(:, i) = trial;
                    new_fitness(i) = trial_fitness;

                else
                    new_population(:, i) = x1;
                    new_fitness(i) = old_fitness;
                end
            end
        end
        
        
        function A = crossover(self)
            A = zeros(self.dim, 1);
        
            for d = 1:self.dim
                if rand() < self.Cr
                    A(d) = 1;
                   
                else
                    A(d) = 0;
        
                end
            end
        end
    end
end


