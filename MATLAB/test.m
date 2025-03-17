figure;

names = ["Quadratic Function", "Sphere Function", "Rosembrock function", "Rotated Rastrigin Function", "Rotated Ackley Function", "Schwefel Function", "BentCigar Function", "Ackley Function"];

for i = 1:8
    subplot(3, 3, i); % Create a 3x3 grid of subplots
    title(names{i});  % Set the title for each subplot

    for j = 1:15
        % Call DE_F for different scenarios and plot the results
        history = DE_F(i, 50, 10, 5000, -20, 20, 0.9, 0.5, 0.7, false, 0.05, 0.01, 0.001, 1);
        semilogy(history, 'Color', 'green', 'LineWidth', 0.5); % Plot with transparency effect

        DE_F(i, 50, 10, 5000, -20, 20, 0.9, 0.5, 0.7, true, 0.1, 0.01, 0.001, 1);
        hold on; % Hold on to add to the same plot
        semilogy(history, 'Color', 'red', 'LineWidth', 0.5);

        DE_F(i, 50, 10, 5000, -20, 20, 0.9, 0.5, 0.7, true, 1, 0.01, 0.001, 1);
        semilogy(history, 'Color', 'blue', 'LineWidth', 0.5);
    end

    % Add legend for the subplot
    legend({'Adapting without randomizing', 'Randomizing 1%', 'Randomizing all'}, 'Location', 'southwest');
    hold off; % Release the hold on the current plot
end

% Adjust layout to prevent overlap
sgtitle('Performance Comparison of Functions'); % Overall title for the figure