--v1.4.7

local rb = require("robot")
local comp = require("component")
local computer = require("computer")
local sides = require("sides")
local fuel = comp.generator;
local CONTROLER = comp.inventory_controller;
local iSize=rb.inventorySize(); --Inventory Size

local inventory = {};



--ITEM DATA
function inventory:itemName (slot)
local item;
--assert ( slot > 0 and slot <= iSize ,"itemName:Slot number to hight or to low! "..tostring (slot).."<<------------")
slot = slot or iSize;

 if rb.count (slot) > 0 then -- chesk or give error bellow line
    item = CONTROLER.getStackInInternalSlot(slot );

   -- print (item.name.."WTF error" .. c);
    return tostring(item.name);
 end
   return false;
   --print(inventory.itemName(1) );
end

-- search for item in inventory and return slot number
function inventory:findName(name)
  local name = name or "";
   for slot=1,inventory:size() do
      if inventory:itemName(slot) == name then
          return slot;
      end
   end
   return -1;
 end

function inventory:durability() -- return item slot durability

      if (rb.durability() ~= nil) then
        return math.floor(rb.durability()/1*100); -- get in procent
      end
       return -1;
end

-- Equip object by given slot
function inventory:equip(slot)
  if slot ~= nil then rb.select(slot); end ;

  return CONTROLER.equip(slot);
end


function inventory:equipTool(name) -- automaticly equip item by given name
    local name=name or "";

    for slot = 1,inventory:size() do
        if (inventory:itemName (slot) == name) then
            rb.select(slot);
            CONTROLER.equip(slot);
            return true ;
        end
    end
end


-- Size of inventory
function inventory:size  ()
  return iSize;
end



function inventory:move  (a,b,amount)
--assert ( a>0 and b>0 and a<=iSize and b<iSize ,"move:Slot number to hight or to low! "..tostring (slot).."<<------------")
amount=amount or 1; --defoult transfer
rb.select(a)
  return rb.transferTo(b,amount);
end

function inventory:sort (slot)

end


--return how much are minecraft:planks
  function inventory:getItemAmount (name) -- bugs with findItem and cannot pass argument to it if using inventory.findItemAmount. To fix that use doble collums inventory:findItemAmount
  local name = name or "ERROR_NO_ITEM";
  local cnt=0;
  --print ("inventory:findItemAmount:"..tostring(name));
  for slot=1,iSize do
        if inventory:itemName(slot) == name then
            cnt=cnt + rb.count (slot);
        end
  end
   return cnt;
end
--print (inventory:getItemAmount ("minecraft:log"));


function inventory:dropItem(name,amountLeave,side) -- drop named item by gaved amount to Leave
    local amountLeave=amountLeave or 0;
    local name=name or "";
    local side = side or sides.bottom;
    for slot=1,inventory:size() do
          if inventory:itemName(slot) == name then

             local amountTotal=inventory:getItemAmount (name);
             local amount= amountTotal-amountLeave;

              if (amount>64)then amount=64;end
                    rb.select(slot);
                   if side == 3 then rb.drop(amount);  -- 'drop front'
                   elseif side == 1 then rb.dropUp(amount);  -- 'drop up'
                   elseif side == 0 then rb.dropDown(amount);  -- 'drop bottom'
                   end
               end


    end
end --Ex: inventory:dropItem("minecraft:planks",12,sides.top);


return inventory;
