new_mapping_adj_list=[];
for i  = 1:2276957
    display(i)
    y = mapping_adj_List(i,2);
    x = find(mapping_adj_List(:,1)==y);
    if(~isempty(x))
        new_mapping_adj_list=[new_mapping_adj_list;mapping_adj_List(i,:)];
    end
end
