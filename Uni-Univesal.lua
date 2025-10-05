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

print("Made by Pato And:")
print("██╗  ██╗║█████╗ ██████╗   ███████╗ ███████╗")
print("██║  ██║██╔══██╗╚════██╗ ██╔═════╝██╔═════╝")
print("███████║██████╔╝ █████╔╝ ███████╗ ███████╗")
print("██╔══██║██╔═══╝  ╚═══██╗ ╚════██║ ╚════██║")
print("██║  ██║██║     ██████╔╝ ███████║ ███████║")
print("╚═╝  ╚═╝╚═╝     ╚═════╝  ╚══════╝ ╚══════╝")


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

--[[local pvpTab = Window:MakeTab({
    Name = "PvP",
    icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

pvpTab:AddLabel("No itens!")
pvpTab:AddLabel("More soon!")--]]

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
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

MainTab:AddSection({
    Name = "Discord Server"
})

MainTab:AddButton({
    Name = "Discord",
    Callback = function()
        print("copied!")
        setclipboard("https://discord.gg/HtxupJnHfu")
        OrionLib:MakeNotification({
            Name = "Discord Copied",
            Content = "Discord Copied",
            Image = "rbxassetid://9327507243",
            Time = 5
        })
    end
})

MainTab:AddSection({
    Name = "FPS Mine Menu"
})

MainTab:AddButton({
    Name = "FPS",
    Callback = function()
        repeat wait() until game:IsLoaded() wait(2)
local ScreenGui = Instance.new("ScreenGui")
local Fps = Instance.new("TextLabel")


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
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- Sound Effects
local function playSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- Play initial sound
playSound("2865227271")

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuperRingPartsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 500)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Make the GUI round
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Super Ring Parts V6 by lukas"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 204, 204)
Title.Font = Enum.Font.Fondamento
Title.TextSize = 22
Title.Parent = MainFrame

-- Round the title
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20)
TitleCorner.Parent = Title

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.Text = "Ring Off"
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.Font = Enum.Font.Fondamento
ToggleButton.TextSize = 18
ToggleButton.Parent = MainFrame

-- Round the toggle button
local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

-- Configuration table
local config = {
    radius = 50,
    height = 100,
    rotationSpeed = 10,
    attractionStrength = 1000,
}

-- Save and load functions
local function saveConfig()
    local configStr = HttpService:JSONEncode(config)
    writefile("SuperRingPartsConfig.txt", configStr)
end

local function loadConfig()
    if isfile("SuperRingPartsConfig.txt") then
        local configStr = readfile("SuperRingPartsConfig.txt")
        config = HttpService:JSONDecode(configStr)
    end
end

loadConfig()

-- Function to create control buttons and textboxes
local function createControl(name, positionY, color, labelText, defaultValue, callback)
    local DecreaseButton = Instance.new("TextButton")
    DecreaseButton.Size = UDim2.new(0.2, 0, 0, 40)
    DecreaseButton.Position = UDim2.new(0.1, 0, positionY, 0)
    DecreaseButton.Text = "-"
    DecreaseButton.BackgroundColor3 = color
    DecreaseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    DecreaseButton.Font = Enum.Font.Fondamento
    DecreaseButton.TextSize = 18
    DecreaseButton.Parent = MainFrame

    local IncreaseButton = Instance.new("TextButton")
    IncreaseButton.Size = UDim2.new(0.2, 0, 0, 40)
    IncreaseButton.Position = UDim2.new(0.7, 0, positionY, 0)
    IncreaseButton.Text = "+"
    IncreaseButton.BackgroundColor3 = color
    IncreaseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    IncreaseButton.Font = Enum.Font.Fondamento
    IncreaseButton.TextSize = 18
    IncreaseButton.Parent = MainFrame

    local Display = Instance.new("TextLabel")
    Display.Size = UDim2.new(0.4, 0, 0, 40)
    Display.Position = UDim2.new(0.3, 0, positionY, 0)
    Display.Text = labelText .. ": " .. defaultValue
    Display.BackgroundColor3 = Color3.fromRGB(255, 153, 51)
    Display.TextColor3 = Color3.fromRGB(0, 0, 0)
    Display.Font = Enum.Font.Fondamento
    Display.TextSize = 18
    Display.Parent = MainFrame

    -- Add TextBox for input
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0.8, 0, 0, 35)
    TextBox.Position = UDim2.new(0.1, 0, positionY + 0.1, 0)
    TextBox.PlaceholderText = "Enter " .. labelText
    TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.Font = Enum.Font.Fondamento
    TextBox.TextSize = 18
    TextBox.Parent = MainFrame

    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.CornerRadius = UDim.new(0, 10)
    TextBoxCorner.Parent = TextBox

    DecreaseButton.MouseButton1Click:Connect(function()
        local value = tonumber(Display.Text:match("%d+"))
        value = math.max(0, value - 10)
        Display.Text = labelText .. ": " .. value
        callback(value)
        playSound("12221967")
        saveConfig()
    end)

    IncreaseButton.MouseButton1Click:Connect(function()
        local value = tonumber(Display.Text:match("%d+"))
        value = math.min(10000, value + 10)
        Display.Text = labelText .. ": " .. value
        callback(value)
        playSound("12221967")
        saveConfig()
    end)

    TextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local newValue = tonumber(TextBox.Text)
            if newValue then
                newValue = math.clamp(newValue, 0, 10000)
                Display.Text = labelText .. ": " .. newValue
                TextBox.Text = ""
                callback(newValue)
                playSound("12221967")
                saveConfig()
            else
                TextBox.Text = ""
            end
        end
    end)
end

createControl("Radius", 0.2, Color3.fromRGB(153, 153, 0), "Radius", config.radius, function(value)
    config.radius = value
    saveConfig()
end)

createControl("Height", 0.4, Color3.fromRGB(153, 0, 153), "Height", config.height, function(value)
    config.height = value
    saveConfig()
end)

createControl("RotationSpeed", 0.6, Color3.fromRGB(0, 153, 153), "Rotation Speed", config.rotationSpeed, function(value)
    config.rotationSpeed = value
    saveConfig()
end)

createControl("AttractionStrength", 0.8, Color3.fromRGB(153, 0, 0), "Attraction Strength", config.attractionStrength, function(value)
    config.attractionStrength = value
    saveConfig()
end)

-- Add minimize button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.Font = Enum.Font.Fondamento
MinimizeButton.TextSize = 15
MinimizeButton.Parent = MainFrame

-- Round the minimize button
local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 15)
MinimizeCorner.Parent = MinimizeButton

-- Minimize functionality
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 40), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "+"
        for _, child in pairs(MainFrame:GetChildren()) do
            if child:IsA("GuiObject") and child ~= Title and child ~= MinimizeButton then
                child.Visible = false
            end
        end
    else
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 500), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "-"
        for _, child in pairs(MainFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child.Visible = true
            end
        end
    end
    playSound("12221967")
end)

-- Make GUI draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Ring Parts Claim
local Workspace = game:GetService("Workspace")

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local Folder = Instance.new("Folder", Workspace)
local Part = Instance.new("Part", Folder)
local Attachment1 = Instance.new("Attachment", Part)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1

if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }

    Network.RetainPart = function(Part)
        if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
            table.insert(Network.BaseParts, Part)
            Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            Part.CanCollide = false
        end
    end

    local function EnablePartControl()
        LocalPlayer.ReplicationFocus = Workspace
        RunService.Heartbeat:Connect(function()
            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            for _, Part in pairs(Network.BaseParts) do
                if Part:IsDescendantOf(Workspace) then
                    Part.Velocity = Network.Velocity
                end
            end
        end)
    end

    EnablePartControl()
end

local function ForcePart(v)
    if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
        for _, x in next, v:GetChildren() do
            if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                x:Destroy()
            end
        end
        if v:FindFirstChild("Attachment") then
            v:FindFirstChild("Attachment"):Destroy()
        end
        if v:FindFirstChild("AlignPosition") then
            v:FindFirstChild("AlignPosition"):Destroy()
        end
        if v:FindFirstChild("Torque") then
            v:FindFirstChild("Torque"):Destroy()
        end
        v.CanCollide = false
        local Torque = Instance.new("Torque", v)
        Torque.Torque = Vector3.new(100000, 100000, 100000)
        local AlignPosition = Instance.new("AlignPosition", v)
        local Attachment2 = Instance.new("Attachment", v)
        Torque.Attachment0 = Attachment2
        AlignPosition.MaxForce = 9999999999999999999999999999999
        AlignPosition.MaxVelocity = math.huge
        AlignPosition.Responsiveness = 200
        AlignPosition.Attachment0 = Attachment2
        AlignPosition.Attachment1 = Attachment1
    end
end

-- Edits
local ringPartsEnabled = false

local function RetainPart(Part)
    if Part:IsA("BasePart") and not Part.Anchored and Part:IsDescendantOf(workspace) then
        if Part.Parent == LocalPlayer.Character or Part:IsDescendantOf(LocalPlayer.Character) then
            return false
        end

        Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        Part.CanCollide = false
        return true
    end
    return false
end

local parts = {}
local function addPart(part)
    if RetainPart(part) then
        if not table.find(parts, part) then
            table.insert(parts, part)
        end
    end
end

local function removePart(part)
    local index = table.find(parts, part)
    if index then
        table.remove(parts, index)
    end
end

for _, part in pairs(workspace:GetDescendants()) do
    addPart(part)
end

workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(removePart)

RunService.Heartbeat:Connect(function()
    if not ringPartsEnabled then return end
    
    local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local tornadoCenter = humanoidRootPart.Position
        for _, part in pairs(parts) do
            if part.Parent and not part.Anchored then
                local pos = part.Position
                local distance = (Vector3.new(pos.X, tornadoCenter.Y, pos.Z) - tornadoCenter).Magnitude
                local angle = math.atan2(pos.Z - tornadoCenter.Z, pos.X - tornadoCenter.X)
                local newAngle = angle + math.rad(config.rotationSpeed)
                local targetPos = Vector3.new(
                    tornadoCenter.X + math.cos(newAngle) * math.min(config.radius, distance),
                    tornadoCenter.Y + (config.height * (math.abs(math.sin((pos.Y - tornadoCenter.Y) / config.height)))),
                    tornadoCenter.Z + math.sin(newAngle) * math.min(config.radius, distance)
                )
                local directionToTarget = (targetPos - part.Position).unit
                part.Velocity = directionToTarget * config.attractionStrength
            end
        end
    end
end)

-- Button functionality
ToggleButton.MouseButton1Click:Connect(function()
    ringPartsEnabled = not ringPartsEnabled
    ToggleButton.Text = ringPartsEnabled and "Tornado On" or "Tornado Off"
    ToggleButton.BackgroundColor3 = ringPartsEnabled and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(160, 82, 45)
    playSound("12221967")
end)

-- Get player thumbnail
local userId = Players:GetUserIdFromNameAsync("Robloxlukasgames")
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

StarterGui:SetCore("SendNotification", {
    Title = "Hey",
    Text = "Enjoy the Script!",
    Icon = content,
    Duration = 5
})

StarterGui:SetCore("SendNotification", {
    Title = "TIPS",
    Text = "Click Textbox To edit Any of them",
    Icon = content,
    Duration = 5
})

StarterGui:SetCore("SendNotification", {
    Title = "Credits",
    Text = "On scriptblox!",
    Icon = content,
    Duration = 5
})


-- Rainbow Background Effect
local hue = 0
RunService.Heartbeat:Connect(function()
    hue = (hue + 0.01) % 1
    MainFrame.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
end)

-- Rainbow TextLabel
local textHue = 0
RunService.Heartbeat:Connect(function()
    textHue = (textHue + 0.01) % 1
    Title.TextColor3 = Color3.fromHSV(textHue, 1, 1)
end)


-- fly gui

local TextButton1 = Instance.new("TextButton") 
TextButton1.Parent = MainFrame
TextButton1.Name = "Fly gui"
TextButton1.BackgroundColor3 = Color3.fromRGB(0,0,255)
TextButton1.BackgroundTransparency = 0
TextButton1.BorderSizePixel = 1
TextButton1.BorderColor3 = Color3.fromRGB(17,17,17)
TextButton1.Position = UDim2.new(1,0,1)
TextButton1.Size = UDim2.new(0.08,0,0.1)
TextButton1.Font = Enum.Font.Legacy
TextButton1.TextColor3 = Color3.fromRGB(242,243,243)
TextButton1.Text = "Fly Gui"
TextButton1.TextSize = 18
TextButton1.TextScaled = true
TextButton1.TextWrapped = true
TextButton1.Visible = true
TextButton1.Active = true

TextButton1.MouseButton1Click:Connect(function() 
loadstring(game:HttpGet('https://pastebin.com/raw/YSL3xKYU'))()
end)

-- no fall damage
local TextButton1 = Instance.new("TextButton") 
TextButton1.Parent = MainFrame
TextButton1.Name = "no fall damage"
TextButton1.BackgroundColor3 = Color3.fromRGB(255,0,0)
TextButton1.BackgroundTransparency = 0
TextButton1.BorderSizePixel = 1
TextButton1.BorderColor3 = Color3.fromRGB(17,17,17)
TextButton1.Position = UDim2.new(0.9,0,1)
TextButton1.Size = UDim2.new(0.08,0,0.1)
TextButton1.Font = Enum.Font.Legacy
TextButton1.TextColor3 = Color3.fromRGB(242,243,243)
TextButton1.Text = "No fall Damage"
TextButton1.TextSize = 18
TextButton1.TextScaled = true
TextButton1.TextWrapped = true
TextButton1.Visible = true
TextButton1.Active = true

TextButton1.MouseButton1Click:Connect(function() 
-- No Fall Damage by Pio (Discord: piomanly or ID: 311397526399877122) --
local runsvc = game:GetService("RunService")
local heartbeat = runsvc.Heartbeat
local rstepped = runsvc.RenderStepped

local lp = game.Players.LocalPlayer

local novel = Vector3.zero

local function nofalldamage(chr)
    local root = chr:WaitForChild("HumanoidRootPart")
    
    if root then
        local con
        con = heartbeat:Connect(function()
            if not root.Parent then
                con:Disconnect()
            end
            
            local oldvel = root.AssemblyLinearVelocity
            root.AssemblyLinearVelocity = novel
            
            rstepped:Wait()
            root.AssemblyLinearVelocity = oldvel
        end)
    end
end

nofalldamage(lp.Character)
    lp.CharacterAdded:Connect(nofalldamage)
end)

-- noclip
local TextButton1 = Instance.new("TextButton") 
TextButton1.Parent = MainFrame
TextButton1.Name = "noclip"
TextButton1.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton1.BackgroundTransparency = 0
TextButton1.BorderSizePixel = 1
TextButton1.BorderColor3 = Color3.fromRGB(17,17,17)
TextButton1.Position = UDim2.new(0.8,0,1)
TextButton1.Size = UDim2.new(0.08,0,0.1)
TextButton1.Font = Enum.Font.Legacy
TextButton1.TextColor3 = Color3.fromRGB(242,243,243)
TextButton1.Text = "Noclip"
TextButton1.TextSize = 18
TextButton1.TextScaled = true
TextButton1.TextWrapped = true
TextButton1.Visible = true
TextButton1.Active = true

TextButton1.MouseButton1Click:Connect(function() 
local Noclip = nil
local Clip = nil

function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.21) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end

noclip() -- to toggle noclip() and clip()
end)

-- Inf jump

local TextButton1 = Instance.new("TextButton") 
TextButton1.Parent = MainFrame
TextButton1.Name = "Inf jump"
TextButton1.BackgroundColor3 = Color3.fromRGB(0,255,0)
TextButton1.BackgroundTransparency = 0
TextButton1.BorderSizePixel = 1
TextButton1.BorderColor3 = Color3.fromRGB(17,17,17)
TextButton1.Position = UDim2.new(0.7,0,1)
TextButton1.Size = UDim2.new(0.08,0,0.1)
TextButton1.Font = Enum.Font.Legacy
TextButton1.TextColor3 = Color3.fromRGB(242,243,243)
TextButton1.Text = "Inf jump"
TextButton1.TextSize = 18
TextButton1.TextScaled = true
TextButton1.TextWrapped = true
TextButton1.Visible = true
TextButton1.Active = true

TextButton1.MouseButton1Click:Connect(function() 
local InfiniteJumpEnabled = true game:GetService("UserInputService").JumpRequest:connect(function() 	if InfiniteJumpEnabled then 		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping") 	end end)
end)

-- Inf yield

local TextButton1 = Instance.new("TextButton") 
TextButton1.Parent = MainFrame
TextButton1.Name = "Inf yield"
TextButton1.BackgroundColor3 = Color3.fromRGB(0,255,255)
TextButton1.BackgroundTransparency = 0
TextButton1.BorderSizePixel = 1
TextButton1.BorderColor3 = Color3.fromRGB(17,17,17)
TextButton1.Position = UDim2.new(0.6,0,1)
TextButton1.Size = UDim2.new(0.08,0,0.1)
TextButton1.Font = Enum.Font.Legacy
TextButton1.TextColor3 = Color3.fromRGB(242,243,243)
TextButton1.Text = "Inf yield"
TextButton1.TextSize = 18
TextButton1.TextScaled = true
TextButton1.TextWrapped = true
TextButton1.Visible = true
TextButton1.Active = true

TextButton1.MouseButton1Click:Connect(function() 
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- nameless admin

local TextButton1 = Instance.new("TextButton") 
TextButton1.Parent = MainFrame
TextButton1.Name = "nameless admin"
TextButton1.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton1.BackgroundTransparency = 0
TextButton1.BorderSizePixel = 1
TextButton1.BorderColor3 = Color3.fromRGB(17,17,17)
TextButton1.Position = UDim2.new(0.5,0,1)
TextButton1.Size = UDim2.new(0.08,0,0.1)
TextButton1.Font = Enum.Font.Legacy
TextButton1.TextColor3 = Color3.fromRGB(242,243,243)
TextButton1.Text = "NAMELESS"
TextButton1.TextSize = 18
TextButton1.TextScaled = true
TextButton1.TextWrapped = true
TextButton1.Visible = true
TextButton1.Active = true

TextButton1.MouseButton1Click:Connect(function() 
loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Nameless-Admin-FE-11243"))()
end)

-- fps

local TextButton1 = Instance.new("TextButton") 
TextButton1.Parent = MainFrame
TextButton1.Name = "FPS"
TextButton1.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton1.BackgroundTransparency = 0
TextButton1.BorderSizePixel = 1
TextButton1.BorderColor3 = Color3.fromRGB(17,17,17)
TextButton1.Position = UDim2.new(0.4,0,1)
TextButton1.Size = UDim2.new(0.08,0,0.1)
TextButton1.Font = Enum.Font.Legacy
TextButton1.TextColor3 = Color3.fromRGB(242,243,243)
TextButton1.Text = "FPS"
TextButton1.TextSize = 18
TextButton1.TextScaled = true
TextButton1.TextWrapped = true
TextButton1.Visible = true
TextButton1.Active = true

TextButton1.MouseButton1Click:Connect(function() 
loadstring(game:HttpGet("https://pastebin.com/raw/ySHJdZpb",true))()
end)
-- Just that enjoy skidding this lol
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

MainTab:AddSection({
    Name = "Anti Lag"
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

MainTab:AddSection({
    Name = "Infinite Yield"
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

MainTab:AddSection({
    Name = "Sky and Shine"
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

MainTab:AddSection({
    Name = "Keybind TP"
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


local HubsTab = Window:MakeTab({
    Name = "More Hubs",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

HubsTab:AddSection({
    Name = "Aimbot"
})

HubsTab:AddButton({
    Name = "Universal Esp/Aimbot",
    Callback = function()
        -- Yes, I know This Is Shit.
local PLAYER = game.Players.LocalPlayer
local CurrentCam  = game.Workspace.CurrentCamera
local UIS = game:GetService("UserInputService")-- Made By Mick Gordon
local WorldToViewportPoint = CurrentCam.WorldToViewportPoint
local mouseLocation = UIS.GetMouseLocation

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Made By Mick Gordon", Text = "Enjoy !"})

local DeleteMob ={
    GUi = {
        OpenNCloseButton = true; -- Have A Button For It
        KeybindEnable = false; -- If You Want A Bind For The Menu
        Keybind = "z"; -- Menu Key Bind
    };
	Aimbot= {
        Keybind = "MouseButton2"; -- Change Aim Bot Key Bind Here !!! No Capitals, Unless it is MouseButton1 or MouseButton2
------------------------------------------------------------------------------------------
		Enabled = false; -- No Need To Change Anything Here As It Is On The GUI
		TeamCheck = false;
		WallCheck = false;
		ShowFov = false;
		Fov = 0;
		Smoothing = 0;
		AimPart = "Head";
		Thickness = 1;
		FovFillColor = Color3.fromRGB(100,0,100);
		FovColor = Color3.fromRGB(100,0,100);
		FovFillTransparency = 1;
		FovTransparenct = 0;
        IsAimKeyDown = false;
	};
	ESP ={
		Box = {
			Box = false;
			Name = false;
			Distance = false;
			Health = false;

			TeamCheck = false;

			HealthType = "Bar";

			BoxColor = Color3.fromRGB(75,0,10);
		};
		OutLines = {
			Enabled = false;
			TeamCheck = false;
			TeamColor = false;

			AllwaysShow = true;

			FillCollor = Color3.fromRGB(75,0,10);
			FillTrancparenct = 0;

			OutlineColor = Color3.fromRGB(0,0,0);
			OutlineTrancparency = 0;
		};
		Tracers = {
			Enabled = false;
			TeamCheck = false;
			TeamColor = false;

			Color = Color3.fromRGB(75,0,10);
		}
	}-- Made By Mick Gordon
}

-- Made By Mick Gordon
local Fov = Instance.new("ScreenGui")Fov.Name = "Fov" Fov.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") Fov.ZIndexBehavior = Enum.ZIndexBehavior.Sibling Fov.ResetOnSpawn = false-- i miss you synapse fov
local TracersG = Instance.new("ScreenGui")TracersG.Name = "Tracers" TracersG.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") TracersG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling TracersG.ResetOnSpawn = false
local FOVFFrame = Instance.new("Frame")FOVFFrame.Parent = Fov FOVFFrame.Name = "FOVFFrame" FOVFFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) FOVFFrame.BorderColor3 = Color3.fromRGB(0, 0, 0) FOVFFrame.BorderSizePixel = 0 FOVFFrame.BackgroundTransparency = 1 FOVFFrame.AnchorPoint = Vector2.new(0.5, 0.5) FOVFFrame.Position = UDim2.new(0.5, 0,0.5, 0) FOVFFrame.Size = UDim2.new(0, DeleteMob.Aimbot.Fov, 0, DeleteMob.Aimbot.Fov) FOVFFrame.BackgroundTransparency = 1 
local UICorner = Instance.new("UICorner")UICorner.CornerRadius = UDim.new(1, 0) UICorner.Parent = FOVFFrame -- Made By Mick Gordon
local UIStroke = Instance.new("UIStroke")UIStroke.Color = Color3.fromRGB(100,0,100) UIStroke.Parent = FOVFFrame UIStroke.Thickness = 1 UIStroke.ApplyStrokeMode = "Border" game:GetService("StarterGui"):SetCore("SendNotification", {Title = "https://discord.gg/FsApQ7YNTq", Text = "The Discord For More!"})
local BoxC = Instance.new("ScreenGui", game.Workspace) BoxC.Name = "Box"
local Higlight = Instance.new("ScreenGui",game.Workspace)
local connections = {}
-- Made By Mick Gordon
local function AddHighlight(plr)
	local Highlight = Instance.new("Highlight")
	Highlight.Parent = Higlight
	Highlight.Name = plr.Name
	Highlight.Enabled = DeleteMob.ESP.OutLines.Enabled
	local plrchar = plr.Character
	if plrchar then
		Highlight.Adornee = plrchar
	end
	connections[plr] = plr.CharacterAdded:Connect(function(char)
		Highlight.Adornee = char
	end)
	local co = coroutine.create(function()
		while wait(.1) do
			if plr ~= PLAYER and plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then

				if DeleteMob.ESP.OutLines.Enabled == true then
					if DeleteMob.ESP.OutLines.TeamCheck == true and plr.TeamColor == PLAYER.TeamColor then
						Highlight.Enabled = false
					else
						Highlight.Enabled = true
					end
				else-- Made By Mick Gordon
					Highlight.Enabled = false
				end

				if DeleteMob.ESP.OutLines.TeamColor == true then
					Highlight.FillColor = plr.TeamColor.Color 
				else
					Highlight.FillColor = DeleteMob.ESP.OutLines.FillCollor
				end

				if DeleteMob.ESP.OutLines.AllwaysShow == true then
					Highlight.DepthMode = "AlwaysOnTop" 
				else
					Highlight.DepthMode = "Occluded" 
				end-- Made By Mick Gordon

				Highlight.OutlineTransparency = DeleteMob.ESP.OutLines.OutlineTrancparency
				Highlight.OutlineColor = DeleteMob.ESP.OutLines.OutlineColor
				Highlight.FillTransparency = DeleteMob.ESP.OutLines.FillTrancparenct

				if not (game:GetService"Players":FindFirstChild(plr.Name)) then
					Higlight:FindFirstChild(plr.Name):Destroy()
					coroutine.yield()
				end
			else
				Highlight.Enabled = false
			end
		end
	end)
	coroutine.resume(co)
end
-- Made By Mick Gordon
local function AddBox(player) -- Saves FPS 
	local bbg = Instance.new("BillboardGui", BoxC)
	bbg.Name = player.Name
	bbg.AlwaysOnTop = true
	bbg.Size = UDim2.new(4,0,5.4,0)
	bbg.ClipsDescendants = false
	bbg.Enabled = false

	local outlines = Instance.new("Frame", bbg)
	outlines.Size = UDim2.new(1,0,1,0)
	outlines.BorderSizePixel = 1
	outlines.BackgroundTransparency = 1
	local left = Instance.new("Frame", outlines)
	left.BorderSizePixel = 1
	left.Size = UDim2.new(0,(1),1,0)
	local right = left:Clone()
	right.Parent = outlines
	right.Size = UDim2.new(0,-(1),1,0)   
	right.Position = UDim2.new(1,0,0,0)
	local up = left:Clone()-- Made By Mick Gordon
	up.Parent = outlines
	up.Size = UDim2.new(1,0,0,(1))
	local down = left:Clone()
	down.Parent = outlines
	down.Size = UDim2.new(1,0,0,-(1))
	down.Position = UDim2.new(0,0,1,0)

	local info = Instance.new("BillboardGui", bbg)
	info.Name = "info"
	info.Size = UDim2.new(3,0,0,54)
	info.StudsOffset = Vector3.new(3.6,-3,0)
	info.AlwaysOnTop = true
	info.ClipsDescendants = false
	info.Enabled = false
	local namelabel = Instance.new("TextLabel", info)
	namelabel.Name = "namelabel"
	namelabel.BackgroundTransparency = 1
	namelabel.TextStrokeTransparency = 0
	namelabel.TextXAlignment = Enum.TextXAlignment.Left
	namelabel.Size = UDim2.new(0,100,0,18)
	namelabel.Position = UDim2.new(0,0,0,0)
	namelabel.Text = player.Name
	local distancel = Instance.new("TextLabel", info)
	distancel.Name = "distancelabel"
	distancel.BackgroundTransparency = 1-- Made By Mick Gordon
	distancel.TextStrokeTransparency = 0
	distancel.TextXAlignment = Enum.TextXAlignment.Left
	distancel.Size = UDim2.new(0,100,0,18)
	distancel.Position = UDim2.new(0,0,0,18)
	local healthl = Instance.new("TextLabel", info)
	healthl.Name = "healthlabel"
	healthl.BackgroundTransparency = 1
	healthl.TextStrokeTransparency = 0
	healthl.TextXAlignment = Enum.TextXAlignment.Left
	healthl.Size = UDim2.new(0,100,0,18)
	healthl.Position = UDim2.new(0,0,0,36)

	local uill = Instance.new("UIListLayout", info)

	local forhealth = Instance.new("BillboardGui", bbg)
	forhealth.Name = "forhealth"
	forhealth.Size = UDim2.new(4.5,0,6,0)
	forhealth.AlwaysOnTop = true
	forhealth.ClipsDescendants = false
	forhealth.Enabled = false

	local healthbar = Instance.new("Frame", forhealth)
	healthbar.Name = "healthbar"
	healthbar.BackgroundColor3 = Color3.fromRGB(40,40,40)
	healthbar.BorderColor3 = Color3.fromRGB(0,0,0)
	healthbar.Size = UDim2.new(0.04,0,0.9,0)
	healthbar.Position = UDim2.new(0,0,0.05,0)
	local bar = Instance.new("Frame", healthbar)
	bar.Name = "bar"
	bar.BorderSizePixel = 0
	bar.BackgroundColor3 = Color3.fromRGB(94,255,69)
	bar.AnchorPoint = Vector2.new(0,1)
	bar.Position = UDim2.new(0,0,1,0)
	bar.Size = UDim2.new(1,0,1,0)

	-- Made By Mick Gordon
	local co = coroutine.create(function()
		while wait(0.1) do
			if player ~= PLAYER and player and player.Character and player.Character.FindFirstChild(player.Character, "Humanoid") and player.Character.Humanoid.Health > 0 then
				bbg.Adornee = player.Character.HumanoidRootPart
				info.Adornee = player.Character.HumanoidRootPart
				forhealth.Adornee = player.Character.HumanoidRootPart

				if DeleteMob.ESP.Box.Box == true then
					outlines.Visible = true
				else
					outlines.Visible = false
				end

				outlines.BackgroundTransparency = 1

				if DeleteMob.ESP.Box.Health == true then
					if player.Character:FindFirstChild("Humanoid") ~= nil then
						healthl.Text = "Health: "..math.floor(player.Character:FindFirstChild"Humanoid".Health)
						healthbar.bar.Size = UDim2.new(1,0,player.Character:FindFirstChild"Humanoid".Health/player.Character:FindFirstChild"Humanoid".MaxHealth,0)
					end
					if DeleteMob.ESP.Box.HealthType == "Text" then
						healthbar.Visible = false
						healthl.Visible = true
					end-- Made By Mick Gordon
					if DeleteMob.ESP.Box.HealthType == "Bar" then
						healthl.Visible = false
						healthbar.Visible = true
					end
					if DeleteMob.ESP.Box.HealthType == "Both" then
						healthl.Visible = true
						healthbar.Visible = true
					end
				else
					healthl.Visible = false
					healthbar.Visible = false
				end


				if DeleteMob.ESP.Box.Name then
					namelabel.Visible = true
				else
					namelabel.Visible = false
				end

				-- Made By Mick Gordon
				if DeleteMob.ESP.Box.Distance == true then
					distancel.Visible = true
					if PLAYER.Character and PLAYER.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						distancel.Text = "Distance: "..math.floor(0.5+(PLAYER.Character:FindFirstChild"HumanoidRootPart".Position - player.Character:FindFirstChild"HumanoidRootPart".Position).magnitude)
					end
				else
					distancel.Visible = false
				end


				if DeleteMob.ESP.Box.TeamCheck == true and player.TeamColor == PLAYER.TeamColor then
					bbg.Enabled = false
					info.Enabled = false
					forhealth.Enabled = false
				else
					bbg.Enabled = true
					info.Enabled = true
					forhealth.Enabled = true
				end
				-- Made By Mick Gordon

				if DeleteMob.ESP.Box.TeamColor == true then
					left.BackgroundColor3 = player.TeamColor.Color
					right.BackgroundColor3 = player.TeamColor.Color
					up.BackgroundColor3 = player.TeamColor.Color
					down.BackgroundColor3 = player.TeamColor.Color
					outlines.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
				else
					outlines.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
					left.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
					right.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
					up.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
					down.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
					healthl.TextColor3 = DeleteMob.ESP.Box.BoxColor
					distancel.TextColor3 = DeleteMob.ESP.Box.BoxColor
					namelabel.TextColor3 = DeleteMob.ESP.Box.BoxColor
				end

				if not (game:GetService"Players":FindFirstChild(player.Name)) then
					BoxC:FindFirstChild(player.Name):Destroy()
					coroutine.yield()
				end-- Made By Mick Gordon
			else
				bbg.Enabled = false
				bbg.Adornee = nil
				info.Adornee = nil
				info.Enabled = false
				forhealth.Adornee = nil
				forhealth.Enabled = false
			end
		end 
	end)
	coroutine.resume(co)
end


local function AddTracers(Player) -- Tracers Without Lib OMG !!!!
	local tracer = Instance.new("Frame") -- Idk What I Was Smoking When Making This Scrip Hub, It Is Shit And I Will Remake Later 
	tracer.Parent = TracersG
	tracer.Name = Player.Name
	tracer.Active = false
	tracer.AnchorPoint = Vector2.new(.5, .5)
	tracer.Visible = false

	local co = coroutine.create(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if Player ~= PLAYER and Player and Player.Character and Player.Character.FindFirstChild(Player.Character, "Humanoid") and Player.Character.Humanoid.Health > 0 then
				local TargetPart = Player.Character:FindFirstChild("HumanoidRootPart")
				local ScreenPoint, OnScreen = CurrentCam:WorldToScreenPoint(TargetPart.Position)
				local distance 
				-- Made By Mick Gordon
				distance = math.floor(0.5+(game.Workspace.CurrentCamera.CFrame.Position - Player.Character:WaitForChild("HumanoidRootPart").Position).magnitude)

				local screenpointmain = Vector2.new(ScreenPoint.X, ScreenPoint.Y + (2500 / distance)) --  / distance so it can be at the bottom of the box.
				local posd = UIS:GetMouseLocation()
				local MouseOrigin = Vector2.new(posd.X, posd.Y - 36)
				local Origin = Vector2.new(CurrentCam.ViewportSize.X/2, CurrentCam.ViewportSize.Y - 1)
				local Position = (Origin + screenpointmain) / 2
				local Length = (Origin - screenpointmain).Magnitude
				tracer.Rotation = math.deg(math.atan2(screenpointmain.Y - Origin.Y, screenpointmain.X - Origin.X))


				Position = (Origin + screenpointmain) / 2
				Length = (Origin - screenpointmain).Magnitude
				tracer.Rotation = math.deg(math.atan2(screenpointmain.Y - Origin.Y, screenpointmain.X - Origin.X))


				if OnScreen then
					if DeleteMob.ESP.Tracers.Enabled == true and OnScreen then
						if DeleteMob.ESP.Tracers.TeamCheck == true then
							if Player.TeamColor == PLAYER.TeamColor then
								tracer.Visible = false
							else
								tracer.Visible = true
							end
						else -- Made By Mick Gordon
							tracer.Visible = true
						end
					else
						tracer.Visible = false
					end-- Made By Mick Gordon

					if DeleteMob.ESP.Tracers.TeamColor == true then
						tracer.BackgroundColor3 = Player.TeamColor.Color
					else
						tracer.BackgroundColor3 = DeleteMob.ESP.Tracers.Color
					end

					tracer.BorderColor3 = Color3.fromRGB(27, 42, 53)
					tracer.Position = UDim2.new(0, Position.X, 0, Position.Y)
					tracer.Size = UDim2.new(0, Length, 0, 2)
				else
					tracer.Visible = false
				end

				if not (game:GetService"Players":FindFirstChild(Player.Name)) then
					Fov:FindFirstChild(Player.Name):Destroy()
					coroutine.yield()
				end
			else
				tracer.Visible = false
			end
		end)
	end)
	coroutine.resume(co)-- Made By Mick Gordon
end

function isVisible(p, ...)
	
	if not (DeleteMob.Aimbot.WallCheck == true) then
		return true
	end
	
	return #CurrentCam:GetPartsObscuringTarget({ p }, { CurrentCam, PLAYER.Character, ... }) == 0 
end-- Made By Mick Gordon

function CameraGetClosestToMouse(Fov)
	local AimFov = Fov
	local targetPos = nil

	for i,v in pairs (game:GetService("Players"):GetPlayers()) do
		if v ~= PLAYER then
			if DeleteMob.Aimbot.TeamCheck == true then
				if v.Character and v.Character:FindFirstChild(DeleteMob.Aimbot.AimPart) and v.Character.Humanoid and v.Character.Humanoid.Health > 0 and not (v.Team == PLAYER.Team) then
					local screen_pos, on_screen = WorldToViewportPoint(CurrentCam, v.Character[DeleteMob.Aimbot.AimPart].Position)
					local screen_pos_2D = Vector2.new(screen_pos.X, screen_pos.Y)
					local new_magnitude = (screen_pos_2D - mouseLocation(UIS)).Magnitude
					if on_screen and new_magnitude < AimFov and isVisible(v.Character[DeleteMob.Aimbot.AimPart].Position, v.Character.Head.Parent) then
						AimFov = new_magnitude
						targetPos = v-- Made By Mick Gordon
					end
				end-- Made By Mick Gordon
			else
				if v.Character and v.Character:FindFirstChild(DeleteMob.Aimbot.AimPart) and v.Character.Humanoid and v.Character.Humanoid.Health > 0 then
					local screen_pos, on_screen = WorldToViewportPoint(CurrentCam, v.Character[DeleteMob.Aimbot.AimPart].Position)
					local screen_pos_2D = Vector2.new(screen_pos.X, screen_pos.Y)
					local new_magnitude = (screen_pos_2D - mouseLocation(UIS)).Magnitude
					if on_screen and new_magnitude < AimFov and isVisible(v.Character[DeleteMob.Aimbot.AimPart].Position, v.Character.Head.Parent) then
						AimFov = new_magnitude
						targetPos = v
					end
				end
			end
		end
	end
	return targetPos
end


local function aimAt(pos, smooth)
	local AimPart = pos.Character:FindFirstChild(DeleteMob.Aimbot.AimPart)
	if AimPart then
		local LookAt = nil
		local Distance = math.floor(0.5+(PLAYER.Character:FindFirstChild"HumanoidRootPart".Position - pos.Character:FindFirstChild"HumanoidRootPart".Position).magnitude)
		if Distance > 100  then
			local distChangeBig = Distance / 10
			LookAt = CurrentCam.CFrame:PointToWorldSpace(Vector3.new(0,0,-smooth * distChangeBig)):Lerp(AimPart.Position,.01) -- No one esle do camera smoothing ? tf
		else-- Made By Mick Gordon
			local distChangeSmall = Distance / 10
			LookAt = CurrentCam.CFrame:PointToWorldSpace(Vector3.new(0,0,-smooth * distChangeSmall)):Lerp(AimPart.Position,.01) -- No one esle do camera smoothing ? tf
		end
		CurrentCam.CFrame = CFrame.lookAt(CurrentCam.CFrame.Position, LookAt)
	end
end

-- Cant Be Botherd To Clean This Up
local CheatEngineDeleteMob = Instance.new("ScreenGui")
local DeleteMobF = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local Name = Instance.new("TextLabel")
local Line = Instance.new("Frame")
local Line_2 = Instance.new("Frame")
local AimBotSection = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ABE = Instance.new("TextButton")
local ABWC = Instance.new("TextButton")
local ABTC = Instance.new("TextButton")
local ABSF = Instance.new("TextButton")
local Frame = Instance.new("Frame")
local Slider3 = Instance.new("Frame")-- Made By Mick Gordon
local UICorner = Instance.new("UICorner")
local Fill1 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local TriggerFov = Instance.new("TextButton")
local Numbers = Instance.new("TextLabel")
local TextLabel = Instance.new("TextLabel")
local Frame_2 = Instance.new("Frame")
local Slider4 = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local Fill2 = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local UIGradient_2 = Instance.new("UIGradient")
local TriggerSmoothing = Instance.new("TextButton")-- Made By Mick Gordon
local Numbers_2 = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local Allways_Show = Instance.new("TextButton")
local TextLabel_4 = Instance.new("TextLabel")
local ESPSection = Instance.new("Frame")
local UIListLayout_2 = Instance.new("UIListLayout")
local BBE = Instance.new("TextButton")
local BTC = Instance.new("TextButton")
local BBN = Instance.new("TextButton")
local BBD = Instance.new("TextButton")
local BBH = Instance.new("TextButton")
local TextLabel_5 = Instance.new("TextLabel")
local BBHT = Instance.new("TextButton")
local TextLabel_6 = Instance.new("TextLabel")
local TextLabel_7 = Instance.new("TextLabel")
local Frame_3 = Instance.new("Frame")
local UIListLayout_3 = Instance.new("UIListLayout")
local Box_R = Instance.new("TextBox")
local Box_G = Instance.new("TextBox")
local Box_B = Instance.new("TextBox")
local TextLabel_8 = Instance.new("TextLabel")
local ESPSection_2 = Instance.new("Frame")
local UIListLayout_4 = Instance.new("UIListLayout")
local OE = Instance.new("TextButton")
local OTC = Instance.new("TextButton")-- Made By Mick Gordon
local Frame_4 = Instance.new("Frame")
local Slider1 = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local Fill3 = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local UIGradient_3 = Instance.new("UIGradient")
local TriggerOutTans = Instance.new("TextButton")
local Numbers_3 = Instance.new("TextLabel")
local TextLabel_9 = Instance.new("TextLabel")
local Frame_5 = Instance.new("Frame")
local Slider2 = Instance.new("Frame")
local UICorner_7 = Instance.new("UICorner")
local Fill4 = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local UIGradient_4 = Instance.new("UIGradient")
local TriggerFill = Instance.new("TextButton")
local Numbers_4 = Instance.new("TextLabel")
local TextLabel_10 = Instance.new("TextLabel")
local TextLabel_11 = Instance.new("TextLabel")
local Frame_6 = Instance.new("Frame")
local UIListLayout_5 = Instance.new("UIListLayout")
local Outlines_R = Instance.new("TextBox")
local Outlines_G = Instance.new("TextBox")
local Outlines_B = Instance.new("TextBox")
local TextLabel_12 = Instance.new("TextLabel")
local Frame_7 = Instance.new("Frame")
local UIListLayout_6 = Instance.new("UIListLayout")
local FillOutlines_R = Instance.new("TextBox")
local FillOutlines_G = Instance.new("TextBox")
local FillOutlines_B = Instance.new("TextBox")
local Tracerssection = Instance.new("Frame")
local UIListLayout_7 = Instance.new("UIListLayout")
local TE = Instance.new("TextButton")
local TTC = Instance.new("TextButton")
local TTCOlor = Instance.new("TextButton")
local Frame_8 = Instance.new("Frame")
local UIListLayout_8 = Instance.new("UIListLayout")
local Tracers_R = Instance.new("TextBox")
local Tracers_G = Instance.new("TextBox")
local Tracers_B = Instance.new("TextBox")-- Made By Mick Gordon
local Unknown = Instance.new("Frame")
local UIListLayout_9 = Instance.new("UIListLayout")
local TextLabel_13 = Instance.new("TextLabel")
local TextLabel_14 = Instance.new("TextLabel")
local Open = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

--Properties:

CheatEngineDeleteMob.Name = "CheatEngineDeleteMob"
CheatEngineDeleteMob.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
CheatEngineDeleteMob.Enabled = true
CheatEngineDeleteMob.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CheatEngineDeleteMob.DisplayOrder = 10
CheatEngineDeleteMob.ResetOnSpawn = false
-- Made By Mick Gordon
DeleteMobF.Name = "DeleteMobF"
DeleteMobF.Parent = CheatEngineDeleteMob
DeleteMobF.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
DeleteMobF.BorderColor3 = Color3.fromRGB(255, 255, 255)
DeleteMobF.Position = UDim2.new(0.144998878, 0, 0.328040659, 0)
DeleteMobF.Size = UDim2.new(0, 1213, 0, 398)
DeleteMobF.ZIndex = 10
DeleteMobF.Draggable = true
DeleteMobF.Active = true

TextBox.Parent = DeleteMobF
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.791149139, 0, 0.0127403988, 0)
TextBox.Size = UDim2.new(0, 200, 0, 23)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.Roboto
TextBox.PlaceholderText = "https://discord.gg/FsApQ7YNTq"
TextBox.Text = "https://discord.gg/FsApQ7YNTq - Double Click Me"
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 14.000

Name.Name = "Name"
Name.Parent = DeleteMobF
Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name.BackgroundTransparency = 1.000
Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Name.BorderSizePixel = 0
Name.Position = UDim2.new(0.0178597774, 0, 0.00456260797, 0)
Name.Size = UDim2.new(0, 200, 0, 31)
Name.Font = Enum.Font.Gotham
Name.Text = "DeleteMob | Cheat Engine"
Name.TextColor3 = Color3.fromRGB(17, 223, 255)
Name.TextSize = 19.000

Line.Name = "Line"
Line.Parent = DeleteMobF
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0, 0, 0.0804020092, 0)
Line.Size = UDim2.new(0, 1213, 0, 1)

Line_2.Name = "Line"
Line_2.Parent = DeleteMobF
Line_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Line_2.BorderSizePixel = 0
Line_2.Position = UDim2.new(0.205276027, 0, 0.0828348249, 0)
Line_2.Size = UDim2.new(0, 1, 0, 365)
-- Made By Mick Gordon
AimBotSection.Name = "AimBotSection"
AimBotSection.Parent = DeleteMobF
AimBotSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AimBotSection.BackgroundTransparency = 1.000
AimBotSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
AimBotSection.BorderSizePixel = 0
AimBotSection.Position = UDim2.new(0.0604648069, 0, 0.160724282, 0)
AimBotSection.Size = UDim2.new(0, 100, 0, 334)

UIListLayout.Parent = AimBotSection
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

ABE.Name = "ABE"
ABE.Parent = AimBotSection
ABE.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
ABE.BorderColor3 = Color3.fromRGB(255, 255, 255)
ABE.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
ABE.Size = UDim2.new(0, 164, 0, 29)
ABE.Font = Enum.Font.Gotham
ABE.Text = "Enable"
ABE.TextColor3 = Color3.fromRGB(255, 255, 255)
ABE.TextSize = 16.000

ABWC.Name = "ABWC"
ABWC.Parent = AimBotSection
ABWC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
ABWC.BorderColor3 = Color3.fromRGB(255, 255, 255)
ABWC.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
ABWC.Size = UDim2.new(0, 164, 0, 29)
ABWC.Font = Enum.Font.Gotham
ABWC.Text = "Wall Check"
ABWC.TextColor3 = Color3.fromRGB(255, 255, 255)
ABWC.TextSize = 16.000

ABTC.Name = "ABTC"
ABTC.Parent = AimBotSection
ABTC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
ABTC.BorderColor3 = Color3.fromRGB(255, 255, 255)
ABTC.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
ABTC.Size = UDim2.new(0, 164, 0, 29)
ABTC.Font = Enum.Font.Gotham
ABTC.Text = "Team Check"
ABTC.TextColor3 = Color3.fromRGB(255, 255, 255)
ABTC.TextSize = 16.000

ABSF.Name = "ABSF"
ABSF.Parent = AimBotSection
ABSF.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
ABSF.BorderColor3 = Color3.fromRGB(255, 255, 255)
ABSF.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
ABSF.Size = UDim2.new(0, 164, 0, 29)
ABSF.Font = Enum.Font.Gotham
ABSF.Text = "Show Fov"
ABSF.TextColor3 = Color3.fromRGB(255, 255, 255)
ABSF.TextSize = 16.000

Frame.Parent = AimBotSection
Frame.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Frame.BackgroundTransparency = 0.700
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(-0.550000012, 0, 0.739130437, 0)
Frame.Size = UDim2.new(0, 230, 0, 50)

Slider3.Name = "Slider3"
Slider3.Parent = Frame
Slider3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider3.BorderSizePixel = 0
Slider3.Position = UDim2.new(0.0629399866, 0, 0.45120728, 0)
Slider3.Size = UDim2.new(0, 200, 0, 15)

UICorner.Parent = Slider3

Fill1.Name = "Fill1"
Fill1.Parent = Slider3
Fill1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Fill1.BackgroundTransparency = 0.200
Fill1.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fill1.BorderSizePixel = 0
Fill1.Size = UDim2.new(0, 100, 0, 15)

UICorner_2.Parent = Fill1

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(17, 223, 255)), ColorSequenceKeypoint.new(0.29, Color3.fromRGB(17, 223, 255)), ColorSequenceKeypoint.new(0.43, Color3.fromRGB(18, 218, 249)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(52, 52, 52))}
UIGradient.Parent = Fill1
-- Made By Mick Gordon
TriggerFov.Name = "TriggerFov"
TriggerFov.Parent = Slider3
TriggerFov.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TriggerFov.BackgroundTransparency = 1.000
TriggerFov.BorderColor3 = Color3.fromRGB(0, 0, 0)
TriggerFov.BorderSizePixel = 0
TriggerFov.Size = UDim2.new(1, 0, 1, 0)
TriggerFov.Font = Enum.Font.SourceSans
TriggerFov.Text = ""
TriggerFov.TextColor3 = Color3.fromRGB(0, 0, 0)
TriggerFov.TextSize = 14.000

Numbers.Name = "Numbers"
Numbers.Parent = Frame
Numbers.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Numbers.BackgroundTransparency = 1.000
Numbers.BorderColor3 = Color3.fromRGB(255, 255, 255)
Numbers.BorderSizePixel = 0
Numbers.Position = UDim2.new(0.79130435, 0, 0, 0)
Numbers.Size = UDim2.new(0, 50, 0, 23)
Numbers.Font = Enum.Font.Gotham
Numbers.Text = "350"
Numbers.TextColor3 = Color3.fromRGB(255, 255, 255)
Numbers.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.0608695634, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 50, 0, 23)
TextLabel.Font = Enum.Font.Gotham
TextLabel.Text = "Fov"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000

Frame_2.Parent = AimBotSection
Frame_2.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Frame_2.BackgroundTransparency = 0.700
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(-0.550000012, 0, 0.739130437, 0)
Frame_2.Size = UDim2.new(0, 230, 0, 50)

Slider4.Name = "Slider4"
Slider4.Parent = Frame_2
Slider4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider4.BorderSizePixel = 0
Slider4.Position = UDim2.new(0.0629399866, 0, 0.45120728, 0)
Slider4.Size = UDim2.new(0, 200, 0, 15)

UICorner_3.Parent = Slider4

Fill2.Name = "Fill2"
Fill2.Parent = Slider4
Fill2.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Fill2.BackgroundTransparency = 0.200
Fill2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fill2.BorderSizePixel = 0
Fill2.Size = UDim2.new(0, 0, 0, 15)

UICorner_4.Parent = Fill2

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(17, 223, 255)), ColorSequenceKeypoint.new(0.29, Color3.fromRGB(17, 223, 255)), ColorSequenceKeypoint.new(0.43, Color3.fromRGB(18, 218, 249)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(52, 52, 52))}-- Made By Mick Gordon
UIGradient_2.Parent = Fill2

TriggerSmoothing.Name = "TriggerSmoothing"
TriggerSmoothing.Parent = Slider4
TriggerSmoothing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TriggerSmoothing.BackgroundTransparency = 1.000
TriggerSmoothing.BorderColor3 = Color3.fromRGB(0, 0, 0)
TriggerSmoothing.BorderSizePixel = 0
TriggerSmoothing.Size = UDim2.new(1, 0, 1, 0)
TriggerSmoothing.Font = Enum.Font.SourceSans
TriggerSmoothing.Text = ""
TriggerSmoothing.TextColor3 = Color3.fromRGB(0, 0, 0)
TriggerSmoothing.TextSize = 14.000
-- Made By Mick Gordon
Numbers_2.Name = "Numbers"
Numbers_2.Parent = Frame_2
Numbers_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Numbers_2.BackgroundTransparency = 1.000
Numbers_2.BorderColor3 = Color3.fromRGB(255, 255, 255)
Numbers_2.BorderSizePixel = 0
Numbers_2.Position = UDim2.new(0.79130435, 0, 0, 0)
Numbers_2.Size = UDim2.new(0, 50, 0, 23)
Numbers_2.Font = Enum.Font.Gotham
Numbers_2.Text = "0"
Numbers_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Numbers_2.TextSize = 14.000

TextLabel_2.Parent = Frame_2
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.0608695634, 0, 0, 0)
TextLabel_2.Size = UDim2.new(0, 50, 0, 23)
TextLabel_2.Font = Enum.Font.Gotham
TextLabel_2.Text = "Smoothing"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 14.000

TextLabel_3.Parent = AimBotSection
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.0700000003, 0, 0.20869565, 0)
TextLabel_3.Size = UDim2.new(0, 100, 0, 17)
TextLabel_3.Font = Enum.Font.Gotham
TextLabel_3.Text = "Aim Part"
TextLabel_3.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_3.TextSize = 21.000

Allways_Show.Name = "Allways_Show"
Allways_Show.Parent = AimBotSection
Allways_Show.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Allways_Show.BorderColor3 = Color3.fromRGB(255, 255, 255)
Allways_Show.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
Allways_Show.Size = UDim2.new(0, 164, 0, 29)
Allways_Show.Font = Enum.Font.Gotham
Allways_Show.Text = "HEAD, torso"
Allways_Show.TextColor3 = Color3.fromRGB(255, 255, 255)
Allways_Show.TextSize = 16.000

TextLabel_4.Parent = DeleteMobF
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(0.00569662312, 0, 0.100655407, 0)
TextLabel_4.Size = UDim2.new(0, 100, 0, 17)
TextLabel_4.Font = Enum.Font.Gotham
TextLabel_4.Text = "Aim Bot"
TextLabel_4.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_4.TextSize = 18.000
TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left

ESPSection.Name = "ESPSection"
ESPSection.Parent = DeleteMobF
ESPSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ESPSection.BackgroundTransparency = 1.000
ESPSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
ESPSection.BorderSizePixel = 0
ESPSection.Position = UDim2.new(0.26986298, 0, 0.160724282, 0)
ESPSection.Size = UDim2.new(0, 100, 0, 334)
-- Made By Mick Gordon
UIListLayout_2.Parent = ESPSection
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0, 5)

BBE.Name = "BBE"
BBE.Parent = ESPSection
BBE.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
BBE.BorderColor3 = Color3.fromRGB(255, 255, 255)
BBE.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
BBE.Size = UDim2.new(0, 164, 0, 29)
BBE.Font = Enum.Font.Gotham
BBE.Text = "Box"
BBE.TextColor3 = Color3.fromRGB(255, 255, 255)
BBE.TextSize = 16.000

BBN.Name = "BBN"
BBN.Parent = ESPSection
BBN.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
BBN.BorderColor3 = Color3.fromRGB(255, 255, 255)
BBN.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
BBN.Size = UDim2.new(0, 164, 0, 29)
BBN.Font = Enum.Font.Gotham
BBN.Text = "Name"
BBN.TextColor3 = Color3.fromRGB(255, 255, 255)
BBN.TextSize = 16.000
-- Made By Mick Gordon
BBD.Name = "BBD"
BBD.Parent = ESPSection
BBD.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
BBD.BorderColor3 = Color3.fromRGB(255, 255, 255)
BBD.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
BBD.Size = UDim2.new(0, 164, 0, 29)
BBD.Font = Enum.Font.Gotham
BBD.Text = "Distance"
BBD.TextColor3 = Color3.fromRGB(255, 255, 255)
BBD.TextSize = 16.000

BBH.Name = "BBH"
BBH.Parent = ESPSection
BBH.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
BBH.BorderColor3 = Color3.fromRGB(255, 255, 255)
BBH.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
BBH.Size = UDim2.new(0, 164, 0, 29)
BBH.Font = Enum.Font.Gotham
BBH.Text = "Health"
BBH.TextColor3 = Color3.fromRGB(255, 255, 255)
BBH.TextSize = 16.000

BTC.Name = "BBE"
BTC.Parent = ESPSection
BTC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
BTC.BorderColor3 = Color3.fromRGB(255, 255, 255)
BTC.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
BTC.Size = UDim2.new(0, 164, 0, 29)
BTC.Font = Enum.Font.Gotham
BTC.Text = "Team Check"
BTC.TextColor3 = Color3.fromRGB(255, 255, 255)
BTC.TextSize = 16.000

TextLabel_5.Parent = ESPSection
TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.BackgroundTransparency = 1.000
TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.BorderSizePixel = 0
TextLabel_5.Position = UDim2.new(0.0700000003, 0, 0.20869565, 0)
TextLabel_5.Size = UDim2.new(0, 100, 0, 17)
TextLabel_5.Font = Enum.Font.Gotham
TextLabel_5.Text = "Health Type"
TextLabel_5.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_5.TextSize = 21.000
-- Made By Mick Gordon
BBHT.Name = "BBHT"
BBHT.Parent = ESPSection
BBHT.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
BBHT.BorderColor3 = Color3.fromRGB(255, 255, 255)
BBHT.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
BBHT.Size = UDim2.new(0, 164, 0, 29)
BBHT.Font = Enum.Font.Gotham
BBHT.Text = "BAR, text, both"
BBHT.TextColor3 = Color3.fromRGB(255, 255, 255)
BBHT.TextSize = 16.000

TextLabel_6.Parent = ESPSection
TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.BackgroundTransparency = 1.000
TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_6.BorderSizePixel = 0-- Made By Mick Gordon
TextLabel_6.Position = UDim2.new(0.0700000003, 0, 0.20869565, 0)
TextLabel_6.Size = UDim2.new(0, 100, 0, 17)
TextLabel_6.Font = Enum.Font.Gotham
TextLabel_6.Text = "Box Color"
TextLabel_6.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_6.TextSize = 21.000

TextLabel_7.Parent = ESPSection
TextLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.BackgroundTransparency = 1.000
TextLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_7.BorderSizePixel = 0
TextLabel_7.Position = UDim2.new(0.0700000003, 0, 0.20869565, 0)
TextLabel_7.Size = UDim2.new(0, 100, 0, 17)
TextLabel_7.Font = Enum.Font.Gotham
TextLabel_7.Text = "R,G,B"
TextLabel_7.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_7.TextSize = 21.000

Frame_3.Parent = ESPSection
Frame_3.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0.0909090936, 0, 0.600000739, 0)
Frame_3.Size = UDim2.new(0, 100, 0, 30)

UIListLayout_3.Parent = Frame_3
UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout_3.Padding = UDim.new(0, 5)

Box_R.Name = "Box_R"
Box_R.Parent = Frame_3
Box_R.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Box_R.BorderColor3 = Color3.fromRGB(255, 255, 255)
Box_R.Size = UDim2.new(0, 75, 0, 24)
Box_R.ClearTextOnFocus = false
Box_R.Font = Enum.Font.Gotham
Box_R.PlaceholderText = "255 - 0"
Box_R.Text = "75"
Box_R.TextColor3 = Color3.fromRGB(255, 255, 255)
Box_R.TextSize = 14.000

Box_G.Name = "Box_G"
Box_G.Parent = Frame_3
Box_G.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Box_G.BorderColor3 = Color3.fromRGB(255, 255, 255)
Box_G.Size = UDim2.new(0, 75, 0, 24)
Box_G.ClearTextOnFocus = false
Box_G.Font = Enum.Font.Gotham
Box_G.PlaceholderText = "255 - 0"
Box_G.Text = "0" 
Box_G.TextColor3 = Color3.fromRGB(255, 255, 255)
Box_G.TextSize = 14.000
-- Made By Mick Gordon
Box_B.Name = "Box_B"
Box_B.Parent = Frame_3
Box_B.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Box_B.BorderColor3 = Color3.fromRGB(255, 255, 255)
Box_B.Size = UDim2.new(0, 75, 0, 24)
Box_B.ClearTextOnFocus = false
Box_B.Font = Enum.Font.Gotham
Box_B.PlaceholderText = "255 - 0"
Box_B.Text = "10"
Box_B.TextColor3 = Color3.fromRGB(255, 255, 255)
Box_B.TextSize = 14.000

TextLabel_8.Parent = DeleteMobF
TextLabel_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_8.BackgroundTransparency = 1.000
TextLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_8.BorderSizePixel = 0
TextLabel_8.Position = UDim2.new(0.215919182, 0, 0.100655407, 0)
TextLabel_8.Size = UDim2.new(0, 100, 0, 17)
TextLabel_8.Font = Enum.Font.Gotham
TextLabel_8.Text = "ESP"
TextLabel_8.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_8.TextSize = 18.000
TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left

ESPSection_2.Name = "ESPSection"
ESPSection_2.Parent = DeleteMobF
ESPSection_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ESPSection_2.BackgroundTransparency = 1.000
ESPSection_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ESPSection_2.BorderSizePixel = 0
ESPSection_2.Position = UDim2.new(0.475963563, 0, 0.160724282, 0)
ESPSection_2.Size = UDim2.new(0, 100, 0, 334)

UIListLayout_4.Parent = ESPSection_2
UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_4.Padding = UDim.new(0, 5)

OE.Name = "OE"
OE.Parent = ESPSection_2
OE.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
OE.BorderColor3 = Color3.fromRGB(255, 255, 255)
OE.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
OE.Size = UDim2.new(0, 164, 0, 29)
OE.Font = Enum.Font.Gotham
OE.Text = "Outlines"
OE.TextColor3 = Color3.fromRGB(255, 255, 255)
OE.TextSize = 16.000

OTC.Name = "OTC"
OTC.Parent = ESPSection_2
OTC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
OTC.BorderColor3 = Color3.fromRGB(255, 255, 255)
OTC.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
OTC.Size = UDim2.new(0, 164, 0, 29)
OTC.Font = Enum.Font.Gotham
OTC.Text = "Team Check"
OTC.TextColor3 = Color3.fromRGB(255, 255, 255)
OTC.TextSize = 16.000

Frame_4.Parent = ESPSection_2
Frame_4.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Frame_4.BackgroundTransparency = 0.700
Frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(-0.550000012, 0, 0.739130437, 0)
Frame_4.Size = UDim2.new(0, 230, 0, 50)

Slider1.Name = "Slider1"
Slider1.Parent = Frame_4
Slider1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider1.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider1.BorderSizePixel = 0
Slider1.Position = UDim2.new(0.0629399866, 0, 0.45120728, 0)
Slider1.Size = UDim2.new(0, 200, 0, 15)

UICorner_5.Parent = Slider1

Fill3.Name = "Fill3"
Fill3.Parent = Slider1
Fill3.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Fill3.BackgroundTransparency = 0.200
Fill3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fill3.BorderSizePixel = 0
Fill3.Size = UDim2.new(0, 100, 0, 15)
-- Made By Mick Gordon
UICorner_6.Parent = Fill3

UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(17, 223, 255)), ColorSequenceKeypoint.new(0.29, Color3.fromRGB(17, 223, 255)), ColorSequenceKeypoint.new(0.43, Color3.fromRGB(18, 218, 249)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(52, 52, 52))}
UIGradient_3.Parent = Fill3

TriggerOutTans.Name = "TriggerOutTans"
TriggerOutTans.Parent = Slider1
TriggerOutTans.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TriggerOutTans.BackgroundTransparency = 1.000
TriggerOutTans.BorderColor3 = Color3.fromRGB(0, 0, 0)
TriggerOutTans.BorderSizePixel = 0
TriggerOutTans.Size = UDim2.new(1, 0, 1, 0)
TriggerOutTans.Font = Enum.Font.SourceSans
TriggerOutTans.Text = ""
TriggerOutTans.TextColor3 = Color3.fromRGB(0, 0, 0)
TriggerOutTans.TextSize = 14.000

Numbers_3.Name = "Numbers"
Numbers_3.Parent = Frame_4
Numbers_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Numbers_3.BackgroundTransparency = 1.000
Numbers_3.BorderColor3 = Color3.fromRGB(255, 255, 255)
Numbers_3.BorderSizePixel = 0
Numbers_3.Position = UDim2.new(0.79130435, 0, 0, 0)
Numbers_3.Size = UDim2.new(0, 50, 0, 23)
Numbers_3.Font = Enum.Font.Gotham
Numbers_3.Text = "50"
Numbers_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Numbers_3.TextSize = 14.000

TextLabel_9.Parent = Frame_4
TextLabel_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_9.BackgroundTransparency = 1.000
TextLabel_9.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_9.BorderSizePixel = 0
TextLabel_9.Position = UDim2.new(0.0608695634, 0, 0, 0)
TextLabel_9.Size = UDim2.new(0, 125, 0, 23)
TextLabel_9.Font = Enum.Font.Gotham
TextLabel_9.Text = "Outlines Transparency"
TextLabel_9.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_9.TextSize = 14.000

Frame_5.Parent = ESPSection_2
Frame_5.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Frame_5.BackgroundTransparency = 0.700
Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_5.BorderSizePixel = 0
Frame_5.Position = UDim2.new(-0.550000012, 0, 0.739130437, 0)
Frame_5.Size = UDim2.new(0, 230, 0, 50)

Slider2.Name = "Slider2"
Slider2.Parent = Frame_5
Slider2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider2.BorderSizePixel = 0
Slider2.Position = UDim2.new(0.0629399866, 0, 0.45120728, 0)
Slider2.Size = UDim2.new(0, 200, 0, 15)

UICorner_7.Parent = Slider2

Fill4.Name = "Fill4"
Fill4.Parent = Slider2
Fill4.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Fill4.BackgroundTransparency = 0.200
Fill4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fill4.BorderSizePixel = 0
Fill4.Size = UDim2.new(0, 100, 0, 15)
-- Made By Mick Gordon
UICorner_8.Parent = Fill4

UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(17, 223, 255)), ColorSequenceKeypoint.new(0.29, Color3.fromRGB(17, 223, 255)), ColorSequenceKeypoint.new(0.43, Color3.fromRGB(18, 218, 249)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(52, 52, 52))}
UIGradient_4.Parent = Fill4

TriggerFill.Name = "TriggerFill"
TriggerFill.Parent = Slider2
TriggerFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TriggerFill.BackgroundTransparency = 1.000
TriggerFill.BorderColor3 = Color3.fromRGB(0, 0, 0)
TriggerFill.BorderSizePixel = 0
TriggerFill.Size = UDim2.new(1, 0, 1, 0)
TriggerFill.Font = Enum.Font.SourceSans
TriggerFill.Text = ""
TriggerFill.TextColor3 = Color3.fromRGB(0, 0, 0)
TriggerFill.TextSize = 14.000

Numbers_4.Name = "Numbers"
Numbers_4.Parent = Frame_5
Numbers_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Numbers_4.BackgroundTransparency = 1.000
Numbers_4.BorderColor3 = Color3.fromRGB(255, 255, 255)
Numbers_4.BorderSizePixel = 0
Numbers_4.Position = UDim2.new(0.79130435, 0, 0, 0)
Numbers_4.Size = UDim2.new(0, 50, 0, 23)
Numbers_4.Font = Enum.Font.Gotham
Numbers_4.Text = "50"
Numbers_4.TextColor3 = Color3.fromRGB(255, 255, 255)
Numbers_4.TextSize = 14.000

TextLabel_10.Parent = Frame_5
TextLabel_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_10.BackgroundTransparency = 1.000
TextLabel_10.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_10.BorderSizePixel = 0
TextLabel_10.Position = UDim2.new(0.104347825, 0, 0, 0)
TextLabel_10.Size = UDim2.new(0, 133, 0, 23)
TextLabel_10.Font = Enum.Font.Gotham
TextLabel_10.Text = "Fill Outlines Transparency"
TextLabel_10.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_10.TextSize = 14.000
-- Made By Mick Gordon
TextLabel_11.Parent = ESPSection_2
TextLabel_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_11.BackgroundTransparency = 1.000
TextLabel_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_11.BorderSizePixel = 0
TextLabel_11.Position = UDim2.new(0.0700000003, 0, 0.20869565, 0)
TextLabel_11.Size = UDim2.new(0, 100, 0, 17)
TextLabel_11.Font = Enum.Font.Gotham
TextLabel_11.Text = "Outlines"
TextLabel_11.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_11.TextSize = 21.000

Frame_6.Parent = ESPSection_2
Frame_6.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_6.BorderSizePixel = 0
Frame_6.Position = UDim2.new(0.0909090936, 0, 0.600000739, 0)
Frame_6.Size = UDim2.new(0, 100, 0, 30)

UIListLayout_5.Parent = Frame_6
UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_5.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout_5.Padding = UDim.new(0, 5)

Outlines_R.Name = "Outlines_R"
Outlines_R.Parent = Frame_6
Outlines_R.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Outlines_R.BorderColor3 = Color3.fromRGB(255, 255, 255)
Outlines_R.Size = UDim2.new(0, 75, 0, 24)
Outlines_R.ClearTextOnFocus = false
Outlines_R.Font = Enum.Font.Gotham
Outlines_R.PlaceholderText = "255 - 0"
Outlines_R.Text = "255"
Outlines_R.TextColor3 = Color3.fromRGB(255, 255, 255)
Outlines_R.TextSize = 14.000

Outlines_G.Name = "Outlines_G"
Outlines_G.Parent = Frame_6
Outlines_G.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Outlines_G.BorderColor3 = Color3.fromRGB(255, 255, 255)
Outlines_G.Size = UDim2.new(0, 75, 0, 24)
Outlines_G.ClearTextOnFocus = false
Outlines_G.Font = Enum.Font.Gotham
Outlines_G.PlaceholderText = "255 - 0"
Outlines_G.Text = "255"
Outlines_G.TextColor3 = Color3.fromRGB(255, 255, 255)
Outlines_G.TextSize = 14.000

Outlines_B.Name = "Outlines_B"
Outlines_B.Parent = Frame_6
Outlines_B.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Outlines_B.BorderColor3 = Color3.fromRGB(255, 255, 255)
Outlines_B.Size = UDim2.new(0, 75, 0, 24)
Outlines_B.ClearTextOnFocus = false
Outlines_B.Font = Enum.Font.Gotham
Outlines_B.PlaceholderText = "255 - 0"
Outlines_B.Text = "255"
Outlines_B.TextColor3 = Color3.fromRGB(255, 255, 255)
Outlines_B.TextSize = 14.000
-- Made By Mick Gordon
TextLabel_12.Parent = ESPSection_2
TextLabel_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_12.BackgroundTransparency = 1.000
TextLabel_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_12.BorderSizePixel = 0
TextLabel_12.Position = UDim2.new(0.0700000003, 0, 0.20869565, 0)
TextLabel_12.Size = UDim2.new(0, 100, 0, 17)
TextLabel_12.Font = Enum.Font.Gotham
TextLabel_12.Text = "Fill Outlines"
TextLabel_12.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_12.TextSize = 21.000

Frame_7.Parent = ESPSection_2
Frame_7.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Frame_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_7.BorderSizePixel = 0
Frame_7.Position = UDim2.new(0.0909090936, 0, 0.600000739, 0)
Frame_7.Size = UDim2.new(0, 100, 0, 30)

UIListLayout_6.Parent = Frame_7
UIListLayout_6.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_6.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout_6.Padding = UDim.new(0, 5)

FillOutlines_R.Name = "FillOutlines_R"
FillOutlines_R.Parent = Frame_7
FillOutlines_R.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
FillOutlines_R.BorderColor3 = Color3.fromRGB(255, 255, 255)
FillOutlines_R.Size = UDim2.new(0, 75, 0, 24)
FillOutlines_R.ClearTextOnFocus = false
FillOutlines_R.Font = Enum.Font.Gotham
FillOutlines_R.PlaceholderText = "255 - 0"
FillOutlines_R.Text = "255"
FillOutlines_R.TextColor3 = Color3.fromRGB(255, 255, 255)
FillOutlines_R.TextSize = 14.000

FillOutlines_G.Name = "FillOutlines_G"
FillOutlines_G.Parent = Frame_7
FillOutlines_G.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
FillOutlines_G.BorderColor3 = Color3.fromRGB(255, 255, 255)
FillOutlines_G.Size = UDim2.new(0, 75, 0, 24)
FillOutlines_G.ClearTextOnFocus = false
FillOutlines_G.Font = Enum.Font.Gotham
FillOutlines_G.PlaceholderText = "255 - 0"
FillOutlines_G.Text = "255"
FillOutlines_G.TextColor3 = Color3.fromRGB(255, 255, 255)
FillOutlines_G.TextSize = 14.000

FillOutlines_B.Name = "FillOutlines_B"
FillOutlines_B.Parent = Frame_7
FillOutlines_B.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
FillOutlines_B.BorderColor3 = Color3.fromRGB(255, 255, 255)
FillOutlines_B.Size = UDim2.new(0, 75, 0, 24)
FillOutlines_B.ClearTextOnFocus = false
FillOutlines_B.Font = Enum.Font.Gotham
FillOutlines_B.PlaceholderText = "255 - 0"
FillOutlines_B.Text = "255"
FillOutlines_B.TextColor3 = Color3.fromRGB(255, 255, 255)
FillOutlines_B.TextSize = 14.000
-- Made By Mick Gordon
Tracerssection.Name = "Tracers section"
Tracerssection.Parent = DeleteMobF
Tracerssection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tracerssection.BackgroundTransparency = 1.000
Tracerssection.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tracerssection.BorderSizePixel = 0
Tracerssection.Position = UDim2.new(0.682779849, 0, 0.158000082, 0)
Tracerssection.Size = UDim2.new(0, 100, 0, 334)

UIListLayout_7.Parent = Tracerssection
UIListLayout_7.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_7.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_7.Padding = UDim.new(0, 5)

TE.Name = "TE"
TE.Parent = Tracerssection
TE.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
TE.BorderColor3 = Color3.fromRGB(255, 255, 255)
TE.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
TE.Size = UDim2.new(0, 164, 0, 29)
TE.Font = Enum.Font.Gotham
TE.Text = "Tracers"
TE.TextColor3 = Color3.fromRGB(255, 255, 255)
TE.TextSize = 16.000

TTC.Name = "TTC"
TTC.Parent = Tracerssection
TTC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
TTC.BorderColor3 = Color3.fromRGB(255, 255, 255)
TTC.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
TTC.Size = UDim2.new(0, 164, 0, 29)
TTC.Font = Enum.Font.Gotham
TTC.Text = "Team Check"
TTC.TextColor3 = Color3.fromRGB(255, 255, 255)
TTC.TextSize = 16.000

TTCOlor.Name = "TTCOlor"
TTCOlor.Parent = Tracerssection
TTCOlor.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
TTCOlor.BorderColor3 = Color3.fromRGB(255, 255, 255)
TTCOlor.Position = UDim2.new(0.234439835, 0, 0.139479905, 0)
TTCOlor.Size = UDim2.new(0, 164, 0, 29)
TTCOlor.Font = Enum.Font.Gotham
TTCOlor.Text = "Team Color"
TTCOlor.TextColor3 = Color3.fromRGB(255, 255, 255)
TTCOlor.TextSize = 16.000

Frame_8.Parent = Tracerssection
Frame_8.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Frame_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_8.BorderSizePixel = 0
Frame_8.Position = UDim2.new(0.0909090936, 0, 0.600000739, 0)
Frame_8.Size = UDim2.new(0, 100, 0, 40)

UIListLayout_8.Parent = Frame_8
UIListLayout_8.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_8.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_8.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_8.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout_8.Padding = UDim.new(0, 5)

Tracers_R.Name = "Tracers_R"
Tracers_R.Parent = Frame_8
Tracers_R.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Tracers_R.BorderColor3 = Color3.fromRGB(255, 255, 255)
Tracers_R.Size = UDim2.new(0, 75, 0, 24)
Tracers_R.ClearTextOnFocus = false
Tracers_R.Font = Enum.Font.Gotham
Tracers_R.PlaceholderText = "255 - 0"
Tracers_R.Text = "75" 
Tracers_R.TextColor3 = Color3.fromRGB(255, 255, 255)
Tracers_R.TextSize = 14.000

Tracers_G.Name = "Tracers_G"
Tracers_G.Parent = Frame_8
Tracers_G.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Tracers_G.BorderColor3 = Color3.fromRGB(255, 255, 255)
Tracers_G.Size = UDim2.new(0, 75, 0, 24)
Tracers_G.ClearTextOnFocus = false
Tracers_G.Font = Enum.Font.Gotham
Tracers_G.PlaceholderText = "255 - 0"
Tracers_G.Text = "0"
Tracers_G.TextColor3 = Color3.fromRGB(255, 255, 255)
Tracers_G.TextSize = 14.000

Tracers_B.Name = "Tracers_B"
Tracers_B.Parent = Frame_8
Tracers_B.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
Tracers_B.BorderColor3 = Color3.fromRGB(255, 255, 255)
Tracers_B.Size = UDim2.new(0, 75, 0, 24)
Tracers_B.ClearTextOnFocus = false
Tracers_B.Font = Enum.Font.Gotham
Tracers_B.PlaceholderText = "255 - 0"
Tracers_B.Text = "10"
Tracers_B.TextColor3 = Color3.fromRGB(255, 255, 255)
Tracers_B.TextSize = 14.000
-- Made By Mick Gordon
Unknown.Name = "Unknown"
Unknown.Parent = DeleteMobF
Unknown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Unknown.BackgroundTransparency = 1.000
Unknown.BorderColor3 = Color3.fromRGB(0, 0, 0)
Unknown.BorderSizePixel = 0
Unknown.Position = UDim2.new(0.882285178, 0, 0.158000082, 0)
Unknown.Size = UDim2.new(0, 100, 0, 334)

UIListLayout_9.Parent = Unknown
UIListLayout_9.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_9.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_9.Padding = UDim.new(0, 5)

TextLabel_13.Parent = Unknown
TextLabel_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_13.BackgroundTransparency = 1.000
TextLabel_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_13.BorderSizePixel = 0
TextLabel_13.Position = UDim2.new(0.0700000003, 0, 0.20869565, 0)
TextLabel_13.Size = UDim2.new(0, 100, 0, 17)
TextLabel_13.Font = Enum.Font.Gotham
TextLabel_13.Text = "More Options"
TextLabel_13.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_13.TextSize = 21.000

TextLabel_14.Parent = Unknown
TextLabel_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_14.BackgroundTransparency = 1.000
TextLabel_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_14.BorderSizePixel = 0
TextLabel_14.Position = UDim2.new(0.215919182, 0, 0.100655407, 0)
TextLabel_14.Size = UDim2.new(0, 100, 0, 17)
TextLabel_14.Font = Enum.Font.Gotham
TextLabel_14.Text = "Later"
TextLabel_14.TextColor3 = Color3.fromRGB(17, 223, 255)
TextLabel_14.TextSize = 18.000

Open.Name = "Open"
Open.Parent = CheatEngineDeleteMob
Open.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
Open.BorderColor3 = Color3.fromRGB(255, 255, 255)
Open.Position = UDim2.new(0.5, 0, 0.0199999996, 0)
Open.Size = UDim2.new(0, 150, 0, 50)
Open.ZIndex = 10
Open.Visible = DeleteMob.GUi.OpenNCloseButton
Open.Draggable = true
Open.Active = true

TextButton.Parent = Open
TextButton.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
TextButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextButton.Position = UDim2.new(0, 0, 0.319999933, 0)
TextButton.Size = UDim2.new(0, 150, 0, 34)
TextButton.Font = Enum.Font.Gotham
TextButton.Text = "open / Close"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 14.000

PLAYER:GetMouse().KeyDown:Connect(function(KeyPressed) -- What The Fuck
	if KeyPressed == (DeleteMob.GUi.Keybind) and DeleteMob.GUi.KeybindEnable then
        if DeleteMobF.Visible == true then
            DeleteMobF.Visible = false
        else
            DeleteMobF.Visible = true
        end
    end
    if KeyPressed == (DeleteMob.Aimbot.Keybind) and DeleteMob.Aimbot.Enabled then
        DeleteMob.Aimbot.IsAimKeyDown = true
    end
end)
PLAYER:GetMouse().KeyUp:Connect(function(KeyPressed) 
    if KeyPressed == (DeleteMob.Aimbot.Keybind) and DeleteMob.Aimbot.Enabled then
        DeleteMob.Aimbot.IsAimKeyDown = false
    end
end)

PLAYER:GetMouse().Button1Down:Connect(function()
    if DeleteMob.Aimbot.Keybind == "MouseButton1" and DeleteMob.Aimbot.Enabled then
        DeleteMob.Aimbot.IsAimKeyDown = true
    end
end)
PLAYER:GetMouse().Button1Up:Connect(function()
    if DeleteMob.Aimbot.Keybind == "MouseButton1" and DeleteMob.Aimbot.Enabled then
        DeleteMob.Aimbot.IsAimKeyDown = false
    end
end)
PLAYER:GetMouse().Button2Down:Connect(function()
    if DeleteMob.Aimbot.Keybind == "MouseButton2" and DeleteMob.Aimbot.Enabled then
        DeleteMob.Aimbot.IsAimKeyDown = true
    end
end)
PLAYER:GetMouse().Button2Up:Connect(function()
    if DeleteMob.Aimbot.Keybind == "MouseButton2" and DeleteMob.Aimbot.Enabled then
        DeleteMob.Aimbot.IsAimKeyDown = false
    end
end)

-- Made By Mick Gordon
ABE.MouseButton1Click:Connect(function()
	if ABE.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		ABE.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.Aimbot.Enabled = true
	else
		ABE.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.Aimbot.Enabled = false	
	end
end)

ABSF.MouseButton1Click:Connect(function()
	if ABSF.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		ABSF.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.Aimbot.ShowFov = true
	else
		ABSF.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.Aimbot.ShowFov = false	
	end
end)

ABTC.MouseButton1Click:Connect(function()
	if ABTC.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		ABTC.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.Aimbot.TeamCheck = true
	else
		ABTC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.Aimbot.TeamCheck = false	
	end
end)

ABWC.MouseButton1Click:Connect(function()
	if ABWC.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		ABWC.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.Aimbot.WallCheck = true
	else
		ABWC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.Aimbot.WallCheck = false	
	end
end)

Allways_Show.MouseButton1Click:Connect(function()
	if DeleteMob.Aimbot.AimPart == "Head" then
		Allways_Show.Text = "head, TORSO"
		DeleteMob.Aimbot.AimPart = "HumanoidRootPart"
	else
		Allways_Show.Text = "HEAD, torso"
		DeleteMob.Aimbot.AimPart = "Head"
	end
end)

-- Box ESP

BBD.MouseButton1Click:Connect(function()
	if BBD.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		BBD.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.Box.Distance = true
	else
		BBD.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.Box.Distance = false	
	end
end)

BBE.MouseButton1Click:Connect(function()
	if BBE.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		BBE.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.Box.Box = true
	else
		BBE.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.Box.Box = false	
	end
end)

BBH.MouseButton1Click:Connect(function()
	if BBH.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		BBH.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.Box.Health = true
	else
		BBH.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.Box.Health = false	
	end
end)

BBHT.MouseButton1Click:Connect(function()
	if DeleteMob.ESP.Box.HealthType == "Bar" then
		BBHT.Text = "bar, TEXT, both"
		DeleteMob.ESP.Box.HealthType = "Text"
	elseif DeleteMob.ESP.Box.HealthType == "Text" then
		BBHT.Text = "bar, text, BOTH"
		DeleteMob.ESP.Box.HealthType = "Both"
	elseif DeleteMob.ESP.Box.HealthType == "Both" then
		BBHT.Text = "BAR, text, both"
		DeleteMob.ESP.Box.HealthType = "Bar"
	end
end)

BBN.MouseButton1Click:Connect(function()
	if BBN.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		BBN.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.Box.Name = true
	else
		BBN.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.Box.Name = false	
	end
end)

BTC.MouseButton1Click:Connect(function()
	if BTC.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		BTC.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.Box.TeamCheck = true
	else
		BTC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.Box.TeamCheck = false	
	end
end)
-- Outlines

OE.MouseButton1Click:Connect(function()
	if OE.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		OE.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.OutLines.Enabled = true
	else
		OE.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.OutLines.Enabled = false	
	end
end)

OTC.MouseButton1Click:Connect(function()
	if OTC.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		OTC.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.OutLines.TeamCheck = true
	else
		OTC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.OutLines.TeamCheck = false	
	end
end)

-- Tracers

TE.MouseButton1Click:Connect(function()
	if TE.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		TE.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.Tracers.Enabled = true
	else
		TE.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.Tracers.Enabled = false	
	end
end)

TTC.MouseButton1Click:Connect(function()
	if TTC.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		TTC.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.Tracers.TeamCheck = true
	else
		TTC.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.Tracers.TeamCheck = false	
	end
end)

TTCOlor.MouseButton1Click:Connect(function()
	if TTCOlor.BackgroundColor3 == Color3.fromRGB(52, 52, 52) then
		TTCOlor.BackgroundColor3 = Color3.fromRGB(2, 54, 8)
		DeleteMob.ESP.Tracers.TeamColor = true
	else
		TTCOlor.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		DeleteMob.ESP.Tracers.TeamColor = false	
	end
end)

-- UI Toggle

TextButton.MouseButton1Click:Connect(function()
	if DeleteMobF.Visible == true then
		DeleteMobF.Visible = false
	else
		DeleteMobF.Visible = true
	end
end)


-- Scripts:

local function LDTZWMY_fake_script() -- Slider3.Script1 
	local Mouse = game.Players.LocalPlayer:GetMouse()
	local Slider = Slider3
	local Fill = Fill1
	local Trigger = TriggerFov
	local TextNumbers = Numbers
	
	local maxvalue = 7 or 700/700
	local startingvalue = 0 or 0/100
	
	Fill.Size = UDim2.fromScale(DeleteMob.Aimbot.Fov,1)
	TextNumbers.Text = tostring(math.round(DeleteMob.Aimbot.Fov*100))
	
	local TweenService = game:GetService("TweenService")
	local TweenStyle =  TweenInfo.new(0.25, Enum.EasingStyle.Exponential)
	
	local function UpdateSlider()
		local OutPut = math.clamp(((Vector2.new(Mouse.X,Mouse.Y)-Slider.AbsolutePosition)/Slider.AbsoluteSize).X,0,1)
		
		if DeleteMob.Aimbot.Fov ~= OutPut then
			TweenService:Create(Fill,TweenStyle,{Size = UDim2.fromScale(OutPut,1)}):Play()
		end
		
		DeleteMob.Aimbot.Fov = (startingvalue +(OutPut*(maxvalue-startingvalue)))*100
		TextNumbers.Text = tostring(math.round(DeleteMob.Aimbot.Fov*100))
	end
	
	Fill:GetPropertyChangedSignal("Size"):Connect(function()
		TextNumbers.Text = tostring(math.round(DeleteMob.Aimbot.Fov*100))
	end)
	
	local SliderActive = false
	
	local function ActivateSlider()
		SliderActive = true
		while SliderActive do
			UpdateSlider()
			task.wait()
		end
	end
	
	Trigger.MouseButton1Down:Connect(ActivateSlider)
	
	game:GetService("UserInputService").InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			SliderActive = false
		end
	end)
end
coroutine.wrap(LDTZWMY_fake_script)()

local function YEOE_fake_script() -- Slider4.Script2 
	local Mouse = game.Players.LocalPlayer:GetMouse()
	local Slider = Slider4
	local Fill = Fill2
	local Trigger = TriggerSmoothing
	local TextNumbers = Numbers_2
	
	local maxvalue = 3 or 30/30
	local startingvalue = 0 or 0/100
	
	Fill.Size = UDim2.fromScale(DeleteMob.Aimbot.Smoothing,1)
	TextNumbers.Text = tostring(math.round(DeleteMob.Aimbot.Smoothing*100))
	
	local TweenService = game:GetService("TweenService")
	local TweenStyle =  TweenInfo.new(0.25, Enum.EasingStyle.Exponential)
	
	local function UpdateSlider()
		local OutPut = math.clamp(((Vector2.new(Mouse.X,Mouse.Y)-Slider.AbsolutePosition)/Slider.AbsoluteSize).X,0,1)
		
		if DeleteMob.Aimbot.Smoothing ~= OutPut then
			TweenService:Create(Fill,TweenStyle,{Size = UDim2.fromScale(OutPut,1)}):Play()
		end
		
		DeleteMob.Aimbot.Smoothing = startingvalue +(OutPut*(maxvalue-startingvalue))
		TextNumbers.Text = tostring(math.round(DeleteMob.Aimbot.Smoothing*100))
	end
	
	Fill:GetPropertyChangedSignal("Size"):Connect(function()
		TextNumbers.Text = tostring(math.round(DeleteMob.Aimbot.Smoothing*100))
	end)
	
	local SliderActive = false
	
	local function ActivateSlider()
		SliderActive = true
		while SliderActive do
			UpdateSlider()
			task.wait()
		end
	end
	
	Trigger.MouseButton1Down:Connect(ActivateSlider)
	
	game:GetService("UserInputService").InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			SliderActive = false
		end
	end)
	
end
coroutine.wrap(YEOE_fake_script)()
local function GOUU_fake_script() -- Slider1.Script3 
	local Mouse = game.Players.LocalPlayer:GetMouse()
	local Slider = Slider1
	local Fill = Fill3
	local Trigger = TriggerOutTans
	local TextNumbers = Numbers_3
	
	local maxvalue = 1 or 100/100
	local startingvalue = 0 or 0/100
	
	Fill.Size = UDim2.fromScale(DeleteMob.ESP.OutLines.OutlineTrancparency,1)
	TextNumbers.Text = tostring(math.round(DeleteMob.ESP.OutLines.OutlineTrancparency*100))
	
	local TweenService = game:GetService("TweenService")
	local TweenStyle =  TweenInfo.new(0.25, Enum.EasingStyle.Exponential)
	
	local function UpdateSlider()
		local OutPut = math.clamp(((Vector2.new(Mouse.X,Mouse.Y)-Slider.AbsolutePosition)/Slider.AbsoluteSize).X,0,1)
		
		if DeleteMob.ESP.OutLines.OutlineTrancparency ~= OutPut then
			TweenService:Create(Fill,TweenStyle,{Size = UDim2.fromScale(OutPut,1)}):Play()
		end
		
		DeleteMob.ESP.OutLines.OutlineTrancparency = startingvalue +(OutPut*(maxvalue-startingvalue))
		TextNumbers.Text = tostring(math.round(DeleteMob.ESP.OutLines.OutlineTrancparency*100))
	end
	
	Fill:GetPropertyChangedSignal("Size"):Connect(function()
		TextNumbers.Text = tostring(math.round(DeleteMob.ESP.OutLines.OutlineTrancparency*100))
	end)
	
	local SliderActive = false
	
	local function ActivateSlider()
		SliderActive = true
		while SliderActive do
			UpdateSlider()
			task.wait()
		end
	end
	
	Trigger.MouseButton1Down:Connect(ActivateSlider)
	
	game:GetService("UserInputService").InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			SliderActive = false
		end
	end)
	
end
coroutine.wrap(GOUU_fake_script)()
local function MMUKLB_fake_script() -- Slider2.Script4 
	local Mouse = game.Players.LocalPlayer:GetMouse()
	local Slider = Slider2
	local Fill = Fill4
	local Trigger = TriggerFill
	local TextNumbers = Numbers_4
	
	local maxvalue = 1 or 100/100
	local startingvalue = 0 or 0/100
	
	Fill.Size = UDim2.fromScale(DeleteMob.ESP.OutLines.FillTrancparenct,1)
	TextNumbers.Text = tostring(math.round(DeleteMob.ESP.OutLines.FillTrancparenct*100))
	
	local TweenService = game:GetService("TweenService")
	local TweenStyle =  TweenInfo.new(0.25, Enum.EasingStyle.Exponential)
	
	local function UpdateSlider()
		local OutPut = math.clamp(((Vector2.new(Mouse.X,Mouse.Y)-Slider.AbsolutePosition)/Slider.AbsoluteSize).X,0,1)
		
		if DeleteMob.ESP.OutLines.FillTrancparenct ~= OutPut then
			TweenService:Create(Fill,TweenStyle,{Size = UDim2.fromScale(OutPut,1)}):Play()
		end
		
		DeleteMob.ESP.OutLines.FillTrancparenct = startingvalue +(OutPut*(maxvalue-startingvalue))
		TextNumbers.Text = tostring(math.round(DeleteMob.ESP.OutLines.FillTrancparenct*100))
	end
	
	Fill:GetPropertyChangedSignal("Size"):Connect(function()
		TextNumbers.Text = tostring(math.round(DeleteMob.ESP.OutLines.FillTrancparenct*100))
	end)
	
	local SliderActive = false
	
	local function ActivateSlider()
		SliderActive = true
		while SliderActive do
			UpdateSlider()
			task.wait()
		end
	end
	
	Trigger.MouseButton1Down:Connect(ActivateSlider)
	
	game:GetService("UserInputService").InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			SliderActive = false
		end
	end)
	
end
coroutine.wrap(MMUKLB_fake_script)()


game:GetService('RunService').RenderStepped:connect(function()

	-- Aimbot Check
	if DeleteMob.Aimbot.IsAimKeyDown then
        local _pos = CameraGetClosestToMouse(DeleteMob.Aimbot.Fov)
        if _pos then
            aimAt(_pos, DeleteMob.Aimbot.Smoothing)
        end
    end

	-- Fov
	local acc = DeleteMob.Aimbot.Smoothing / 2	
	local posd = UIS:GetMouseLocation() 
	FOVFFrame.Position = UDim2.new(0, posd.X, 0, posd.Y - 36)
	FOVFFrame.Size = UDim2.new(0, DeleteMob.Aimbot.Fov + acc, 0, DeleteMob.Aimbot.Fov + acc)
	FOVFFrame.Visible = DeleteMob.Aimbot.ShowFov
	FOVFFrame.BackgroundColor3 = DeleteMob.Aimbot.FovFillColor
	FOVFFrame.Transparency = DeleteMob.Aimbot.FovFillTransparency

	UIStroke.Color = DeleteMob.Aimbot.FovFillColor
	UIStroke.Transparency = DeleteMob.Aimbot.FovTransparenct
	UIStroke.Thickness = DeleteMob.Aimbot.Thickness
	
	-- Colors 
	
	DeleteMob.ESP.Box.BoxColor = Color3.fromRGB(tonumber(Box_R.Text), tonumber(Box_G.Text), tonumber(Box_B.Text))
	DeleteMob.ESP.OutLines.FillCollor = Color3.fromRGB(tonumber(FillOutlines_R.Text), tonumber(FillOutlines_G.Text), tonumber(FillOutlines_B.Text))
	DeleteMob.ESP.OutLines.OutlineColor = Color3.fromRGB(tonumber(Outlines_R.Text), tonumber(Outlines_G.Text), tonumber(Outlines_B.Text))
	DeleteMob.ESP.Tracers.Color = Color3.fromRGB(tonumber(Tracers_R.Text), tonumber(Tracers_G.Text), tonumber(Tracers_B.Text))
end)


task.wait()

for i,plr in pairs(game.Players:GetChildren()) do
	AddHighlight(plr)
	AddBox(plr)
	AddTracers(plr)
end

game.Players.PlayerAdded:Connect(function(plr)
	AddHighlight(plr)
	AddBox(plr)
	AddTracers(plr)
end)
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

HubsTab:AddSection({
    Name = "Bliz_T Hub"
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

local DiscordTab = Window:MakeTab({
    Name = "Discord Servers",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

DiscordTab:AddSection({
    Name = "Oficial Server Script"
})

DiscordTab:AddButton({
    Name = "Discord Script",
    Callback = function()
        print("copied!")
        setclipboard("https://discord.gg/HtxupJnHfu")
        OrionLib:MakeNotification({
            Name = "Discord Copied",
            Content = "Discord Copied",
            Image = "rbxassetid://9327507243",
            Time = 5
        })
    end
})

DiscordTab:AddSection({
    Name = "Game Land Server"
})

DiscordTab:AddButton({
    Name = "GameLand Server",
    Callback = function()
        print("GameLand Copied!")
        setclipboard("https://discord.gg/TyCmFKzN5P")
        OrionLib:MakeNotification({
            Name = "Discord Copied",
            Content = "Discord Copied",
            Image = "rbxassetid://9327507243",
            Time = 3
        })
    end
})

DiscordTab:AddSection({
    Name = "CAOS Server (New Script)"
})

DiscordTab:AddButton({
    Name = "CAOS Hub Server",
    Callback = function()
        print("copied!")
        setclipboard("No Link")
        OrionLib:MakeNotification({
            Name = "Discord Copied",
            Content = "Discord Copied",
            Image = "rbxassetid://9327507243",
            Time = 3
        })
    end
})

DiscordTab:AddSection({
    Name = "Old Server CAOS Hub"
})

DiscordTab:AddButton({
    Name = "DeadPrinces",
    Callback = function()
        print("copied!")
        setclipboard("https://discord.gg/BjeHykPDER")
        OrionLib:MakeNotification({
            Name = "Discord Copied",
            Content = "Discord Copied",
            Image = "rbxassetid://9327507243",
            Time = 3
        })
    end
})

DiscordTab:AddSection({
    Name = "Bliz_T Hub Server"
})

DiscordTab:AddButton({
    Name = "Bliz_T Hub",
    Callback = function()
        print("copied!")
        setclipboard("https://discord.gg/dWAR2bzpCP")
        OrionLib:MakeNotification({
            Name = "Discord Copied",
            Content = "Discord Copied",
            Image = "rbxassetid://9327507243",
            Time = 3
        })
    end
})

local ConfigF = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://9327507243",
    PremiumOnly = false
})

ConfigF:AddSection({
    Name = "Pshade Ultimate"
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

ConfigF:AddSection({
    Name = "Save Configs"
})

ConfigF:AddButton({
    Name = "Save Configs",
    Callback = function()
        print("Saved")
        OrionLib:MakeNotification({
            Name = "Saved!",
            Content = "Configs Saved",
            Image = "rbxassetid://9327507243",
            Time = 5
        })
        OrionLib:SaveConfig()
    end
})

ConfigF:AddSection({
    Name = "Pop Up Cat"
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
    "Caius Molestado",
    "Ber Paneleiro",
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
end
})

ConfigF:AddButton({
    Name = "Support",
    Callback = function()
        setclipboard("https://discord.gg/HtxupJnHfu")
       OrionLib:MakeNotification({
            Name = "Discord Copied!",
            Content = "In Your Clipboard",
            Image = "rbxassetid://9327507243",
            Time = 3
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
CreditsTab:AddLabel("Actual lines in Script: 3427 (Optimize)")

CreditsTab:AddButton({
    Name = "Support",
    Callback = function()
        setclipboard("https://discord.gg/HtxupJnHfu")
       OrionLib:MakeNotification({
            Name = "Discord Copied!",
            Content = "In Your Clipboard",
            Image = "rbxassetid://9327507243",
            Time = 3
        })
    end
})      
--FOV
changeFOV(70)

OrionLib:Init()
