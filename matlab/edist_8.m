function edist = edist_8(x,k)

edist = 0;
if sum(x(1:k)>1)>0
    edist = 0;
else
    for i=k+1:7
        if x(i)>1
            err = (x(i)-1)*2^(8-i);
            edist = edist + err;
        end
    end
end

end