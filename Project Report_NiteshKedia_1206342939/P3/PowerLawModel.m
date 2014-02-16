 A=load('RandomGraph.csv');
unique_parent_nodes=unique(A(:,1));                                %Uniques ID's of parent node in Edge List
node_degree=hist(A(:,1),unique_parent_nodes);                      %Degrees of each node from above result 
unique_degrees=unique(node_degree);                                                     %Unique degrees in the list
Nodes_with_same_degree=[unique_degrees;hist(node_degree,unique_degrees)];               %No. of node with above result of Unique degree

%Power Law plot
%loglog of power law plot
figure('name','RandomGraph'),plot(Nodes_with_same_degree(1,:),Nodes_with_same_degree(2,:),'o');

 A=load('PrefrentialGraph.csv');
unique_parent_nodes=unique(A(:,1));                                %Uniques ID's of parent node in Edge List
node_degree=hist(A(:,1),unique_parent_nodes);                      %Degrees of each node from above result 
unique_degrees=unique(node_degree);                                                     %Unique degrees in the list
Nodes_with_same_degree=[unique_degrees;hist(node_degree,unique_degrees)];               %No. of node with above result of Unique degree

%Power Law plot
%loglog of power law plot
figure('name','PrefrentialGraph'),plot(Nodes_with_same_degree(1,:),Nodes_with_same_degree(2,:),'o');

 A=load('SmallWorld.csv');
unique_parent_nodes=unique(A(:,1));                                %Uniques ID's of parent node in Edge List
node_degree=hist(A(:,1),unique_parent_nodes);                      %Degrees of each node from above result 
unique_degrees=unique(node_degree);                                                     %Unique degrees in the list
Nodes_with_same_degree=[unique_degrees;hist(node_degree,unique_degrees)];               %No. of node with above result of Unique degree

%Power Law plot
%loglog of power law plot
figure('name','SmallWorld'),plot(Nodes_with_same_degree(1,:),Nodes_with_same_degree(2,:),'o');