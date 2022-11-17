----------------------------------------------------------------
-- SRS and Mission Config
----------------------------------------------------------------
local hereSRSPath = mySRSPath or "E:\\Program Files\\DCS-SimpleRadio-Standalone"
local hereSRSPort = mySRSPort or 5002
local hereSRSGoogle = mySRSGKey --or "C:\\Program Files\\DCS-SimpleRadio-Standalone\\yourkey.json"

local DEBUG = false
local AirSupportInterval = 600
local AirSupportTemplate = "USAAF Strike"

-- Settings
_SETTINGS:SetPlayerMenuOn()
_SETTINGS:SetImperial()
_SETTINGS:SetA2G_BR()

for i=1,1000 do
  math.random(1,10000)
end

local menu = MENU_COALITION:New(coalition.side.BLUE,"Ops Menu")


----------------------------------------------------------------
-- PlayerTasking Settings and Task Controller
----------------------------------------------------------------
local phoenixtasking = PLAYERTASKCONTROLLER:New("Phoenix",coalition.side.BLUE,PLAYERTASKCONTROLLER.Type.A2G)
phoenixtasking:DisableTaskInfoMenu()
phoenixtasking:EnableTaskInfoMenu()
phoenixtasking:SetMenuOptions(true,5,30)
phoenixtasking:SetAllowFlashDirection(true)
phoenixtasking:SetCallSignOptions(false,true)
phoenixtasking:SetLocale("en")
phoenixtasking:SetMenuName("Phoenix")
phoenixtasking:SetSRS({130,255},{radio.modulation.AM,radio.modulation.AM},hereSRSPath,"female","en-US",hereSRSPort,"Microsoft Hazel Desktop",0.7,hereSRSGoogle)
phoenixtasking:SetSRSBroadcast({127.5,305},{radio.modulation.AM,radio.modulation.AM})
phoenixtasking:SetTargetRadius(750)
phoenixtasking:SetParentMenu(menu)

----------------------------------------------------------------
--  Sounds for Smoke and Mirrors
----------------------------------------------------------------
function phoenixtasking:OnAfterTaskTargetSmoked(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function phoenixtasking:OnAfterTaskTargetFlared(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function phoenixtasking:OnAfterTaskTargetIlluminated(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end----------------------------------------------------------------
-- TODO Mission Targets Operation 1
----------------------------------------------------------------s
local BLUEOperation = { 
  [1] = {       
    TargetName = "Saberio - Supply 2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at Dihazurga\nSaberio Sector - Grid GH32",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [2] = {       
    TargetName = "Chuburhindzhi - Infantry 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Infantry located at Chuburhindzhi\nZeni Sector - Grid GH21/31",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [3] = {       
    TargetName = "Chuburhindzhi - Artillery 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery located at Chuburhindzhi\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [4] = {       
    TargetName = "Chuburhindzhi - Flak 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery located at Chuburhindzhi\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [5] = {       
    TargetName = "Chuburhindzhi - Supply 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at Chuburhindzhi\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [6] = {       
    TargetName = "Enguri Dam - Flak 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery located South of the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [7] = {       
    TargetName = "Enguri Dam - Flak 2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery on the wall of the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [8] = {       
    TargetName = "Enguri Dam - Supply 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located South of the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [9] = {       
    TargetName = "Enguri Dam - Supply 2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [10] = {        
    TargetName = "Saberio - Flak 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery located at Hole\nSaberio Sector - Grid GH32",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [11] = {        
    TargetName = "Saberio - Supply 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at Hole\nSaberio Sector - Grid GH32",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [12] = {        
    TargetName = "Zeni - Infantry 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Infantry located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [13] = {        
    TargetName = "Zeni - Artillery 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [14] = {        
    TargetName = "Zeni - Flak 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [15] = {        
    TargetName = "Zeni - Supply 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [16] = {        
    TargetName = "Enguri Dam - Comms",
    TargetStatic = true,
    TargetBriefing = "Destroy the Communications Tower located at the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [17] = {        
    TargetName = "Saberio - Infantry 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Infantry located at Saberio\nSaberio Sector - Grid GH32",
    TargetAuftrag = AUFTRAG.Type.CAS,
  } ,
  [18] = {        
    TargetName = "Zeni - Military HQ",
    TargetStatic = true,
    TargetBriefing = "Destroy the Military HQ located North of Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [19] = {        
    TargetName = "Zeni - Armor 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Tanks located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [20] = {        
    TargetName = "Chuburhindzhi - Armor 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Tanks located East of Chuburhindzhi\nChuburhindzhi Sector - Grid GH31",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  
  }

local BLUEOperation2 = { 
  [1] = {       
    TargetName = "Saberio - Supply 2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at Dihazurga\nSaberio Sector - Grid GH32",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [2] = {       
    TargetName = "Chuburhindzhi - Infantry 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Infantry located at Chuburhindzhi\nZeni Sector - Grid GH21/31",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [3] = {       
    TargetName = "Chuburhindzhi - Artillery 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery located at Chuburhindzhi\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [4] = {       
    TargetName = "Chuburhindzhi - Flak 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery located at Chuburhindzhi\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [5] = {       
    TargetName = "Chuburhindzhi - Supply 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at Chuburhindzhi\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [6] = {       
    TargetName = "Enguri Dam - Flak 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery located South of the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [7] = {       
    TargetName = "Enguri Dam - Flak 2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery on the wall of the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [8] = {       
    TargetName = "Enguri Dam - Supply 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located South of the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [9] = {       
    TargetName = "Enguri Dam - Supply 2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [10] = {        
    TargetName = "Saberio - Flak 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery located at Hole\nSaberio Sector - Grid GH32",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [11] = {        
    TargetName = "Saberio - Supply 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at Hole\nSaberio Sector - Grid GH32",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [12] = {        
    TargetName = "Zeni - Infantry 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Infantry located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [13] = {        
    TargetName = "Zeni - Artillery 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [14] = {        
    TargetName = "Zeni - Flak 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Flak Battery located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [15] = {        
    TargetName = "Zeni - Supply 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Supply Trucks located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [16] = {        
    TargetName = "Enguri Dam - Comms",
    TargetStatic = true,
    TargetBriefing = "Destroy the Communications Tower located at the Enguri Dam\nEnguri Dam Sector - Grid KN53",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [17] = {        
    TargetName = "Saberio - Infantry 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Infantry located at Saberio\nSaberio Sector - Grid GH32",
    TargetAuftrag = AUFTRAG.Type.CAS,
  } ,
  [18] = {        
    TargetName = "Zeni - Military HQ",
    TargetStatic = true,
    TargetBriefing = "Destroy the Military HQ located North of Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [19] = {        
    TargetName = "Zeni - Armor 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Tanks located at Zeni\nZeni Sector - Grid GH21",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [20] = {        
    TargetName = "Chuburhindzhi - Armor 1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Tanks located East of Chuburhindzhi\nChuburhindzhi Sector - Grid GH31",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  
  }

----------------------------------------------------------------
-- TODO Randomize mission setup and create TARGET objects
----------------------------------------------------------------
BLUEOperation = UTILS.ShuffleTable(BLUEOperation)

local BlueTargets = {}
for i=1,20 do
  if BLUEOperation[i].TargetStatic then
    -- static
    BlueTargets[i] = TARGET:New(STATIC:FindByName(BLUEOperation[i].TargetName))
  else
    -- group
    BlueTargets[i] = TARGET:New(GROUP:FindByName(BLUEOperation[i].TargetName))
  end
end

BLUEOperation2 = UTILS.ShuffleTable(BLUEOperation2)

local BlueTargets2 = {}
for i=1,20 do
  if BLUEOperation2[i].TargetStatic then
    -- static
    BlueTargets2[i] = TARGET:New(STATIC:FindByName(BLUEOperation2[i].TargetName))
  else
    -- group
    BlueTargets2[i] = TARGET:New(GROUP:FindByName(BLUEOperation2[i].TargetName))
  end
end
----------------------------------------------------------------
-- TODO Setup OPERATION to steer through the tasks
----------------------------------------------------------------
local BlueOps = OPERATION:New("Phoenix")
BlueOps:AddBranch("One")
BlueOps:AddBranch("Two")


if DEBUG then
  BlueOps.verbose = 1
end

----------------------------------------------------------------
-- TODO Add Operation Phases
----------------------------------------------------------------
for i=1,20 do
  -- Add Phases
  local phase = BlueOps:AddPhase([i],"One")
  -- Add condition over
  BlueOps:AddPhaseConditonOverAll(phase,
  function(target)
    local Target = target -- Ops.Target#TARGET
    if Target:IsDead() or Target:IsDestroyed() or Target:CountTargets() == 0 then
      return true
    else
     return false
    end 
  end,BlueTargets[i])
end

for i=1,20 do
  -- Add Phases
  local phase = BlueOps:AddPhase([i],"One")
  -- Add condition over
  BlueOps:AddPhaseConditonOverAll(phase,
  function(target)
    local Target = target -- Ops.Target#TARGET
    if Target:IsDead() or Target:IsDestroyed() or Target:CountTargets() == 0 then
      return true
    else
     return false
    end 
  end,BlueTargets2[i])
end
-- start operation
BlueOps:__Start(30)

----------------------------------------------------------------
-- TODO Operation start and phase changes
----------------------------------------------------------------
function BlueOps:OnAfterStart(From,Event,To)
  MESSAGE:New("Operation Phoenix Started!",15,"Phoenix"):ToBlue()
end

---
-- next phase
function BlueOps:OnAfterPhaseChange(From,Event,To,Phase)
  -- Next phase, this is Phase done
  local branch = BlueOps:GetBranchActive()
  if branch == "Zone-2" then
    local phase = BlueOps:GetPhaseActive()
    local ind = phase.name
    local type = BLUEOperation2[ind].TargetAuftrag
    local brief = BLUEOperation2[ind].TargetBriefing
    if DEBUG then
      BlueTargets[ind].verbose = 3
    end
    local task = PLAYERTASK:New(type,BlueTargets2[ind],true,99,type)
    task:AddFreetext(brief)
    if DEBUG then
      task.verbose = true
    end
  else  
    local phase = BlueOps:GetPhaseActive()
    local ind = phase.name
    local type = BLUEOperation[ind].TargetAuftrag
    local brief = BLUEOperation[ind].TargetBriefing
    if DEBUG then
      BlueTargets[ind].verbose = 3
    end
    local task = PLAYERTASK:New(type,BlueTargets[ind],true,99,type)
    task:AddFreetext(brief)
    if DEBUG then
      task.verbose = true
    end
  end  
  phoenixtasking:AddPlayerTaskToQueue(task)
  local file = "That Is Our Target.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

---
-- Operation finished
function BlueOps:OnAfterOver(From,Event,To,Phase)
  MESSAGE:New("Operation Phoenix - We won!",15,"Phoenix"):ToBlue()
  local ogg = math.random(1,4)
  local file = string.format("Campaign Victory %d.ogg",ogg)
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

----------------------------------------------------------------
-- TODO A2G Strike Support
----------------------------------------------------------------
local FlightLock = timer.getTime() - AirSupportInterval

function CallAirSupport()
  local TNow = timer.getTime()
  if TNow-FlightLock > AirSupportInterval then
    FlightLock = timer.getTime()
    -- Get Current Target
    local phase = BlueOps:GetPhaseActive()
    if not phase then
      MESSAGE:New("Strike Bombers Unable To Locate Target",15,"Phoenix"):ToBlue()
      return 
    end
    local branch = BlueOps:GetBranchActive()
    if branch == "Zone-2" then
      local ind = phase.name
      local type = BLUEOperation[ind].TargetAuftrag
      local brief = BLUEOperation[ind].TargetBriefing
      local IsStatic = BLUEOperation[ind].TargetStatic
      local Name = BLUEOperation[ind].TargetName
      local Target = nil
      if IsStatic then
        Target = STATIC:FindByName(Name)
      else
        Target = GROUP:FindByName(Name)
      end
      auftrag = nil
      if type == AUFTRAG.Type.CAS then
        local CasZone = ZONE_RADIUS:New(Name,Target:GetVec2(),500)
        auftrag = AUFTRAG:NewCASENHANCED(CasZone,nil,350,10,nil,{"Ground Units"})
      elseif type == AUFTRAG.Type.BOMBING then
        auftrag = AUFTRAG:NewBOMBING(Target)
        auftrag:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
        auftrag:SetMissionSpeed(350)
      elseif type == AUFTRAG.Type.SEAD then
        auftrag = AUFTRAG:NewSEAD(Target)
        auftrag:SetMissionSpeed(350)
      end
    else
      local ind = phase.name
      local type = BLUEOperation[ind].TargetAuftrag
      local brief = BLUEOperation[ind].TargetBriefing
      local IsStatic = BLUEOperation[ind].TargetStatic
      local Name = BLUEOperation[ind].TargetName
      local Target = nil
      if IsStatic then
        Target = STATIC:FindByName(Name)
      else
        Target = GROUP:FindByName(Name)
      end
      auftrag = nil
      if type == AUFTRAG.Type.CAS then
        local CasZone = ZONE_RADIUS:New(Name,Target:GetVec2(),500)
        auftrag = AUFTRAG:NewCASENHANCED(CasZone,nil,350,10,nil,{"Ground Units"})
      elseif type == AUFTRAG.Type.BOMBING then
        auftrag = AUFTRAG:NewBOMBING(Target)
        auftrag:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
        auftrag:SetMissionSpeed(350)
      elseif type == AUFTRAG.Type.SEAD then
        auftrag = AUFTRAG:NewSEAD(Target)
        auftrag:SetMissionSpeed(350)
      end
    end  
        
    if auftrag then
      local flight = SPAWN:NewWithAlias(AirSupportTemplate,AirSupportTemplate.."-"..math.random(10,10000))
      flight:InitCleanUp(120)
      flight:OnSpawnGroup(
        function(group)
          local FG = FLIGHTGROUP:New(group)
          FG:SetDefaultRadio(254,radio.modulation.AM,true)
          FG:SetDespawnAfterLanding()
          FG:SetFuelLowRTB(true)
          FG:AddMission(auftrag)
          MESSAGE:New("Strike Bombers Launched",15,"Phoenix"):ToBlue()
          USERSOUND:New("Lets Go Get Em.ogg"):ToCoalition(coalition.side.BLUE)
          function FG:OnAfterRTB()    
            MESSAGE:New("Strike Bombers Are Returning To Base",15,"Phoenix"):ToBlue()
          end
          function FG:onafterHolding()
            FG:ClearToLand(2)
          end
          function auftrag:OnAfterExecuting()
            MESSAGE:New("The Strike Bomber Flight Reports Target Coordinates Are Locked In And They Are Engaging!",15,"Phoenix"):ToBlue()
          end    
        end
      )
      flight:SpawnAtAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Senaki_Kolkhi),SPAWN.Takeoff.Cold,nil,nil,true,nil)
    end
  else
    MESSAGE:New("Strike Bombers Are Currently Active, Further Support Is Unavailable",15,"Phoenix"):ToBlue()
  end
end

local support = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Request Support",menu,CallAirSupport)

----------------------------------------------------------------
-- Navy
----------------------------------------------------------------

local Navy = GROUP:FindByName("US Navy")
if Navy then
  Navy:PatrolRoute()
end

----------------------------------------------------------------
-- TODO Config
----------------------------------------------------------------
CommunistWPZones = SET_ZONE:New():FilterPrefixes("Communist WP"):FilterOnce()
AlliedWPZones = SET_ZONE:New():FilterPrefixes("Allied WP"):FilterOnce()

RedSquadronName = "Communist Fighter"
BlueSquadronName = "Allied Fighter"

RedTemplate = "KPAAF MiG-15bis"
BlueTemplate = "USAAF F-86F"

RedHomeBase = AIRBASE.Caucasus.Sukhumi_Babushara
RedParking = {13,14,15,16,17,18,23,24,3,2}

BlueHomeBase = AIRBASE.Caucasus.Senaki_Kolkhi
BlueParking = {18,19,20,21,28,27,26,25,32,34,35,36}

BlueSquadronsEnabled = true
RedSquadronsEnabled = true

RespawnTimerMin = 300
RespawnTimerMax = 600

FlightLevelMin = 7 -- k ft
FlightLevelMax = 25 -- k ft

MaxCAP = 4
CleanupTime = 300

EngagementDistance = 20 -- NM

NoEngageBlue = SET_ZONE:New()
local Bzone = ZONE:FindByName("SAMRange")
NoEngageBlue:AddZone(Bzone)

--RedNoFly
NoEngageRed = SET_ZONE:New()
local Bzone = ZONE:FindByName("RedNoFly")
NoEngageRed:AddZone(Bzone)

USAAFCAP = { 
       "USAAF F-86F",
       "USAAF F-86F 2 Ship",
       "USAAF F-86F 3 Ship",
       "USAAF F-86F FU-178",
       "USAAF F-86F FU-178 2 Ship",
       "USAAF F-86F FU-178 3 Ship",
       "USAAF F-86F 2 Ship",
       "USAAF F-86F 3 Ship",
       "USAAF F-86F FU-178 2 Ship",
       "USAAF F-86F FU-178 3 Ship"
      }
       
KPAAFCAP = {
       "VVS MiG-25PD",
       "VVS MiG-25PD 2 ship",
       "VVS MiG-25PD 3 ship", 
       "VVS MiG-15bis",
       "VVS MiG-15bis 2 Ship",  
       "VVS MiG-15bis 3 Ship",
       "KPAAF MiG-15bis",
       "KPAAF MiG-15bis 2 Ship",
       "KPAAF MiG-15bis 3 Ship",
       "PLAAF MiG-15bis",
       "PLAAF MiG-15bis 2 Ship",
       "PLAAF MiG-15bis 3 Ship", 
       "VVS MiG-15bis 2 Ship",  
       "VVS MiG-15bis 3 Ship",
       "KPAAF MiG-15bis 2 Ship",
       "KPAAF MiG-15bis 3 Ship",
       "PLAAF MiG-15bis 2 Ship",
       "PLAAF MiG-15bis 3 Ship"
       }

USAAFCAP = UTILS.ShuffleTable(USAAFCAP)
KPAAFCAP = UTILS.ShuffleTable(KPAAFCAP)
----------------------------------------------------------------
-- TODO Spawn Flights
----------------------------------------------------------------

function SpawnCapFlight(CapTable,FGTable,Template,Alias,RandomTemplates,Homebase,Parking,ZoneSet,NoEngageSet)
  local CAP = SPAWN:NewWithAlias(Template,Alias)  
    CAP:InitCleanUp(CleanupTime)
    CAP:InitSkill("Random")
    CAP:InitRandomizeTemplate(RandomTemplates)
    CAP:OnSpawnGroup(
      function(group)
        --CapTable[#CapTable+1] = group
        local Flight = FLIGHTGROUP:New(group) -- Ops.FlightGroup#FLIGHTGROUP
        Flight:SetDefaultRadio(254,radio.modulation.AM,true)
        Flight:SetDefaultSpeed(UTILS.KnotsToAltKIAS(350,20000))
        Flight:SetSpeed(300,true,true)
        Flight:SetFuelLowRTB(true)
        Flight:SetFuelLowThreshold(0.2)
        Flight:SetDetection(true)
        Flight:SetOutOfAAMRTB(true)
        Flight:SetEngageDetectedOn(EngagementDistance,{"Air"},nil,NoEngageSet)
        function Flight:OnAfterElementDead(From,Event,To,Element)
          BASE:I("*** CAP Plane Crashed ***")
          local random = math.random(1,6)
          local sound = "Korea Splash "..random..".ogg"
          local radio = USERSOUND:New(sound):ToCoalition(Flight:GetCoalition())
          local othercoalition = Flight:GetCoalition() == coalition.side.BLUE and coalition.side.RED or coalition.side.BLUE
          local radio2 = USERSOUND:New("Oh Jesus.ogg"):ToCoalition(othercoalition)
          MESSAGE:New(Flight:GetGroup():GetTypeName().." has been killed!",15,"Gardener"):ToAll()
        end
        local alt = math.random(FlightLevelMin,FlightLevelMax)*1000
        local zone = ZoneSet:GetRandom()
        local coord = zone:GetCoordinate()
        local mission = AUFTRAG:NewCAP(zone,alt,300,coord)
        Flight:AddMission(mission)
        FGTable[#FGTable+1] = Flight
      end
    )
    CAP:SpawnAtParkingSpot(AIRBASE:FindByName(Homebase),Parking,SPAWN.Takeoff.Hot)
end

----------------------------------------------------------------
-- TODO Red CAP
----------------------------------------------------------------

local BlueCAPs = {}
local BlueFGs = {}

if BlueSquadronsEnabled then
  BASE:I("Spawning BLUE CAPs")
  for i = 1,MaxCAP do
    SpawnCapFlight(BlueCAPs,BlueFGs,BlueTemplate,BlueSquadronName.."-"..i,USAAFCAP,BlueHomeBase,BlueParking,AlliedWPZones,NoEngageBlue)
  end
end

----------------------------------------------------------------
-- TODO Red CAP
----------------------------------------------------------------

local RedCAPs = {}
local RedFGs = {}

if RedSquadronsEnabled then
  BASE:I("Spawning RED CAPs")
  for i = 1,MaxCAP do
    SpawnCapFlight(RedCAPs,RedFGs,RedTemplate,RedSquadronName.."-"..i,KPAAFCAP,RedHomeBase,RedParking,CommunistWPZones,NoEngageRed)
  end
end

----------------------------------------------------------------
-- TODO Checks Flights in Air
----------------------------------------------------------------

function CheckFlights(MaxCAP)
  BASE:I("CheckFlights")
  if BlueSquadronsEnabled then
    -- Housekeeping
    local FG = {}
    local N = 0
    for _,_flight in pairs(BlueFGs) do
      local flight = _flight -- Ops.FlightGroup#FLIGHTGROUP
      if flight and (not flight:IsDead()) then
        FG[#FG+1] = flight
        N=N+1
      end
    end
    BlueFGs = nil
    BlueFGs = FG
    if N < MaxCAP then
      BASE:I("Spawning BLUE CAP Flights: "..MaxCAP-N)
      for i = 1,MaxCAP-N do
        SpawnCapFlight(BlueCAPs,BlueFGs,BlueTemplate,BlueSquadronName.."-"..i,USAAFCAP,BlueHomeBase,BlueParking,AlliedWPZones,NoEngageBlue)
      end
    end
  end
  if RedSquadronsEnabled then
        -- Housekeeping
    local FG = {}
    local N = 0
    for _,_flight in pairs(RedFGs) do
      local flight = _flight -- Ops.FlightGroup#FLIGHTGROUP
      if flight and (not flight:IsDead()) then
        FG[#FG+1] = flight
        N=N+1
      end
    end
    RedFGs = nil
    RedFGs = FG
    if N < MaxCAP then
      BASE:I("Spawning RED CAP Flights: "..MaxCAP-N)
      for i = 1,MaxCAP-N do
        SpawnCapFlight(RedCAPs,RedFGs,RedTemplate,RedSquadronName.."-"..i,KPAAFCAP,RedHomeBase,RedParking,CommunistWPZones,nil)
      end
    end
  end
end

local CheckTimer = TIMER:New(CheckFlights,MaxCAP)
local DT = math.random(RespawnTimerMin,RespawnTimerMax)
CheckTimer:Start(600,DT)

-- We need an AirWing
local AwacsAW = AIRWING:New("AirForce WH-1","AirForce One")
AwacsAW:SetMarker(false)
AwacsAW:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Kutaisi))
AwacsAW:SetRespawnAfterDestroyed(900)
AwacsAW:SetTakeoffAir()
AwacsAW:__Start(2)

function AwacsAW:OnAfterFlightOnMission(From,Event,To,FlightGroup,Mission)
  local group = FlightGroup:GetGroup()
  group:SetOption(AI.Option.Air.id.SILENCE, true)
end

---
--@param string From
--@param string Event
--@param string To
--@param Functional.Warehouse#WAREHOUSE.Assetitem  asset
--@param Functional.Warehouse#WAREHOUSE.Pendingitem  request
function AwacsAW:OnAfterAssetDead(From,Event,To,asset,request)
  BASE:I("*** AWACS AI CAP Crashed ***")
  local random = math.random(1,6)
  local sound = "Korea Splash "..random..".ogg"
  local radio = USERSOUND:New(sound):ToCoalition(coalition.side.BLUE)
  local othercoalition = coalition.side.RED
  local radio2 = USERSOUND:New("Oh Jesus.ogg"):ToCoalition(othercoalition)
  MESSAGE:New("A-4E-C has been killed!",15,"Gardener"):ToAll()
end

-- And a couple of Squads
-- CAP
local Squad_Three = SQUADRON:New("CAP",20,"VMA-124")
Squad_Three:AddMissionCapability({AUFTRAG.Type.ALERT5, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT},80)
Squad_Three:SetFuelLowRefuel(true)
Squad_Three:SetFuelLowThreshold(0.3)
Squad_Three:SetTurnoverTime(10,20)
Squad_Three:SetTakeoffAir()
Squad_Three:SetRadio(265,radio.modulation.AM)
AwacsAW:AddSquadron(Squad_Three)
AwacsAW:NewPayload("CAP-1-1",99,{AUFTRAG.Type.ALERT5,AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT},100)

-- Get AWACS started
local testawacs = AWACS:New("GCI Senaki",AwacsAW,"blue",AIRBASE.Caucasus.Kutaisi,nil,ZONE:FindByName("Rock"),"York",265,radio.modulation.AM )

-- change the below to your path and port
--if hereSRSGoogle then
  -- use Google
  --testawacs:SetSRS(hereSRSPath,"male","en-US",hereSRSPort,"en-US-Wavenet-I",0.9,hereSRSGoogle)
--else
  -- use Windows
  testawacs:SetSRS(hereSRSPath,"female","en-US",hereSRSPort,nil,0.9)
--end

testawacs:SetAICAPDetails(CALLSIGN.Aircraft.Chevy,2,2,300)
testawacs:SetColdWar()
testawacs:SetPlayerGuidance(true)
--testawacs:DrawFEZ()
testawacs.AllowMarkers = true
testawacs.debug=false
local blueEWR = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes("EWR"):FilterOnce()
testawacs:AddGroupToDetection(blueEWR)
-- Start as GCI
testawacs:SetAsGCI(GROUP:FindByName("Blue EWR"),2)
testawacs:SetCustomAWACSCallSign({
                [1]="Barber", -- Overlord
                [2]="Gunpost", -- Magic
                [3]="Birdbrain", -- Wizard
                [4]="Racecart", -- Focus
                [5]="Logroll", -- Darkstar
                })
testawacs:SetAwacsDetails(CALLSIGN.AWACS.Magic)
testawacs:SetRejectionZone(ZONE:New("SAMRange"),true)
testawacs:__Start(4)

local myatis = ATIS:New(AIRBASE.Caucasus.Senaki_Kolkhi,132.5,radio.modulation.AM)
myatis:SetSRS(hereSRSPath,"male","en-US",nil,hereSRSPort)
myatis:SetActiveRunway("09")
myatis:SetMetricUnits()
myatis:SetTACAN(31)
myatis:SetTransmitOnlyWithPlayers(true)
myatis:SetReportmBar(true)
myatis:__Start(2)

local redatis = ATIS:New(AIRBASE.Caucasus.Sukhumi_Babushara,129.5,radio.modulation.AM)
redatis:SetSRS(hereSRSPath,"male","en-US",nil,hereSRSPort)
redatis:SetActiveRunway("12")
redatis:SetImperialUnits()
redatis:SetTransmitOnlyWithPlayers(true)
redatis:SetReportmBar(true)
redatis:__Start(4)

local atiskut = ATIS:New(AIRBASE.Caucasus.Kutaisi,134.5,radio.modulation.AM)
atiskut:SetSRS(hereSRSPath,"male","en-US",nil,hereSRSPort)
--atiskut:SetActiveRunway("09")
atiskut:SetImperialUnits()
atiskut:SetTACAN(44)
atiskut:SetTransmitOnlyWithPlayers(true)
myatis:SetReportmBar(true)
atiskut:__Start(4)
