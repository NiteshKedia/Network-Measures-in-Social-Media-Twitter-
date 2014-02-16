maincouter = 0;
counter =  0 ; 
for i = 1:1172297
    for j = i+1:1172297
        for k = j+1:1172297
            maincouter=maincouter+1;
%             display(maincouter);
               display([i,j,k]);
               
            ij=find(mapping_adjacency_List(:,1) == i & mapping_adjacency_List(:,2) == j);
%             ji=find(mapping_adjacency_List(:,2) == i & mapping_adjacency_List(:,1) == j);
%             jk=find(mapping_adjacency_List(:,1) == j & mapping_adjacency_List(:,2) == k);
%             kj=find(mapping_adjacency_List(:,2) == j & mapping_adjacency_List(:,1) == k);
%             ik=find(mapping_adjacency_List(:,1) == i & mapping_adjacency_List(:,2) == k);
%             ki=find(mapping_adjacency_List(:,2) == i & mapping_adjacency_List(:,1) == k);
%             
%             if((~isempty(ij) || ~isempty(ji))&&(~isempty(jk) || ~isempty(kj)) && (~isempty(ik) || ~isempty(ki)))
%                 display(i,j,k);
%                 counter = counter + 1;
%             end
        end
    end
end
                  