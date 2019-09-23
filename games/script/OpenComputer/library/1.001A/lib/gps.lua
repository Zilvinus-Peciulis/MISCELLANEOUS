local lib = {}

lib.test = function()

  print("Hello, file system")

end




local rb = require("robot")
local comp = require("component")
local computer = require("computer")
local gps = comp.navigation
local fuel = comp.generator;





local wX;
local wY;
local wZ;

local rX , rY , rZ = gps.getPosition(); -- Robot position

 lib.getwX = function() return wX ;end
 lib.getwY = function() return wY ;end
 lib.getwZ = function() return wZ ;end
 lib.getrX = function() return rX ;end
 lib.getrY = function() return rY ;end
 lib.getrZ = function() return rZ ;end

local orentations = {['S']=3,['N']=2,['W']=4,['E']=5};
local orentationsN = {[3]='S',[2]='N',[4]='W',[5]='E'};

print (orentations["S"])



--print ("FASING:"..gps.getFacing().. "/"..tostring(orentation[gps.getFacing()]))


--ITEM DATA
local function itemName (slot)

--local item = comp.inventory_controller.getStackInInternalSlot(slot or 1 );
 return item.name or false;
end
--FUEL
local function refuel(value)

 fuel.insert(value or 10);
  print ("Fuel is: " ..fuel.count() .. ", My energy:" .. math.floor( computer.energy() / computer.maxEnergy() *100 ) .. "%"  )

end

local function dig()
   while rb.detect() do
   rb.swing();
   if rb.detectUp() then
      rb.swingUp();
   end
  end
end

local function  howRefuel ()
  -- less then 80%
  if   computer.energy() / computer.maxEnergy() < .80 then
     refuel(1)
  end
end



lib.look = function(diretion)
	assert(type(diretion)~="number", "Orentations expected nunber")
  diretion = orentations[diretion] ;

  while  gps.getFacing() ~= diretion do
    rb.turnRight();
    print ("FACING: "..gps.getFacing() .." ,orentations:"..tostring( orentationsN[diretion]) ) ;
   print ( gps.getFacing())
   end
end



local function updateXYZ(waypointlabel , rangeofwaypoints)
    waypoints =   gps.findWaypoints(rangeofwaypoints or 100);
    index=nil;

    for i,v in ipairs (waypoints) do

    		if v.label == waypointlabel then
    			index = i; -- index of beecon
    		end

    end
     if not index then
     	print("Waypoint:'"..tostring(waypointlabel).."' not exist! \nAvailable Labels:\n---------------");
     		for i,v in ipairs (waypoints) do print("WAYPOINT:".."["..i.."]"..v.label);
     			end
     	print('---------------');
     	return false
     end;

	  wX =waypoints[index].position[1];
    wY =waypoints[index].position[2];
    wZ =waypoints[index].position[3];
    return true; -- no errors
end

local  function robot( go ) -- while not rb.forward() and	 gps.findWaypoints(100) do rb.swing() end return;
	if go == "forward" then  while not rb.forward() do    rb.swing(); os.sleep(.100);   end end
	if go == "up" then  while not rb.up() do    rb.swingUp(); os.sleep(.100);   end end
	if go == "down" then while not rb.down() do    rb.swingDown(); os.sleep(.100);   end end
end

local function forRobot  (go,times)
	for i=1,times do
		print(go.."."..i)
		robot(go)
	end
end
-----Waypoint
 lib.goWaypoint = function(waypointlabel ,offsetY, rangeofwaypoints)
	if not updateXYZ(waypointlabel) then return; end
	assert(type(offsetY)=="number", "\n-->Error expected offsetY a nunber<--")
 local function printWaypoint () print (" pos x: " .. wX .." y:"..wY .. ",z:".. wZ);return true;end

    print ("label:" ..tostring(waypoints[1].label));
    print (" pos x: " .. waypoints[1].position[1] .." y:"..waypoints[1].position[2] .. ",z:".. waypoints[1].position[3])
    --Way Points

  --Y go UP OR DOWN OFFSET
   if wY > offsetY then while  wY ~= offsetY do robot("up") ;  wY=wY-1;printWaypoint (); end end
   if wY < offsetY  then while  wY ~= offsetY do robot("down") ;    wY=wY+1;printWaypoint (); end end

 --X
   if wX > 0 then  lib.look ("E");  while  wX ~= 0 do robot("forward") ;wX=wX-1; printWaypoint (); end end
   if wX < 0  then lib.look ("W"); while  wX ~= 0 do robot("forward") ;  wX=wX+1; printWaypoint (); end end

 --Z
   if wZ > 0 then      lib.look ("S");  while  wZ ~= 0 do robot("forward") ;  wZ=wZ-1;printWaypoint (); end end
   if  wZ < 0 then lib.look ("N");  while  wZ ~= 0 do robot("forward") ;  wZ=wZ+1;printWaypoint (); end  end

   --Y
   if wY > 0 then while  wY ~= 0 do robot("up") ;  wY=wY-1;printWaypoint (); end end
   if wY < 0  then while  wY ~= 0 do robot("down") ;    wY=wY+1;printWaypoint (); end end
end
--------------------------- GOTO
lib.goTo  = function(x,y,z ,offsetY)
  assert (type(x)=="number" and type(y)=="number" and type(z)=="number", "-->error:x,y,z must be a  number" )
   rX , rY , rZ  =   gps.getPosition();
   local function pos () print ("x"..(x).."-rX" .. (rX) ..",y"..(y).."-rY:"..(rY) .. ",z"..(z).."-rZ:".. (rZ)); end
   x=math.ceil (x)-.5;y=math.floor(y)-.5 ;z=math.ceil(z)-.5; --offset of coordinates
   offsetY = offsetY or rY;
   pos ();
 --  --Y go UP OR DOWN OFFSET
 --Y
     offsetY =math.floor(offsetY)-.5;
     print ("OFFSET Y:"..offsetY);
    if rY < offsetY and offsetY then while  rY ~= offsetY do robot("up") ;  rY=rY+1;pos (); end end
    if rY > offsetY and offsetY then while  rY ~= offsetY do robot("down") ;    rY=rY-1;pos (); end end
 -- --X
    if rX < x then     lib.look ("E");  while  rX ~= x do robot("forward") ;rX=rX+1; pos (); end end
    if rX > x  then    lib.look ("W"); while  rX ~= x do robot("forward") ;  rX=rX-1; pos (); end end
 --
  --Z
   if rZ < z then      lib.look ("S");  while  rZ ~= z do robot("forward") ;  rZ=rZ+1;pos (); end end
   if rZ > z then      lib.look ("N");  while  rZ ~= z do robot("forward") ;  rZ=rZ-1;pos (); end  end

   --Y
   if rY < y then while  rY ~= y do robot("up") ;  rY=rY+1;pos (); end end
   if rY > y  then while  rY ~= y do robot("down") ;    rY=rY-1;pos (); end end

end

--lib.goWaypoint ("RATAS",-4)
 --lib.goWaypoint ("TREEFARM",0)


--lib.goTo(-16,76,-40)
--Waypoint ("RATAS",)


return lib;
