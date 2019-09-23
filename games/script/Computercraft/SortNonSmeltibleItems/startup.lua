term.clear();
term.setCursorPos(1,1);
-- Smelt , crush list.
sortList = {"minecraft:iron_ore","minecraft:gold_ore",
			"thermalfoundation:ore",
			"immersiveengineering:ore"
			}

local timeleft = 20;

print("Sorting program will start up " );

-- annonse about start time

while true do 
     if timeleft <= 0 then break end;
     timeleft = timeleft - 1;   
     term.setCursorPos(2,2); 
        term.clearLine();
        write(timeleft);
        sleep (1);
end
term.setCursorPos(1,2);
term.clearLine();



-- Sorting program start
local textMax = 5;
local trackTextMax = -1;


while true do
    for slot = 1, 16 do
        if turtle.getItemCount(slot) > 0 then 
            info = turtle.getItemDetail(slot);  boolIsSortable = false; -- save condition throw list if that true
  boolIsSortable = false; -- save condition about item are included in sortList or not.


            for id,listName in pairs(sortList) do 
             --   print("in "..slot.." slot ,["..id.." name:"..listName.."]");
                    
                    if (listName == info.name) then 
                       
                        boolIsSortable = true;
                                                                    
                    end
            end
        
            if not boolIsSortable then  
                turtle.select(slot);
                turtle.dropDown();
                
                -- track text
                if textMax > trackTextMax then 
                
					 trackTextMax = trackTextMax + 1;
					 
                else
                    
                     trackTextMax = 0;
					 for line=2,3 do term.setCursorPos(1,line); term.clearLine(); end 
				   
                end
                     
					term.setCursorPos((trackTextMax == 0 and 0 or trackTextMax)*6,2);
					write(" in "..slot..",");					
					 
				 term.setCursorPos(1,3);
				-- term.clearLine(1,3);
				 write (info.name);
				 
				 	-- term.setCursorPos(1,5);
					-- print ((trackTextMax == 0 and 0 or trackTextMax).."          ")
               
                
            end 
        
        end
    end
sleep(5);
end
