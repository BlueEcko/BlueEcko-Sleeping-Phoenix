
BASE:I("Load-Save Loading")
--EnableSave = true -- put into ME Trigger
--Path and FileName Definitions
local Path = FilePath -- example path
--local BlueStationaryFilename = BlueStationaryFilename or "UFBlueStationarySave.csv"
local RedStationaryFilename = RedStationaryFilename or "SPRedStationarySave.csv"
--local BlueStaticFilename = BlueStaticFilename or "UFBlueStaticSave.csv"
local RedStaticFilename = RedStaticFilename or "SPRedStaticSave.csv"
local BlueSpawnFilename = BlueSpawnFilename or "SPBlueSpawnedUnitsSave.csv"
local RedSpawnFilename = RedSpawnFilename or "SPRedSpawnedUnitsSave.csv"


--Build Ground Units List (String matches Mission Editor Group Names and Qty in number needs to match or exceed ground unit groups in ME.
local RedGroundSave = {}
local RedGroundTag = {
  ["RED ARTILLERY-"]= 30,
  ["RED ARMOR-"] = 35,
  ["RED COMMAND TRUCKS-"]= 10,
  ["RED EWR-"]= 5,
  ["RED SAM SA-13-"] = 10,
  ["RED SAM SA-15-"] = 15,
  ["RED SAM SA-2-"] = 5,  
  ["RED SAM SA-8-"] = 15,
}
for label, number in pairs(RedGroundTag) do
  for i=1, number do
    table.insert(RedGroundSave,label..i)
  end
end

--Build Red Static List (String matches Mission Editor Group Names and Qty in number needs to match or exceed ground unit groups in ME.
local RedStaticSave = {
"Enguri Dam - Comms",
"Saberio - Tent 1",
"Saberio - Water Tower",
"Zeni - Military HQ",
}
--local RedStaticTag = {
--  ["Enguri Dam - Comms"] = 1,
--  ["Krasnodar Warehouse"] = 1,
--  ["Krymsk Warehouse"] = 1,
--  ["Mineralnye Warehouse"] = 1,
--  ["Mozdok Warehouse"] = 1,
--  ["Saberio - Tent 1"] = 1,
--  ["Saberio - Water Tower"] = 1,
--  ["Sochi Warehouse"] = 1,
--  ["Zeni - Military HQ"] = 1,
--}
--for label, number in pairs(RedStaticTag) do
--  for i=1, number do
--    table.insert(RedStaticSave,label..i)
--  end
--end

--[[
Build Set of spawned units to add to list and save out (Red and Blue)
--]]
local RedSaveOps = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes("AID"):FilterCategoryGround():FilterStart()
local BlueSaveOps = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes({"Capture","Platoon"}):FilterCategoryGround():FilterStart()


function SaveGroups()
  BASE:I("***** Save Groups Cycle")


  UTILS.SaveStationaryListOfGroups(RedGroundSave,Path,RedStationaryFilename)
  UTILS.SaveSetOfGroups(RedSaveOps,Path,RedSpawnFilename)
  UTILS.SaveStationaryListOfStatics(RedStaticSave,Path,RedStaticFilename)

--  UTILS.SaveStationaryListOfGroups(BlueSaveList,Path,BlueStationaryFilename)
  UTILS.SaveSetOfGroups(BlueSaveOps,Path,BlueSpawnFilename)
  --UTILS.SaveStationaryListOfStatics(BlueStaticSave,Path,BlueStaticFilename)
end

if EnableSave and not Reset then
  
  BASE:I("***** Load Groups At Start")
  
  if UTILS.CheckFileExists(Path,RedStationaryFilename) then
    UTILS.LoadStationaryListOfGroups(Path,RedStationaryFilename,true)
  end

  if UTILS.CheckFileExists(Path,RedStaticFilename) then
    UTILS.LoadStationaryListOfStatics(Path,RedStaticFilename,true)
  end
  --if UTILS.CheckFileExists(Path,BlueStationaryFilename) then
  --  UTILS.LoadStationaryListOfGroups(Path,BlueStationaryFilename,true)
  --end
  
  local SaveTimer = TIMER:New(SaveGroups)
  SaveTimer:Start(30,60)
  
end

BASE:I("Load-Save Started")