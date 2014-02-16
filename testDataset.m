%clear all;

disp('Processing Edge-List File')

A = csvread('C:\Users\Nitesh\Documents\MATLAB\SMM\twitty_1.1.1\dataset.csv');

dim = max(max(A));
[E_Size, junk] = size(A);

sprintf('The dataset has %d nodes and %d edges',dim, E_Size)

disp('Filling Adjanceny Matrix')

adj = sparse(A(:,1), A(:,2), ones(E_Size,1), dim, dim, E_Size);
if(isequal(adj,adj'))
    disp('Symmetric Adjacency Matrix - Undirected Graph')
else
    disp('Assymmetric Adjacency Matrix - Directed Graph')
end


