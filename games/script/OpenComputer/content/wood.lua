local rb = require("robot")
local gps = require("gps");
local refuel = require("refuel");
local XHome , YHome , ZHome;
XHome = -16;
YHome = 74;
ZHome = -40

local HEIGHT = 5;

local function go (to)
while not  rb[to]() do os.sleep(.100) end
end
local function suckSapling ()
 for xSapling =0 , 2 do
    rb.suckDown();
  end
end

--print (refuel.itemName(1));

 print ("robot: x:"..gps.getrX() , " y:" .. gps.getrY() , " z:"..gps.getrZ())

 print(gps.test());


-- os.sleep (2);
-- gps.goTo(XHome ,YHome,ZHome ,YHome );

local function placeSapling ()
  for xslot = 1,16 do
   if refuel.itemName(xslot) == "minecraft:sapling" then ;
       print ("Sapling !! in:"..xslot);
       rb.select(xslot);
       rb.placeDown();
     return;
   end
 end
end

local function selectLog ()
  for xslot = 1,16 do
   if refuel.itemName(xslot) == "minecraft:log" then ;
      -- print ("Log !! in:"..xslot);
       rb.select(xslot);
     return true;
   end
 end
end



local  function robot( go ) -- while not rb.forward() and	 gps.findWaypoints(100) do rb.swing() end return;
	if go == "forward" then  while not rb.forward() do    rb.swing(); os.sleep(.100);   end end
	if go == "up" then  while not rb.up() do    rb.swingUp(); os.sleep(.100);   end end
	if go == "down" then while not rb.down() do    rb.swingDown(); os.sleep(.100);   end end
end

local function lumberjack ()
local tree count = 0;
    selectLog (); -- Select Log
  if rb.compareDown() then rb.swingDown();  end
if rb.compare() or rb.compareUp()  then
  count = count + 1;
      for xUp = 1,HEIGHT do
            rb.swing();
                robot("up");
      end
        for xDown  =  HEIGHT , 1 , -1 do
              robot("down");
       end;
          rb.swingDown();

              print ( "Tree was choped: " .. count );
      end
  placeSapling ();
end

bool = rb.compare();
print("DETECT: "..tostring(bool))

local function main ()
gps.goTo(XHome+1 ,YHome+1,ZHome+1 ,YHome+1 );
gps.look("E");

for rows=1,9 do
  print ("in Rows;");

   for row=1,8 do
     lumberjack ();
     robot("forward");
      suckSapling();
     print ("in Row;");
     -- if  is sapling
      if refuel.itemName(xslot) == "minecraft:sapling"  then return; end
   end
   if rows%2 == 0 then
      rb.turnLeft();
      robot("forward");
      placeSapling ();
      rb.turnLeft();
      os.sleep(.100);
  else
    rb.turnRight();
    robot("forward");
        placeSapling ();
    rb.turnRight();
  end

end
    gps.goTo(XHome ,YHome,ZHome ,YHome );
    for i=1,10 do
      rb.suckDown();
    end
end

while true do
main ();
  for i=400,0,-1 do
    print ("SLeep: "..i);
    os.sleep(1);
  end
end