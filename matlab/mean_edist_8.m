function med8=mean_edist_8(x)

%med_a=mean_edist_8(error_a)
%sum(sum(med_a(:,:,1)))/sum(sum((med_a(:,:,1)>0)))
%sum(sum(med_a(:,:,2)))/sum(sum((med_a(:,:,2)>0)))

med8=0;
for i=1:253
    for j=1:253
        for k=1:6
        med8(i,j,k)=edist_8(x(i,j,:),k);
        end
    end
end

end