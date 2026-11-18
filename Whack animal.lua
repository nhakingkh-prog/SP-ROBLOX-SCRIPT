local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ==========================================
-- [Theme]
-- ==========================================
local Theme = {
    Bg = Color3.fromRGB(18, 18, 24),
    Header = Color3.fromRGB(26, 26, 36),
    Row = Color3.fromRGB(30, 30, 42),
    RowHover = Color3.fromRGB(38, 38, 54),
    Accent = Color3.fromRGB(120, 90, 255),
    On = Color3.fromRGB(70, 220, 130),
    Off = Color3.fromRGB(70, 70, 90),
    Text = Color3.fromRGB(240, 240, 250),
    SubText = Color3.fromRGB(150, 150, 170),
    Danger = Color3.fromRGB(255, 80, 90),
}

local function tween(obj, props, t, style, dir)
    local tw = TweenService:Create(obj, TweenInfo.new(t or 0.2, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props)
    tw:Play()
    return tw
end

local function corner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = obj
    return c
end

local function stroke(obj, color, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thick or 1
    s.Transparency = trans or 0.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = obj
    return s
end

-- ==========================================
-- [ScreenGui]
-- ==========================================
local gui = Instance.new("ScreenGui")
gui.Name = "SP_Roblox_Script_GUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local success = pcall(function()
    gui.Parent = (gethui and gethui()) or game.CoreGui
end)
if not success then
    gui.Parent = player:WaitForChild("PlayerGui")
end

-- ==========================================
-- [Open Button]
-- ==========================================
local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 110, 0, 40)
openButton.Position = UDim2.new(0, 20, 0.5, 0)
openButton.BackgroundColor3 = Theme.Accent
openButton.TextColor3 = Theme.Text
openButton.Text = "SP SCRIPT"
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 14
openButton.AutoButtonColor = false
openButton.Parent = gui
corner(openButton, 20)
stroke(openButton, Color3.new(1, 1, 1), 1, 0.7)

openButton.MouseEnter:Connect(function()
    tween(openButton, {Size = UDim2.new(0, 118, 0, 42)}, 0.15)
end)
openButton.MouseLeave:Connect(function()
    tween(openButton, {Size = UDim2.new(0, 110, 0, 40)}, 0.15)
end)

-- ==========================================
-- [Main Dashboard]
-- ==========================================
local dashboard = Instance.new("Frame")
dashboard.Name = "Dashboard"
dashboard.Size = UDim2.new(0, 400, 0, 470)
dashboard.Position = UDim2.new(0.5, -200, 0.5, -235)
dashboard.BackgroundColor3 = Theme.Bg
dashboard.BorderSizePixel = 0
dashboard.Visible = false
dashboard.ClipsDescendants = true
dashboard.Parent = gui
corner(dashboard, 14)
stroke(dashboard, Theme.Accent, 1.5, 0.4)

local scale = Instance.new("UIScale")
scale.Scale = 0
scale.Parent = dashboard

local function openDashboard()
    dashboard.Visible = true
    tween(scale, {Scale = 1}, 0.35, Enum.EasingStyle.Back)
end

local function closeDashboard()
    local tw = tween(scale, {Scale = 0}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    tw.Completed:Once(function()
        if scale.Scale <= 0.01 then dashboard.Visible = false end
    end)
end

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Theme.Header
header.BorderSizePixel = 0
header.Parent = dashboard

local headerGrad = Instance.new("UIGradient")
headerGrad.Color = ColorSequence.new(Color3.fromRGB(60, 40, 140), Theme.Header)
headerGrad.Rotation = 0
headerGrad.Parent = header

local logoImage = Instance.new("ImageLabel")
logoImage.Size = UDim2.new(0, 32, 0, 32)
logoImage.Position = UDim2.new(0, 12, 0.5, -16)
logoImage.BackgroundTransparency = 1
logoImage.Image = "rbxassetid://116345727167504"
logoImage.Parent = header
corner(logoImage, 8)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -110, 1, 0)
title.Position = UDim2.new(0, 54, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Theme.Text
title.Text = "SP ROBLOX SCRIPT"
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBlack
title.TextSize = 18
title.Parent = header

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 32, 0, 32)
closeButton.Position = UDim2.new(1, -42, 0.5, -16)
closeButton.BackgroundColor3 = Theme.Danger
closeButton.BackgroundTransparency = 0.8
closeButton.TextColor3 = Theme.Danger
closeButton.Text = "✕"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.AutoButtonColor = false
closeButton.Parent = header
corner(closeButton, 8)

closeButton.MouseEnter:Connect(function()
    tween(closeButton, {BackgroundTransparency = 0.2, TextColor3 = Theme.Text}, 0.15)
end)
closeButton.MouseLeave:Connect(function()
    tween(closeButton, {BackgroundTransparency = 0.8, TextColor3 = Theme.Danger}, 0.15)
end)

-- Smooth drag (via header)
do
    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = dashboard.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            tween(dashboard, {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            }, 0.08, Enum.EasingStyle.Linear)
        end
    end)
end

-- Content (scrolling)
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -100)
content.Position = UDim2.new(0, 10, 0, 60)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = Theme.Accent
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = dashboard

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 8)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = content

local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 2)
pad.PaddingBottom = UDim.new(0, 6)
pad.PaddingRight = UDim.new(0, 6)
pad.Parent = content

-- Status bar / toast
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 26)
status.Position = UDim2.new(0, 10, 1, -34)
status.BackgroundColor3 = Theme.Row
status.TextColor3 = Theme.SubText
status.Text = "Ready"
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.Parent = dashboard
corner(status, 8)

local statusToken = 0
local function notify(msg, color)
    statusToken += 1
    local my = statusToken
    status.Text = msg
    status.TextColor3 = color or Theme.Text
    tween(status, {BackgroundColor3 = Theme.RowHover}, 0.15)
    task.delay(2, function()
        if my == statusToken then
            status.Text = "Ready"
            status.TextColor3 = Theme.SubText
            tween(status, {BackgroundColor3 = Theme.Row}, 0.3)
        end
    end)
end

-- ==========================================
-- [UI Builders]
-- ==========================================
local order = 0
local function nextOrder() order += 1 return order end

local function makeRow(height)
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, 0, 0, height or 44)
    row.BackgroundColor3 = Theme.Row
    row.AutoButtonColor = false
    row.Text = ""
    row.LayoutOrder = nextOrder()
    row.Parent = content
    corner(row, 10)
    stroke(row, Color3.new(1, 1, 1), 1, 0.92)
    row.MouseEnter:Connect(function() tween(row, {BackgroundColor3 = Theme.RowHover}, 0.15) end)
    row.MouseLeave:Connect(function() tween(row, {BackgroundColor3 = Theme.Row}, 0.15) end)
    return row
end

local function makeLabel(parent, text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -70, 1, 0)
    l.Position = UDim2.new(0, 14, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Theme.Text
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.GothamMedium
    l.TextSize = 14
    l.Parent = parent
    return l
end

local function makeSection(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 20)
    l.BackgroundTransparency = 1
    l.Text = string.upper(text)
    l.TextColor3 = Theme.SubText
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.LayoutOrder = nextOrder()
    l.Parent = content
    local p = Instance.new("UIPadding")
    p.PaddingLeft = UDim.new(0, 4)
    p.Parent = l
end

-- Toggle row with animated switch.
-- guard(): return false to block turning on. onChange(state): start/stop logic.
local function makeToggle(text, flag, onChange, guard)
    local row = makeRow(44)
    makeLabel(row, text)

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 44, 0, 22)
    track.Position = UDim2.new(1, -58, 0.5, -11)
    track.BackgroundColor3 = Theme.Off
    track.Parent = row
    corner(track, 11)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Parent = track
    corner(knob, 8)

    local function render(on)
        tween(track, {BackgroundColor3 = on and Theme.On or Theme.Off}, 0.2)
        tween(knob, {Position = on and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}, 0.2, Enum.EasingStyle.Back)
    end

    row.MouseButton1Click:Connect(function()
        if not _G[flag] and guard and not guard() then return end
        _G[flag] = not _G[flag]
        render(_G[flag])
        notify(text .. (_G[flag] and ": ON" or ": OFF"), _G[flag] and Theme.On or Theme.SubText)
        onChange(_G[flag])
    end)
    return row
end

local function makeButton(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Theme.Text
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.LayoutOrder = nextOrder()
    btn.Parent = content
    corner(btn, 10)
    btn.MouseEnter:Connect(function() tween(btn, {BackgroundTransparency = 0.15}, 0.15) end)
    btn.MouseLeave:Connect(function() tween(btn, {BackgroundTransparency = 0}, 0.15) end)
    btn.MouseButton1Down:Connect(function() tween(btn, {Size = UDim2.new(1, -6, 0, 38)}, 0.08) end)
    btn.MouseButton1Up:Connect(function() tween(btn, {Size = UDim2.new(1, 0, 0, 40)}, 0.12, Enum.EasingStyle.Back) end)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

-- ==========================================
-- [Variables]
-- ==========================================
_G.RunFast = false
_G.AutoSwing = false
_G.AntiChase = false
_G.AutoGrabTP = false
_G.AutoSnipeExclusive = false
_G.ESPEggs = false
local savedBaseCFrame = nil

local function needBase()
    if not savedBaseCFrame then
        notify("Please Set Base First!", Theme.Danger)
        return false
    end
    return true
end

-- ==========================================
-- [Features]
-- ==========================================
makeSection("Player")

makeToggle("Run Fast", "RunFast", function(on)
    if on then
        task.spawn(function()
            while _G.RunFast do
                task.wait(0.5)
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = 500
                end
            end
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = 16
            end
        end)
    end
end)

makeToggle("Auto Swing", "AutoSwing", function(on)
    if on then
        task.spawn(function()
            while _G.AutoSwing do
                task.wait(0.01)
                local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end)
    end
end)

makeToggle("Anti Chase", "AntiChase", function(on)
    if on then
        task.spawn(function()
            while _G.AntiChase do
                task.wait(2)
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj:IsA("Script") or obj:IsA("LocalScript") then
                        if obj.Name:lower():match("chase") or obj.Name:lower():match("aggro") then
                            obj:Destroy()
                        end
                    end
                end
            end
        end)
    end
end)

makeSection("Farm")

makeButton("1. Set Base (Stand here & Click)", Color3.fromRGB(50, 130, 255), function(btn)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedBaseCFrame = player.Character.HumanoidRootPart.CFrame
        btn.Text = "✔ Base Saved!"
        tween(btn, {BackgroundColor3 = Theme.On}, 0.2)
        notify("Base location saved", Theme.On)
        task.delay(1.5, function()
            btn.Text = "1. Update Base Location"
            tween(btn, {BackgroundColor3 = Color3.fromRGB(50, 130, 255)}, 0.3)
        end)
    end
end)

makeToggle("2. Auto Grab Prompt & TP", "AutoGrabTP", function(on)
    if on then
        task.spawn(function()
            while _G.AutoGrabTP do
                task.wait(0.1)
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("ProximityPrompt") then
                            local promptParent = obj.Parent
                            if promptParent and promptParent:IsA("BasePart") then
                                char.HumanoidRootPart.CFrame = promptParent.CFrame
                                task.wait(0.1)
                                pcall(function() fireproximityprompt(obj, 1) end)
                                task.wait(0.1)
                                char.HumanoidRootPart.CFrame = savedBaseCFrame
                                break
                            end
                        end
                    end
                end
            end
        end)
    end
end, needBase)

makeToggle("3. Auto Snipe Exclusive Egg", "AutoSnipeExclusive", function(on)
    if on then
        task.spawn(function()
            while _G.AutoSnipeExclusive do
                task.wait(0.5)
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then continue end

                local targetEgg = nil
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj ~= char and not Players:GetPlayerFromCharacter(obj) then
                        local isExclusive = false
                        for _, child in pairs(obj:GetDescendants()) do
                            if child:IsA("TextLabel") and child.Text:lower():match("exclusive") then
                                isExclusive = true
                                break
                            end
                        end
                        if not isExclusive and obj.Name:lower():match("exclusive") then
                            isExclusive = true
                        end
                        if isExclusive then
                            targetEgg = obj
                            break
                        end
                    end
                end

                if targetEgg and targetEgg.Parent then
                    local root = targetEgg:FindFirstChild("HumanoidRootPart") or targetEgg.PrimaryPart or targetEgg:FindFirstChildOfClass("Part") or targetEgg:FindFirstChildOfClass("MeshPart")
                    if root then
                        local isFarming = true
                        while isFarming and _G.AutoSnipeExclusive and targetEgg.Parent do
                            char.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 3, 0)
                            local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
                            if tool then
                                tool.Parent = char
                                tool:Activate()
                            end
                            for _, prompt in pairs(workspace:GetDescendants()) do
                                if prompt:IsA("ProximityPrompt") and prompt.Parent and prompt.Parent:IsA("BasePart") then
                                    local dist = (prompt.Parent.Position - char.HumanoidRootPart.Position).Magnitude
                                    if dist < 20 then
                                        pcall(function() fireproximityprompt(prompt, 1) end)
                                        isFarming = false
                                        task.wait(0.2)
                                        char.HumanoidRootPart.CFrame = savedBaseCFrame
                                    end
                                end
                            end
                            task.wait(0.05)
                        end
                        if isFarming then
                            task.wait(0.2)
                            for _, prompt in pairs(workspace:GetDescendants()) do
                                if prompt:IsA("ProximityPrompt") and prompt.Parent and prompt.Parent:IsA("BasePart") then
                                    local dist = (prompt.Parent.Position - char.HumanoidRootPart.Position).Magnitude
                                    if dist < 30 then
                                        pcall(function() fireproximityprompt(prompt, 1) end)
                                    end
                                end
                            end
                            char.HumanoidRootPart.CFrame = savedBaseCFrame
                        end
                    end
                end
            end
        end)
    end
end, needBase)

makeSection("Visual")

-- ESP helpers
local rarities = {
    galactic = {name = "Galactic", color = Color3.fromRGB(0, 255, 255)},
    exclusive = {name = "Exclusive", color = Color3.fromRGB(255, 215, 0)},
    mythic = {name = "Mythic", color = Color3.fromRGB(255, 50, 255)},
    legendary = {name = "Legendary", color = Color3.fromRGB(255, 100, 50)},
    epic = {name = "Epic", color = Color3.fromRGB(200, 50, 255)},
    rare = {name = "Rare", color = Color3.fromRGB(50, 150, 255)},
    uncommon = {name = "Uncommon", color = Color3.fromRGB(50, 255, 100)},
    common = {name = "Common", color = Color3.fromRGB(200, 200, 200)}
}

local function getEggValueInfo(obj)
    for _, child in pairs(obj:GetDescendants()) do
        if child:IsA("TextLabel") and child.Text ~= "" then
            local txt = child.Text:lower()
            for key, data in pairs(rarities) do
                if txt:match(key) and key ~= "common" then
                    return data.name, data.color
                elseif txt == "common" then
                    return "Common", rarities.common.color
                end
            end
        end
    end

    local nameLower = obj.Name:lower()
    for key, data in pairs(rarities) do
        if nameLower:match(key) then
            return data.name, data.color
        end
    end

    return "Unknown", Color3.fromRGB(200, 200, 200)
end

local function createESP(obj)
    if obj:FindFirstChild("EggESP") then return end

    local root = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildOfClass("Part") or obj:FindFirstChildOfClass("MeshPart")
    if not root then return end

    local petValue = "Unknown"
    local valueColor = Color3.fromRGB(200, 200, 200)

    local function findValue(parent, depth)
        if depth > 4 then return false end
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("TextLabel") and child.Text:match("%$[%d%.]+[KMBT]?/s") then
                petValue = child.Text
                if petValue:match("B/s") or petValue:match("T/s") then
                    valueColor = Color3.fromRGB(50, 255, 100)
                elseif petValue:match("M/s") then
                    valueColor = Color3.fromRGB(50, 150, 255)
                else
                    valueColor = Color3.fromRGB(255, 150, 50)
                end
                return true
            end

            if child:IsA("StringValue") and (child.Name:lower():match("value") or child.Name:lower():match("stats")) then
                if child.Value:match("%$[%d%.]+[KMBT]?/s") then
                    petValue = child.Value
                    return true
                end
            end
            if findValue(child, depth + 1) then return true end
        end
        return false
    end

    if not findValue(obj, 1) then
        petValue, valueColor = getEggValueInfo(obj)
    end

    local bgui = Instance.new("BillboardGui")
    bgui.Name = "EggESP"
    bgui.Adornee = root
    bgui.Size = UDim2.new(0, 100, 0, 40)
    bgui.StudsOffset = Vector3.new(0, 3.5, 0)
    bgui.AlwaysOnTop = true

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = petValue
    text.TextColor3 = valueColor
    text.TextStrokeTransparency = 0
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.Parent = bgui

    bgui.Parent = obj
end

makeToggle("ESP Eggs (Show Value)", "ESPEggs", function(on)
    if on then
        task.spawn(function()
            while _G.ESPEggs do
                task.wait(1)
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj ~= player.Character and not Players:GetPlayerFromCharacter(obj) then
                        local isTarget = obj.Name:lower():match("egg") or obj.Name:lower():match("boss") or obj.Name:lower():match("dragon") or obj:FindFirstChildOfClass("Humanoid")
                        if isTarget then
                            createESP(obj)
                        end
                    end
                end
            end
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("EggESP") then
                    obj.EggESP:Destroy()
                end
            end
        end)
    end
end)

-- ==========================================
-- [Open / Close]
-- ==========================================
openButton.MouseButton1Click:Connect(function()
    if dashboard.Visible and scale.Scale > 0.5 then closeDashboard() else openDashboard() end
end)
closeButton.MouseButton1Click:Connect(closeDashboard)

openDashboard()

-- ==========================================
-- [ADMIN Title above head]
-- ==========================================
local function addAdminTitle(character)
    local head = character:WaitForChild("Head", 5)
    if not head then return end

    if head:FindFirstChild("AdminTitle") then
        head.AdminTitle:Destroy()
    end

    local bgui = Instance.new("BillboardGui")
    bgui.Name = "AdminTitle"
    bgui.Adornee = head
    bgui.Size = UDim2.new(0, 300, 0, 50)
    bgui.StudsOffset = Vector3.new(0, 2.5, 0)
    bgui.AlwaysOnTop = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = bgui

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, 8)
    layout.Parent = frame

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 28, 0, 28)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://7300408655"
    icon.Parent = frame

    local text = Instance.new("TextLabel")
    text.AutomaticSize = Enum.AutomaticSize.X
    text.Size = UDim2.new(0, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "[ADMIN] " .. player.Name
    text.TextColor3 = Color3.fromRGB(255, 50, 50)
    text.TextStrokeTransparency = 0
    text.Font = Enum.Font.GothamBlack
    text.TextSize = 25
    text.Parent = frame

    bgui.Parent = head
end

if player.Character then
    addAdminTitle(player.Character)
end
player.CharacterAdded:Connect(addAdminTitle)
