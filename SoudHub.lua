local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SoudHub/SoudHub-/refs/heads/main/Orion/Orion%20by%20Bliz_T"))()
local Players = game:GetService("Players")
local speaker = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local mouse = speaker:GetMouse()

OrionLib.Themes.Purple = {
    Main     = Color3.fromRGB(10, 0, 15),
    Second   = Color3.fromRGB(25, 0, 35), 
    Stroke   = Color3.fromRGB(180, 100, 255),
    Divider  = Color3.fromRGB(120, 60, 200),
    Text     = Color3.fromRGB(220, 180, 255),
    TextDark = Color3.fromRGB(180, 140, 230)
}

OrionLib.SelectedTheme = "Purple"

local Window = OrionLib:MakeWindow({
    Name = "Nigga Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Hentai",
    IntroEnabled = false,
    IntroText = "Blus after molestation"
})


--locals
local InfiniteJumpEnabled = false
local JumpCooldown = 0.1
local canJump = true
-------------------------
local AntiLoop = false
local AntiLoopConnection = nil
local LoopSpeed = 1 -- segundos entre cada reset
--variaveis
local teleportKeybind = Enum.KeyCode.T
local teleportConnection = nil
_G.SelectedPlayer = nil
_G.FlingEnabled = false
_G.LoopTPEnabled = false
_G.FlingConnection = nil
_G.CapetaTechEnabled = false
_G.CapetaTechOrbitEnabled = false
_G.CapetaTechConnection = nil
_G.CapetaTechOriginalProperties = {}
_G.CurrentFOV = 70  

local function setupTeleportKeybind()
    return UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == teleportKeybind then
            local char = speaker.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            if mouse.Target then 
                hrp.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 5, mouse.Hit.Z)
            end
        end
    end)
end

-- keybind
teleportConnection = setupTeleportKeybind()

-- Fov
local function changeFOV(value)
    _G.CurrentFOV = value
    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = value
    end
end

local function onJumpRequest()
    if InfiniteJumpEnabled and canJump then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        canJump = false
        task.wait(JumpCooldown)
        canJump = true
    end
end

-- Conexão com o evento de pulo
local jumpConnection
local function toggleInfiniteJump(state)
    InfiniteJumpEnabled = state
    if state and not jumpConnection then
        jumpConnection = UserInputService.JumpRequest:Connect(onJumpRequest)
    elseif not state and jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end
end

--Infinitejump
--[[local function setupInfiniteJump()
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
end--]]
print("Made by Pato And:")
print("                             ██▀███  ▓█████ ▓█████▄    ▄▄▄█████▓ ██▓  ▄████ ▓█████  ██▀███")
print("                            ▓██ ▒ ██▒▓█   ▀ ▒██▀ ██▌   ▓  ██▒ ▓▒▓██▒ ██▒ ▀█▒▓█   ▀ ▓██ ▒ ██▒")
print("                            ▓██ ░▄█ ▒▒███   ░██   █▌   ▒ ▓██░ ▒░▒██▒▒██░▄▄▄░▒███   ▓██ ░▄█ ▒")
print("                            ▒██▀▀█▄  ▒▓█  ▄ ░▓█▄   ▌   ░ ▓██▓ ░ ░██░░▓█  ██▓▒▓█  ▄ ▒██▀▀█▄")
print("                            ░██▓ ▒██▒░▒████▒░▒████▓      ▒██▒ ░ ░██░░▒▓███▀▒░▒████▒░██▓ ▒██▒")
print("                            ░ ▒▓ ░▒▓░░░ ▒░ ░ ▒▒▓  ▒      ▒ ░░   ░▓   ░▒   ▒ ░░ ▒░ ░░ ▒▓ ░▒▓░")
print("                              ░▒ ░ ▒░ ░ ░  ░ ░ ▒  ▒        ░     ▒ ░  ░   ░  ░ ░  ░  ░▒ ░ ▒░")
print("                             ░░   ░    ░    ░ ░  ░      ░       ▒ ░░ ░   ░    ░     ░░   ░")
print("                              ░        ░  ░   ░                 ░        ░    ░  ░   ░")

--setupInfiniteJump()

-- Serverscript (coloque em ServerScriptService)
local Players = game:GetService("Players")

-- Função para quando um jogador entra
local function onPlayerAdded(player)
    print("🎮 Jogador entrou: " .. player.Name .. " (ID: " .. player.UserId .. ")")
    
end

-- Função para quando um jogador sai
local function onPlayerRemoving(player)
    print("🚪 Jogador saiu: " .. player.Name .. " (ID: " .. player.UserId .. ")")
    
end

-- Conectar os eventos
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

print("✅ Sistema de monitoramento de players ativado!")

local pvpTab = Window:MakeTab({
    Name = "PvP",
    icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

pvpTab:AddLabel("No itens!")
pvpTab:AddLabel("More soon!")

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
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

--[[MainTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        infJumpT = Value
        if Value then
            OrionLib:MakeNotification({
                Name = "Infinite Jump Ativado!",
                Content = "Pulo infinito ativado",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Infinite Jump Desativado!",
                Content = "Pulo infinito desativado",
                Time = 3
            })
        end
    end
})--]]

MainTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        toggleInfiniteJump(Value)
    end
})

-- Slider para ajustar o cooldown do pulo
MainTab:AddSlider({
    Name = "Cooldown do Pulo",
    Min = 0,
    Max = 1,
    Default = 0.1,
    Color = Color3.fromRGB(193, 18, 31),
    Increment = 0.1,
    ValueName = "segundos",
    Callback = function(Value)
        JumpCooldown = Value
    end
})

MainTab:AddButton({
    Name = "Discord",
    Callback = function()
        print("copied!")
        setclipboard("https://discord.gg/HJYd9s3jy4")
        OrionLib:MakeNotification({
            Name = "Discord Copied",
            Content = "Discord Copied",
            Image = "rbxassetid://9327507243",
            Time = 5
        })
    end
})

MainTab:AddButton({
    Name = "FPS",
    Callback = function()
        repeat wait() until game:IsLoaded() wait(2)
local ScreenGui = Instance.new("ScreenGui")
local Fps = Instance.new("TextLabel")

--Propriedades

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Fps.Name = "Fps"
Fps.Parent = ScreenGui
Fps.BackgroundColor3 = Color3.fromRGB(193, 18, 31)
Fps.BackgroundTransparency = 1
Fps.Position = UDim2.new(0.786138654, 0, 0, 0)
Fps.Size = UDim2.new(0, 125, 0, 25)
Fps.Font = Enum.Font.SourceSans
Fps.TextColor3 = Color3.fromRGB(120, 0, 0)
Fps.TextScaled = true
Fps.TextSize = 14.000
Fps.TextWrapped = true


local script = Instance.new('LocalScript', Fps)
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function(frame) -- This will fire every time a frame is rendered
script.Parent.Text = ("FPS: "..math.round(1/frame)) 
end)
end
})

MainTab:AddButton({
    Name = "Tornado",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SoudHub/SoudHub-/refs/heads/main/Tornado"))()
        print("Tornado Loaded")
        OrionLib:MakeNotification({
            Name = "Tornado",
            Content = "Tornado Loaded (Destroyed GUI)",
            Image = "rbxassetid://9327507243",
            Time = 5
        })
        task.wait(1)
        OrionLib:Destroy()
    end
})

MainTab:AddButton({
    Name = "Anti Lag",
    Callback = function()
        print("antilag Loaded")
        local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")
        local Terrain = workspace:FindFirstChildOfClass('Terrain')
        
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
        end
        
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 9e9
        
        settings().Rendering.QualityLevel = 1

        for i, v in pairs(game:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
                v.BackSurface = Enum.SurfaceType.SmoothNoOutlines
                v.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
                v.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
                v.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
                v.RightSurface = Enum.SurfaceType.SmoothNoOutlines
                v.TopSurface = Enum.SurfaceType.SmoothNoOutlines
            elseif v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0, 0)
            end
        end
        
        for i, v in pairs(Lighting:GetDescendants()) do
            if v:IsA("PostEffect") then
                v.Enabled = false
            end
        end
        
        workspace.DescendantAdded:Connect(function(child)
            if child:IsA('ForceField') or child:IsA('Sparkles') or child:IsA('Smoke') or 
               child:IsA('Fire') or child:IsA('Beam') or child:IsA("ParticleEmitter") or 
               child:IsA("Trail") then
                task.wait() 
                pcall(function() 
                    child:Destroy()
                end)
            end
        end)
        
        print("Anti-Lag ativado!")
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
            Time = 5
        })
        task.wait(1)
        OrionLib:Destroy()
    end
})

MainTab:AddButton({
    Name = "Dex",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SoudHub/SoudHub-/refs/heads/main/Dark%20Dex"))()
        print("Dex Loaded")
        OrionLib:MakeNotification({
            Name = "Dex",
            Content = "Dex Loaded (Destroyed GUI)",
            Image = "rbxassetid://9327507243",
            Time = 3
        })
        task.wait(2)
        OrionLib:Destroy()
    end
})

MainTab:AddButton({
    Name = "Pvp Mode",
    Callback = function()
        print("Pvp mode loaded")
        local Lighting = game:GetService("Lighting")
        
        for _, object in ipairs(Lighting:GetChildren()) do
            if object:IsA("Sky") then
                object:Destroy()
            end
        end

        local graySky = Instance.new("Sky")
        graySky.SkyboxBk = "rbxassetid://99155141"
        graySky.SkyboxDn = "rbxassetid://99155141"
        graySky.SkyboxFt = "rbxassetid://99155141"
        graySky.SkyboxLf = "rbxassetid://99155141"
        graySky.SkyboxRt = "rbxassetid://99155141"
        graySky.SkyboxUp = "rbxassetid://99155141"
        graySky.Parent = Lighting

        Lighting.Brightness = 0.5
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        
        OrionLib:MakeNotification({
            Name = "PVP!",
            Content = "Sky Moded.",
            Time = 5
        })
    end
})


MainTab:AddToggle({
    Name = "FullBright",
    Default = false,
    Callback = function(Value)
        if Value then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            game:GetService("Lighting").Brightness = 1
            game:GetService("Lighting").FogEnd = 1000000
            game:GetService("Lighting").GlobalShadows = true
        end
    end
})


MainTab:AddSlider({
    Name = "Brilho",
    Min = 0,
    Max = 10,
    Default = 1,
    Color = Color3.fromRGB(193, 18, 31),
    Increment = 0.5,
    ValueName = "nível",
    Callback = function(Value)
        game:GetService("Lighting").Brightness = Value
    end
})


MainTab:AddDropdown({
    Name = "Keybind TP",
    Default = "Z",
    Options = {"Z", "Q", "R", "F", "G", "T"},
    Callback = function(Value)
        teleportKeybind = Enum.KeyCode[Value]
        
        -- Reconectar
        if teleportConnection then
            teleportConnection:Disconnect()
        end
        teleportConnection = setupTeleportKeybind()
        
        print("Keybind modified")
        OrionLib:MakeNotification({
            Name = "Keybind Alt",
            Content = "New Key: " .. Value,
            Time = 3
        })
    end
})

MainTab:AddButton({
    Name = "TP test",
    Callback = function()
        local char = speaker.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        if mouse.Target then 
            hrp.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 5, mouse.Hit.Z)
        end
    end
})

local loopTab = Window:MakeTab({
    Name = "Loops",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

-- select
local playerDropdown = loopTab:AddDropdown({
    Name = "Select a Player",
    Default = "Nenhum",
    Options = {"Nenhum"},
    Callback = function(Value)
        if Value == "Nenhum" then
            _G.SelectedPlayer = nil
        else
            _G.SelectedPlayer = Players:FindFirstChild(Value)
        end
    end
})

--atualizar lista
function UpdatePlayerList()
    local playerNames = {"Nenhum"}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= speaker then
            table.insert(playerNames, player.Name)
        end
    end
    playerDropdown:Refresh(playerNames, true)
end

-- Função para gerar string
function randomString()
    local length = math.random(5, 15)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

function getRoot(character)
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
end

-- stop flingF
function stopFling()
    _G.FlingEnabled = false
    if _G.FlingConnection then
        _G.FlingConnection:Disconnect()
        _G.FlingConnection = nil
    end
    
    local myChar = speaker.Character
    if myChar then
        for _, child in pairs(myChar:GetDescendants()) do
            if child:IsA("BodyAngularVelocity") and child.Name ~= "BodyAngularVelocity" then
                child:Destroy()
            end
        end
        
        for _, child in pairs(myChar:GetDescendants()) do
            if child:IsA("BasePart") then
                child.CustomPhysicalProperties = nil
                child.CanCollide = true
                child.Massless = false
            end
        end
    end
end

local CapetaTechMaxDistance = 12
local CapetaTechOrbitDistance = 2
local CapetaTechOrbitSpeed = 3
local CapetaTechVerticalOffset = -2.5
local CapetaTechOrbitAngle = 0

function SaveCapetaTechStates()
    local humanoid = speaker.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    _G.CapetaTechOriginalProperties = {
        WalkSpeed = humanoid.WalkSpeed,
        AutoRotate = humanoid.AutoRotate,
        PlatformStand = humanoid.PlatformStand,
    }
    
    for _, part in pairs(speaker.Character:GetDescendants()) do
        if part:IsA('BasePart') then
            _G.CapetaTechOriginalProperties[part.Name .. '_CanCollide'] = part.CanCollide
        end
    end
end

function CleanupCapetaTech()
    if not _G.CapetaTechOriginalProperties.WalkSpeed then
        return
    end
    
    local humanoid = speaker.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = _G.CapetaTechOriginalProperties.WalkSpeed
        humanoid.AutoRotate = _G.CapetaTechOriginalProperties.AutoRotate
        humanoid.PlatformStand = _G.CapetaTechOriginalProperties.PlatformStand
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
    
    for _, part in pairs(speaker.Character:GetDescendants()) do
        if part:IsA('BasePart') and _G.CapetaTechOriginalProperties[part.Name .. '_CanCollide'] ~= nil then
            part.CanCollide = _G.CapetaTechOriginalProperties[part.Name .. '_CanCollide']
        end
    end
    
    for _, part in pairs(speaker.Character:GetDescendants()) do
        if part:IsA('BasePart') then
            part.Velocity = Vector3.new(0, 0, 0)
            part.RotVelocity = Vector3.new(0, 0, 0)
        end
    end
end

function GetCapetaTechTarget()
    local closest, part = nil, nil
    local shortest = CapetaTechMaxDistance
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= speaker and p.Character and p.Character:FindFirstChild('HumanoidRootPart') then
            local hrp = p.Character.HumanoidRootPart
            local dist = (hrp.Position - getRoot(speaker.Character).Position).Magnitude
            if dist < shortest then
                closest = p
                part = hrp
                shortest = dist
            end
        end
    end
    return closest, part
end

function ActivateCapetaTechOrbit()
    if _G.CapetaTechOrbitEnabled then
        return
    end
    
    local targetPlayer, targetPart = GetCapetaTechTarget()
    
    if not targetPart then
        OrionLib:MakeNotification({
            Name = "Capeta Tech",
            Content = "No Player Nearby",
            Image = "rbxassetid://91044602515577",
            Time = 2
        })
        return
    end
    --91044602515577
    -- Ativar órbita
    _G.CapetaTechOrbitEnabled = true
    SaveCapetaTechStates()
    
    for _, part in pairs(speaker.Character:GetDescendants()) do
        if part:IsA('BasePart') then
            part.CanCollide = false
        end
    end
    
    local humanoid = speaker.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.AutoRotate = false
    end
    
    -- Iniciar loop de órbita
    if _G.CapetaTechConnection then
        _G.CapetaTechConnection:Disconnect()
    end
    
    _G.CapetaTechConnection = RunService.Heartbeat:Connect(function(dt)
        if not _G.CapetaTechOrbitEnabled then
            return
        end
        
        -- Manter colisões desabilitadas
        for _, part in pairs(speaker.Character:GetDescendants()) do
            if part:IsA('BasePart') then
                part.CanCollide = false
            end
        end
        
        -- Calcular nova posição orbital
        local myHRP = getRoot(speaker.Character)
        if targetPart and targetPart.Parent and myHRP then
            CapetaTechOrbitAngle = CapetaTechOrbitAngle + (dt * CapetaTechOrbitSpeed * 6)
            local targetPos = targetPart.Position
            local newPos = Vector3.new(
                targetPos.X + (CapetaTechOrbitDistance * math.cos(CapetaTechOrbitAngle)),
                targetPos.Y + CapetaTechVerticalOffset,
                targetPos.Z + (CapetaTechOrbitDistance * math.sin(CapetaTechOrbitAngle))
            )
            myHRP.CFrame = CFrame.new(newPos, targetPos)
            myHRP.Velocity = Vector3.new(0, 0, 0)
            myHRP.RotVelocity = Vector3.new(0, 0, 0)
        end
    end)
    
    OrionLib:MakeNotification({
        Name = "Capeta Tech",
        Content = "Set: " .. targetPlayer.Name,
        Image = "rbxassetid://9327507243",
        Time = 3
    })
    
    -- Parar órbita após 0.6 segundos
    task.delay(0.6, function()
        _G.CapetaTechOrbitEnabled = false
        if _G.CapetaTechConnection then
            _G.CapetaTechConnection:Disconnect()
            _G.CapetaTechConnection = nil
        end
        CleanupCapetaTech()
    end)
end

-- Keybind para Capeta Tech
local capetaKeybind = loopTab:AddBind({
    Name = "Capeta Tech Keybind",
    Default = Enum.KeyCode.E,
    Hold = false,
    Callback = function()
        if _G.CapetaTechEnabled and speaker.Character then
            ActivateCapetaTechOrbit()
        end
    end
})

loopTab:AddButton({
    Name = "Capeta Tech Mobile",
    Callback = function()
        -- Capeta Tech com Botão Móvel - Ativação Direta
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Variáveis do Capeta Tech (Stealth Orbit)
local CapetaTechCharacter = player.Character or player.CharacterAdded:Wait()
local CapetaTechHumanoid = CapetaTechCharacter:WaitForChild('Humanoid')
local CapetaTechHRP = CapetaTechCharacter:WaitForChild('HumanoidRootPart')
local CapetaTechMaxDistance = 12
local CapetaTechOrbitDistance = 2
local CapetaTechOrbitSpeed = 3
local CapetaTechVerticalOffset = -2.5
local CapetaTechOrbitEnabled = false
local CapetaTechOrbitAngle = 0
local CapetaTechOriginalProperties = {}
local orbitConnection = nil

-- Criar GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CapetaTechGUI"
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 120, 0, 50)
frame.Position = UDim2.new(0, 10, 0.5, -25)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Cantos arredondados
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Botão
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -10, 1, -10)
button.Position = UDim2.new(0, 5, 0, 5)
button.BackgroundColor3 = Color3.fromRGB(50, 138, 220)
button.BorderSizePixel = 0
button.Text = "Capeta Tech"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.Parent = frame

-- Cantos arredondados do botão
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = button

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 1, 5)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "READY"
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- Função para salvar estados originais
local function SaveCapetaTechStates()
    CapetaTechOriginalProperties = {
        WalkSpeed = CapetaTechHumanoid.WalkSpeed,
        AutoRotate = CapetaTechHumanoid.AutoRotate,
        PlatformStand = CapetaTechHumanoid.PlatformStand,
    }
    for _, part in pairs(CapetaTechCharacter:GetDescendants()) do
        if part:IsA('BasePart') then
            CapetaTechOriginalProperties[part.Name .. '_CanCollide'] = part.CanCollide
        end
    end
end

-- Função para limpar estados
local function CleanupCapetaTech()
    if not CapetaTechOriginalProperties.WalkSpeed then
        return
    end
    CapetaTechHumanoid.WalkSpeed = CapetaTechOriginalProperties.WalkSpeed
    CapetaTechHumanoid.AutoRotate = CapetaTechOriginalProperties.AutoRotate
    CapetaTechHumanoid.PlatformStand = CapetaTechOriginalProperties.PlatformStand
    CapetaTechHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    
    for _, part in pairs(CapetaTechCharacter:GetDescendants()) do
        if part:IsA('BasePart') and CapetaTechOriginalProperties[part.Name .. '_CanCollide'] ~= nil then
            part.CanCollide = CapetaTechOriginalProperties[part.Name .. '_CanCollide']
        end
    end
    
    for _, part in pairs(CapetaTechCharacter:GetDescendants()) do
        if part:IsA('BasePart') then
            part.Velocity = Vector3.new(0, 0, 0)
            part.RotVelocity = Vector3.new(0, 0, 0)
        end
    end
end

-- Função para encontrar alvo
local function GetCapetaTechTarget()
    local closest, part = nil, nil
    local shortest = CapetaTechMaxDistance
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild('HumanoidRootPart') then
            local hrp = p.Character.HumanoidRootPart
            local dist = (hrp.Position - CapetaTechHRP.Position).Magnitude
            if dist < shortest then
                closest = p
                part = hrp
                shortest = dist
            end
        end
    end
    return closest, part
end

-- Função para ativar órbita
local function ActivateOrbit()
    if CapetaTechOrbitEnabled then
        return -- Já está orbitando
    end
    
    local targetPlayer, targetPart = GetCapetaTechTarget()
    
    if not targetPart then
        statusLabel.Text = "NO TARGET"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        wait(1)
        statusLabel.Text = "READY"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    -- Ativar órbita
    CapetaTechOrbitEnabled = true
    SaveCapetaTechStates()
    
    -- Status visual
    button.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
    statusLabel.Text = "ORBITING"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
    
    -- Configurar personagem para órbita
    for _, part in pairs(CapetaTechCharacter:GetDescendants()) do
        if part:IsA('BasePart') then
            part.CanCollide = false
        end
    end
    CapetaTechHumanoid.AutoRotate = false
    
    -- Iniciar loop de órbita
    if orbitConnection then
        orbitConnection:Disconnect()
    end
    
    orbitConnection = RunService.Heartbeat:Connect(function(dt)
        if not CapetaTechOrbitEnabled then
            return
        end
        
        -- Manter colisões desabilitadas
        for _, part in pairs(CapetaTechCharacter:GetDescendants()) do
            if part:IsA('BasePart') then
                part.CanCollide = false
            end
        end
        
        -- Calcular nova posição orbital
        if targetPart and targetPart.Parent then
            CapetaTechOrbitAngle = CapetaTechOrbitAngle + (dt * CapetaTechOrbitSpeed * 6)
            local targetPos = targetPart.Position
            local newPos = Vector3.new(
                targetPos.X + (CapetaTechOrbitDistance * math.cos(CapetaTechOrbitAngle)),
                targetPos.Y + CapetaTechVerticalOffset,
                targetPos.Z + (CapetaTechOrbitDistance * math.sin(CapetaTechOrbitAngle))
            )
            CapetaTechHRP.CFrame = CFrame.new(newPos, targetPos)
            CapetaTechHRP.Velocity = Vector3.new(0, 0, 0)
            CapetaTechHRP.RotVelocity = Vector3.new(0, 0, 0)
        end
    end)
    
    -- Parar órbita após 0.6 segundos
    task.delay(0.6, function()
        CapetaTechOrbitEnabled = false
        if orbitConnection then
            orbitConnection:Disconnect()
            orbitConnection = nil
        end
        CleanupCapetaTech()
        
        -- Resetar status visual
        button.BackgroundColor3 = Color3.fromRGB(50, 138, 220)
        statusLabel.Text = "READY"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
    
    print("Capeta Tech ativado! Orbitando " .. (targetPlayer and targetPlayer.Name or "alvo"))
end

-- Handle respawn
player.CharacterAdded:Connect(function(newChar)
    CapetaTechCharacter = newChar
    CapetaTechHumanoid = newChar:WaitForChild('Humanoid')
    CapetaTechHRP = newChar:WaitForChild('HumanoidRootPart')
    CapetaTechOrbitEnabled = false
    CapetaTechOriginalProperties = {}
end)

-- Evento do botão - Ativar órbita diretamente
button.MouseButton1Click:Connect(function()
    ActivateOrbit()
end)

-- Animação de clique
button.MouseButton1Down:Connect(function()
    button:TweenSize(UDim2.new(1, -12, 1, -12), "Out", "Quad", 0.1, true)
end)

button.MouseButton1Up:Connect(function()
    button:TweenSize(UDim2.new(1, -10, 1, -10), "Out", "Quad", 0.1, true)
end)

print("Capeta Tech carregado! Clique no botão para orbitar o alvo mais próximo.")
end
})

loopTab:AddToggle({
    Name = "Capeta Tech (Keybind: E)",
    Default = false,
    Callback = function(Value)
        print("Capeta Tech actived")
        _G.CapetaTechEnabled = Value
        if Value then
            OrionLib:MakeNotification({
                Name = "Capeta Tech",
                Content = "Ativado! Pressione E para orbitar",
                Image = "rbxassetid://9327507243",
                Time = 3
            })
        else
            _G.CapetaTechOrbitEnabled = false
            if _G.CapetaTechConnection then
                _G.CapetaTechConnection:Disconnect()
                _G.CapetaTechConnection = nil
            end
            CleanupCapetaTech()
        end
    end
})

-- Atualizar lista
UpdatePlayerList()

-- Conectar eventos para atualizar automaticamente
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

-- Label de status inicial
local statusLabel = loopTab:AddLabel("Player Selecionado: Nenhum player selecionado")

-- Toggle para Fling
loopTab:AddToggle({
    Name = "Fling no Player",
    Default = false,
    Callback = function(Value)
        print("Fling actived!")
        if Value then
            if not _G.SelectedPlayer then
                OrionLib:MakeNotification({
                    Name = "Error",
                    Content = "Select a Player!",
                    Image = "rbxassetid://91044602515577",
                    Time = 3
                })
                return
            end
            
            _G.FlingEnabled = true
            
            spawn(function()
                for _, child in pairs(speaker.Character:GetDescendants()) do
                    if child:IsA("BasePart") then
                        child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
                    end
                end
                
                task.wait(0.1)
                
                local bambam = Instance.new("BodyAngularVelocity")
                bambam.Name = randomString()
                bambam.Parent = getRoot(speaker.Character)
                bambam.AngularVelocity = Vector3.new(0, 99999, 0)
                bambam.MaxTorque = Vector3.new(0, math.huge, 0)
                bambam.P = math.huge
                
                for _, v in pairs(speaker.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                        v.Massless = true
                        v.Velocity = Vector3.new(0, 0, 0)
                    end
                end
                
                _G.FlingConnection = speaker.Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
                    stopFling()
                end)
                
                -- Loop do fling
                while _G.FlingEnabled and task.wait(0.2) do
                    if not speaker.Character or not getRoot(speaker.Character) then
                        stopFling()
                        break
                    end
                    
                    bambam.AngularVelocity = Vector3.new(0, 99999, 0)
                    task.wait(0.2)
                    bambam.AngularVelocity = Vector3.new(0, 0, 0)
                end
                
                -- Limpeza final
                if bambam and bambam.Parent then
                    bambam:Destroy()
                end
            end)
        else
            stopFling()
        end
    end
})

-- Loop TP
loopTab:AddToggle({
    Name = "Loop TP",
    Default = false,
    Callback = function(Value)
        print("loop tp actived")
        _G.LoopTPEnabled = Value
        
        if Value and _G.SelectedPlayer then
            spawn(function()
                while _G.LoopTPEnabled and _G.SelectedPlayer and task.wait(0.05) do
                    local targetChar = _G.SelectedPlayer.Character
                    local myChar = speaker.Character
                    
                    if targetChar and myChar and targetChar:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
                        -- Teleporta para o player
                        myChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                    end
                end
            end)
        end
    end
})


loopTab:AddToggle({
    Name = "Fling Player",
    Default = false,
    Callback = function(Value)
        print("flinging")
        if Value then
            if not _G.SelectedPlayer then
                OrionLib:MakeNotification({
                    Name = "Error",
                    Content = "Select a Player!",
                    Image = "rbxassetid://91044602515577",
                    Time = 3
                })
                return
            end
            
            _G.FlingEnabled = true
            _G.LoopTPEnabled = true
            
            spawn(function()
                -- Prepara o character para fling
                for _, child in pairs(speaker.Character:GetDescendants()) do
                    if child:IsA("BasePart") then
                        child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
                    end
                end
                
                task.wait(0.1)
                
                local bambam = Instance.new("BodyAngularVelocity")
                bambam.Name = randomString()
                bambam.Parent = getRoot(speaker.Character)
                bambam.AngularVelocity = Vector3.new(0, 99999, 0)
                bambam.MaxTorque = Vector3.new(0, math.huge, 0)
                bambam.P = math.huge
                
                for _, v in pairs(speaker.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                        v.Massless = true
                        v.Velocity = Vector3.new(0, 0, 0)
                    end
                end
                
                _G.FlingConnection = speaker.Character:FindFirstChildOfClass('Humanoid').Died:Connect(stopFling)
                
                while _G.FlingEnabled and _G.LoopTPEnabled and task.wait(0.05) do
                    local targetChar = _G.SelectedPlayer.Character
                    local myChar = speaker.Character
                    
                    if targetChar and myChar and targetChar:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
                        -- Teleporta para o player
                        myChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                        
                    
                        bambam.AngularVelocity = Vector3.new(0, 99999, 0)
                        task.wait(0.1)
                        bambam.AngularVelocity = Vector3.new(0, 0, 0)
                    end
                end
                
                if bambam and bambam.Parent then
                    bambam:Destroy()
                end
            end)
        else
            stopFling()
            _G.LoopTPEnabled = false
        end
    end
})


spawn(function()
    while task.wait(1) do
        statusLabel:Set("Player Selecionado: " .. (_G.SelectedPlayer and _G.SelectedPlayer.Name or "Nenhum player selecionado"))
    end
end)


local HubsTab = Window:MakeTab({
    Name = "More Hubs",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

HubsTab:AddButton({
    Name = "Universal Esp/Aimbot",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Mick-gordon/Hyper-Escape/main/DeleteMobCheatEngine.lua"))()
        print("loaded")
        OrionLib:MakeNotification({
            Name = "Hubs",
            Content = "Universal Esp Aimbot Carregado Com Sucesso!",
            Image = "rbxassetid://10709782497",
            Time = 5
        })
        task.wait(1)
        OrionLib:Destroy()
    end
})

HubsTab:AddButton({
    Name = "Bliz_T Hub FTAP (Fling Things And People)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/refs/heads/main/FTAP.lua"))()
        print("loaded")
        OrionLib:MakeNotification({
            Name = "Hubs",
            Content = "Loaded (Destroyed GUI)",
            Image = "rbxassetid://9327507243",
            Time = 5
        })
        task.wait(1)
        OrionLib:Destroy()
    end
})

local test = Window:MakeTab({
    Name = "Klio molestado",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

test:AddButton({
    Name = "Moged supremo",
    Callback = function()
        -- Servicos
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace:FindFirstChildOfClass("Camera")
local SpawnLocation = Workspace:FindFirstChildOfClass("SpawnLocation")
local Map = Workspace:FindFirstChild("Map")

-- Configurações de iluminação e efeitos
Lighting.Brightness = 0.4
if Camera then Camera.FieldOfView = 90 end

-- Remove objetos desnecessários
if SpawnLocation then SpawnLocation:Destroy() end
if Map and Map:FindFirstChild("MapNoises") then Map.MapNoises:Destroy() end
if Map and Map.AlwaysHereTweenedObjects:FindFirstChild("Ocean") then Map.AlwaysHereTweenedObjects.Ocean:Destroy() end

-- Atmosfera e efeitos visuais
local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere")
atmosphere.Density = 0.35
atmosphere.Parent = Lighting

local blur = Lighting:FindFirstChildOfClass("BlurEffect") or Instance.new("BlurEffect")
blur.Size = 2
blur.Parent = Lighting

-- Skybox
local sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")
sky.Name = "CustomSky"
sky.MoonTextureId = "rbxasset://sky/moon.jpg"
sky.SkyboxBk = "rbxassetid://15535998366"
sky.SkyboxDn = "rbxassetid://15535999786"
sky.SkyboxFt = "rbxassetid://15536004448"
sky.SkyboxLf = "rbxassetid://15536002722"
sky.SkyboxRt = "rbxassetid://15536018506"
sky.SkyboxUp = "rbxassetid://15536006595"
sky.StarCount = 3000
sky.SunAngularSize = 0
sky.Parent = Lighting

-- Remove Clouds se existirem
if Terrain and Terrain:FindFirstChild("Clouds") then
    Terrain.Clouds:Destroy()
end

-- Função para ajustar crosshair
local function WOW()
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local crosshairsFolder = playerGui:FindFirstChild("Crosshairs") or Instance.new("Folder")
    crosshairsFolder.Name = "Crosshairs"
    crosshairsFolder.Parent = playerGui

    local crosshairImage = crosshairsFolder:FindFirstChild("CrosshairImage")
    if not crosshairImage then
        crosshairImage = Instance.new("ImageLabel")
        crosshairImage.Name = "CrosshairImage"
        crosshairImage.Size = UDim2.new(0, 60, 0, 60)
        crosshairImage.Position = UDim2.new(0.5, -30, 0.5, -30)
        crosshairImage.Image = "http://www.roblox.com/asset/?id=6270542807"
        crosshairImage.BackgroundTransparency = 1
        crosshairImage.Parent = crosshairsFolder
    else
        crosshairImage.Visible = true
    end

    -- Desabilita CrosshairsFrame e Dot
    local crosshairsFrame = crosshairsFolder:FindFirstChild("CrosshairsFrame")
    if crosshairsFrame then crosshairsFrame.Visible = false end

    local dot = crosshairsFolder:FindFirstChild("Dot")
    if dot then dot.Visible = false end
end

local function ABABA(character)
    WOW()
end

game.Players.LocalPlayer.CharacterAdded:Connect(ABABA)
if game.Players.LocalPlayer.Character then
    ABABA(game.Players.LocalPlayer.Character)
end

-- Menu Gui personalização
local menuGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MenuGui")
local menu = menuGui:WaitForChild("Menu")

-- Personalizando TabBar
local tabBar = menu:WaitForChild("TabBar")
tabBar.Size = UDim2.new(0.1, 1, 0.999999, 0)
tabBar.BackgroundColor3 = Color3.fromRGB(200, 85, 0)

-- Personalizando Toy Contents
local toys = menu:WaitForChild("TabContents"):WaitForChild("Toys")

local title = toys:WaitForChild("Title")
title.Position = UDim2.new(0.486, 1.1, 0, 0)

local contents = toys:WaitForChild("Contents")
contents.BackgroundColor3 = Color3.fromRGB(153, 51, 0)

local closeButton = menu:WaitForChild("CloseButton")
closeButton.Position = UDim2.new(1.45, 1, 1.2, 1)

-- Ajustando cores dos filhos de Toys, exceto Contents e DropShadow
for _, child in ipairs(toys:GetChildren()) do
    if child:IsA("GuiObject") and child.Name ~= "Contents" and child.Name ~= "DropShadow" then
        child.BackgroundColor3 = Color3.fromRGB(200, 85, 0)
    end
end
end
})

local ConfigF = Window:MakeTab({
    Name = "Configuração",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

ConfigF:AddButton({
    Name = "Shaders",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SoudHub/SoudHub-/refs/heads/main/Shaders"))()
        OrionLib:MakeNotification({
            Name = "Shader",
            Content = "Shaders Loaded (Destroyed GUI)",
            Image = "rbxassetid://9327507243",
            Time = 5
        })
        task.wait(0.2)
        OrionLib:Destroy()
    end
})   

ConfigF:AddButton({
    Name = "Save Configs",
    Callback = function()
        OrionLib:SaveConfig()
        print("Saved")
        OrionLib:MakeNotification({
            Name = "Saved!",
            Content = "Configs Saved",
            Image = "rbxassetid://9327507243",
            Time = 5
        })
    end
})

ConfigF:AddButton({
    Name = "Rage Quit",
    Callback = function()
        -- Mensagens de rage que serão enviadas
        local messages = {
            "lol",
            "Ez", 
            "Ezzzzzzzzz",
            "Runner",
            "lollllll"
        }

        -- Função para enviar mensagens no chat
        local function sendMessages()
            for i = 1, 5 do
                -- Enviar mensagem no chat
                pcall(function()
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(messages[i], "All")
                end)
                wait(0.5) -- Espera mais curta entre mensagens (500ms)
            end
        end

        -- Executar em uma thread separada para não travar o botão
        coroutine.wrap(function()
            sendMessages()
            wait(0.7)
            
            -- Mensagem de kick personalizada
            local mensagem = "Você foi kickado do jogo.\n\nMotivo: RAGE QUIT"
            
            -- Kickar o jogador
            pcall(function()
                game.Players.LocalPlayer:Kick(mensagem)
            end)
        end)()
    end
})

ConfigF:AddToggle({
    Name = "Anti Anim",
    Default = false,
    Callback = function(Value)
        AntiLoop = Value
        
        if AntiLoop then
            OrionLib:MakeNotification({
                Name = "Anti Anim",
                Content = "Anti Anim ativado! Resetando a cada " .. LoopSpeed .. " segundos.",
                Image = "rbxassetid://10709782497",
                Time = 3
            })
            
            -- Loop com intervalo controlável
            AntiLoopConnection = game:GetService("RunService").Heartbeat:Connect(function()
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        -- Teleportar para mesma posição (reset suave)
                        local currentPosition = character.HumanoidRootPart.Position
                        character.HumanoidRootPart.CFrame = CFrame.new(currentPosition)
                        
                        -- Resetar velocidades
                        character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        character.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
                    end
                end)
            end)
            
        else
            if AntiLoopConnection then
                AntiLoopConnection:Disconnect()
                AntiLoopConnection = nil
            end
            OrionLib:MakeNotification({
                Name = "Anti Anim",
                Content = "Anti Loop desativado.",
                Time = 3
            })
        end
    end
})

-- Opcional: Slider para controlar a velocidade do loop
ConfigF:AddSlider({
    Name = "Velocidade Anti Anim",
    Min = 0.1,
    Max = 5,
    Default = 1,
    Color = Color3.fromRGB(193, 18, 31),
    Increment = 0.1,
    ValueName = "segundos",
    Callback = function(Value)
        LoopSpeed = Value
    end
})

ConfigF:AddButton({
    Name = "Return to Dead",
    Callback = function()
        local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Função para enviar mensagem no chat
local function sendChatMessage(message)
    local success = false
    
    pcall(function()
        local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if chatEvents then
            local sayMessageRequest = chatEvents:FindFirstChild("SayMessageRequest")
            if sayMessageRequest then
                sayMessageRequest:FireServer(message, "All")
                success = true
            end
        end
    end)
    
    if not success then
        pcall(function()
            local TextChatService = game:GetService("TextChatService")
            local textChannels = TextChatService:FindFirstChild("TextChannels")
            if textChannels then
                local textChannel = textChannels:FindFirstChild("RBXGeneral")
                if textChannel then
                    textChannel:SendAsync(message)
                    success = true
                end
            end
        end)
    end
    
    if not success then
        pcall(function()
            local ChatService = game:GetService("Chat")
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                ChatService:Chat(LocalPlayer.Character.Head, message)
                success = true
            end
        end)
    end
end

local lastDeathPosition = nil
local shouldSendOnRespawn = false -- controle: só manda dps do teleport

-- Função para executar emote
local function playUntouchableEmote()
    local args = {
        {
            Goal = "Emote",
            Emote = "Untouchable"
        }
    }
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Communicate") then
        LocalPlayer.Character.Communicate:FireServer(unpack(args))
    end
end

-- Função que executa quando o personagem morre
local function onCharacterDied()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        lastDeathPosition = LocalPlayer.Character.HumanoidRootPart.Position
        shouldSendOnRespawn = true -- só manda quando voltar
    end
end

-- Função que executa quando o personagem spawna (teleportado)
local function onCharacterSpawned(character)
    task.wait(0.5) -- delay para garantir que o character carregou
    
    if lastDeathPosition and shouldSendOnRespawn then
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- Teleporta 3 studs acima da última posição
            character:SetPrimaryPartCFrame(CFrame.new(lastDeathPosition + Vector3.new(0, 3, 0)))
            
            -- Agora sim, manda as mensagens e faz o emote
            sendChatMessage("i returned")
            sendChatMessage("ez")
            playUntouchableEmote()
            
            -- desativa até morrer de novo
            shouldSendOnRespawn = false
        end
    end
    
    -- Conecta o evento de morte do novo personagem
    local humanoid = character:WaitForChild("Humanoid")
    if humanoid then
        humanoid.Died:Connect(onCharacterDied)
    end
end

-- Conecta o evento de spawn do personagem
LocalPlayer.CharacterAdded:Connect(onCharacterSpawned)

-- Se o personagem já existir, conecta os eventos
if LocalPlayer.Character then
    onCharacterSpawned(LocalPlayer.Character)
end
task.wait(0.2)
OrionLib:MakeNotification({
    Name = "Return To Dead",
    Content = "Return To Dead Load!",
    Image = "rbxassetid://10709782497",
    Time = 3
})
end
})

ConfigF:AddButton({
    Name = "Cat",
    Callback = function()
        local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Lista de frases que o gatinho vai falar (em ordem sequencial)
local frasesDoGatinho = {
    "Vini Molestado",
    "Bliz molestado",
    "Menta Molestado",
    "credits: shizuku, Bliz_T, Pato_Soud",
    "by Pato_Soud"
}

-- Variável para controlar a frase atual
local indiceFraseAtual = 1
local tempoUltimaFala = os.time()

-- Criar a interface do gatinho
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GatinhoArrastavel"
screenGui.Parent = PlayerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Name = "GatinhoFrame"
frame.Size = UDim2.new(0, 60, 0, 60)
frame.Position = UDim2.new(1, -70, 1, -70)  -- Posição no canto inferior direito
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Adicionar imagem de gatinho
local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "GatinhoImagem"
imageLabel.Size = UDim2.new(1, 0, 1, 0)
imageLabel.Position = UDim2.new(0, 0, 0, 0)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxassetid://9577165397"  -- IDS Mais: -Base: 9577165397- -18829480769 femboy- gato com medo -6274377111- Rikka-8890490135-
imageLabel.Parent = frame

-- Criar balão de fala
local balaoDeFala = Instance.new("Frame")
balaoDeFala.Name = "BalaoDeFala"
balaoDeFala.Size = UDim2.new(0, 120, 0, 40)
balaoDeFala.Position = UDim2.new(0.5, -60, 0, -50)
balaoDeFala.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
balaoDeFala.BackgroundTransparency = 0.8
balaoDeFala.BorderSizePixel = 0
balaoDeFala.Visible = false
balaoDeFala.ZIndex = 2
balaoDeFala.Parent = frame

-- Deixar o balão com formato de nuvem
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.5, 0)
UICorner.Parent = balaoDeFala

-- Adicionar texto ao balão
local textoFala = Instance.new("TextLabel")
textoFala.Name = "TextoFala"
textoFala.Size = UDim2.new(0.9, 0, 0.8, 0)
textoFala.Position = UDim2.new(0.05, 0, 0.1, 0)
textoFala.BackgroundTransparency = 1
textoFala.TextColor3 = Color3.fromRGB(0, 0, 0)
textoFala.TextScaled = true
textoFala.Font = Enum.Font.SourceSansBold
textoFala.Text = ""
textoFala.ZIndex = 3
textoFala.Parent = balaoDeFala

-- Adicionar "ponta" no balão (setinha apontando para o gatinho)
local pontaBalao = Instance.new("Frame")
pontaBalao.Name = "PontaBalao"
pontaBalao.Size = UDim2.new(0, 15, 0, 15)
pontaBalao.Position = UDim2.new(0.5, -7.5, 1, -10)
pontaBalao.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
pontaBalao.BackgroundTransparency = 0.8
pontaBalao.BorderSizePixel = 0
pontaBalao.Rotation = 45
pontaBalao.ZIndex = 2
pontaBalao.Parent = balaoDeFala

-- Variáveis para arrastar
local dragging = false
local dragInput
local dragStart
local startPos

-- Função para fazer o gatinho falar
local function fazerGatinhoFalar()
    -- Obter a frase atual baseada no índice
    local fraseAtual = frasesDoGatinho[indiceFraseAtual]
    textoFala.Text = fraseAtual
    
    -- Avançar para a próxima frase (voltar ao início se chegar no final)
    indiceFraseAtual = indiceFraseAtual + 1
    if indiceFraseAtual > #frasesDoGatinho then
        indiceFraseAtual = 1
    end
    
    -- Resetar transparências
    balaoDeFala.BackgroundTransparency = 0.8
    textoFala.TextTransparency = 0
    pontaBalao.BackgroundTransparency = 0.8
    
    -- Mostrar o balão de fala
    balaoDeFala.Visible = true
    
    -- Animação de aparecimento
    balaoDeFala.Size = UDim2.new(0, 10, 0, 10)
    balaoDeFala.Position = UDim2.new(0.5, -5, 0, -5)
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local tween = TweenService:Create(balaoDeFala, tweenInfo, {
        Size = UDim2.new(0, 120, 0, 40),
        Position = UDim2.new(0.5, -60, 0, -50)
    })
    tween:Play()
    
    -- Esconder o balão após alguns segundos (usando spawn para não bloquear o script)
    spawn(function()
        wait(4)
        
        -- Animação de desaparecimento
        tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        tween = TweenService:Create(balaoDeFala, tweenInfo, {
            BackgroundTransparency = 1
        })
        tween:Play()
        
        tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tweenTexto = TweenService:Create(textoFala, tweenInfo, {
            TextTransparency = 1
        })
        tweenTexto:Play()
        
        tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tweenPonta = TweenService:Create(pontaBalao, tweenInfo, {
            BackgroundTransparency = 1
        })
        tweenPonta:Play()
        
        wait(0.5)
        balaoDeFala.Visible = false
    end)
end

-- Função para atualizar a posição ao arrastar
local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

-- Conexões de entrada do usuário para arrastar
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Efeito de hover para melhor interatividade
frame.MouseEnter:Connect(function()
    local tween = TweenService:Create(
        frame,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 70, 0, 70)}
    )
    tween:Play()
end)

frame.MouseLeave:Connect(function()
    local tween = TweenService:Create(
        frame,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 60, 0, 60)}
    )
    tween:Play()
end)

-- Loop de fala a cada 30 segundos usando Heartbeat para melhor performance
RunService.Heartbeat:Connect(function()
    local tempoAtual = os.time()
    if tempoAtual - tempoUltimaFala >= 30 then
        tempoUltimaFala = tempoAtual
        fazerGatinhoFalar()
    end
end)

    OrionLib:MakeNotification({
       Name = "Cat",
       Content = "Cat Active!",
       Image = "rbxassetid://10709782497",
       Time = 5
    })
end
})

-- Final/Créditos
local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

CreditsTab:AddLabel("Creditos:")
CreditsTab:AddLabel("Pato_Soud")
CreditsTab:AddLabel("Shizuku")
CreditsTab:AddLabel("Bliz_T")
CreditsTab:AddLabel("Traco")
CreditsTab:AddLabel("DeadPrinces")
CreditsTab:AddLabel("ScriPtinG_DevS")
CreditsTab:AddLabel("Actual lines in Script: 1826")
--FOV
changeFOV(70)

OrionLib:Init()
