
--V. 1.2.5
local component = require("component")
local rb = require("robot")
local inventory = require("inventory")
local craft__ = component.crafting -- get primary crafting component


local craft ={}

--print(inventory:itemName(1));
--inventory:move(1,3)

local planks="minecraft:planks";
local log="minecraft:log";
local cobble="minecraft:cobblestone";
local stick="minecraft:stick";

local recipe = {

 map = {
    --know item ammount are after crafting
     ["stick"] = {planks,0,0,planks,ammount=2; };
     ["planks"] = {log,ammount=4; };
     ["stone-pickaxe"] = {cobble,cobble,cobble,0,stick,0,0,stick};
 };

}

function craft:setCraft  ()
  local slot=1;
    rb.swingUp();
      for levelJump =1 ,3 do
          for levelDrop=1,3 do

            rb.select(slot);

            rb.dropUp();
              slot=slot+1
          end
          slot=slot+1;
      end
end

--return slot value where item exist
function craft:findItem (name)
-- Searching Slots = []
--1     2    3   [4]
--5     6    7   [8]
--9     10   11  [12]
--[13] [14] [15] [16]
--[17] [18] [19] [20]
--[left slots---->>]

  local slot=1;
    rb.swingUp();
   -- select three right slots
      for RightSlot =1 ,3 do
              slot=slot+3
              -- Program in here
                --  rb.select(slot); --debug
                if inventory:itemName(slot) == name then
                   return slot; -- return slot value where item exist
                end
              slot=slot+1;
      end

      -- finish with last slots
      for bottomSlot=13,inventory:size() do
          --  rb.select(bottomSlot); --debug
            if inventory:itemName(bottomSlot) == name then
               return bottomSlot; -- return slot value where item exist
            end
      end
      return -1; -- if fails return -1
end --print ("I need planks " .. craft.findItem(planks));


-- find out how much are  materials and values  in crafting map ;
function craft:findCraftingAmount (recipe_map )
  local tb ={}; -- table where are amouth of

    if recipe_map~=nil and  recipe.map[recipe_map] ~= nil  then

        print ("Recipe ["..recipe_map.."] found");

            for item=1, #recipe.map[recipe_map] do

              local material = recipe.map[recipe_map][item]; -- return something like minecraft:planks

                  --print("material: "..tostring(material)); --debug
                  if material ~= 0  then -- material in table is minecraft:something
                      --print ("FOUND L: " .. material); --debug

                     if tb[ material ] == nil then -- if table instance not exist then  create one
                      --Save Amount of requare item
                      tb[ material ]={}; -- create a new instance of recipe.map[recipe_map][material]
                      tb[ material ]=0;
                    end

                      tb[ material ]=tb[ material ] + 1; -- add count  to this item
                      --tb[ recipe.map[recipe_map][material] ].value=;
                      --tb[recipe.map[recipe_map][material]].value=1;


                  end
            end
            -- debug
            -- for i,v in  pairs(tb) do
            --   print (i,v);
            --
            --
            -- end

        return tb; -- return collected ammmount
    end
    print ("~Recipe ["..tostring (recipe_map).."] not exist~");
    return nil;
end-- return table of list and item requare to craft value
--Exsample print (craft.findCraftingAmount("planks")["minecraft:log"]); -- return log ammout requare to craft planks


-- check if is enout materials to craft by given recipe
function craft:isEnouthMaterial  (recipe_map ,  ammountCraftingItem) -- ammountCraftingItem rezult a items requare to craft
  local material = craft:findCraftingAmount(recipe_map);
  local bool = true;
  local ammountCraftingItem= ammountCraftingItem or 1; --rezult a items requare to craft

    if material ~= nil then -- if recipe_map was found in recipe.map then
      print ("Is enough material ["..recipe_map.."] to craft: ")
       for item, ItemAmount in pairs(material) do

         ItemAmount = ItemAmount * ammountCraftingItem; -- each item to craft requare same amount of items
         local HaveItemsAmmount = inventory:getItemAmount(item);

        if ItemAmount > HaveItemsAmmount then -- if not enout item in inventory:then
             local AmountRezult = ItemAmount - HaveItemsAmmount;
                print("Missing ".. item .. " ammount "..AmountRezult.." requare." );
                bool = false;
              else
                 print ("Requare "..ItemAmount.." of "..item .. " are "..HaveItemsAmmount .. "." );
         end
       end
    end
    if material == nil then return nil; end
    return bool;
end



-- move requare items ammount  to a slots.
function craft:install (recipe_map , ammountCraftingItem) ----ammountCraftingItem each item to craft requare same amount of items
    if recipe.map[recipe_map] ~= nil then
        local ammountCraftingItem = ammountCraftingItem or 1;
        print ("->Recipe ["..recipe_map.."] found");



            local slot=1;
            local tbCounter=1;
              rb.swingUp();
                for levelJump =1 ,3 do
                    for levelDrop=1,3 do
                        local material = craft:findItem (recipe.map [recipe_map][tbCounter]) -- give requare material slot
                          local amount = ammountCraftingItem - rb.count (slot); -- return sum of requare item to move
                            --print ("requare: ".. tostring(recipe.map [recipe_map][tbCounter]).. " in "..slot.." slot ")

                            for x = 1 , inventory:size() - 9 do
                                if (amount > 0 and slot > 0 and material > 0) then

                                          print ("move  amount :"..amount .. ", slot: "..slot .. ".");
                                      -- move material to this slot
                                        inventory:move(material,slot , amount); --craft
                                        break;
                                end
                            end
                              --rb.select(slot)
                        slot=slot+1;
                        tbCounter=tbCounter+1; -- counter for a table level

                        --if tbCounter > #recipe.map [recipe_map] then  return 0 end -- to avoid looking in all slots
                    end
                    slot=slot+1;
                end

        return {};
    end
    print ("->Recipe ["..recipe_map.."] not exist");
end --Exsample --craft.install("planks")



-- loop in rewie slot and copare if item match with argiment slot
-- if no slot argument then look for any items
function craft:inRecipeSlot (slot)
  local recipeSlot=1; ;
    rb.swingUp();
      for levelJump =1 ,3 do
          for levelDrop=1,3 do
             if slot ~=nil then
                  local __slot = inventory:itemName (slot); -- return bool if fail to find

                  if __slot and  inventory:itemName (recipeSlot) == __slot  then
                    return recipeSlot ;
                  end
              else  -- if no slot argument then return any found item
                  if rb.count(recipeSlot) > 0 then
                    return recipeSlot;
                  end
              end
            --rb.select(recipeSlot);
              recipeSlot=recipeSlot+1;
          end
          recipeSlot=recipeSlot+1;
      end
      return -1;
end


-- loop in rewie slot and copare in bottom slots out of crafting grid if item match with argiment slot
-- if no slot argument then look for any items in bottom slots
function craft:inBottomMaterialSlot(slot) --Loop BottomSlot and
     for bSlot=13,inventory:size() do

           if slot~=nil then
                  if inventory:itemName(bSlot) == inventory:itemName(slot) and rb.count(bSlot) < 64  then
                    return bSlot
                 end
           else
               if rb.count(bSlot) == 0 then
                 return bSlot;  -- Bottom Slot is Free
              end

           end
     end
     return -1;
 end



-- Sorting items from recipe slots to materials slots
function craft:sortRecipeSlot ()


      -- local tprint = print; -- save  global print function
      -- local function print (var)  --debug function
      --     tprint (var); -- control if we want to see message
      -- end
--==============================================
 local function  indRightSlotMathing ()

    local indRightSlot=1;
     -- select three right slots then item in crafting grid is mathing
        for RightSlot =1 ,3 do
                indRightSlot=indRightSlot+3
                -- Program in here
                  --  rb.select(indRightSlot); --debug

                              for GridStep = 1 , 9 do

                                    local inGridMath = craft:inRecipeSlot (indRightSlot) ; -- looking for mathing item in crafting grid
                                    print ("In Grid Math:"..inGridMath.." with right indRightSlot:"..indRightSlot);
                                    if inGridMath < 0 or rb.count(indRightSlot) >= 64 then break; end -- if cannot find any math in selected material indRightSlot then stop looking
                                    if inGridMath>0 then inventory:move (inGridMath   , indRightSlot,64);  end;


                               end
                indRightSlot=indRightSlot+1;
        end
    end;
--==============================================
  local function indRightSlotAny()
        local indRightSlot=1;
               -- select only emty slots in material slot
                  for RightSlot =1 ,3 do
                          indRightSlot=indRightSlot+3
                          -- Program in here
                            --  rb.select(indRightSlot); --debug

                                        for GridStep = 1 , 9 do

                                              local inGridAny = craft:inRecipeSlot () ; -- looking for any item in crafting grid
                                                print ("In Grid Any:"..inGridAny.." indRightSlot:"..indRightSlot .. "="..rb.count(indRightSlot) .. " math name.:"..tostring( inventory.itemName(indRightSlot) ~= inventory.itemName(inGridAny) ));
                                              if inGridAny < 0 or rb.count(indRightSlot) >= 64 or inventory.itemName(indRightSlot) ~= inventory.itemName(inGridAny) then print ("BREAK slot:"..indRightSlot) break; end -- if cannot find any math in selected material indRightSlot then stop looking
                                              if rb.count(indRightSlot)== 0 and  inGridAny>0  then inventory:move (inGridAny   , indRightSlot,64);  end;


                                         end
                          indRightSlot=indRightSlot+1;
                  end

    end
--==============================================
  local function inBottomSlotMathing ()
 -- select three right slots then item in crafting grid is mathing
      for inBottomSlot =13 ,inventory:size() do

              -- Program in here
                --  rb.select(inBottomSlot); --debug

                            for GridStep = 1 , 9 do

                                  local inGridMath = craft:inRecipeSlot (inBottomSlot) ; -- looking for mathing item in crafting grid
                                  print ("In bottom Math:"..inGridMath.." with right inBottomSlot:"..inBottomSlot);
                                  if inGridMath < 0 or rb.count(inBottomSlot) >= 64 then break; end -- if cannot find any math in selected material inBottomSlot then stop looking
                                  if inGridMath>0 then inventory:move (inGridMath   , inBottomSlot,64);  end;


                             end
      end
  end
--==============================================
 local function inBottomSlotAny()
     -- select only emty slots in material slot
        for  inBottomSlot =13 ,inventory:size() do
                -- Program in here
                  --  rb.select(inBottomSlot); --debug

                              for GridStep = 1 , 9 do

                                    local inGridAny = craft:inRecipeSlot () ; -- looking for any item in crafting grid
                                      print ("In bottom Any:"..inGridAny.." inBottomSlot:"..inBottomSlot .. "="..rb.count(inBottomSlot) .. " math name.:"..tostring( inventory.itemName(inBottomSlot) ~= inventory.itemName(inGridAny) ));
                                    if inGridAny < 0 or rb.count(inBottomSlot) >= 64 or inventory.itemName(inBottomSlot) ~= inventory.itemName(inGridAny) then print ("BREAK slot:"..inBottomSlot) break; end -- if cannot find any math in selected material inBottomSlot then stop looking
                                    if rb.count(inBottomSlot)== 0 and  inGridAny>0  then inventory:move (inGridAny   , inBottomSlot,64);  end;


                               end
        end
  end

--==============================================
local  function SortMaterialSlots(AnyorMAthing)

      if AnyorMAthing == "mathing" then
          local indRightSlot=1;
           -- select three right slots then item in crafting grid is mathing
              for RightSlot =1 ,3 do
                      indRightSlot=indRightSlot+3
                      -- Program in here
                        --  rb.select(indRightSlot); --debug

                                    for GridStep = 13 , inventory:size() do

                                          local inGridMath = craft:inBottomMaterialSlot (indRightSlot) ; -- looking for mathing item in crafting grid
                                          print ("In Grid Math:"..inGridMath.." with right indRightSlot:"..indRightSlot);
                                          if inGridMath < 0 or rb.count(indRightSlot) >= 64 then break; end -- if cannot find any math in selected material indRightSlot then stop looking
                                          if inGridMath>0 and rb.count(indRightSlot) > 0 then inventory:move (indRightSlot,  inGridMath ,64);  end;


                                     end
                      indRightSlot=indRightSlot+1;
              end
        end
            ----------------------
        if AnyorMAthing == "all" then
            local indRightSlot=1;
                   -- select only emty slots in material slot
                      for RightSlot =1 ,3 do
                              indRightSlot=indRightSlot+3
                              -- Program in here
                                --  rb.select(indRightSlot); --debug

                                            for GridStep = 13 , inventory:size() do

                                                    local inGridAny = craft:inBottomMaterialSlot () ; -- looking for any item in crafting grid
                                                    print ("In Grid Any:"..inGridAny.." indRightSlot:"..indRightSlot .. "="..rb.count(indRightSlot) .. " math name.:"..tostring( inventory.itemName(indRightSlot) ~= inventory.itemName(inGridAny) ));
                                                  --if inGridAny < 0 or rb.count(indRightSlot) >= 64 or inventory.itemName(indRightSlot) ~= inventory.itemName(inGridAny) then print ("BREAK slot:"..indRightSlot) break; end -- if cannot find any math in selected material indRightSlot then stop looking
                                                  if rb.count(indRightSlot) > 0 and  inGridAny>0  then  inventory:move (indRightSlot, inGridAny   ,64); end



                                             end
                              indRightSlot=indRightSlot+1;
                      end

        end
end

      print("----->SORTING STARDED<----")
        -- Sequal bottom
        inBottomSlotMathing ();
        inBottomSlotAny();
        inBottomSlotMathing ();
          -- Sequal right
        indRightSlotMathing ();
        indRightSlotAny();
        indRightSlotMathing ();
        --Finaly sort slots are sorted
        SortMaterialSlots("mathing");
        SortMaterialSlots("all");
        SortMaterialSlots("mathing");
        print("-----> COMPLETE SORTING<----")


end -- sort function end
---------------------------------------------------------------------


--==============================================


function craft:cleanRecipeSlots (recipe_map , ammountCraftingItem )
    local material =craft:findCraftingAmount (recipe_map );
    local ammountCraftingItem = ammountCraftingItem or 1;
    -- move not requared item
    if material ~= nil then  -- Remove
         for slot= 1 , inventory:size() do
           local junk=true; -- if not item we are looking for then drop as junk
                   for item,ItemAmount in pairs(material) do
                        -- print ("SLOT: "..slot.."i ",name," v ",ItemAmount);
                         --os.sleep(.4);

                            if (rb.count(slot) > 0 and item == inventory:itemName(slot)) then -- drop requare amount of item to be crafted later

                                         local amount = inventory:getItemAmount (item) ;
                                         local __amount =amount - (ammountCraftingItem * ItemAmount); -- return sum of requare item to move
                                          --print("amount: "..amount..", "..ItemAmount  );
                                               if __amount >64 then __amount = 64; end;
                                               rb.select(slot);
                                            --   print ("DROPP:"..__amount.." of " ..amount.." a "..item .. ",".. ammountCraftingItem*ItemAmount .." requare ");
                                               rb.dropUp(__amount);
                                        --     end
                                               junk = false; -- if found  something from map list then mean is not a junk
                            end
                     end

                    if junk and rb.count(slot) > 0 then
                        rb.select (slot);
                        rb.dropUp();
                    end;
           end
        else return -1
    end
end

local function  craftThis (recipe_map , ammountCraftingItem)
    local tb ={}; -- table where are amouth of

      if recipe_map~=nil and  recipe.map[recipe_map] ~= nil  then

          print ("Craft ["..recipe_map.."] found");
              local ammount = recipe.map[recipe_map].ammount or 1; -- table output ammount
              local ammountCraftingItem = ammountCraftingItem or 1;
              local craftAmount = ammount * ammountCraftingItem;
              local recipe_map=recipe_map or "";

              print ("Craft: "..craftAmount);
              if craftAmount > 64 then
                  print ("Only make  64 per craft~!")
              end
              rb.select(13);
              craft__.craft(craftAmount ); -- requare full out[ut ammount ]



          return tb; -- return collected ammmount
      end
end



function craft:craft(recipe_map , ammount)
  local recipe_map=recipe_map or "1";
      local ammount=ammount or 1;


      if craft:isEnouthMaterial(recipe_map, ammount)  then
          craft:cleanRecipeSlots(recipe_map , ammount);
          craft:sortRecipeSlot ();
          craft:install (recipe_map , ammount);


                craftThis (recipe_map,ammount);


          for xtime=1,9 do
              rb.suckUp();
          end
          print("Success!");

          for i=1,inventory:size() do
            rb.suckUp();
          end
          return true;
      else
        print "Cannot craft, not enout materials or bad recipe name."
      end
end




--craft:craft("picaxe");

 --craft:isEnouthMaterial("SIESE", 3)
--craft__.craft(800);

--craft:install ("planks" , 3);
--craft:findCraftingAmount ("planks" )



--print (inventory:itemName(1))
--print (inventory:itemName(1) == recipe.stick)


return craft;
