for i = 1:25
    fname = strcat('shift_data_', num2str(i), '.txt');
    fileID = fopen(fname,'w');
    
    for j = 1:100
        if rand() <= 0.2
            v = (-1)^(randi([0, 1])) * 100;
            fprintf(fileID, '%.8e ', v);
        else
            v = (-1)^(randi([0, 1])) * (80 + 20*rand());
            fprintf(fileID, '%.8e ', v);
        end
    end
    fprintf(fileID, '\n');
    
    fclose(fileID);
end