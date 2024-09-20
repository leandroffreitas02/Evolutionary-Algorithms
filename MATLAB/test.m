for i = 1:9
    his = DE_F(i, 50, 3, 500, -20, 20, 1, 0.0001, 0.7, false, 0, 0.001, 0.0001, 1);

    semilogy(his);
    hold on;
    legend('show');

end

hold off;