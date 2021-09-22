function DB = HASHTABLE(Hashtable,peak_pair,SONGID)
    DB = Hashtable;
    for i = 1:length(peak_pair) 
        index = Hindex(peak_pair(i,3),peak_pair(i,4),peak_pair(i,2)-peak_pair(i,1)); %f1 f2 t2-t1
        DB(index).t1 = [DB(index).t1,peak_pair(i,1)];
        DB(index).Song_ID = [DB(index).Song_ID,SONGID];
    end    
    save HASHTABLE DB
end