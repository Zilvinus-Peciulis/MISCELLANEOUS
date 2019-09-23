local rb = require("robot")
local comp = require("component")
local computer = require("computer")
local fuel = comp.generator;

local iSize=rb.inventorySize(); --Inventory Size

local inventory = {};



--ITEM DATA
function inventory:itemName (slot)
local item;
--assert ( slot > 0 and slot <= iSize ,"itemName:Slot number to hight or to low! "..tostring (slot).."<<------------")
slot = slot or iSize;

 if rb.count (slot) > 0 then -- chesk or give error bellow line
    item = comp.inventory_controller.getStackInInternalSlot(slot );

   -- print (item.name.."WTF error" .. c);
    return tostring(item.name);
 end
   return false;
   --print(inventory.itemName(1) );
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

return inventory;
