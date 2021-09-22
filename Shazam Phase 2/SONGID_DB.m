function SONGID_list = SONGID_DB(directory)
    SONGID_list = get_mp3_list(directory);
    save SONGID_DB SONGID_list  
end