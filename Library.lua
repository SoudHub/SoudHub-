-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Library Main Table
local CustomLib = {}
CustomLib.__index = CustomLib

-- Configurações padrão
local defaultConfig = {
    Theme = "Dark",
    AccentColor = Color3.fromRGB(0, 170, 255),
    BackgroundTransparency = 0.1,
    BackgroundImage = nil, -- ID da imagem
    Font = Enum.Font.Gotham,
    TextSize = 14,
    Roundness = 8
}

-- Tabela para armazenar as instâncias
local activeWindows = {}

-- Função para criar elementos UI
function CustomLib:CreateElement(className, properties)
    local element = Instance.new(className)
    for property, value in pairs(properties) do
        element[property] = value
    end
    return element
end

-- Color Picker Customizado
function CustomLib:CreateColorPicker(config)
    local colorPicker = {
        Value = config.Default or Color3.new(1, 1, 1),
        Callback = config.Callback or function() end
    }
    
    local colorPickerFrame = self:CreateElement("Frame", {
        Name = "ColorPicker",
        Size = UDim2.new(1, 0, 0, 100),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        BackgroundTransparency = 0.1,
        Parent = config.Parent
    })
    
    -- Preview da cor atual
    local colorPreview = self:CreateElement("Frame", {
        Name = "ColorPreview",
        Size = UDim2.new(0, 80, 0, 25),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundColor3 = colorPicker.Value,
        BorderSizePixel = 0,
        Parent = colorPickerFrame
    })
    
    -- Hue Slider
    local hueSlider = self:CreateElement("Frame", {
        Name = "HueSlider",
        Size = UDim2.new(0, 200, 0, 15),
        Position = UDim2.new(0, 100, 0, 10),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Parent = colorPickerFrame
    })
    
    -- Gradient para o hue
    local hueGradient = self:CreateElement("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        }),
        Parent = hueSlider
    })
    
    -- Slider handle
    local hueHandle = self:CreateElement("Frame", {
        Name = "HueHandle",
        Size = UDim2.new(0, 6, 1, 4),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = hueSlider
    })
    
    -- Área de Saturação/Brilho
    local saturationBrightness = self:CreateElement("Frame", {
        Name = "SaturationBrightness",
        Size = UDim2.new(0, 150, 0, 80),
        Position = UDim2.new(0, 100, 0, 35),
        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        BorderSizePixel = 0,
        Parent = colorPickerFrame
    })
    
    local sbGradient1 = self:CreateElement("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
        }),
        Rotation = 90,
        Parent = saturationBrightness
    })
    
    local sbGradient2 = self:CreateElement("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
        }),
        Parent = saturationBrightness
    })
    
    -- Handle da área SB
    local sbHandle = self:CreateElement("Frame", {
        Name = "SBHandle",
        Size = UDim2.new(0, 8, 0, 8),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 1,
        ZIndex = 2,
        Parent = saturationBrightness
    })
    
    -- Inputs RGB
    local rgbInputs = {}
    local rgbLabels = {"R", "G", "B"}
    
    for i, label in ipairs(rgbLabels) do
        local yPos = 10 + (i-1) * 25
        
        local labelText = self:CreateElement("TextLabel", {
            Text = label,
            Size = UDim2.new(0, 15, 0, 20),
            Position = UDim2.new(0, 260, 0, yPos),
            BackgroundTransparency = 1,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 12,
            Font = Enum.Font.Gotham,
            Parent = colorPickerFrame
        })
        
        local textBox = self:CreateElement("TextBox", {
            Text = "255",
            Size = UDim2.new(0, 40, 0, 20),
            Position = UDim2.new(0, 280, 0, yPos),
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 12,
            Font = Enum.Font.Gotham,
            Parent = colorPickerFrame
        })
        
        rgbInputs[label] = textBox
    end
    
    -- Função para atualizar a cor
    local function updateColor(hue, saturation, brightness)
        local color = Color3.fromHSV(hue, saturation, brightness)
        colorPicker.Value = color
        colorPreview.BackgroundColor3 = color
        saturationBrightness.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        
        -- Atualizar inputs RGB
        rgbInputs["R"].Text = tostring(math.floor(color.R * 255))
        rgbInputs["G"].Text = tostring(math.floor(color.G * 255))
        rgbInputs["B"].Text = tostring(math.floor(color.B * 255))
        
        colorPicker.Callback(color)
    end
    
    -- Conectar eventos dos sliders
    -- (Aqui você implementaria a lógica de drag para hueSlider e saturationBrightness)
    
    -- Conectar eventos dos textboxes
    for label, textBox in pairs(rgbInputs) do
        textBox.FocusLost:Connect(function()
            local value = tonumber(textBox.Text) or 0
            value = math.clamp(value, 0, 255)
            textBox.Text = tostring(value)
            
            -- Atualizar cor baseada nos valores RGB
            local r = tonumber(rgbInputs["R"].Text) or 0
            local g = tonumber(rgbInputs["G"].Text) or 0
            local b = tonumber(rgbInputs["B"].Text) or 0
            
            local color = Color3.fromRGB(r, g, b)
            local h, s, v = color:ToHSV()
            updateColor(h, s, v)
        end)
    end
    
    return colorPicker
end

-- Função principal para criar a window
function CustomLib:CreateWindow(config)
    config = setmetatable(config or {}, {__index = defaultConfig})
    
    local self = setmetatable({}, CustomLib)
    self.Config = config
    self.Tabs = {}
    
    -- Criar a GUI principal
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    self.ScreenGui = self:CreateElement("ScreenGui", {
        Name = "CustomLibGUI",
        DisplayOrder = 10,
        Parent = playerGui
    })
    
    -- Background com imagem
    self.Background = self:CreateElement("Frame", {
        Name = "Background",
        Size = UDim2.new(0, 500, 0, 400),
        Position = UDim2.new(0.5, -250, 0.5, -200),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BackgroundTransparency = config.BackgroundTransparency,
        Parent = self.ScreenGui
    })
    
    -- Adicionar imagem de fundo se especificada
    if config.BackgroundImage then
        local backgroundImage = self:CreateElement("ImageLabel", {
            Name = "BackgroundImage",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image = "rbxassetid://" .. config.BackgroundImage,
            ScaleType = Enum.ScaleType.Crop,
            Parent = self.Background
        })
    end
    
    -- UIStroke e Corner
    self:CreateElement("UICorner", {
        CornerRadius = UDim.new(0, config.Roundness),
        Parent = self.Background
    })
    
    self:CreateElement("UIStroke", {
        Thickness = 2,
        Color = config.AccentColor,
        Parent = self.Background
    })
    
    -- Topbar
    local topBar = self:CreateElement("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = config.AccentColor,
        BackgroundTransparency = 0.2,
        Parent = self.Background
    })
    
    self:CreateElement("UICorner", {
        CornerRadius = UDim.new(0, config.Roundness),
        Parent = topBar
    })
    
    local title = self:CreateElement("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0, 200, 1, 0),
        BackgroundTransparency = 1,
        Text = config.Name or "Custom Menu",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 16,
        Font = config.Font,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = topBar
    })
    
    -- Área de tabs
    self.TabButtons = self:CreateElement("Frame", {
        Name = "TabButtons",
        Size = UDim2.new(0, 120, 1, -30),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = 1,
        Parent = self.Background
    })
    
    self.TabContainer = self:CreateElement("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(1, -120, 1, -30),
        Position = UDim2.new(0, 120, 0, 30),
        BackgroundTransparency = 1,
        Parent = self.Background
    })
    
    -- Adicionar à lista de windows ativas
    table.insert(activeWindows, self)
    
    return self
end

-- Função para adicionar tab
function CustomLib:AddTab(name)
    local tab = {
        Name = name,
        Sections = {}
    }
    
    -- Botão da tab
    local tabButton = self:CreateElement("TextButton", {
        Name = name .. "TabButton",
        Size = UDim2.new(1, -10, 0, 30),
        Position = UDim2.new(0, 5, 0, 5 + (#self.Tabs * 35)),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        BackgroundTransparency = 0.5,
        Text = "",
        Parent = self.TabButtons
    })
    
    self:CreateElement("UICorner", {
        CornerRadius = UDim.new(0, self.Config.Roundness),
        Parent = tabButton
    })
    
    local tabLabel = self:CreateElement("TextLabel", {
        Name = "TabLabel",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = self.Config.TextSize,
        Font = self.Config.Font,
        Parent = tabButton
    })
    
    -- Container da tab (inicialmente invisível)
    local tabFrame = self:CreateElement("ScrollingFrame", {
        Name = name .. "Tab",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        ScrollBarThickness = 3,
        Parent = self.TabContainer
    })
    
    tab.Button = tabButton
    tab.Frame = tabFrame
    
    table.insert(self.Tabs, tab)
    
    -- Lógica de clique
    tabButton.MouseButton1Click:Connect(function()
        self:SwitchTab(tab)
    end)
    
    -- Primeira tab fica ativa
    if #self.Tabs == 1 then
        self:SwitchTab(tab)
    end
    
    return tab
end

-- Função para mudar de tab
function CustomLib:SwitchTab(selectedTab)
    for _, tab in ipairs(self.Tabs) do
        tab.Frame.Visible = (tab == selectedTab)
        tab.Button.BackgroundTransparency = (tab == selectedTab) and 0.2 or 0.5
    end
end

-- Função para adicionar seção
function CustomLib:AddSection(tab, name)
    local section = {
        Name = name,
        Elements = {}
    }
    
    local sectionFrame = self:CreateElement("Frame", {
        Name = name .. "Section",
        Size = UDim2.new(1, -20, 0, 0), -- Altura será ajustada
        Position = UDim2.new(0, 10, 0, 10 + (#section.Elements * 5)),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BackgroundTransparency = 0.3,
        Parent = tab.Frame
    })
    
    self:CreateElement("UICorner", {
        CornerRadius = UDim.new(0, self.Config.Roundness),
        Parent = sectionFrame
    })
    
    self:CreateElement("UIStroke", {
        Thickness = 1,
        Color = self.Config.AccentColor,
        Parent = sectionFrame
    })
    
    local sectionLabel = self:CreateElement("TextLabel", {
        Name = "SectionLabel",
        Size = UDim2.new(1, -10, 0, 25),
        Position = UDim2.new(0, 5, 0, 5),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = self.Config.TextSize,
        Font = self.Config.Font,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sectionFrame
    })
    
    section.Frame = sectionFrame
    table.insert(tab.Sections, section)
    
    return section
end

-- AGORA A FUNÇÃO QUE VOCÊ PEDIU - AddColorID
function CustomLib:AddColorID(section, config)
    local colorElement = {
        Type = "ColorPicker",
        Value = config.Default or Color3.new(1, 1, 1),
        Callback = config.Callback
    }
    
    local elementFrame = self:CreateElement("Frame", {
        Name = config.Name .. "Color",
        Size = UDim2.new(1, -20, 0, 40),
        BackgroundTransparency = 1,
        Parent = section.Frame
    })
    
    local elementLabel = self:CreateElement("TextLabel", {
        Name = "Label",
        Size = UDim2.new(0.6, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = config.Name,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = self.Config.TextSize - 1,
        Font = self.Config.Font,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = elementFrame
    })
    
    local colorPreview = self:CreateElement("TextButton", {
        Name = "ColorPreview",
        Size = UDim2.new(0, 60, 0, 25),
        Position = UDim2.new(0.7, 0, 0.5, -12),
        BackgroundColor3 = colorElement.Value,
        Text = "",
        Parent = elementFrame
    })
    
    self:CreateElement("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = colorPreview
    })
    
    self:CreateElement("UIStroke", {
        Thickness = 1,
        Color = Color3.new(1, 1, 1),
        Parent = colorPreview
    })
    
    -- Quando clicar no preview, abrir color picker
    colorPreview.MouseButton1Click:Connect(function()
        -- Aqui você implementaria a lógica para mostrar/ocultar o color picker
        -- Por enquanto, vou usar um color picker simples do Roblox
        self:ShowSimpleColorPicker(colorElement, colorPreview, config.Name)
    end)
    
    table.insert(section.Elements, colorElement)
    
    -- Reorganizar elementos na section
    self:OrganizeSection(section)
    
    return colorElement
end

-- Função simples para color picker (como fallback)
function CustomLib:ShowSimpleColorPicker(colorElement, preview, name)
    -- Esta é uma implementação simplificada
    -- Você pode expandir para usar o color picker customizado que criamos acima
    
    local colorPicker = self:CreateColorPicker({
        Name = name,
        Default = colorElement.Value,
        Parent = preview.Parent,
        Callback = function(newColor)
            colorElement.Value = newColor
            preview.BackgroundColor3 = newColor
            if colorElement.Callback then
                colorElement.Callback(newColor)
            end
        end
    })
end

-- Função para organizar elementos na section
function CustomLib:OrganizeSection(section)
    local totalHeight = 30 -- Altura do label + padding
    
    for _, element in ipairs(section.Elements) do
        if element.Frame then
            element.Frame.Position = UDim2.new(0, 10, 0, totalHeight)
            totalHeight = totalHeight + element.Frame.Size.Y.Offset + 5
        end
    end
    
    section.Frame.Size = UDim2.new(1, -20, 0, totalHeight + 10)
end

-- Função para toggle da GUI
function CustomLib:Toggle()
    self.Background.Visible = not self.Background.Visible
end

return CustomLib
