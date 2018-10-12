function clear_set = deleteNeighbors(max_num,set)
    siz = size(set, 2);
   
    i = 1;
    j = 1;
    n = 1;
    m = 1;
    a = 0;
    b = 0;
    pre_flag = 1;
    for j = 1 : siz - 1
        a = set(1, j);
        b = set(1, j + 1);
       
        if b - a ~= 1
            if pre_flag > max_num 
                for m = n : j
                    clear_set(1, i) = set(1, m);
                    i = i + 1;  
                end
            end
            n = j + 1;
            pre_flag = 1;
            continue;
        end 
        pre_flag = pre_flag + 1;
    end
    
    if pre_flag > max_num 
        for m = n : siz
            clear_set(1, i) = set(1, m);
            i = i + 1;  
        end
    end
end