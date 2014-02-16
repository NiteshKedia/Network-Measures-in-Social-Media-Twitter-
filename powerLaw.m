load  5000DataSetTwitterFinal.mat
unique_parent_nodes=unique(mapping_adjacency_List(:,1));                                %Uniques ID's of parent node in Edge List
node_degree=hist(mapping_adjacency_List(:,1),unique_parent_nodes);                      %Degrees of each node from above result 
unique_degrees=unique(node_degree);                                                     %Unique degrees in the list
Nodes_with_same_degree=[unique_degrees;hist(node_degree,unique_degrees)];               %No. of node with above result of Unique degree

%Power Law plot
%loglog of power law plot
plot(Nodes_with_same_degree(1,:),Nodes_with_same_degree(2,:),'o'),figure,plot(log(Nodes_with_same_degree(1,:)),log(Nodes_with_same_degree(2,:)),'o');            