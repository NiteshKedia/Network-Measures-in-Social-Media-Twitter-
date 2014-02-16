clear all;
                                                                            %Giving credentials to access twitter
credentials.ConsumerKey = 'VeVzP9Hjd2DzLD0rV6nWYQ';
credentials.ConsumerSecret = 'XCOG27tJbwbWLDAGBMQm9BeuwCsiIyBiwPILAZ4qo';
credentials.AccessToken = '400213917-MhrVhgyU0YsG6dGQTpv2UnCHCqDgw0JExIGNhiwy';
credentials.AccessTokenSecret = 'xydhgw4X4eCqOuIoQ0OJUUHSkjYOPz5vdH7pEfAqQ';
tw = twitty(credentials);

                                                                            %Initialisations
parent_user_ID = 400213917;
mapping_Id = 1;
counter = 1;
mapping_Table = [parent_user_ID mapping_Id];
current_adjacency_List = [];
mapping_adjacency_List = [];
adjacency_List = [];
unique_no_parent_nodes=1;

                                                                            %Iterating for 5000 nodes
while(unique_no_parent_nodes < 5001)
    display(unique_no_parent_nodes)
    if(rem(counter,15) == 0)
        pause(910);
    end                                                                       
    Followings = tw.friendsIds('user_id',parent_user_ID);                   %Getting Followings of a user_ID and processing them
    current_adjacency_List = current_adjacency_List(2:end,:);
    if ~ischar(Followings)
        Followings = cell2mat(Followings{1,1}.ids);
        if(length(Followings) > 1000 )
            Followings = Followings(1:1000);                                %taking only max only 1000 followings of every user
        end
        counter = counter + 1;
        for followings = Followings
            user_ID = uint32(followings);
            temp = [parent_user_ID user_ID];
            adjacency_List = [adjacency_List;temp];
            current_adjacency_List = [current_adjacency_List;temp];
            row_user_ID = find(mapping_Table(:,1)==user_ID);
            row_parent_user_ID = find(mapping_Table(:,1)==parent_user_ID);
            if(isempty(row_user_ID))
                mapping_Id = mapping_Id + 1;
                temp = [user_ID mapping_Id];
                mapping_Table = [mapping_Table;temp];
                row_user_ID = mapping_Id;
            end
            temp = [row_parent_user_ID row_user_ID];
            mapping_adjacency_List = [mapping_adjacency_List;temp];
        end
    end
    temp = 0;                                                                          
    while temp ~= 1                                                         %Getting the next unprocessed parent ID and 
        parent_user_ID = current_adjacency_List(1,2);                       %remove it from the current_adjacency_List if already processed
        ID_already_processed = find(adjacency_List(:,1) == parent_user_ID);
        if(isempty(ID_already_processed))
            temp = 1;
        else
            current_adjacency_List = current_adjacency_List(2:end,:);
        end
    end
    unique_no_parent_nodes=length(unique(mapping_adjacency_List(:,1)));
end

dlmwrite('non_annonymized_edge_List.csv',adjacency_List,'precision','%d');
dlmwrite('annonymized_edge_List.csv',mapping_adjacency_List,'precision','%d');
dlmwrite('mapping_Table.csv',mapping_Table,'precision','%d');

