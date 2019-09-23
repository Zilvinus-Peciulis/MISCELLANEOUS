
------------Version 2.1------ 2017-07
local filesystem = {}
local fs = require "filesystem"

filesystem.test = function()
  print("Hello, file system");
end


--[[Core Method, Wide use]]
 filesystem.fwrite=function( path , text )
--core
	assert(type(path)=="string", "fwrite:\nRequare path.")
	local file =  assert(io.open(path ,'w')) --do --loop
	   file:write(text)
	   file:close()
	 --end
	-- exs: fwrite( 'text' , 'text' )
end

filesystem.writeFromTable=function (path ,t)
--core
 assert(type(path)=="string", "writeFromTable:\nRequare path.")
 assert (type(t)== "table", "writeFromTable expected table got "..tostring(t))
 local text = '';
  for _ , index in pairs(t) do
       text=text..index..'\n'
  end
 filesystem.fwrite( path , text )

--exs:ass = {'mabo','jambo'};writeFromTable ('text' ,ass)
end

-- [[Manipulate types]]

filesystem.fromType=function( changeTo ) -- translate in string
--core
	assert(tostring(changeTo), "toType:Requare changeTo argument.")

 				if tostring(changeTo) == "true" then  return "true"
 				elseif tostring(changeTo) == "false" then  return   "false"
 				elseif tostring(changeTo) == "" then  return "nil"
 			    elseif type(tonumber(changeTo)) == "number" then  return tonumber (changeTo)
 				elseif type(tostring(changeTo)) == "string" then  return "\""..tostring(changeTo).."\""
 				end
 				--return tostring ("'"..changeTo.."'")
end




filesystem.toType=function( changeTo ) -- translate in type
--core
	assert(changeTo, "toType:Requare changeTo argument.")
	local    a1 = string.find(changeTo ,"\"",1) or string.find(changeTo ,"\'",1) -- check "" or '' return position
	 local    a2 = string.find(changeTo ,"\"",2) or string.find(changeTo ,"\'",2)

	 local     b1 = string.find(changeTo ,"\"",2) or string.find(changeTo ,"\'",3)
	 local     b2 = string.find(changeTo ,"\"",3) or string.find(changeTo ,"\'",3)
	           -- print ("a1 "..tostring(a1))
	           -- print ("a2 "..tostring(a2))
	           -- print ("b1 "..tostring(b1))
	           -- print ("b2 "..tostring(b2))
	           -- print (type(changeTo))

	           a1 = a1~=a2 and a1 or 0 -- HAHA got you
	           b1 = b1~=b2 and b1 or 0 -- HAHA got you
-- print (changeTo,changeTo=="\"nil\"")

 				if changeTo == "true" then return true
 				elseif changeTo == "false" then   return false
 				elseif changeTo == "" or changeTo=="\"nil\"" then  return nil
 			    elseif type(tonumber(changeTo)) == "number" then return tonumber(changeTo)
    			 elseif  type(tostring(changeTo)) == "string" and type( b2 ) == "nil"  then return tostring( string.sub(changeTo,a1 and a1+1 or 1,a2 and a2-1 or #changeTo) )
 				 elseif  type(tostring(changeTo)) == "string" and a2>b2 then return tostring( string.sub(changeTo,a1 and a1+1 or 1,a2 and a2-1 or #changeTo) )
 				 elseif  type(tostring(changeTo)) == "string" and a2<b2 then return tostring( string.sub(changeTo,b1 and b1+1 or 1,a2 and b2-1 or #changeTo) )
    			 elseif  type(tostring(changeTo)) == "string" and a1 ~= b1  then return tostring( string.sub(changeTo,b1 and a1+1 or 1,a2 and a2-1 or #changeTo) )
 				end
end


filesystem.toType=function( changeTo ) -- translate in type
--core
	assert(changeTo, "toType:Requare changeTo argument.")
	local    a1 = string.find(changeTo ,"\"",1) or string.find(changeTo ,"\'",1) -- check "" or '' return position
	 local    a2 = string.find(changeTo ,"\"",2) or string.find(changeTo ,"\'",2)

	 local     b1 = string.find(changeTo ,"\"",2) or string.find(changeTo ,"\'",3)
	 local     b2 = string.find(changeTo ,"\"",3) or string.find(changeTo ,"\'",3)
	           -- print ("a1 "..tostring(a1))
	           -- print ("a2 "..tostring(a2))
	           -- print ("b1 "..tostring(b1))
	           -- print ("b2 "..tostring(b2))
	           -- print (type(changeTo))

	           a1 = a1~=a2 and a1 or 0 -- HAHA got you
	           b1 = b1~=b2 and b1 or 0 -- HAHA got you
-- print (changeTo,changeTo=="\"nil\"")

 				if changeTo == "true" then return true
 				elseif changeTo == "false" then   return false
 				elseif changeTo == "" or changeTo=="\"nil\"" then  return nil
 			    elseif type(tonumber(changeTo)) == "number" then return tonumber(changeTo)
    			 elseif  type(tostring(changeTo)) == "string" and type( b2 ) == "nil"  then return tostring( string.sub(changeTo,a1 and a1+1 or 1,a2 and a2-1 or #changeTo) )
 				 elseif  type(tostring(changeTo)) == "string" and a2>b2 then return tostring( string.sub(changeTo,a1 and a1+1 or 1,a2 and a2-1 or #changeTo) )
 				 elseif  type(tostring(changeTo)) == "string" and a2<b2 then return tostring( string.sub(changeTo,b1 and b1+1 or 1,a2 and b2-1 or #changeTo) )
    			 elseif  type(tostring(changeTo)) == "string" and a1 ~= b1  then return tostring( string.sub(changeTo,b1 and a1+1 or 1,a2 and a2-1 or #changeTo) )
 				end
end




 filesystem.getTable=function( path ) --read everything from file/path and return table
 --core
 --print(fs.exists(path) and "Path found" or "Path to found")
--print "TESTgetTable"
--print ("FILE EXSISIT?: "..tostring (fs.exists(path) ) .. " WHAT FILE: "..path)
 if fs.exists(path) or fs.exists("/home/"..path)  then -- in opencomputer requare full path. In ComputerCraft no need that
 	 local file =   assert (io.open(path ,'r')," error io.open() cannot read -_- because reasons and file not found:"..tostring (path));

   local lines = {};
 	 local i = 1;
 	 local line = file:read('*l');
                      --print ("LINE "..tostring(line) ) --debug
 	   while  line~=nil  do --loop
 	    lines[i]=line;
 	    line = file:read('*l');
 	    i=i+1;
                      --print ("WHILE line: "..tostring (line)) debug
 	  end
 	  file:close()
 	   return lines
    end
                      --print "Complete" --debug
	return {}

--exs: mama = rgetTable( 'text' );print ( mama[1] )
end



filesystem.setContent=function( path,text) --support only simple data "One line"
	assert(fs.exists(path) or fs.exists("/home/"..path), "setContent:Requare correct path")
	assert(type(text),"setTabletoType:Reuqare sum of coontet!")
	local content = filesystem.fromType( text )
	filesystem.fwrite( path , content )
end



filesystem.getContent=function( path) --support only simple data/translate to type "One line"
	assert(fs.exists(path) or fs.exists("/home/"..path), "getContent:Requare correct path")
	 local content = filesystem.getTable( path )[1]
	 if content then return filesystem.toType( content ) else error "getContent:No contect found!" end
end


--[[Simple config family]]
filesystem.replaceLine=function( path , n ,text )
	local  lines = filesystem.getTable(path); --read file to table
	lines[n]=text                  --return text
	filesystem.writeFromTable(path ,lines)    --write back
  return lines[n]                     --return what are made
--exs: ptb=replaceLine( 'text' , 1 ,"hello World" )
end



filesystem.append=function( path , addtext )--prideda teksta
local file =   assert(  io.open(path ,'a'))
file:write(addtext..'\n')
file:close()
	-- body
end

--append( 'text' , "Mother of good" )

--[[SINGLE BIT CONSTRUCTOR]]
-- OLD
-- function replaceLineValue( path , n ,chValue ,syntax)
-- 	assert (path, "replaceLineValue:Requare file path.")
-- 	assert (n ,"replaceLineValue:Requare file line.")
-- 	assert (chValue~=nil, "replaceLineValue:Requare  input value.")
-- 	assert(syntax, "replaceLineValue:Requare syntax for \":, =, ;\"  ")

-- 	local  lines = getTable(path);
--     local  isStax = string.find(lines[n] , syntax  )
-- 	          if isStax then
-- 		   	        local isText = string.sub(lines[n] , 1 , string.find(lines[n], syntax or ":"))
-- 		      	       lines[n] = isText..string.rep(" ", 1)..tostring(chValue)
-- 				      writeFromTable(path ,lines)    --write back
--   					return lines[n]
-- 	          end
-- end




 filesystem.replaceLineValue=function( path , n ,chValue, lineName )
	assert (path, "replaceLineValue:Requare file path.")
	assert (n ,"replaceLineValue:Requare file line.")
	assert (chValue~=nil, "replaceLineValue:Requare  input value /"..path)
	assert (filesystem.Lenght (path)>= n, "Line "..n.." not exists /"..path)
	local  lines = filesystem.getTable(path);
    local  isStax = string.find(lines[n] , ":")
	          if isStax then
		   	        local isText = string.sub(lines[n] , 1 , string.find(lines[n],":"))
		      	       lines[n] = isText..string.rep(" ", 1)..filesystem.fromType(chValue)
				        filesystem.writeFromTable(path ,lines)    --write back
  				else
  					local lineName = lineName or ""
  					lines[n] = lineName..":"..filesystem.fromType(chValue)
				    filesystem.writeFromTable(path ,lines)    --write back

  					print "No found syntax"
	          end
end
-----------------------Designet for auto config files auto copletion--------
filesystem.ConfigLineAuto=function( path , n ,index, value )
    assert (path, "ConfigLineAuto:Requare file path got /"..tostring (path))
	assert (n ,"ConfigLineAuto:Requare file line to /"..path)
	assert (index ~=nil, "ConfigLineAuto expected index got "..type(index))
	assert (value ~=nil, "ConfigLineAuto expected value got "..type(value))
	local lines = filesystem.getTable( path )
	local line = {}
	local text = ""
	for Start=1,n-1 do
		line[Start] = lines[Start] or ""
    --  print (lines[Start]); --debug
	end
        if lines[n] then local  isStax = string.find(lines[n] , ":") end
		if isStax then
			line[n] = lines[n]
		else
			if value == nil then value = "" end
  		    line[n] = index..": "..filesystem.fromType(value)
		end
	for End=n+1,#lines do
		line[End] = lines[End]
	end
	filesystem.writeFromTable (path ,line)
end


-- filesystem.getTable( "/home/HARMONY.txt" )
-- filesystem.ConfigLineAuto( "/home/HARMONY.txt" , 2 ,"index2", "value" )
-- filesystem.ConfigLineAuto( "/home/HARMONY.txt" , 3 ,"index3", "value" )
-- filesystem.ConfigLineAuto( "/home/HARMONY.txt" , 4 ,"index4", "value" )
-- filesystem.ConfigLineAuto( "/home/HARMONY.txt" , 8 ,"index8", "value" )
--filesystem.setContent( "/home/HARMONY.txt","LILIPOPE")
--------------------------
filesystem.getLineValue=function( path , n )
	assert (path, "getLineValue:Requare file path.")
	assert (n ,"getLineValue:Requare file line.")

	local  lines = filesystem.getTable(path);
    local  isStax = string.find(lines[n] , ":"  )
	          if isStax then
		   	         local  whatType =  (string.sub( lines[n], string.find(lines[n],":")+2 ) )
	                 return filesystem.toType( whatType )
	          end
            --give rezult a "value" using pattern of ConfigLineAuto
end




filesystem.getAllValuesByType=function( path ) -- return all values in type in table
	assert(type(path)=="string", "getAllValuesByType:\nRequare path.")
	local  lines = filesystem.getTable(path);
	local  tb ={}
	            for line = 1 , #lines do
				  local text = filesystem.toType( lines[line] )
	              table.insert(tb,text)
	              --print(text)
	            end
       return tb
end







----------------------------------------------------------------------------------------






--[[MULTIPLE BITS CONTRUCTORS]]
---[[Long String Family]]

filesystem.ReplaceLongLineValue=function( path, ln ,arg) -- serialize data
--CORE
    assert(type(path)=="string", "createLongLineValue:\narg1 Requare path.")
    assert(type(ln)=="number", "createLongLineValue:\narg2 Requare line value.")
    assert(type(arg)=="table", "createLongLineValue:\narg3 Requare table.")

    --assert(arg and #arg>0, "createLongLineValue:\narg3 Table is emtpy.")
     --fwrite( path , text )
     --writeFromTable (path ,t)



    local lines =  filesystem.getTable( path ) or ""
    local text1 = ""
    local text2 = ""



                                    --print ("TABLE LEN#"..#lines) --debug

          for line = 1,ln-1 do --puch down

                                    --print("lines[line]:"..tostring(lines[line]) ) --debug
        		-- print(bracet.."BR")
               if (bracet ~= nil or lines[line] ~= nil) and string.find(lines[line],")")~=nil then -- update 2017-07-11 string.find(lines[line],")")<-- nil or if true number error "Cannot add nil and number"
       		         -- print(line.." yes")
                                      --print("lines[line]:"..tostring (lines[line])); --debug
                    local bracet="";
                          bracet = string.sub(lines[line], string.find(lines[line],")")+1 or 1 ,string.len(lines[line]) )
       		          text1 =text1..line..")".. bracet.."\n"
       		           else
       		        -- print(line.." No")
       		         text1 =text1..line..")".."\n"
       		      end
                                    --print("TEXT1:"..tostring (text1)) --debug
          end -- then write stuff
	     	--set values

	     			 text1 = text1..ln..")".."{"
	     		for index , content in pairs (arg) do

     		 		    text1 = text1.."|"..filesystem.fromType( index ).."]="..filesystem.fromType( content ).."," -- Stranslate To type
     		    end

     		         text1 = text1.."}\n"
     		-- Finish text
     	 for line = ln+1 , #lines do -- comlete string

        local bracet = string.sub(lines[line], string.find(lines[line],")")+1 or 1 ,string.len(lines[line]) )
     	       text1 =text1..line..")".. bracet.."\n"
     	 --  print(text2)
     	 end 	 --text=text..index..'\n'
         filesystem.fwrite( path , text1 )
        --print(text2)

--ReplaceLongLineValue("config/ctest",5,{"mambo",lamda=false,hera="WOWOW",lol=55,haha="YES"} )
end

--debug
--  filesystem.ReplaceLongLineValue("/home/MOORSE.txt",8{"mambo",lamda=false,hera="WOWOW",lol=55,haha="YES"} )





 filesystem.GetLongLineValue=function( path, ln) -- unserialize data/where magic happend
--CORE

	assert(type(path)=="string" , "GetLongLineValue:Reuqare path.")
	assert(type(ln)=="number", "GetLongLineValue:Reuqare line.")

	local index = ""
	local text = ""
	local lines =  filesystem.getTable( path )[ln] -- get data
	local tb = {}
	if filesystem.Lenght(path) == 0 then error (path.." is empty.")  end
	if type(string.find(lines,"{"))=="nil" then error ("Unable to find'{' Brackets OR missing data gaps --> [' 1) ??) 3) '], FILE:"..tostring (path)) end --error acurves

	      lines = string.sub (lines , string.find(lines,"{"), string.len(lines)) -- leave line pure data
      while string.find(lines,",") and lines ~= nil do
	    	 index = string.sub(lines, string.find(lines,"|")+1,  string.find(lines,"]")-1) -- get index Text
         	text = string.sub(lines, string.find(lines,"=")+1,  string.find(lines,",")-1) -- get Text
		 	tb[filesystem.toType(index)] = filesystem.toType( text ) -- save in table , leave data type/dranslate .
	     	lines = string.sub (lines, string.find(lines, ",")+1, string.len( lines))-- remove latest data leaving left ones.
     		--print("["..index.."] "..text)
	   		--print(lines)
     		--print(tb[index])
     		--sleep(3)
     end

	return tb
-- tb = fLib.GetLongLineValue( "config/ctest", 5)
--call print(tb[hera].." -??")
end


filesystem.AppendLoongLine=function( path , arg ) --Add one by one

	assert(type(path)=="string" , "AppendLoongLine:Reuqare path.")
	assert(type(arg)=="table", "AppendLoongLine:Requare table\nTable with sum values\n{\"mambo\",lamda=false,lol=55}.")
	local linesCount = #(filesystem.getTable(path))
	filesystem.ReplaceLongLineValue( path, linesCount+1 ,arg)
-- AppendLoongLine( path , {ID="...", status=false , isAvailable = true})
end




filesystem.TakeLastLongLine=function( path ) -- take data and  Remove
	assert(type(path)=="string" , "TakeLastLongLine:Reuqare path.")

local lines = filesystem.getTable(path)
local lastLine = filesystem.GetLongLineValue( path, #lines) -- unserialize.
local text =""

     for line = 1, #lines-1   do
     	text = text..lines[line].."\n"
     end

      filesystem.fwrite( path , text )
   	  return lastLine
end

filesystem.TakeFirstLongLine=function( path ) -- take data and  Remove/disapend
	assert(type(path)=="string" , "TakeFirstLongLine:Reuqare path.")

local lines = filesystem.getTable(path)
local lastLine = filesystem.GetLongLineValue( path, 1) -- unserialize.
local text =""

     for line = 2, #lines   do
     	text = text..lines[line].."\n"
     end

      filesystem.fwrite( path , text )
   	  return lastLine
end


filesystem.GetFirstLongLine=function( path ) -- take data and  Remove/disapend
	assert(type(path)=="string" , "GetFirstLongLine:Reuqare path.")
local lines = filesystem.getTable(path)
local lastLine = filesystem.GetLongLineValue( path, 1) -- unserialize.
local text =""

     for line = 1, #lines   do
     	text = text..lines[line].."\n"
     end

      filesystem.fwrite( path , text )
   	  return lastLine
end

filesystem.GetLastLongLine=function( path ) -- take data and  Remove
	assert(type(path)=="string" , "GetLastLongLine:Reuqare path.")

local lines = filesystem.getTable(path)
local lastLine = filesystem.GetLongLineValue( path, #lines) -- unserialize.
local text =""

     for line = 1, #lines   do
     	text = text..lines[line].."\n"
     end

      filesystem.fwrite( path , text )
   	  return lastLine
end




filesystem.GetAllLongLines=function( path ) -- always return table , usefull when no need to protect from none exsisting table
	assert(fs.exists(path) or fs.exists("/home/"..path), "getAllLongLines:Requare path.")
	local Lenght = filesystem.Lenght( path )
	local tb= {}
	for line = 1 , Lenght do
		tb[line] = filesystem.GetLongLineValue( path, line)
	end
	return tb
end

filesystem.ReplaceAllLongLine=function(path , table  )
 assert ( type (path)== "string" and fs.exists (path) or fs.exists("/home/"..path), "ReplaceAllLongLine expected path got nil " )
 assert ( type ( table )== "table" , "ReplaceAllLongLine expected table got "..tostring(type (table)))
  local  text = ""
  local ln = 0
   for k,pointer in pairs(table) do
   	ln = ln + 1
   	 filesystem.ReplaceLongLineValue( path, ln ,pointer)
   end
end

filesystem.GetIndexValue=function( path, pointindex ) -- Looking for index value , more specific ,return value
	assert(fs.exists(path) or fs.exists("/home/"..path), "IndexExists:\nRequare path.")
	assert (pointindex~=nil, "IndexExists:Requare pointindex.")
	local tb = {}
		for xline = 1, filesystem.Lenght(path) do
			local line = filesystem.GetLongLineValue( path, xline)
			for index,value in pairs(line) do
				--print (index.." = "..tostring(value))
				if index == pointindex  then
					--print ("Find that ="..tostring(value))
					tb[xline] = line[pointindex]

					--print(tb[xline])
				end
			--sleep(3)
			end
		end
    return tb
end



--Chesk Loong Line-----------------------------------------------------------------------
--[[]]

-- Chesk if indexe and value is exsist return line
filesystem.Inspect=function(path, pointindex,pointvalue ) --Core
    assert(fs.exists(path) or fs.exists("/home/"..path), "IndexExists:\nRequare path.")
	assert (pointindex~=nil, "IndexExists:Requare pointindex.")
	assert (pointvalue~=nil, "IndexExists:Requare pointvalue.")

		for xline = 1, filesystem.Lenght(path) do
			--print (xline)
			local line = filesystem.GetLongLineValue( path, xline)
			for index,value in pairs(line) do
				--print (index.." = "..tostring(value))
				if index == pointindex and value == pointvalue then
					--print "Find that"
					return xline
				end
			end
		end
    return false
--exstm" fLib.IndexExistsLongLine(path, 2,"Status" ) -- look index Status
end



---------Pointer-Replace-------------------------------------------------------------------


--Golden

-- find pointing line then find where toIndex need to save a new value. Rape Style
filesystem.PointIndexToValue=function( path, pointindex ,pointvalue,toIndex, setvalue )--Core --Find index and value then replace it
	assert(fs.exists(path) or fs.exists("/home/"..path), "PointIndexToValue:Requare path.")
	assert (pointindex~=nil, "PointIndexToValue:Requare pointindex.")
	assert (pointvalue~=nil, "PointIndexToValue:Requare pointvalue.")
	assert (toIndex~=nil,"PointIndexToValue:Requare toIndex.")
	assert(setvalue~=nil,"PointIndexToValue: Requare set value.")


	local Lenght = filesystem.Lenght( path )
	for line = 1 , Lenght do
		local data = filesystem.GetLongLineValue( path, line)
		for name,content in pairs(data) do
			if name == pointindex and pointvalue == content then
				 for toName,_ in pairs(data) do
					  if toName == toIndex then
					  	-- print "Saving new value."
					  	 data[toIndex] = setvalue
					  	 filesystem.ReplaceLongLineValue( path, line ,data)
					  	 return true
					  end
				  end
			end
		end
	end
return false
-- PointIndexToValue( pathDATA, "ID" ,258,"Status", 5558 )
end

--FUCK THE POLICE

----------------------------------------------------------------------------------------
--[[Utilities]]

 filesystem.ArhiveNameAPI=function( pathAPI  ) -- Arhive Library name from string
     assert(type(pathAPI)=="string","Please I need name ob api.")
     local nameAPI = pathAPI --"config/DATA/GenerateJobCoord/GenerateQuarry/GenerateQuarry"
     while string.find(nameAPI,"/") and nameAPI ~= nil do
      nameAPI  = string.sub(nameAPI,string.find(nameAPI,"/")+1,string.len( nameAPI))
    end
   return nameAPI
end

filesystem.Lenght=function( path )--get content lenght
	assert(type(path)=="string" , "Lenght:Reuqare path.")
	return  #filesystem.getTable( path )
end

 filesystem.isContent=function( path )--check if stil is some of content
	assert(type(path)=="string" , "DeleteContent:Reuqare path.")
	return  #filesystem.getTable( path )~=0 or false
end

filesystem.isContentLongLines=function( path ) -- CHECK CONTENT still
	assert(type(path)=="string" , "isContentLongLine:Reuqare path.")
		local lines = filesystem.getTable( path )
		for line = 1,#lines do
			if  string.find (lines[line],",") then return true end
		end
return false
end


filesystem.DeleteContent=function( path )--Delete whole content in file
	assert(type(path)=="string" , "DeleteContent:Reuqare path.")
	filesystem.fwrite( path , "" )
end


filesystem.DeleteLongLine=function( path , ln )-- Delete Long line values
	assert(type(path)=="string" , "DeleteLongLine:Reuqare path.")
	assert(type(ln)=="number", "Requare to line delete.")
	-- ReplaceLongLineValue( path, ln ,{})
	filesystem.replaceLine( path , ln ,nil )
end


--Little bit different :D
 filesystem.SpamLine=function( path,ln ,text)-- Just do somehing in line LD
	assert (type(path)=="string", "SpamLine:Requare path")
	assert(type(ln)=="number", "Requare to line delete.")
	filesystem.ReplaceLongLineValue( pathDATA, ln ,{tostring(text or " ")})
end

return filesystem;
