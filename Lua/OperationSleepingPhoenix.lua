--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- SRS and Mission Config
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
BASE:I("Operation Sleeping Phoenix Loading v.0.7.5")
-- Settings
_SETTINGS:SetPlayerMenuOff()
_SETTINGS:SetImperial()
_SETTINGS:SetA2G_LL_DDM()
_SETTINGS:SetA2A_BRAA()
_SETTINGS:SetLL_Accuracy( 3 )
_SETTINGS:SetMGRS_Accuracy( 4 )
_SETTINGS:SetEraModern()
BASE:I("Settings Loaded")

--BASE:TraceOff()
--BASE:TraceLevel(1)
--BASE:TraceClass("MANTIS")



local hereSRSPath = mySRSPath or "G:\\DCS-SimpleRadio-Standalone"
local hereSRSPort = mySRSPort or 5002
local hereSRSGoogle = mySRSGKey or "G:\\DCS-SimpleRadio-Standalone\\dcsservertts-9dbcbd76a991.json"

local DEBUG = false
local AirSupportInterval = 600
local AirSupportTemplate = "USAAF Strike"


for i=1,1000 do
  math.random(1,10000)
end

local menu = MENU_COALITION:New(coalition.side.BLUE,"Ops Menu")
local menu2 = MENU_COALITION:New(coalition.side.BLUE,"Request Support")

BlueDetectionSet = SET_GROUP:New():FilterCoalitions(coalition.side.BLUE):FilterPrefixes({"AWACS", "EWR", "SAM" }):FilterStart()
RedDetectionSet = SET_GROUP:New():FilterCoalitions(coalition.side.RED):FilterPrefixes({"EWR","AWACS", "SAM"}):FilterStart()

RedCapZone01 = ZONE:FindByName("RedCapZone-1")
RedCapZone02 = ZONE:FindByName("RedCapZone-2")
RedCapZone03 = ZONE:FindByName("RedCapZone-3")
RedCapZone04 = ZONE:FindByName("RedCapZone-4")
RedCapZone05 = ZONE:FindByName("RedCapZone-5")
RedCapZone06 = ZONE:FindByName("RedCapZone-6")
BlueCapZone01 = ZONE:FindByName("BlueCapZone-1")
BlueCapZone02 = ZONE:FindByName("BlueCapZone-2")
BlueCapZone03 = ZONE:FindByName("BlueCapZone-3")
BlueAWACSZone1 = ZONE:FindByName("BlueAWACS1")
BlueTexacoZone1 = ZONE:FindByName("TexacoNorth1")
BlueShellZone1 = ZONE:FindByName("ShellSouth1")

BlueBorder1 = ZONE_POLYGON:NewFromGroupName("BlueBorder-1")
BlueBorder2 = ZONE_POLYGON:NewFromGroupName("BlueBorder-2")
BlueBorder3 = ZONE_POLYGON:NewFromGroupName("BlueBorder-3")
BlueBorder4 = ZONE_POLYGON:NewFromGroupName("BlueBorder-4")
RedBorder1 = ZONE_POLYGON:NewFromGroupName("RedBorder-1")
RedBorder2 = ZONE_POLYGON:NewFromGroupName("RedBorder-2")
RedBorder3 = ZONE_POLYGON:NewFromGroupName("RedBorder-3")
RedBorder4 = ZONE_POLYGON:NewFromGroupName("RedBorder-4")
RedEngageSet = SET_ZONE:New():AddZone(RedBorder1):AddZone(RedBorder2):AddZone(RedBorder3):AddZone(RedBorder4):DrawZone(2,{1,0,0},.5,{1,0,0},.15,2,true)
BlueEngageSet = SET_ZONE:New():AddZone(BlueBorder1):DrawZone(2,{0,0,1},.5,{0,0,1},.15,2,true)


--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- SRS PLAYERSOUNDS AND TTS
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local PhoenixSRS = MSRS:New(hereSRSPath , {31,131,281}, {radio.modulation.FM,radio.modulation.AM,radio.modulation.AM}, 1)
PhoenixSRS:SetGoogle(hereSRSGoogle)
PhoenixSRS:SetVoice("uk-UA-Wavenet-A")
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- PlayerTasking Settings and Task Controller
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local phoenixwesttasking = PLAYERTASKCONTROLLER:New("Phoenix West",coalition.side.BLUE,PLAYERTASKCONTROLLER.Type.A2G)
phoenixwesttasking:DisableTaskInfoMenu()
phoenixwesttasking:EnableTaskInfoMenu() 
phoenixwesttasking:SetMenuOptions(true,5,30)
phoenixwesttasking:SetAllowFlashDirection(true)
phoenixwesttasking:SetLocale("en")
phoenixwesttasking:SetMenuName("Phoenix West")
phoenixwesttasking:SetSRS({32,132,282},{radio.modulation.FM,radio.modulation.AM,radio.modulation.AM},hereSRSPath,nil,nil,hereSRSPort,"en-AU-Wavenet-C",0.7,hereSRSGoogle)
phoenixwesttasking:SetSRSBroadcast({30,130,280},{radio.modulation.FM,radio.modulation.AM,radio.modulation.AM})
phoenixwesttasking:SetTargetRadius(750)
phoenixwesttasking:SetParentMenu(menu)
phoenixwesttasking:SetTransmitOnlyWithPlayers(true)

function phoenixwesttasking:OnAfterTaskTargetSmoked(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function phoenixwesttasking:OnAfterTaskTargetFlared(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function phoenixwesttasking:OnAfterTaskTargetIlluminated(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local phoenixeasttasking = PLAYERTASKCONTROLLER:New("Phoenix East",coalition.side.BLUE,PLAYERTASKCONTROLLER.Type.A2G)
phoenixeasttasking:DisableTaskInfoMenu()
phoenixeasttasking:EnableTaskInfoMenu() 
phoenixeasttasking:SetMenuOptions(true,5,30)
phoenixeasttasking:SetAllowFlashDirection(true)
phoenixeasttasking:SetLocale("en")
phoenixeasttasking:SetMenuName("Phoenix East")
phoenixeasttasking:SetSRS({34,134,284},{radio.modulation.FM,radio.modulation.AM,radio.modulation.AM},hereSRSPath,nil,nil,hereSRSPort,"en-AU-Wavenet-C",0.7,hereSRSGoogle)
phoenixeasttasking:SetSRSBroadcast({31,131,281},{radio.modulation.FM,radio.modulation.AM,radio.modulation.AM})
phoenixeasttasking:SetTargetRadius(750)
phoenixeasttasking:SetParentMenu(menu)
phoenixeasttasking:SetTransmitOnlyWithPlayers(true)

function phoenixeasttasking:OnAfterTaskTargetSmoked(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function phoenixeasttasking:OnAfterTaskTargetFlared(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

function phoenixeasttasking:OnAfterTaskTargetIlluminated(From,Event,To,Task)
  local file = "Target Smoke.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
end

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--  Mission Targets Operation 1
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local OPWestPhase1 = { 
 [1] = {       
    TargetName = "RED SAM SA-8-2",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-8 SAM Site located at Ochamchira\nGrid GH03",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [2] = {       
    TargetName = "RED COMMAND TRUCKS-3",
    TargetStatic = false,
    TargetBriefing = "Destroy the Field Command Post Near Enguri Dam\nGrid KN53",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [3] = {       
    TargetName = "RED COMMAND TRUCKS-1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Field Command Post located at Zeni\nGrid GH21",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [4] = {       
    TargetName = "RED ARMOR-1",
    TargetStatic = false,
    TargetBriefing = "Destroy the tanks located east of Zartsupai\nGrid GH10",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [5] = {       
    TargetName = "RED ARMOR-13",
    TargetStatic = false,
    TargetBriefing = "Destroy the Tanks located at Chuburhindzhi\nGrid GH21",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [6] = {       
    TargetName = "RED ARMOR-14",
    TargetStatic = false,
    TargetBriefing = "Destroy the APC's located at Modzvi\nGrid LM67",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [7] = {       
    TargetName = "RED ARMOR-2",
    TargetStatic = false,
    TargetBriefing = "Destroy the APC's located at Nebodzin\nGrid LM64",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [8] = {       
    TargetName = "RED ARMOR-3",
    TargetStatic = false,
    TargetBriefing = "Destroy the APC's located North of Sareki\nGrid LM69",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [9] = {       
    TargetName = "RED ARMOR-4",
    TargetStatic = false,
    TargetBriefing = "Destroy the APC's located East of Korbouli\nGrid LM77",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [10] = {        
    TargetName = "RED ARMOR-5",
    TargetStatic = false,
    TargetBriefing = "Destroy the APC's located North of Salieti\nGrid LM58",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [11] = {        
    TargetName = "RED ARMOR-6",
    TargetStatic = false,
    TargetBriefing = "Destroy the APC's located at Chkhortoli\nGrid GH23",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [12] = {        
    TargetName = "RED ARTILLERY-1",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery located at Tsipa\nGrid LM75",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [13] = {        
    TargetName = "RED ARTILLERY-6",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery located at Muszhava\nGrid GH43/KN53",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [14] = {        
    TargetName = "RED ARMOR-25",
    TargetStatic = false,
    TargetBriefing = "Destroy the APC's located at Saberio\nGrid GH32",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [15] = {        
    TargetName = "RED COMMAND TRUCKS-2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Command Vehicles located at Gali\nGrid GH22",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [16] = {        
    TargetName = "RED SAM SA-13-4",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-13 SAM Site located East of Pokvesh\nGrid GH14",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [17] = {        
    TargetName = "RED SAM SA-13-3",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-13 SAM Site located West of Korbouli\nGrid LM77",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  } ,
  [18] = {        
    TargetName = "RED SAM SA-13-2",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-13 SAM Site located Northeast of Grigalati\nGrid LM66",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [19] = {        
    TargetName = "RED SAM SA-15-8",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-15 SAM Site located North of Gali\nGrid GH22",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [20] = {        
    TargetName = "RED SAM SA-2-3",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-2 SAM Site located North of Tbilisi-Lochini Airfield\nGrid MM91",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },

  }
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
  
OPWestPhase1 = UTILS.ShuffleTable(OPWestPhase1)

local OPWestPhase1Targets = {}
for i=1,20 do
  if OPWestPhase1[i].TargetStatic then
    -- static
    OPWestPhase1Targets[i] = TARGET:New(STATIC:FindByName(OPWestPhase1[i].TargetName))
  else
    -- group
    OPWestPhase1Targets[i] = TARGET:New(GROUP:FindByName(OPWestPhase1[i].TargetName))
  end
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

local WestPhase1Operation = OPERATION:New("Operation Sleeping Phoenix West/Phase 1")
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

for i=1,20 do
  -- Add Phases
  local phase = WestPhase1Operation:AddPhase(i)
  -- Add condition over
  WestPhase1Operation:AddPhaseConditonOverAll(phase,
  function(target)
    local Target = target -- Ops.Target#TARGET
    if Target:IsDead() or Target:IsDestroyed() or Target:CountTargets() == 0 then
      return true
    else
     return false
    end 
  end,OPWestPhase1Targets[i])
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

WestPhase1Operation:__Start(20)
  
  
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local OPWestPhase2 = { 
  [1] = {       
    TargetName = "RED ARMOR-21",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Unit located at Bzyb\nGrid FH18",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [2] = {       
    TargetName = "RED ARTILLERY-14",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Unit located at Nizh. Teberda\nGrid GJ33",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [3] = {       
    TargetName = "RED ARTILLERY-10",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Unit located at Navaginka\nGrid EJ52",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [4] = {       
    TargetName = "RED ARMOR-8",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Unit located at Vardane\nGrid EJ44",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [5] = {       
    TargetName = "RED ARMOR-22",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Unit located Northwest of Kurdzhinoyo\nGrid FJ57",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [6] = {       
    TargetName = "RED ARMOR-9",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Unit located West of Kurdzhinoyo\nGrid FJ57",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [7] = {       
    TargetName = "RED ARMOR-23",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Unit located West of Zemo-Azhara\nGrid GH27",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [8] = {       
    TargetName = "RED ARTILLERY-9",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Unit located NorthEast of Sochi-Adler\nGrid EJ71",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [9] = {       
    TargetName = "RED SAM SA-2-2",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-2 SAM Site located North of Sochi-Adler\nGrid EJ71",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [10] = {        
    TargetName = "RED SAM SA-8-7",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-8 SAM Site located at Sochi-Adler\nGrid EJ70",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [11] = {        
    TargetName = "RED SAM SA-15-5",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-15 SAM Site located at Sochi-Adler\nGrid EJ70",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [12] = {        
    TargetName = "RED SAM SA-15-6",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-15 SAM Site located at Gaudata City\nGrid FH37",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [13] = {        
    TargetName = "RED SAM SA-8-6",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-8 SAM Site located at Gaudata Airfield\nGrid FH27",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [14] = {        
    TargetName = "RED EWR-2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Early Warning Radar Site South of Arhyz\nGrid FJ81",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [15] = {        
    TargetName = "RED ARTILLERY-7",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located at Gaudata Airfield\nGrid FH27",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [16] = {        
    TargetName = "RED ARTILLERY-8",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located at Mugudzyrhva\nGrid FH27",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [17] = {        
    TargetName = "RED ARTILLERY-5",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located at Chlou\nGrid GH04",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  } ,
  [18] = {        
    TargetName = "RED ARMOR-7",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Kochara\nGrid GH04",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [19] = {        
    TargetName = "RED SAM SA-15-7",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-15 SAM Site located south of Baglan\nGrid FH74",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [20] = {        
    TargetName = "RED SAM SA-8-1",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-8 SAM Site located West of Varcha\nGrid FH74",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },

}
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

OPWestPhase2 = UTILS.ShuffleTable(OPWestPhase2)

local OPWestPhase2Targets = {}
for i=1,20 do
  if OPWestPhase2[i].TargetStatic then
    -- static
    OPWestPhase2Targets[i] = TARGET:New(STATIC:FindByName(OPWestPhase2[i].TargetName))
  else
    -- group
    OPWestPhase2Targets[i] = TARGET:New(GROUP:FindByName(OPWestPhase2[i].TargetName))
  end
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

local WestPhase2Operation = OPERATION:New("Operation Sleeping Phoenix West/Phase 2")
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

for i=1,20 do
  -- Add Phases
  local phase = WestPhase2Operation:AddPhase(i)
  -- Add condition over
  WestPhase2Operation:AddPhaseConditonOverAll(phase,
  function(target)
    local Target = target -- Ops.Target#TARGET
    if Target:IsDead() or Target:IsDestroyed() or Target:CountTargets() == 0 then
      return true
    else
     return false
    end 
  end,OPWestPhase2Targets[i])
end

--WestPhase2Operation:__Start(20)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local OPEastPhase1 = { 
  [1] = {       
    TargetName = "RED ARMOR-24",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located North of Agara\nGrid MM05",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [2] = {       
    TargetName = "RED ARMOR-16",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located North of Gori\nGrid MM25",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [3] = {       
    TargetName = "RED ARTILLERY-3",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located North of Kashuri\nGrid LM85",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [4] = {       
    TargetName = "RED SAM SA-8-5",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-8 SAM Site located at North of Alagir\nGrid MN36",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [5] = {       
    TargetName = "RED SAM SA-13-6",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-13 SAM Site located West of Agara\nGrid MM05",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [6] = {       
    TargetName = "RED SAM SA-15-11",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-15 SAM Site located South of Nart\nGrid MN57",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [7] = {       
    TargetName = "RED ARTILLERY-21",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located West of Dzali\nGrid MM64",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [8] = {       
    TargetName = "RED ARMOR-17",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units locatedEast of Tarskoye\nGrid MN95",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [9] = {       
    TargetName = "RED EWR-3",
    TargetStatic = false,
    TargetBriefing = "Destroy the Early Warning Radar Site East of Kazbegi\nGrid MN72",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [10] = {        
    TargetName = "RED ARMOR-29",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Karabulak\nGrid MN99",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [11] = {        
    TargetName = "RED ARMOR-20",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located East of Dusheri\nGrid MM75",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [12] = {        
    TargetName = "RED ARMOR-28",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Leningori\nGrid MM56",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [13] = {        
    TargetName = "RED SAM SA-8-3",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-8 SAM Site located at Vladikavkaz\nGrid MN76",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [14] = {        
    TargetName = "RED ARTILLERY-20",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located at Vladikavkaz\nGrid MN76",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [15] = {        
    TargetName = "RED SAM SA-15-9",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-15 SAM Site located at Beslan Airfield\nGrid MN68",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [16] = {        
    TargetName = "RED ARTILLERY-2",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located at Beslan Airfield\nGrid MN76",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [17] = {        
    TargetName = "RED ARMOR-19",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Beslan\nGrid MN68",
    TargetAuftrag = AUFTRAG.Type.CAS,
  } ,
  [18] = {        
    TargetName = "RED ARMOR-18",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Tskhinvali\nGrid MM17",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [19] = {        
    TargetName = "RED COMMAND TRUCKS-4",
    TargetStatic = false,
    TargetBriefing = "Destroy the Command Vehicles located at Karaleti\nGrid MM25",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [20] = {        
    TargetName = "RED ARMOR-15",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Vladikavkaz\nGrid MN76",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },

}
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

OPEastPhase1 = UTILS.ShuffleTable(OPEastPhase1)

local OPEastPhase1Targets = {}
for i=1,20 do
  if OPEastPhase1[i].TargetStatic then
    -- static
    OPEastPhase1Targets[i] = TARGET:New(STATIC:FindByName(OPEastPhase1[i].TargetName))
  else
    -- group
    OPEastPhase1Targets[i] = TARGET:New(GROUP:FindByName(OPEastPhase1[i].TargetName))
  end
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

local EastPhase1Operation = OPERATION:New("Operation Sleeping Phoenix East/Phase 1")
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

for i=1,20 do
  -- Add Phases
  local phase = EastPhase1Operation:AddPhase(i)
  -- Add condition over
  EastPhase1Operation:AddPhaseConditonOverAll(phase,
  function(target)
    local Target = target -- Ops.Target#TARGET
    if Target:IsDead() or Target:IsDestroyed() or Target:CountTargets() == 0 then
      return true
    else
     return false
    end 
  end,OPEastPhase1Targets[i])
end

EastPhase1Operation:__Start(25)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local OPEastPhase2 = { 
  [1] = {       
    TargetName = "RED SAM SA-15-10",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-15 SAM Site located at Nalchik Airfield\nGrid LP91",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [2] = {       
    TargetName = "RED SAM SA-15-12",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-15 SAM Site located at Mozdok Airfield\nGrid MP64",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [3] = {       
    TargetName = "RED SAM SA-15-13",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-15 SAM Site located at Mineralnye-Vody Airfield\nGrid LP49",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [4] = {       
    TargetName = "RED EWR-4",
    TargetStatic = false,
    TargetBriefing = "Destroy the Early Warning Radar Site located at Mineralnye-Vody Airfield\nGrid LQ31",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [5] = {       
    TargetName = "RED SAM SA-8-4",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-8 SAM Site located at Mineralnye-Vody Airfield\nGrid LQ40",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [6] = {       
    TargetName = "RED SAM SA-8-10",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-8 SAM Site located at Mozdok\nGrid MP74",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [7] = {       
    TargetName = "RED SAM SA-8-11",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-8 SAM Site located at Nalchik Airfield\nGrid LP91",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [8] = {       
    TargetName = "RED SAM SA-2-3",
    TargetStatic = false,
    TargetBriefing = "Destroy the SA-2 SAM Site located at Mineralnye-Vody Airfield\nGrid LQ40",
    TargetAuftrag = AUFTRAG.Type.SEAD,
  },
  [9] = {       
    TargetName = "RED COMMAND TRUCKS-5",
    TargetStatic = false,
    TargetBriefing = "Destroy the Command and Supply Units located at Nalchik\nGrid LP81",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [10] = {        
    TargetName = "RED ARMOR-30",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Znamenka\nGrid KP69",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [11] = {        
    TargetName = "RED ARMOR-31",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Energetik\nGrid LP48",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [12] = {        
    TargetName = "RED ARMOR-32",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Nalchik\nGrid LP81",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [13] = {        
    TargetName = "RED ARMOR-33",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Mozdok\nGrid MP64",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [14] = {        
    TargetName = "RED ARMOR-34",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Novopavlovsk\nGrid LP96",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [15] = {        
    TargetName = "RED ARMOR-35",
    TargetStatic = false,
    TargetBriefing = "Destroy the Armor Units located at Bekeshevskaya\nGrid KP98",
    TargetAuftrag = AUFTRAG.Type.CAS,
  },
  [16] = {        
    TargetName = "RED ARTILLERY-4",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located north of Shithala\nGrid MP02",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [17] = {        
    TargetName = "RED ARTILLERY-22",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located at Russkoye\nGrid MP65",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  } ,
  [18] = {        
    TargetName = "RED ARTILLERY-23",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located at Kichmalka\nGrid LP35",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [19] = {        
    TargetName = "RED ARTILLERY-24",
    TargetStatic = false,
    TargetBriefing = "Destroy the Artillery Units located at Baksan\nGrid LP83",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },
  [20] = {        
    TargetName = "RED COMMAND TRUCKS-5",
    TargetStatic = false,
    TargetBriefing = "Destroy the Command and Supply Units located at Kislovodsk\nGrid LP16",
    TargetAuftrag = AUFTRAG.Type.BOMBING,
  },

}
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

local OPEastPhase2Targets = {}
for i=1,20 do
  if OPEastPhase2[i].TargetStatic then
    -- static
    OPEastPhase2Targets[i] = TARGET:New(STATIC:FindByName(OPEastPhase2[i].TargetName))
  else
    -- group
    OPEastPhase2Targets[i] = TARGET:New(GROUP:FindByName(OPEastPhase2[i].TargetName))
  end
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

local EastPhase2Operation = OPERATION:New("Operation Sleeping Phoenix East/Phase 2")
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

for i=1,20 do
  -- Add Phases
  local phase = EastPhase2Operation:AddPhase(i)
  -- Add condition over
  EastPhase2Operation:AddPhaseConditonOverAll(phase,
  function(target)
    local Target = target -- Ops.Target#TARGET
    if Target:IsDead() or Target:IsDestroyed() or Target:CountTargets() == 0 then
      return true
    else
     return false
    end 
  end,OPEastPhase2Targets[i])
end

--EastPhase2Operation:__Start(25)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

if DEBUG then
  WestPhase1Operation.verbose = 1
  WestPhase2Operation.verbose = 1
  EastPhase1Operation.verbose = 1
  EastPhase2Operation.verbose = 1
end

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- TODO A2G Strike Support
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local FlightLock = timer.getTime() - AirSupportInterval

function CallAirSupportWest()
  local TNow = timer.getTime()
  if TNow-FlightLock > AirSupportInterval then
    FlightLock = timer.getTime()
    -- Get Current Target
    local phase = WestOperation:GetPhaseActive()
    if not phase then
      MESSAGE:New("Strike Bombers Unable To Locate Target",15,"Phoenix"):ToBlue()
      return 
    end
    local ind = phase.name
    local type = WestMissions[ind].TargetAuftrag
    local brief = WestMissions[ind].TargetBriefing
    local IsStatic = WestMissions[ind].TargetStatic
    local Name = WestMissions[ind].TargetName
    local Target = nil
    if IsStatic then
      Target = STATIC:FindByName(Name)
    else
      Target = GROUP:FindByName(Name)
    end
    auftragwest = nil
    if type == AUFTRAG.Type.CAS then
      local CasZone = ZONE_RADIUS:New(Name,Target:GetVec2(),500)
      auftragwest = AUFTRAG:NewCASENHANCED(CasZone,nil,350,10,nil,{"Ground Units"})
    elseif type == AUFTRAG.Type.BOMBING then
      auftragwest = AUFTRAG:NewBOMBING(Target)
      auftragwest:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
      auftragwest:SetMissionSpeed(350)
    elseif type == AUFTRAG.Type.SEAD then
      auftragwest = AUFTRAG:NewSEAD(Target)
      auftragwest:SetMissionSpeed(350)
    end
    if auftragwest then
      local flight = SPAWN:NewWithAlias(AirSupportTemplate,AirSupportTemplate.."-"..math.random(10,10000))
      flight:InitCleanUp(120)
      flight:OnSpawnGroup(
        function(group)
          local FG = FLIGHTGROUP:New(group)
          FG:SetDefaultRadio(254,radio.modulation.AM,true)
          FG:SetDespawnAfterLanding()
          FG:SetFuelLowRTB(true)
          FG:AddMission(auftragwest)
          MESSAGE:New("Strike Bombers Launched",15,"Phoenix"):ToBlue()
          PhoenixSRS:PlayText("Phoenix to all stations. Strike Bombers Launched",1)
          --USERSOUND:New("Lets Go Get Em.ogg"):ToCoalition(coalition.side.BLUE)
          function FG:OnAfterRTB()    
            MESSAGE:New("Strike Bombers Are Returning To Base",15,"Phoenix"):ToBlue()
            PhoenixSRS:PlayText("Phoenix to all stations. Strike Bombers Are R.T.B",1)
          end
          function FG:onafterHolding()
            FG:ClearToLand(2)
          end
          function auftragwest:OnAfterExecuting()
            MESSAGE:New("The Strike Bomber Flight Reports Target Coordinates Are Locked In And They Are Engaging!",15,"Phoenix"):ToBlue()
            PhoenixSRS:PlayText("Phoenix to all stations. The Strike Bomber Flight Reports Target Coordinates Are Locked In And They Are Engaging!",1)
          end    
        end
      )
      flight:SpawnAtAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Senaki_Kolkhi),SPAWN.Takeoff.Hot,nil,nil,true,nil)
    end
  else
    MESSAGE:New("Strike Bombers Are Currently Active, Further Support Is Unavailable",15,"Phoenix"):ToBlue()
    PhoenixSRS:PlayText("Phoenix to all stations. Strike Bombers Are Currently Active, Further Support Is Unavailable",1)
  end
end

local support = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Request Support - West",menu2,CallAirSupportWest)

function CallAirSupportEast()
  local TNow = timer.getTime()
  if TNow-FlightLock > AirSupportInterval then
    FlightLock = timer.getTime()
    -- Get Current Target
    local phase = EastOperation:GetPhaseActive()
    if not phase then
      MESSAGE:New("Strike Bombers Unable To Locate Target",15,"Phoenix"):ToBlue()
      return 
    end
    local ind = phase.name
    local type = EastMissions[ind].TargetAuftrag
    local brief = EastMissions[ind].TargetBriefing
    local IsStatic = EastMissions[ind].TargetStatic
    local Name = EastMissions[ind].TargetName
    local Target = nil
    if IsStatic then
      Target = STATIC:FindByName(Name)
    else
      Target = GROUP:FindByName(Name)
    end
    auftrageast = nil
    if type == AUFTRAG.Type.CAS then
      local CasZone = ZONE_RADIUS:New(Name,Target:GetVec2(),500)
      auftrageast = AUFTRAG:NewCASENHANCED(CasZone,nil,350,10,nil,{"Ground Units"})
    elseif type == AUFTRAG.Type.BOMBING then
      auftrageast = AUFTRAG:NewBOMBING(Target)
      auftrageast:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
      auftrageast:SetMissionSpeed(350)
    elseif type == AUFTRAG.Type.SEAD then
      auftrageast = AUFTRAG:NewSEAD(Target)
      auftrageast:SetMissionSpeed(350)
    end
    if auftrageast then
      local flight = SPAWN:NewWithAlias(AirSupportTemplate,AirSupportTemplate.."-"..math.random(10,10000))
      flight:InitCleanUp(120)
      flight:OnSpawnGroup(
        function(group)
          local FG = FLIGHTGROUP:New(group)
          FG:SetDefaultRadio(254,radio.modulation.AM,true)
          FG:SetDespawnAfterLanding()
          FG:SetFuelLowRTB(true)
          FG:AddMission(auftrageast)
          MESSAGE:New("Strike Bombers Launched",15,"Phoenix"):ToBlue()
          PhoenixSRS:PlayText("Phoenix to all stations. Strike Bombers Launched",1)
          --USERSOUND:New("Lets Go Get Em.ogg"):ToCoalition(coalition.side.BLUE)
          function FG:OnAfterRTB()    
            MESSAGE:New("Strike Bombers Are Returning To Base",15,"Phoenix"):ToBlue()
            PhoenixSRS:PlayText("Phoenix to all stations. Strike Bombers Are R.T.B",1)
          end
          function FG:onafterHolding()
            FG:ClearToLand(2)
          end
          function auftrageast:OnAfterExecuting()
            MESSAGE:New("The Strike Bomber Flight Reports Target Coordinates Are Locked In And They Are Engaging!",15,"Phoenix"):ToBlue()
            PhoenixSRS:PlayText("Phoenix to all stations. The Strike Bomber Flight Reports Target Coordinates Are Locked In And They Are Engaging!",1)
          end    
        end
      )
      flight:SpawnAtAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Senaki_Kolkhi),SPAWN.Takeoff.Hot,nil,nil,true,nil)
    end
  else
    MESSAGE:New("Strike Bombers Are Currently Active, Further Support Is Unavailable",15,"Phoenix"):ToBlue()
    PhoenixSRS:PlayText("Phoenix to all stations. Strike Bombers Are Currently Active, Further Support Is Unavailable",1)
  end
end

local support2 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Request Support - East",menu2,CallAirSupportEast)

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Navy
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

local Navy = GROUP:FindByName("US Navy")
if Navy then
  Navy:PatrolRoute()
end

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--ATIS
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local myatis = ATIS:New(AIRBASE.Caucasus.Senaki_Kolkhi,132.5,radio.modulation.AM)
myatis:SetSRS(hereSRSPath,"female","en-GB",nil,hereSRSPort)
myatis:SetActiveRunway("27")
myatis:SetImperialUnits()
myatis:SetTACAN(31)
myatis:SetTransmitOnlyWithPlayers(true)
myatis:__Start(2)

--local atiskut = ATIS:New(AIRBASE.Caucasus.Kutaisi,134.5,radio.modulation.AM)
--atiskut:SetSRS(hereSRSPath,"male","en-US",nil,hereSRSPort)
--atiskut:SetActiveRunway("25")
--atiskut:SetImperialUnits()
--atiskut:SetTACAN(44)
--atiskut:SetTransmitOnlyWithPlayers(true)
--atiskut:__Start(4)

local atiskob = ATIS:New(AIRBASE.Caucasus.Kobuleti,136.5,radio.modulation.AM)
atiskob:SetSRS(hereSRSPath,"male","en-US",nil,hereSRSPort)
atiskob:SetActiveRunway("25")
atiskob:SetImperialUnits()
atiskob:SetTACAN(44)
atiskob:SetTransmitOnlyWithPlayers(true)
atiskob:__Start(4)

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--MANTIS
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedMantis = MANTIS:New("Red MANTIS","RED SAM","RED EWR",nil,"red",true,nil,true,30)

RedMantis:__Start(10)
local BlueMantis = MANTIS:New("Blue MANTIS","BLUE SAM","BLUE EWR",nil,"blue",true,nil,true,30)

BlueMantis:__Start(10)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--RED SQDRN/AIRWINGS/CHIEF
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd1=SQUADRON:New("MiG-29A",12,"Red Fighter Squadron 1") --Ops.Squadron#SQUADRON
RedSqd1:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
RedSqd1:SetModex(100)
RedSqd1:SetTurnoverTime(5, 6)
RedSqd1:SetGrouping(4)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd2=SQUADRON:New("MiG-29S",12,"Red Fighter Squadron 2") --Ops.Squadron#SQUADRON
RedSqd2:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
RedSqd2:SetModex(200)
RedSqd2:SetTurnoverTime(5, 6)
RedSqd2:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd3=SQUADRON:New("Su-33",12,"Red Fighter Squadron 3") --Ops.Squadron#SQUADRON
RedSqd3:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
RedSqd3:SetModex(300)
RedSqd3:SetTurnoverTime(5, 6)
RedSqd3:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd4=SQUADRON:New("Su-27",12,"Red Fighter Squadron 4") --Ops.Squadron#SQUADRON
RedSqd4:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
RedSqd4:SetModex(400)
RedSqd4:SetTurnoverTime(5, 6)
RedSqd4:SetGrouping(4)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd5=SQUADRON:New("F-14A",12,"Red Fighter Squadron 5") --Ops.Squadron#SQUADRON
RedSqd5:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
RedSqd5:SetModex(500)
RedSqd5:SetTurnoverTime(5, 6)
RedSqd5:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd6=SQUADRON:New("Su-33",12,"Red Fighter Squadron 3") --Ops.Squadron#SQUADRON
RedSqd6:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
RedSqd6:SetModex(300)
RedSqd6:SetTurnoverTime(5, 6)
RedSqd6:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd7=SQUADRON:New("MiG-29S",12,"Red Fighter Squadron 2") --Ops.Squadron#SQUADRON
RedSqd7:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
RedSqd7:SetModex(200)
RedSqd7:SetTurnoverTime(5, 6)
RedSqd7:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd8=SQUADRON:New("Su-27",12,"Red Fighter Squadron 4") --Ops.Squadron#SQUADRON
RedSqd8:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
RedSqd8:SetModex(400)
RedSqd8:SetTurnoverTime(5, 6)
RedSqd8:SetGrouping(4)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd98=SQUADRON:New("IL-78", 99, "RED REFUELING SQD") --Ops.Squadron#SQUADRON
RedSqd98:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
RedSqd98:SetFuelLowRefuel(true)
RedSqd98:SetFuelLowThreshold(0.1)
RedSqd98:SetTakeoffAir()
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedSqd99=SQUADRON:New("A-50 AWACS", 99, "RED 97th AWACS") --Ops.Squadron#SQUADRON
RedSqd99:AddMissionCapability(AUFTRAG.Type.AWACS, 100)
RedSqd99:SetFuelLowRefuel(true)
RedSqd99:SetFuelLowThreshold(.10)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedAirWing1=AIRWING:New("Krasnodar Warehouse", "Krasnodar Airwing") --Ops.AirWing#AIRWING
RedAirWing1:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Krasnodar_Center))
RedAirWing1:NewPayload("F-14A", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
RedAirWing1:NewPayload("MiG-29S", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
RedAirWing1:NewPayload("IL-78", 99, {AUFTRAG.Type.TANKER}, 99)
RedAirWing1:NewPayload("A-50 AWACS", 99, {AUFTRAG.Type.AWACS}, 99)
RedAirWing1:AddSquadron(RedSqd2)
RedAirWing1:AddSquadron(RedSqd5)
RedAirWing1:AddSquadron(RedSqd98)
RedAirWing1:AddSquadron(RedSqd99)
RedAirWing1:SetRunwayRepairtime(600)
RedAirWing1:SetTakeoffHot()
RedAirWing1:SetDespawnAfterHolding(true)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedAirWing2=AIRWING:New("Sochi Warehouse", "Sochi-Adler Airwing") --Ops.AirWing#AIRWING
RedAirWing2:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Sochi_Adler))
RedAirWing2:NewPayload("MiG-29A", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
RedAirWing2:AddSquadron(RedSqd1)
RedAirWing2:SetRunwayRepairtime(600)
RedAirWing2:SetTakeoffHot()
RedAirWing2:SetDespawnAfterHolding(true)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedAirWing3=AIRWING:New("Krymsk Warehouse", "Krymsk Airwing") --Ops.AirWing#AIRWING
RedAirWing3:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Krymsk))
RedAirWing3:NewPayload("Su-27", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
RedAirWing3:NewPayload("Su-33", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
RedAirWing3:AddSquadron(RedSqd4)
RedAirWing3:AddSquadron(RedSqd6)
RedAirWing3:SetRunwayRepairtime(600)
RedAirWing3:SetTakeoffHot()
RedAirWing3:SetDespawnAfterHolding(true)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedAirWing4=AIRWING:New("Mineralnye Warehouse", "Mineralnye Airwing") --Ops.AirWing#AIRWING
RedAirWing4:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Mineralnye_Vody))
RedAirWing4:NewPayload("Su-27", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
RedAirWing4:NewPayload("MiG-29S", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
RedAirWing4:AddSquadron(RedSqd8)
RedAirWing4:AddSquadron(RedSqd7)
RedAirWing4:SetRunwayRepairtime(600)
RedAirWing4:SetTakeoffHot()
RedAirWing4:SetDespawnAfterHolding(true)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedAirWing5=AIRWING:New("Mozdok Warehouse", "Mozdok Airwing") --Ops.AirWing#AIRWING
RedAirWing5:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Mozdok))
RedAirWing5:NewPayload("Su-33", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
RedAirWing5:AddSquadron(RedSqd3)
RedAirWing5:SetRunwayRepairtime(600)
RedAirWing5:SetTakeoffHot()
RedAirWing5:SetDespawnAfterHolding(true)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--RED AUFTRAG SETUP
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
RedGCICAP01 = AUFTRAG:NewGCICAP(RedCapZone01:GetRandomPointVec2(),23000,UTILS.KnotsToAltKIAS(400,23000),125,80):SetRepeat(99)
RedGCICAP01:SetROE(ENUMS.ROE.OpenFire)
RedGCICAP01:SetROT(ENUMS.ROT.EvadeFire)
RedGCICAP01:SetEngageDetected(40,"Air",RedEngageSet,BlueEngageSet)


RedGCICAP02 = AUFTRAG:NewGCICAP(RedCapZone02:GetRandomPointVec2(),24000,UTILS.KnotsToAltKIAS(400,24000),90,60):SetRepeat(99)
RedGCICAP02:SetROE(ENUMS.ROE.OpenFire)
RedGCICAP02:SetROT(ENUMS.ROT.EvadeFire)
RedGCICAP02:SetEngageDetected(40,"Air",RedEngageSet,BlueEngageSet)

RedGCICAP03 = AUFTRAG:NewGCICAP(RedCapZone03:GetRandomPointVec2(),21000,UTILS.KnotsToAltKIAS(500,21000),230,80):SetRepeat(99)
RedGCICAP03:SetROE(ENUMS.ROE.OpenFire)
RedGCICAP03:SetROT(ENUMS.ROT.EvadeFire)
RedGCICAP03:SetEngageDetected(40,"Air",RedEngageSet,BlueEngageSet)

RedGCICAP04 = AUFTRAG:NewGCICAP(RedCapZone04:GetRandomPointVec2(),24000,UTILS.KnotsToAltKIAS(500,24000),120,60):SetRepeat(99)
RedGCICAP04:SetROE(ENUMS.ROE.OpenFire)
RedGCICAP04:SetROT(ENUMS.ROT.EvadeFire)
RedGCICAP04:SetEngageDetected(40,"Air",RedEngageSet,BlueEngageSet)

RedGCICAP05 = AUFTRAG:NewGCICAP(RedCapZone05:GetRandomPointVec2(),20000,UTILS.KnotsToAltKIAS(300,20000),215,40):SetRepeat(99)
RedGCICAP05:SetROE(ENUMS.ROE.OpenFire)
RedGCICAP05:SetROT(ENUMS.ROT.EvadeFire)
RedGCICAP05:SetEngageDetected(40,"Air",RedEngageSet,BlueEngageSet)

RedGCICAP06 = AUFTRAG:NewGCICAP(RedCapZone06:GetRandomPointVec2(),20000,UTILS.KnotsToAltKIAS(300,20000),165,60):SetRepeat(99)
RedGCICAP06:SetROE(ENUMS.ROE.OpenFire)
RedGCICAP06:SetROT(ENUMS.ROT.EvadeFire)
RedGCICAP06:SetEngageDetected(40,"Air",RedEngageSet,BlueEngageSet)

RedAWACS01 = AUFTRAG:NewAWACS(ZONE:FindByName("RedAwacsZone"):GetRandomPointVec2(),24000,UTILS.KnotsToAltKIAS(240, 24000),86,100):SetRepeat(99)
RedTANKER01 = AUFTRAG:NewTANKER(ZONE:FindByName("RedTankerZone"):GetRandomPointVec2(), 20000, UTILS.KnotsToAltKIAS(350,20000), 110, 90, 1):SetRepeat(99)

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--RED CHIEF SETUP
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local RedChief = CHIEF:New("red",RedDetectionSet,"RedChief") --Ops.Chief#CHIEF
RedChief:SetBorderZones(RedEngageSet)
RedChief:SetResponseOnTarget(1,2,1,TARGET.Category.AIRCRAFT)
RedChief:SetResponseOnTarget(2,4,4,TARGET.Category.AIRCRAFT)
RedChief:SetStrategy(CHIEF.Strategy.DEFENSIVE)
RedChief:AddAirwing(RedAirWing1)
RedChief:AddAirwing(RedAirWing2)
RedChief:AddAirwing(RedAirWing3)
RedChief:AddAirwing(RedAirWing4)
RedChief:AddAirwing(RedAirWing5)
--RedChief:AddAirwing(RedAirWing6)
RedChief:AddMission(RedGCICAP01)
RedChief:AddMission(RedGCICAP02)
RedChief:AddMission(RedGCICAP03)
RedChief:AddMission(RedGCICAP04)
RedChief:AddMission(RedGCICAP05)
RedChief:AddMission(RedGCICAP06)
RedChief:AddMission(RedAWACS01)
RedChief:AddMission(RedTANKER01)
RedChief:SetVerbosity(0)
RedChief:__Start(15)

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--Blue SQDRN/AIRWINGS/CHIEF
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd1=SQUADRON:New("F-16CM",99,"Blue Fighter Squadron 1") --Ops.Squadron#SQUADRON
BlueSqd1:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
BlueSqd1:SetModex(100)
BlueSqd1:SetTurnoverTime(5, 6)
BlueSqd1:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd2=SQUADRON:New("M-2000C",99,"Blue Fighter Squadron 2") --Ops.Squadron#SQUADRON
BlueSqd2:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
BlueSqd2:SetModex(200)
BlueSqd2:SetTurnoverTime(5, 6)
BlueSqd2:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd3=SQUADRON:New("F-16CM",99,"Blue Fighter Squadron 3") --Ops.Squadron#SQUADRON
BlueSqd3:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
BlueSqd3:SetModex(100)
BlueSqd3:SetTurnoverTime(5, 6)
BlueSqd3:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd4=SQUADRON:New("M-2000C",99,"Blue Fighter Squadron 4") --Ops.Squadron#SQUADRON
BlueSqd4:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
BlueSqd4:SetModex(200)
BlueSqd4:SetTurnoverTime(5, 6)
BlueSqd4:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd204=SQUADRON:New("VF-142-F-14B",99,"VF-142") --Ops.Squadron#SQUADRON
BlueSqd204:AddMissionCapability({AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
BlueSqd204:SetModex(140)
BlueSqd204:SetGrouping(2)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd90=SQUADRON:New("RooseveltRescueHelo", 99, "RooseveltRescueHelo") --Ops.Squadron#SQUADRON
BlueSqd90:AddMissionCapability({AUFTRAG.Type.RESCUEHELO}, 100)
BlueSqd90:SetFuelLowRefuel(true)
BlueSqd90:SetFuelLowThreshold(0.1)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd91=SQUADRON:New("StennisRescueHelo", 99, "StennisRescueHelo") --Ops.Squadron#SQUADRON
BlueSqd91:AddMissionCapability({AUFTRAG.Type.RESCUEHELO}, 100)
BlueSqd91:SetFuelLowRefuel(true)
BlueSqd91:SetFuelLowThreshold(0.1)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd96=SQUADRON:New("Arco 1-1", 99, "Arco 1-1") --Ops.Squadron#SQUADRON
BlueSqd96:AddMissionCapability({AUFTRAG.Type.RECOVERYTANKER}, 100)
BlueSqd96:SetFuelLowRefuel(true)
BlueSqd96:SetFuelLowThreshold(0.1)
BlueSqd96:SetRadio(251)
BlueSqd96:SetCallsign(CALLSIGN.Tanker.Arco,1)
BlueSqd96:AddTacanChannel(51,51)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd98=SQUADRON:New("22nd ARW Texaco", 99, "22nd Tanker Squadron") --Ops.Squadron#SQUADRON
BlueSqd98:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
BlueSqd98:SetFuelLowRefuel(true)
BlueSqd98:SetFuelLowThreshold(0.1)
BlueSqd98:SetRadio(245)
BlueSqd98:SetCallsign(CALLSIGN.Tanker.Texaco,1)
BlueSqd98:AddTacanChannel(45,45)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd97=SQUADRON:New("23rd ARW Shell", 99, "23rd Tanker Squadron") --Ops.Squadron#SQUADRON
BlueSqd97:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)
BlueSqd97:SetFuelLowRefuel(true)
BlueSqd97:SetFuelLowThreshold(0.1)
BlueSqd97:SetRadio(246)
BlueSqd97:SetCallsign(CALLSIGN.Tanker.Shell,1)
BlueSqd97:AddTacanChannel(46,46)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueSqd99=SQUADRON:New("USAF AWACS Detection", 99, "99th USAF AWACS Detection") --Ops.Squadron#SQUADRON
BlueSqd99:AddMissionCapability(AUFTRAG.Type.AWACS, 100)
BlueSqd99:SetFuelLowRefuel(true)
BlueSqd99:SetFuelLowThreshold(.10)
BlueSqd99:SetRadio(266)
BlueSqd99:SetCallsign(CALLSIGN.AWACS.Darkstar,1)
BlueSqd99:AddTacanChannel(66,66)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueAirWing1=AIRWING:New("Kutaisi Warehouse", "Kutaisi Airwing") --Ops.AirWing#AIRWING
--BlueAirWing1:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Kutaisi))
BlueAirWing1:NewPayload("F-16CM", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
BlueAirWing1:NewPayload("M-2000C", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
BlueAirWing1:NewPayload("22nd ARW Texaco", 99, {AUFTRAG.Type.TANKER}, 99)
BlueAirWing1:NewPayload("23rd ARW Shell", 99, {AUFTRAG.Type.TANKER}, 99)
BlueAirWing1:NewPayload("USAF AWACS Detection", 99, {AUFTRAG.Type.AWACS}, 99)
BlueAirWing1:AddSquadron(BlueSqd1)
BlueAirWing1:AddSquadron(BlueSqd2)
BlueAirWing1:AddSquadron(BlueSqd99)
BlueAirWing1:AddSquadron(BlueSqd98)
BlueAirWing1:AddSquadron(BlueSqd97)
BlueAirWing1:SetRunwayRepairtime(600)
BlueAirWing1:SetTakeoffHot()
BlueAirWing1:SetDespawnAfterHolding(true)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueAirWing2=AIRWING:New("Batumi Warehouse", "Batumi Airwing") --Ops.AirWing#AIRWING
--BlueAirWing2:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Batumi))
BlueAirWing2:NewPayload("F-16CM", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
BlueAirWing2:NewPayload("M-2000C", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
BlueAirWing2:AddSquadron(BlueSqd3)
BlueAirWing2:AddSquadron(BlueSqd4)
BlueAirWing2:SetRunwayRepairtime(600)
BlueAirWing2:SetTakeoffHot()
BlueAirWing2:SetDespawnAfterHolding(true)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueFordAirwing = AIRWING:New("USS Ford FFG-54","USS Ford FFG-54")
BlueFordAirwing:NewPayload("RooseveltRescueHelo", 99, {AUFTRAG.Type.RESCUEHELO}, 100)
BlueFordAirwing:AddSquadron(BlueSqd90)
BlueFordAirwing:SetTakeoffHot()
BlueFordAirwing:SetDespawnAfterHolding(true)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueErieAirwing = AIRWING:New("USS Lake Erie CG-70","USS Lake Erie CG-70")
BlueErieAirwing:NewPayload("StennisRescueHelo", 99, {AUFTRAG.Type.RESCUEHELO}, 100)
BlueErieAirwing:AddSquadron(BlueSqd91)
BlueErieAirwing:SetTakeoffHot()
BlueErieAirwing:SetDespawnAfterHolding(true)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueRooseveltAirwing = AIRWING:New("CVN-71 Theodore Roosevelt","CVN-71 Theodore Roosevelt Wing")
BlueRooseveltAirwing:NewPayload("Arco 1-1", 99, {AUFTRAG.Type.RECOVERYTANKER}, 100)
BlueRooseveltAirwing:AddSquadron(BlueSqd96)
BlueRooseveltAirwing:NewPayload("VF-142-F-14B", 99, {AUFTRAG.Type.GCICAP,AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT}, 100)
BlueRooseveltAirwing:AddSquadron(BlueSqd204)
BlueRooseveltAirwing:SetTakeoffHot()
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--Blue AUFTRAG SETUP
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
BlueRESCUEHELO = AUFTRAG:NewRESCUEHELO(UNIT:FindByName("CVN-71 Theodore Roosevelt"))
BlueRECOVERYTANKER = AUFTRAG:NewRECOVERYTANKER(UNIT:FindByName("CVN-71 Theodore Roosevelt"))

RooseveltCapZone = ZONE_UNIT:New("Roosevelt CAP Zone",UNIT:FindByName("CVN-71 Theodore Roosevelt"),50)
RooseveltGCICAP = AUFTRAG:NewGCICAP(RooseveltCapZone:GetRandomPointVec2(),15000,UTILS.KnotsToAltKIAS(400,15000)):SetRepeat(99)
RooseveltGCICAP:SetROE(ENUMS.ROE.OpenFire)
RooseveltGCICAP:SetROT(ENUMS.ROT.EvadeFire)
RooseveltGCICAP:SetEngageDetected(40,"Air",BlueEngageSet,RedEngageSet)

BlueGCICAP01 = AUFTRAG:NewGCICAP(BlueCapZone01:GetRandomPointVec2(),23000,UTILS.KnotsToAltKIAS(400,23000),75,40):SetRepeat(99)
BlueGCICAP01:SetROE(ENUMS.ROE.OpenFire)
BlueGCICAP01:SetROT(ENUMS.ROT.EvadeFire)
BlueGCICAP01:SetEngageDetected(40,"Air",BlueEngageSet,RedEngageSet)

BlueGCICAP02 = AUFTRAG:NewGCICAP(BlueCapZone02:GetRandomPointVec2(),24000,UTILS.KnotsToAltKIAS(400,24000),150,70):SetRepeat(99)
BlueGCICAP02:SetROE(ENUMS.ROE.OpenFire)
BlueGCICAP02:SetROT(ENUMS.ROT.EvadeFire)
BlueGCICAP02:SetEngageDetected(40,"Air",BlueEngageSet,RedEngageSet)

BlueGCICAP03 = AUFTRAG:NewGCICAP(BlueCapZone03:GetRandomPointVec2(),21000,UTILS.KnotsToAltKIAS(500,21000),295,120):SetRepeat(99)
BlueGCICAP03:SetROE(ENUMS.ROE.OpenFire)
BlueGCICAP03:SetROT(ENUMS.ROT.EvadeFire)
BlueGCICAP03:SetEngageDetected(40,"Air",BlueEngageSet,RedEngageSet)

BlueAWACS01 = AUFTRAG:NewAWACS(BlueAWACSZone1:GetRandomPointVec2(),26000,UTILS.KnotsToAltKIAS(240, 26000),83,80):SetRepeat(99)
BlueSHELL01 = AUFTRAG:NewTANKER(BlueShellZone1:GetRandomPointVec2(), 20000, UTILS.KnotsToAltKIAS(350,20000), 270, 80, 1):SetRepeat(99)
BlueTEXACO01 = AUFTRAG:NewTANKER(BlueTexacoZone1:GetRandomPointVec2(), 18000, UTILS.KnotsToAltKIAS(350,18000), 90, 80, 0):SetRepeat(99)
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- AIRBOSS Carrier Setup
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local AirbossSuperCarrier = AIRBOSS:New("CVN-71 Theodore Roosevelt","Roosevelt")
AirbossSuperCarrier:SetTACAN(71, "X", "ROS")
AirbossSuperCarrier:SetICLS(1, "ROS")
AirbossSuperCarrier:SetCarrierControlledArea(50)
AirbossSuperCarrier:SetHandleAIOFF()
AirbossSuperCarrier:SetAirbossNiceGuy(true)
AirbossSuperCarrier:SetMPWireCorrection(12)
AirbossSuperCarrier:SetPatrolAdInfinitum(true)
AirbossSuperCarrier:SetMenuRecovery(180, 30, false)
AirbossSuperCarrier:SetSoundfilesFolder("Airboss Soundfiles/")
AirbossSuperCarrier:SetRadioRelayLSO("RooseveltRescueHelo")
AirbossSuperCarrier:SetLSORadio("325", "AM")
AirbossSuperCarrier:SetRadioRelayMarshal("RooseveltRescueHelo")
AirbossSuperCarrier:SetMarshalRadio("320", "AM")
AirbossSuperCarrier:SetMenuRecovery(30, 20, false)
AirbossSuperCarrier:SetDespawnOnEngineShutdown()
AirbossSuperCarrier:Load()
AirbossSuperCarrier:Save()
AirbossSuperCarrier:SetAutoSave()
AirbossSuperCarrier:SetTrapSheet()
AirbossSuperCarrier:__Start(25)

function AirbossSuperCarrier:OnAfterLSOGrade(From, Event, To, playerData, myGrade)

    local string_grade = myGrade.grade
    local player_name = playerData.name
    local player_wire = playerData.wire
    local player_case = myGrade.case
    local player_detail = myGrade.details

    player_name = player_name:gsub('[%p]', '')

    --local gradeForFile
    local trapsheet = ''
    if string_grade == "_OK_" and player_wire > 1 then
        --if  string_grade == "_OK_" and player_wire == "3" and player_Tgroove >=15 and player_Tgroove <19 then
        timer.scheduleFunction(underlinePass, {}, timer.getTime() + 5)
        if client_performing_sh:Get() == 1 then
            myGrade.grade = "_OK_<SH>"
            myGrade.points = myGrade.points
            client_performing_sh:Set(0)
            trapsheet = "SH_unicorn_AIRBOSS-trapsheet-" .. player_name
        else
            trapsheet = "unicorn_AIRBOSS-trapsheet-" .. player_name
        end

    elseif string_grade == "OK" and player_wire > 1 then
        if client_performing_sh:Get() == 1 then
            myGrade.grade = "OK<SH>"
            myGrade.points = myGrade.points + 0.5
            client_performing_sh:Set(0)
            trapsheet = "SH_AIRBOSS-trapsheet-" .. player_name
        else
            trapsheet = "AIRBOSS-trapsheet-" .. player_name
        end

    elseif string_grade == "(OK)" and player_wire > 1 then
        AirbossSuperCarrier:SetTrapSheet(nil, "AIRBOSS-trapsheet-" .. player_name)
        if client_performing_sh:Get() == 1 then
            myGrade.grade = "(OK)<SH>"
            myGrade.points = myGrade.points + 1.00
            client_performing_sh:Set(0)
            trapsheet = "SH_AIRBOSS-trapsheet-" .. player_name
        else
            trapsheet = "AIRBOSS-trapsheet-" .. player_name
        end

    elseif string_grade == "--" and player_wire > 1 then
        if client_performing_sh:Get() == 1 then
            myGrade.grade = "--<SH>"
            myGrade.points = myGrade.points + 1.00
            client_performing_sh:Set(0)
            trapsheet = "SH_AIRBOSS-trapsheet-" .. player_name
        else
            trapsheet = "AIRBOSS-trapsheet-" .. player_name
        end

    elseif string_grade == "-- (BOLTER)" then
        trapsheet = "Bolter_AIRBOSS-trapsheet-" .. player_name
    elseif string_grade == "WOFD" then
        trapsheet = "WOFD_AIRBOSS-trapsheet-" .. player_name
    elseif string_grade == "OWO" then
        trapsheet = "OWO_AIRBOSS-trapsheet-" .. player_name
    elseif string_grade == "CUT" then
        if player_wire == 1 then
            myGrade.points = myGrade.points + 1.00
            trapsheet = "Cut_AIRBOSS-trapsheet-" .. player_name
        else
            trapsheet = "Cut_AIRBOSS-trapsheet-" .. player_name
        end
    end
    if player_case == 3 and player_detail == "    " then
        trapsheet = "NIGHT5_AIRBOSS-trapsheet-" .. player_name
        myGrade.grade = "_OK_"
        myGrade.points = 5.0
    end
    AirbossSuperCarrier:SetTrapSheet(nil, trapsheet)

    myGrade.messageType = 2
    myGrade.callsign = playerData.callsign
    myGrade.name = playerData.name
    if playerData.wire == 1 then
        myGrade.points = myGrade.points - 1.00
        local onewire_to_discord = ('**' .. player_name .. ' almost had a rampstrike with that 1-wire!**')
        dcsbot.sendBotMessage(onewire_to_discord)
    end
    self:_SaveTrapSheet(playerData, mygrade)
    msg = {}
    msg.command = "onMissionEvent"
    msg.eventName = "S_EVENT_AIRBOSS"
    msg.initiator = {}
    msg.initiator.name = playerData.name
    msg.place = {}
    msg.place.name = myGrade.carriername
    msg.points = myGrade.points
    msg.grade = myGrade.grade
    msg.details = myGrade.details
    msg.wire = playerData.wire
    msg.trapsheet = trapsheet
    msg.time = timer.getTime()
    dcsbot.sendBotTable(msg)
    timer.scheduleFunction(resetTrapSheetFileFormat, {}, timer.getTime() + 10)
end


----------------------------------------------------------------------------------------------------------------------------------------------------
local AirbossStennis = AIRBOSS:New("CVN-74 John C. Stennis","Stennis")
AirbossStennis:SetTACAN(74, "X", "STN")
AirbossStennis:SetICLS(4, "STN")
AirbossStennis:SetSoundfilesFolder("Airboss Soundfiles/")
AirbossStennis:SetRadioRelayLSO("RooseveltRescueHelo")
AirbossStennis:SetLSORadio("315", "AM")
AirbossStennis:SetRadioRelayMarshal("RooseveltRescueHelo")
AirbossStennis:SetMarshalRadio("310", "AM")
AirbossStennis:SetMenuRecovery(30, 20, false)
AirbossStennis:SetDespawnOnEngineShutdown()
AirbossStennis:Load()
AirbossStennis:SetAutoSave()
AirbossStennis:SetTrapSheet()
AirbossStennis:__Start(30)


--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
local BlueChief=CHIEF:New(coalition.side.BLUE,BlueDetectionSet,"Chief") --Ops.Chief#CHIEF
BlueChief:AddAirwing(BlueAirWing1)
BlueChief:AddAirwing(BlueAirWing2)
BlueChief:AddAirwing(BlueFordAirwing)
BlueChief:AddAirwing(BlueErieAirwing)
BlueChief:AddAirwing(BlueRooseveltAirwing)
BlueChief:SetBorderZones(BlueEngageSet)
BlueChief:AddMission(BlueGCICAP01)
BlueChief:AddMission(BlueGCICAP02)
BlueChief:AddMission(BlueAWACS01)
BlueChief:AddMission(BlueSHELL01)
BlueChief:AddMission(BlueTEXACO01)
BlueChief:AddMission(BlueRESCUEHELO)
BlueChief:AddMission(BlueRECOVERYTANKER)
BlueChief:AddMission(RooseveltGCICAP)
BlueChief:SetStrategy(CHIEF.Strategy.DEFENSIVE)
BlueChief:SetResponseOnTarget(1, 2, 0, TARGET.Category.AIRCRAFT)
BlueChief:SetResponseOnTarget(1, 4, 4, TARGET.Category.AIRCRAFT)
BlueChief:SetVerbosity(0)
BlueChief:__Start(10)

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FARP MANAGEMENT
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function DallasFARPPhase1()
  local FarpDallasZone1=ZONE:FindByName("FARP DALLAS PHASE 1")
  local SpawnDallasFarp=SPAWNSTATIC:NewFromStatic("FARP DALLAS",country.id.USA)
        SpawnDallasFarp:InitFARP(CALLSIGN.FARP.Dallas, 130.000, 0)
        SpawnDallasFarp:InitCountry(country.id.USA)
  local FarpDallas=SpawnDallasFarp:SpawnFromZone(FarpDallasZone1, 90, "FARP DALLAS")
        local findfarp = STATIC:FindByName("FARP DALLAS")
        local FarpSupply= SPAWN:New("FARPSUPPORTDALLAS"):SpawnFromStatic(findfarp)
end

function DallasFARPPhase2()
  local FarpDallasZone2=ZONE:FindByName("FARP DALLAS PHASE 2")
  local SpawnDallasFarp=SPAWNSTATIC:NewFromStatic("FARP DALLAS", country.id.USA)
        SpawnDallasFarp:InitFARP(CALLSIGN.FARP.Dallas, 130.000, 0)
  local FarpDallas=SpawnDallasFarp:SpawnFromZone(FarpDallasZone2, 90, "FARP DALLAS")
        local findfarp = STATIC:FindByName("FARP DALLAS")
        local FarpSupply= SPAWN:New("FARPSUPPORTDALLAS"):SpawnFromStatic(findfarp)
end
function DallasFARPPhase3()
  local FarpDallasZone3=ZONE:FindByName("FARP DALLAS PHASE 3")
  local SpawnDallasFarp=SPAWNSTATIC:NewFromStatic("FARP DALLAS", country.id.USA)
        SpawnDallasFarp:InitFARP(CALLSIGN.FARP.Dallas, 130.000, 0)
  local FarpDallas=SpawnDallasFarp:SpawnFromZone(FarpDallasZone3, 90, "FARP DALLAS")
        local findfarp = STATIC:FindByName("FARP DALLAS")
        local FarpSupply= SPAWN:New("FARPSUPPORTDALLAS"):SpawnFromStatic(findfarp)
end

function LondonFARPPhase1()
  local FarpLondonZone1=ZONE:FindByName("FARP LONDON PHASE 1")
  local SpawnLondonFarp=SPAWNSTATIC:NewFromStatic("FARP LONDON",country.id.USA)
        SpawnLondonFarp:InitFARP(CALLSIGN.FARP.London, 131.000, 0)
        SpawnLondonFarp:InitCountry(country.id.USA)
  local FarpDallas=SpawnLondonFarp:SpawnFromZone(FarpLondonZone1, 90, "FARP LONDON")
        local findfarp = STATIC:FindByName("FARP LONDON")
        local FarpSupply= SPAWN:New("FARPSUPPORTLONDON"):SpawnFromStatic(findfarp)
end

function LondonFARPPhase2()
  local FarpLondonZone2=ZONE:FindByName("FARP LONDON PHASE 2")
  local SpawnLondonFarp=SPAWNSTATIC:NewFromStatic("FARP LONDON",country.id.USA)
        SpawnLondonFarp:InitFARP(CALLSIGN.FARP.London, 131.000, 0)
        SpawnLondonFarp:InitCountry(country.id.USA)
  local FarpDallas=SpawnLondonFarp:SpawnFromZone(FarpLondonZone2, 90, "FARP LONDON")
        local findfarp = STATIC:FindByName("FARP LONDON")
        local FarpSupply= SPAWN:New("FARPSUPPORTLONDON"):SpawnFromStatic(findfarp)
end

function LondonFARPPhase3()
  local FarpLondonZone3=ZONE:FindByName("FARP LONDON PHASE 3")
  local SpawnLondonFarp=SPAWNSTATIC:NewFromStatic("FARP LONDON",country.id.USA)
        SpawnLondonFarp:InitFARP(CALLSIGN.FARP.London, 131.000, 0)
        SpawnLondonFarp:InitCountry(country.id.USA)
  local FarpDallas=SpawnLondonFarp:SpawnFromZone(FarpLondonZone3, 90, "FARP LONDON")
        local findfarp = STATIC:FindByName("FARP LONDON")
        local FarpSupply= SPAWN:New("FARPSUPPORTLONDON"):SpawnFromStatic(findfarp)
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- TODO Operation start and phase changes
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
WestOperation = WestPhase1Operation
EastOperation = EastPhase1Operation
WestMissions = OPWestPhase1
EastMissions = OPEastPhase1
WestTargets = OPWestPhase1Targets
EastTargets = OPEastPhase1Targets


function WestPhase1Operation:OnAfterStart(From,Event,To)
    MESSAGE:New("Operation Sleeping Phoenix West Phase 1 Started!",15,"Phoenix"):ToBlue()
    PhoenixSRS:PlayText("Operation Sleeping Phoenix West Phase 1 Started!",1)
    DallasFARPPhase1()
end

function WestPhase2Operation:OnAfterStart(From,Event,To)
    MESSAGE:New("Mission Progress - Operation Sleeping Phoenix West Phase 2 Started!",15,"Phoenix"):ToBlue()
    PhoenixSRS:PlayText("Mission Progress - Operation Sleeping Phoenix West Phase 2 Started!",1)
    DallasFARPPhase2()
end

function EastPhase1Operation:OnAfterStart(From,Event,To)
    MESSAGE:New("Operation Sleeping Phoenix East Phase 1 Started!",15,"Phoenix"):ToBlue()
    PhoenixSRS:PlayText("Operation Sleeping Phoenix East Phase 1 Started!",1)
    LondonFARPPhase1()
end

function EastPhase2Operation:OnAfterStart(From,Event,To)
    MESSAGE:New("Mission Progress - Operation Sleeping Phoenix East Phase 2 Started!",15,"Phoenix"):ToBlue()
    PhoenixSRS:PlayText("Mission Progress - Operation Sleeping Phoenix East Phase 2 Started!",1)
    LondonFARPPhase2()
end


---Check current operation and set on phase change and playertask update
-- next phase
function WestOperation:OnAfterPhaseChange(From,Event,To,Phase)
  -- Next phase, this is Phase done
  local phase = WestOperation:GetPhaseActive()
  local ind = phase.name
  local type = WestMissions[ind].TargetAuftrag
  local brief = WestMissions[ind].TargetBriefing
  local targetname = WestMissions[ind].TargetName
  local targetgroup = GROUP:FindByName(targetname)
    if DEBUG then
      WestTargets[ind].verbose = 3
    end
  local task = PLAYERTASK:New(type,WestTargets[ind],true,99,type)
  task:AddFreetext(brief)
    if DEBUG then
      task.verbose = true
    end
  phoenixwesttasking:AddPlayerTaskToQueue(task)
  local file = "That Is Our Target.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
  local name = WestOperation.name
  local phasesremain = tostring(WestOperation:CountPhases(OPERATION.PhaseStatus.ACTIVE) + WestOperation:CountPhases(OPERATION.PhaseStatus.PLANNED))
  local threatlevel = targetgroup:GetThreatLevel()
  local ThreatGraph = "[" .. string.rep(  "■", threatlevel ) .. string.rep(  "□", 10 - threatlevel ) .. "]: "..threatlevel
  local targetcoord = targetgroup:GetCoordinate() or "Unknown"
  local targetmgrs = targetcoord:ToStringMGRS() 
  local targetllddm = targetcoord:ToStringLLDDM()
  local embed = {}
  embed.title = "Operation Sleeping Phoenix West Region"
  embed.description = "Mission Status Report"
  embed.img = "https://cdn.discordapp.com/avatars/1034319512205545482/8632aaac3c14618467edcfeded166047.png"
  embed.fields = {}
    local field1 = {}
    field1['name'] = 'Current Operation'
    field1['value'] = name or "Unknown"
    field1['inline'] = false
    table.insert(embed.fields, field1)
    local field2 = {}
    field2['name'] = 'Current Mission'
    field2['value'] = type or "Unknown"
    field2['inline'] = false
    table.insert(embed.fields, field2)
    local field3 = {}
    field3['name'] = 'Phases/Targets Remaining'
    field3['value'] = phasesremain or "Unknown"
    field3['inline'] = true
    table.insert(embed.fields, field3)
    local field4 = {}    
    field4['name'] = 'Mission Briefing'
    field4['value'] = brief or "Unknown"
    field4['inline'] = false
    table.insert(embed.fields, field4)
    local field5 = {}    
    field5['name'] = 'Threat Level'
    field5['value'] = ThreatGraph or "Unknown"
    field5['inline'] = false
    table.insert(embed.fields, field5)
    local field6 = {}    
    field6['name'] = 'Target Coordinates'
    field6['value'] = targetmgrs
    field6['inline'] = false
    table.insert(embed.fields, field6)
    local field7 = {}    
    field7['name'] = 'Target Coordinates'
    field7['value'] = targetllddm or "Unknown"
    field7['inline'] = false
    table.insert(embed.fields, field7)
  embed.footer = "Join now and get in on the action!"
  dcsbot.updateEmbed('OSPStatus', embed.title, embed.description, embed.img, embed.fields, embed.footer,"1040466446842593371")  
  
end

function EastOperation:OnAfterPhaseChange(From,Event,To,Phase)
  -- Next phase, this is Phase done
  local phase = EastOperation:GetPhaseActive()
  local ind = phase.name
  local type = EastMissions[ind].TargetAuftrag
  local brief = EastMissions[ind].TargetBriefing
  local targetname = EastMissions[ind].TargetName
  local targetgroup = GROUP:FindByName(targetname)
    if DEBUG then
      EastTargets[ind].verbose = 3
    end
  local task = PLAYERTASK:New(type,EastTargets[ind],true,99,type)
  task:AddFreetext(brief)
    if DEBUG then
      task.verbose = true
    end
  phoenixeasttasking:AddPlayerTaskToQueue(task)
  local file = "That Is Our Target.ogg"
  local radio = USERSOUND:New(file):ToCoalition(coalition.side.BLUE)
  local name = EastOperation.name
  local phasesremain = tostring(EastOperation:CountPhases(OPERATION.PhaseStatus.ACTIVE) + EastOperation:CountPhases(OPERATION.PhaseStatus.PLANNED))
  local threatlevel = targetgroup:GetThreatLevel()
  local ThreatGraph = "[" .. string.rep(  "■", threatlevel ) .. string.rep(  "□", 10 - threatlevel ) .. "]: "..threatlevel
  local targetcoord = targetgroup:GetCoordinate()
  local targetmgrs = targetcoord:ToStringMGRS()
  local targetllddm = targetcoord:ToStringLLDDM()
  local embed = {}
  embed.title = "Operation Sleeping Phoenix East Region"
  embed.description = "Mission Status Report"
  embed.img = "https://cdn.discordapp.com/avatars/1034319512205545482/8632aaac3c14618467edcfeded166047.png"
  embed.fields = {}
    local field1 = {}
    field1['name'] = 'Current Operation'
    field1['value'] = name or "Unknown"
    field1['inline'] = false
    table.insert(embed.fields, field1)
    local field2 = {}
    field2['name'] = 'Current Mission'
    field2['value'] = type or "Unknown"
    field2['inline'] = false
    table.insert(embed.fields, field2)
    local field3 = {}
    field3['name'] = 'Phases/Targets Remaining'
    field3['value'] = phasesremain or "Unknown"
    field3['inline'] = true
    table.insert(embed.fields, field3)
    local field4 = {}    
    field4['name'] = 'Mission Briefing'
    field4['value'] = brief or "Unknown"
    field4['inline'] = false
    table.insert(embed.fields, field4)
    local field5 = {}    
    field5['name'] = 'Threat Level'
    field5['value'] = ThreatGraph or "Unknown"
    field5['inline'] = false
    table.insert(embed.fields, field5)
    local field6 = {}    
    field6['name'] = 'Target Coordinates'
    field6['value'] = targetmgrs
    field6['inline'] = false
    table.insert(embed.fields, field6)
    local field7 = {}    
    field7['name'] = 'Target Coordinates'
    field7['value'] = targetllddm or "Unknown"
    field7['inline'] = false
    table.insert(embed.fields, field7)
  embed.footer = "Join now and get in on the action!"
  dcsbot.updateEmbed('OSPStatus2', embed.title, embed.description, embed.img, embed.fields, embed.footer,"1040466446842593371")  
  
end

---






-- Operation finished
function WestPhase1Operation:OnAfterOver(From,Event,To,Phase)
    MESSAGE:New("Operation Sleeping Phoenix - Operational Area Controlled /nRetasking Missions and Switching Operational Area /nSee F10 Map for Current Operational Area!",15,"Phoenix"):ToBlue()
    PhoenixSRS:PlayText("Phoenix to all units, Operational Area Controlled, Retasking Missions and Switching Operational Area, See F10 Map for New Operational Area",1)
    WestOperation = WestPhase2Operation
    WestMissions = OPWestPhase2
    WestTargets = OPWestPhase2Targets
    WestPhase1Operation:Stop()
    WestPhase2Operation:__Start(15)
    RedEngageSet:RemoveZonesByName(RedBorder3)
    BlueEngageSet:AddZone(BlueBorder3)
    
end

--function WestPhase2Operation:OnAfterOver(From,Event,To,Phase)
--    MESSAGE:New("Operation Sleeping Phoenix - Operational Area Controlled /nRetasking Missions and Switching Operational Area /nSee F10 Map for Current Operational Area!",15,"Phoenix"):ToBlue()
--    PhoenixSRS:PlayText("Phoenix to all units, Operational Area Controlled, Retasking Missions and Switching Operational Area, See F10 Map for New Operational Area",1)
--    WestOperation = OSPPhase3Op
--    WestMissions = OSPPhase3
--    WestTargets = OSPPhase3Targets
--    WestPhase2Operation:Stop()
--    WestPhase5Operation:__Start(15)
--    RedChief:SetBorderZones(RedBorder3)
--    BlueChief:SetBorderZones(BlueBorder3)
--    BlueChief:AddMission(BlueGCICAP03)
--end
function EastPhase1Operation:OnAfterOver(From,Event,To,Phase)
    MESSAGE:New("Operation Sleeping Phoenix - Operational Area Controlled /nRetasking Missions and Switching Operational Area /nSee F10 Map for Current Operational Area!",15,"Phoenix"):ToBlue()
    PhoenixSRS:PlayText("Phoenix to all units, Operational Area Controlled, Retasking Missions and Switching Operational Area, See F10 Map for New Operational Area",1)
    EastOperation = EastPhase2Operation
    EastMissions = OPEastPhase2
    EastTargets = OPEastPhase2Targets
    EastPhase1Operation:Stop()
    EastPhase2Operation:__Start(15)
    RedEngageSet:RemoveZonesByName(RedBorder2)
    BlueEngageSet:AddZone(BlueBorder2)
end