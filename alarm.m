    
function detected = alarm(ps, n, sli_width, significance_level)
    detected = -1;
    sum = 0;
    max = 0;

    %start from a positive num
    if n - sli_width + 1 > 0				        
        for i = n - sli_width + 1 : n
            sum = sum + (-ps(1, i) + 1 / 2);
            if abs(sum) > abs(max)
                max = sum;
            end
        end
    end

    if abs(max) >= sqrt(sli_width / (12 * significance_level))
       detected = n;
       %fprintf('Detected at frame %d\n', n);
    end
end