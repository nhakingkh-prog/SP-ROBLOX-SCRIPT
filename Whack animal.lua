local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "SP_Roblox_Script_GUI"
gui.ResetOnSpawn = false

-- ធ្វើឲ្យ Support ជាមួយគ្រប់កម្មវិធី Executors ទាំងអស់
local success, error = pcall(function()
    gui.Parent = (gethui and gethui()) or game.CoreGui
end)
if not success then
    gui.Parent = player:WaitForChild("PlayerGui")
end

-- ==========================================
-- [ប៊ូតុងបើកផ្ទាំង]
-- ==========================================
local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 100, 0, 40)
openButton.Position = UDim2.new(0, 20, 0.5, 0)
openButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Text = "SP SCRIPT"
openButton.Font = Enum.Font.SourceSansBold
openButton.TextSize = 18
openButton.Parent = gui

-- ==========================================
-- [ផ្ទាំង Dashboard គោល]
-- ==========================================
local dashboard = Instance.new("Frame")
dashboard.Name = "Dashboard"
dashboard.Size = UDim2.new(0, 400, 0, 380) 
dashboard.Position = UDim2.new(0.5, -200, 0.5, -190)
dashboard.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
dashboard.BorderSizePixel = 0
dashboard.Visible = true 
dashboard.Active = true
dashboard.Draggable = true 
dashboard.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "       SP ROBLOX SCRIPT" -- រុញអក្សរទៅស្តាំបន្តិចដើម្បីទុកកន្លែងដាក់ Logo
title.Font = Enum.Font.FredokaOne
title.TextSize = 22
title.Parent = dashboard

-- ==========================================
-- [កូដបង្ហាញរូប Logo របស់អ្នក]
-- ==========================================
local logoImage = Instance.new("ImageLabel")
logoImage.Size = UDim2.new(0, 30, 0, 30) 
logoImage.Position = UDim2.new(0, 10, 0, 5) 
logoImage.BackgroundTransparency = 1
logoImage.Image = "rbxassetid://116345727167504" -- លេខ ID Logo របស់អ្នក
logoImage.Parent = title

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -40, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.TextColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.Parent = dashboard

-- អថេរទាំងអស់
_G.RunFast = false
_G.AutoSwing = false
_G.AntiChase = false
_G.AutoGrabTP = false
_G.AutoSnipeExclusive = false 
_G.ESPEggs = false
local savedBaseCFrame = nil 

-- ==========================================
-- [1. ប៊ូតុង រត់លឿន]
-- ==========================================
local runBtn = Instance.new("TextButton")
runBtn.Size = UDim2.new(0, 360, 0, 30)
runBtn.Position = UDim2.new(0, 20, 0, 50)
runBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
runBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
runBtn.Text = "Run Fast: OFF"
runBtn.Font = Enum.Font.SourceSansBold
runBtn.TextSize = 16
runBtn.Parent = dashboard

runBtn.MouseButton1Click:Connect(function()
    _G.RunFast = not _G.RunFast
    if _G.RunFast then
        runBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        runBtn.Text = "Run Fast: ON"
        spawn(function()
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
    else
        runBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        runBtn.Text = "Run Fast: OFF"
    end
end)

-- ==========================================
-- [2. ប៊ូតុង វាយស្វ័យប្រវត្តិ]
-- ==========================================
local swingBtn = Instance.new("TextButton")
swingBtn.Size = UDim2.new(0, 360, 0, 30)
swingBtn.Position = UDim2.new(0, 20, 0, 90)
swingBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
swingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
swingBtn.Text = "Auto Swing: OFF"
swingBtn.Font = Enum.Font.SourceSansBold
swingBtn.TextSize = 16
swingBtn.Parent = dashboard

swingBtn.MouseButton1Click:Connect(function()
    _G.AutoSwing = not _G.AutoSwing
    if _G.AutoSwing then
        swingBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        swingBtn.Text = "Auto Swing: ON"
        spawn(function()
            while _G.AutoSwing do
                task.wait(0.01) 
                local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end)
    else
        swingBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        swingBtn.Text = "Auto Swing: OFF"
    end
end)

-- ==========================================
-- [3. ប៊ូតុង កុំអោយសត្វដេញ]
-- ==========================================
local chaseBtn = Instance.new("TextButton")
chaseBtn.Size = UDim2.new(0, 360, 0, 30)
chaseBtn.Position = UDim2.new(0, 20, 0, 130)
chaseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
chaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
chaseBtn.Text = "Anti Chase: OFF"
chaseBtn.Font = Enum.Font.SourceSansBold
chaseBtn.TextSize = 16
chaseBtn.Parent = dashboard

chaseBtn.MouseButton1Click:Connect(function()
    _G.AntiChase = not _G.AntiChase
    if _G.AntiChase then
        chaseBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        chaseBtn.Text = "Anti Chase: ON"
        spawn(function()
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
    else
        chaseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        chaseBtn.Text = "Anti Chase: OFF"
    end
end)

-- ==========================================
-- [4. ប៊ូតុង កំណត់ទីតាំង Forest Zone]
-- ==========================================
local setBaseBtn = Instance.new("TextButton")
setBaseBtn.Size = UDim2.new(0, 360, 0, 30)
setBaseBtn.Position = UDim2.new(0, 20, 0, 175)
setBaseBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
setBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setBaseBtn.Text = "1. Set Base (Stand here & Click)"
setBaseBtn.Font = Enum.Font.SourceSansBold
setBaseBtn.TextSize = 16
setBaseBtn.Parent = dashboard

setBaseBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedBaseCFrame = player.Character.HumanoidRootPart.CFrame
        setBaseBtn.Text = "Base Saved!"
        setBaseBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        task.wait(1.5)
        setBaseBtn.Text = "1. Update Base Location"
        setBaseBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    end
end)

-- ==========================================
-- [5. ប៊ូតុង Auto Grab & TP]
-- ==========================================
local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Size = UDim2.new(0, 360, 0, 30)
autoFarmBtn.Position = UDim2.new(0, 20, 0, 215)
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmBtn.Text = "2. Auto Grab Prompt & TP: OFF"
autoFarmBtn.Font = Enum.Font.SourceSansBold
autoFarmBtn.TextSize = 16
autoFarmBtn.Parent = dashboard

autoFarmBtn.MouseButton1Click:Connect(function()
    if not savedBaseCFrame then
        autoFarmBtn.Text = "Please Set Base First!"
        task.wait(1.5)
        autoFarmBtn.Text = "2. Auto Grab Prompt & TP: OFF"
        return
    end

    _G.AutoGrabTP = not _G.AutoGrabTP
    if _G.AutoGrabTP then
        autoFarmBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        autoFarmBtn.Text = "2. Auto Grab Prompt & TP: ON"
        spawn(function()
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
    else
        autoFarmBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        autoFarmBtn.Text = "2. Auto Grab Prompt & TP: OFF"
    end
end)

-- ==========================================
-- [6. ប៊ូតុងថ្មី: Auto Snipe Exclusive Egg]
-- ==========================================
local snipeBtn = Instance.new("TextButton")
snipeBtn.Size = UDim2.new(0, 360, 0, 35)
snipeBtn.Position = UDim2.new(0, 20, 0, 255)
snipeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 255) 
snipeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
snipeBtn.Text = "3. Auto Snipe Exclusive Egg: OFF"
snipeBtn.Font = Enum.Font.SourceSansBold
snipeBtn.TextSize = 16
snipeBtn.Parent = dashboard

snipeBtn.MouseButton1Click:Connect(function()
    if not savedBaseCFrame then
        snipeBtn.Text = "Please Set Base First!"
        task.wait(1.5)
        snipeBtn.Text = "3. Auto Snipe Exclusive Egg: OFF"
        return
    end

    _G.AutoSnipeExclusive = not _G.AutoSnipeExclusive
    if _G.AutoSnipeExclusive then
        snipeBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        snipeBtn.Text = "3. Auto Snipe Exclusive Egg: ON"
        
        spawn(function()
            while _G.AutoSnipeExclusive do
                task.wait(0.5)
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then continue end

                local targetEgg = nil
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj ~= char and not game.Players:GetPlayerFromCharacter(obj) then
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
    else
        snipeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 255)
        snipeBtn.Text = "3. Auto Snipe Exclusive Egg: OFF"
    end
end)

-- ==========================================
-- [7. ESP Eggs (បង្ហាញតម្លៃពងទា និងសត្វចិញ្ចឹម)]
-- ==========================================
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0, 360, 0, 35)
espBtn.Position = UDim2.new(0, 20, 0, 310)
espBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.Text = "ESP Eggs (Show Value): OFF"
espBtn.Font = Enum.Font.SourceSansBold
espBtn.TextSize = 16
espBtn.Parent = dashboard

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

espBtn.MouseButton1Click:Connect(function()
    _G.ESPEggs = not _G.ESPEggs
    if _G.ESPEggs then
        espBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        espBtn.Text = "ESP Eggs (Show Value): ON"
        spawn(function()
            while _G.ESPEggs do
                task.wait(1)
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj ~= player.Character and not game.Players:GetPlayerFromCharacter(obj) then
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
    else
        espBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        espBtn.Text = "ESP Eggs (Show Value): OFF"
    end
end)

-- ដំណើរការប៊ូតុងបើកបិទ Dashboard
openButton.MouseButton1Click:Connect(function() dashboard.Visible = not dashboard.Visible end)
closeButton.MouseButton1Click:Connect(function() dashboard.Visible = false end)

-- ==========================================
-- [មុខងារបង្ហាញឈ្មោះ ADMIN និងសញ្ញាគ្រីស លើក្បាល]
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
    
    layout.Parent = frame
    frame.Parent = bgui
    bgui.Parent = head
end

if player.Character then
    addAdminTitle(player.Character)
end
player.CharacterAdded:Connect(addAdminTitle)
