cfxGroups = {}
cfxGroups.version = "1.1.0"
--[[--

Module to read Unit data from DCS and make it available to scripts
DOES NOT KEEP TRACK OF MISSION-CREATED GROUPS!!!!
Main use is to access player groups for slot blocking etc since these 
groups can't be allocated dynamically

Version history

 1.0.0 - initial version
 1.1.0 - for each player unit, store point(x, 0, y), and action for first WP, as well as name 
 
--]]--

cfxGroups.groups = {} -- all groups, indexed by name 

--[[-- group objects are 
    {
        name= "", 
        coalition = "" (red, bleu, neutral), 
        coanum = # (0, 1, 2 for neutral, red, blue)
        category = "" (helicopter, ship, plane, vehicle, static),
        hasPlayer = true/false,
        playerUnits = {} (for each player unit in group: name, point, action)
        
    }
    
--]]--

function cfxGroups.fetchAllGroupsFromDCS()
    -- a mission is a lua table that is loaded by executing the miz. it builds
    -- the environment mission table, accesible as env.mission 
    -- iterate the "coalition" table of the mission (note: NOT coalitionS)
    -- inspired by mist, GIANT tip o'the hat to Grimes!    
    
    for coa_name_miz, coa_data in pairs(env.mission.coalition) do -- iterate all coalitions
        local coa_name = coa_name_miz
        if string.lower(coa_name_miz) == 'neutrals' then -- convert "neutrals" to "neutral", singular
            coa_name = 'neutral'
        end
        -- directly convert coalition into number for easier access later
        local coaNum = 0
        if coa_name == "red" then coaNum = 1 end 
        if coa_name == "blue" then coaNum = 2 end 
        
        if type(coa_data) == 'table' then
            if coa_data.country then -- make sure there a country table for this coalition
                for cntry_id, cntry_data in pairs(coa_data.country) do -- iterate all countries for this 
                    local countryName = string.lower(cntry_data.name)
                    if type(cntry_data) == 'table' then    --just making sure
                        for obj_type_name, obj_type_data in pairs(cntry_data) do
                            if obj_type_name == "helicopter" or obj_type_name == "ship" or obj_type_name == "plane" or obj_type_name == "vehicle" or obj_type_name == "static" then --should be an unncessary check
                                local category = obj_type_name
                                if ((type(obj_type_data) == 'table') and obj_type_data.group and (type(obj_type_data.group) == 'table') and (#obj_type_data.group > 0)) then    --there's a group!

                                    for group_num, group_data in pairs(obj_type_data.group) do
                                        if group_data and group_data.units and type(group_data.units) == 'table' then    --making sure again- this is a valid group
                                            local groupName = group_data.name
                                            if env.mission.version > 7 then -- translate raw to actual 
                                                groupName = env.getValueDictByKey(groupName)
                                            end
                                            local hasPlayer = false 
                                            local playerUnits = {}
                                            for unit_num, unit_data in pairs(group_data.units) do -- iterate units
                                                -- see if there is at least one player in group 
                                                if unit_data.skill then 
                                                    if unit_data.skill == "Client" or  unit_data.skill == "Player" then
                                                        -- this is player unit. save it, remember
                                                        hasPlayer = true 
                                                        local playerData = {}
                                                        playerData.name = unit_data.name
                                                        playerData.point = {}
                                                        playerData.point.x = unit_data.x
                                                        playerData.point.y = 0
                                                        playerData.point.z = unit_data.y
                                                        playerData.action = "none" -- default 
                                                        
                                                        -- access initial waypoint data by 'reaching up'
                                                        -- into group data and extract route.points[1]
                                                        if group_data.route and group_data.route.points and (#group_data.route.points > 0) then 
                                                            playerData.action = group_data.route.points[1].action
                                                        end
                                                        table.insert(playerUnits, playerData)
                                                    end                                                        
                                                end
                                            end --for all units in group
                        
                                            local entry = {}
                                            entry.name = groupName
                                            entry.coalition = coa_name
                                            entry.coaNum = coaNum 
                                            entry.category  = category
                                            entry.hasPlayer = hasPlayer 
                                            entry.playerUnits = playerUnits
                                            -- add to db
                                            cfxGroups.groups[groupName] = entry
                                            
                                        end --if has group_data and group_data.units then
                                    end --for all groups in category 
                                end --if has category data 
                            end --if plane, helo etc... category
                        end --for all objects in country 
                    end --if has country data 
                end --for all countries in coalition
            end --if coalition has country table 
        end -- if there is coalition data  
    end --for all coalitions in mission 
end

-- simply dump all groups to the screen
function cfxGroups.showAllGroups()
    for gName, gData in pairs (cfxGroups.groups) do 
        local isP = "(NPC)"
        if gData.hasPlayer then isP = "*PLAYER GROUP (".. #gData.playerUnits ..")*" end
        trigger.action.outText(gData.name.. ": " .. isP .. " - " .. gData.category .. ", F:" .. gData.coalition
        .. " (" .. gData.coaNum .. ")", 30)
    end
end

-- return all cfxGroups that can have players in them
-- includes groups that currently are not or not anymore alive
function cfxGroups.getPlayerGroup()
    local playerGroups = {}
    for gName, gData in pairs (cfxGroups.groups) do 
        if gData.hasPlayer then
            table.insert(playerGroups, gData)
        end
    end
    return playerGroups 
end

-- return all group names that can have players in them
-- includes groups that currently are not or not anymore alive
function cfxGroups.getPlayerGroupNames()
    local playerGroups = {}
    for gName, gData in pairs (cfxGroups.groups) do 
        if gData.hasPlayer then
            table.insert(playerGroups, gName)
        end
    end
    return playerGroups 
end


function cfxGroups.start()
    cfxGroups.fetchAllGroupsFromDCS() -- read all groups from mission. 
--    cfxGroups.showAllGroups()
    
    trigger.action.outText("cfxGroups version " .. cfxGroups.version .. " started", 30)
    return true 
    
end

cfxGroups.start() 

cfxSSBClient = {}
cfxSSBClient.version = "1.2.0"
cfxSSBClient.verbose = false 
--[[--
Version History
  1.0.0 - initial version
  1.1.0 - detect airfield by action and location, not group name
  1.1.1 - performance tuning. only read player groups once 
        - and remove in-air-start groups from scan. this requires
        - ssb (server) be not modified    
  1.2.0 - API to close airfields: invoke openAirfieldNamed() 
          and closeAirfieldNamed() with name as string (exact match required)
          to block an airfield for any player aircraft.
          Works for FARPS as well 
          API to associate a player group with any airfied's status (nil for unbind):
          cfxSSBClient.bindGroupToAirfield(group, airfieldName)
          API shortcut to unbind groups: cfxSSBClient.unbindGroup(group) 
          verbose messages now identify better: "+++SSB:"
    
WHAT IT IS
SSB Client is a small script that forms the client-side counterpart to
Ciribob's simple slot block. It will block slots for all client airframes
that are on an airfield that does not belong to the faction that currently
owns the airfield. 

REQUIRES CIRIBOB's SIMPLE SLOT BLOCK (SSB) TO RUN ON THE SERVER

If run without SSB, your planes will not be blocked.

In order to work, a plane that should be blocked when the airfield or 
FARP doesn't belong to the player's faction, the group's first unit
must be within 3000 meters of the airfield and on the ground. 
Previous versions of this script relied on group names. No longer.


WARNING:
If you modified ssb's flag values, this script will not work 

YOU DO NOT NEED TO ACTIVATE SBB, THIS SCRIPT DOES SO AUTOMAGICALLY


--]]--

-- below value for enabled MUST BE THE SAME AS THE VALUE OF THE SAME NAME 
-- IN SSB. DEFAULT IS ZERO, AND THIS WILL WORK

cfxSSBClient.enabledFlagValue = 0 -- DO NOT CHANGE, MUST MATCH SSB 
cfxSSBClient.disabledFlagValue = cfxSSBClient.enabledFlagValue + 100 -- DO NOT CHANGE
cfxSSBClient.allowNeutralFields = false -- set to FALSE if players can't spawn on neutral airfields 
cfxSSBClient.maxAirfieldRange = 3000 -- meters to airfield before group is no longer associated with airfield 
-- actions to home in on when a player plane is detected and a slot may 
-- be blocked. Currently, homing in on airfield, but not fly over 
cfxSSBClient.slotActions = {
    "From Runway",
    "From Parking Area",
    "From Parking Area Hot",
    "From Ground Area",
    "From Ground Area Hot",
}
cfxSSBClient.keepInAirGroups = true -- if false we only look at planes starting on the ground 
-- setting this to true only makes sense if you plan to bind in-air starts to airfields 

cfxSSBClient.playerGroups = {}
cfxSSBClient.closedAirfields = {} -- list that closes airfields for any aircrafts

function cfxSSBClient.closeAirfieldNamed(name)
    if not name then return end 
    cfxSSBClient.closedAirfields[name] = true 
    cfxSSBClient.setSlotAccessByAirfieldOwner()
    if cfxSSBClient.verbose then 
        trigger.action.outText("+++SSB: Airfield " .. name .. " now closed", 30) 
    end
end

function cfxSSBClient.openAirFieldNamed(name)
    cfxSSBClient.closedAirfields[name] = nil 
    cfxSSBClient.setSlotAccessByAirfieldOwner()
    if cfxSSBClient.verbose then 
        trigger.action.outText("+++SSB: Airfield " .. name .. " just opened", 30) 
    end
end

function cfxSSBClient.unbindGroup(groupName)
    cfxSSBClient.bindGroupToAirfield(groupName, nil)
end

function cfxSSBClient.bindGroupToAirfield(groupName, airfieldName)
    if not groupName then return end 
    local airfield = nil
    if airfieldName then airfield = Airbase.getByName(airfieldName) end 
    for idx, theGroup in pairs(cfxSSBClient.playerGroups) do
        if theGroup.name == groupName then 
            if cfxSSBClient.verbose then
                local newBind = "NIL"
                if airfield then newBind = airfieldName end 
                trigger.action.outText("+++SSB: Group " .. theGroup.name .. " changed binding to " .. newBind, 30) 
            end
            theGroup.airfield = airfield
            return
        end
    end
    if not airfieldName then airfieldName = "<NIL>" end 
    trigger.action.outText("+++SSB: Binding Group " .. groupName .. " to " .. airfieldName .. " failed.", 30) 
end

function cfxSSBClient.dist(point1, point2) -- returns distance between two points            
  local x = point1.x - point2.x
  local y = point1.y - point2.y 
  local z = point1.z - point2.z
  
  return (x*x + y*y + z*z)^0.5
end
    
-- see if instring conatins what, defaults to case insensitive
function cfxSSBClient.containsString(inString, what, caseSensitive)
    if (not caseSensitive) then 
        inString = string.upper(inString)
        what = string.upper(what)
    end
    return string.find(inString, what)
end


function cfxSSBClient.arrayContainsString(theArray, theString)
    -- warning: case sensitive!
    if not theArray then return false end
    if not theString then return false end
    for i = 1, #theArray do 
        if theArray[i] == theString then return true end 
    end
    return false 
end


function cfxSSBClient.getClosestAirbaseTo(thePoint)
    local delta = math.huge
    local allYourBase = world.getAirbases() -- get em all
    local closestBase = nil 
    for idx, aBase in pairs(allYourBase) do
        -- iterate them all 
        local abPoint = aBase:getPoint()
        newDelta = cfxSSBClient.dist(thePoint, {x=abPoint.x, y = 0, z=abPoint.z})
        if newDelta < delta then 
            delta = newDelta
            closestBase = aBase
        end
    end
    return closestBase, delta 
end

function cfxSSBClient.setSlotAccessByAirfieldOwner()
    -- get all groups that have a player-controlled aircraft
    -- now uses cached, reduced set of player planes
    local pGroups = cfxSSBClient.playerGroups -- cfxGroups.getPlayerGroup() -- we want the group.name attribute
    for idx, theGroup in pairs(pGroups) do
        local theName = theGroup.name 
        -- airfield was attached at startup to group 
        local theMatchingAirfield = theGroup.airfield 
        if theMatchingAirfield ~= nil then 
            -- we have found a plane that is tied to an airfield 
            -- so this group will receive a block/unblock
            -- we always set all block/unblock every time
            -- note: since caching, above guard not needed
            local airFieldSide = theMatchingAirfield:getCoalition()
            local groupCoalition = theGroup.coaNum
            local blockState = cfxSSBClient.enabledFlagValue -- we default to ALLOW the block
            local comment = "pass"
            
            -- see if airfield is closed 
            local afName = theMatchingAirfield:getName()
            if cfxSSBClient.closedAirfields[afName] then 
                -- airfield is closed. no take-offs 
                blockState = cfxSSBClient.disabledFlagValue
                comment = "!closed airfield!"
            end
            
            -- on top of that, check coalitions
            if groupCoalition ~= airFieldSide then 
                -- we have a problem. sides don't match 
                if airFieldSide == 3 
                or (cfxSSBClient.allowNeutralFields and airFieldSide == 0)
                then 
                    -- all is well, airfield is contested or neutral and 
                    -- we allow this plane to spawn here
                else 
                    -- DISALLOWED!!!!
                    blockState = cfxSSBClient.disabledFlagValue
                    comment = "!!!BLOCKED!!!"
                end
            end 
            -- set the ssb flag for this group so the server can see it
            trigger.action.setUserFlag(theName, blockState)
            if cfxSSBClient.verbose then 
                trigger.action.outText("+++SSB: group ".. theName .. ": " .. comment, 30)
            end 
        else 
            if cfxSSBClient.verbose then 
                trigger.action.outText("+++SSB: group ".. theName .. " no bound airfield", 30)
            end
        end
    end

end

function cfxSSBClient:onEvent(event)
    if event.id == 10 then -- S_EVENT_BASE_CAPTURED
        if cfxSSBClient.verbose then 
            trigger.action.outText("+++SSB: CAPTURE EVENT -- RESETTING SLOTS", 30)
        end
        cfxSSBClient.setSlotAccessByAirfieldOwner()
    end
    -- removed parachute guy filter. use parashoo instead
end

function cfxSSBClient.update()
    -- first, re-schedule me in one minute 
    timer.scheduleFunction(cfxSSBClient.update, {}, timer.getTime() + 60)
    
    -- now establish all slot blocks 
    cfxSSBClient.setSlotAccessByAirfieldOwner()
end

-- pre-process static player data to minimize 
-- processor load on checks
function cfxSSBClient.processPlayerData()
    cfxSSBClient.playerGroups = cfxGroups.getPlayerGroup()
    local pGroups = cfxSSBClient.playerGroups
    local filteredPlayers = {}
    for idx, theGroup in pairs(pGroups) do
        if theGroup.airfield ~= nil or cfxSSBClient.keepInAirGroups then 
            -- only transfer groups that have airfields (or also keepInAirGroups)
            -- attached. Ignore the rest as they are 
            -- always fine
            table.insert(filteredPlayers, theGroup)
        end
    end
    cfxSSBClient.playerGroups = filteredPlayers
end

-- add airfield information to each player group
function cfxSSBClient.processGroupData()
    local pGroups = cfxGroups.getPlayerGroup() -- we want the group.name attribute
    for idx, theGroup in pairs(pGroups) do
        -- we always use the first player's plane as referenced
        local playerData = theGroup.playerUnits[1]
        local theAirfield = nil
        local delta = -1
        local action = playerData.action 
        if not action then action = "<NIL>" end 
        -- see if the data has any of the slot-interesting actions
        if cfxSSBClient.arrayContainsString(cfxSSBClient.slotActions, action ) then 
            -- yes, fetch the closest airfield 
            theAirfield, delta = cfxSSBClient.getClosestAirbaseTo(playerData.point)
            local afName = theAirfield:getName()
            if cfxSSBClient.verbose then 
                trigger.action.outText("+++SSB: group: " .. theGroup.name .. " closest to AF " .. afName .. ": " .. delta .. "m" , 30)
            end 
            if delta > cfxSSBClient.maxAirfieldRange then 
                -- forget airfield
                 theAirfield = nil
            end
            theGroup.airfield = theAirfield
        else 
            if cfxSSBClient.verbose then 
                trigger.action.outText("+++SSB: group: " .. theGroup.name .. " action " .. action .. " does not concern SSB", 30)
            end 
        end
    end
end

function cfxSSBClient.start()
    -- install callback for events in DCS
    world.addEventHandler(cfxSSBClient)
    
    -- process group data to attach airfields 
    cfxSSBClient.processGroupData()
    
    -- process player data to minimize effort and build cache
    -- into cfxSSBClient.playerGroups
    cfxSSBClient.processPlayerData()
    
    -- install a timed update just to make sure
    -- and start NOW
    timer.scheduleFunction(cfxSSBClient.update, {}, timer.getTime() + 1)
     
    -- now turn on ssb 
    trigger.action.setUserFlag("SSB",100)
    
    -- say hi!
    trigger.action.outText("cfxSSBClient v".. cfxSSBClient.version .. " running, SBB enabled", 30)
    
    --cfxSSBClient.allYourBase()
    
    return true 
end

cfxSSBClient.start()