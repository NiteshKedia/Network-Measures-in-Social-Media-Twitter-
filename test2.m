newwww_mapping_adj_list=[];
for i  = 1:2276957
    display(i)
    y = mapping_adj_List(i,2);
    x = find(unique_parent_nodes(:,1)==y);
    if(~isempty(x))
        newwww_mapping_adj_list=[newwww_mapping_adj_list;mapping_adj_List(i,:)];
    end
end