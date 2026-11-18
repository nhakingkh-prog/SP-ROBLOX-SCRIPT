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
dashboard.Size = UDim2.new(0, 400, 0, 380) -- បង្កើនកម្ពស់ដើម្បីដាក់ប៊ូតុង ESP
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
title.Text = "SP ROBLOX SCRIPT"
title.Font = Enum.Font.FredokaOne
title.TextSize = 22
title.Parent = dashboard

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
_G.ESPEggs = false -- អថេរសម្រាប់ ESP
local savedBaseCFrame = nil 

-- ==========================================
-- [1. ប៊ូតុង រត់លឿន]
-- ==========================================
local runBtn = Instance.new("TextButton")
runBtn.Size = UDim2.new(0, 360, 0, 35)
runBtn.Position = UDim2.new(0, 20, 0, 55)
runBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
runBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
runBtn.Text = "Run Fast: OFF"
runBtn.Font = Enum.Font.SourceSansBold
runBtn.TextSize = 18
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
swingBtn.Size = UDim2.new(0, 360, 0, 35)
swingBtn.Position = UDim2.new(0, 20, 0, 100)
swingBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
swingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
swingBtn.Text = "Auto Swing: OFF"
swingBtn.Font = Enum.Font.SourceSansBold
swingBtn.TextSize = 18
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
chaseBtn.Size = UDim2.new(0, 360, 0, 35)
chaseBtn.Position = UDim2.new(0, 20, 0, 145)
chaseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
chaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
chaseBtn.Text = "Anti Chase: OFF"
chaseBtn.Font = Enum.Font.SourceSansBold
chaseBtn.TextSize = 18
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
setBaseBtn.Size = UDim2.new(0, 360, 0, 35)
setBaseBtn.Position = UDim2.new(0, 20, 0, 200)
setBaseBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
setBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setBaseBtn.Text = "1. Set Forest Zone (Stand here & Click)"
setBaseBtn.Font = Enum.Font.SourceSansBold
setBaseBtn.TextSize = 16
setBaseBtn.Parent = dashboard

setBaseBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedBaseCFrame = player.Character.HumanoidRootPart.CFrame
        setBaseBtn.Text = "Forest Zone Saved!"
        setBaseBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        task.wait(1.5)
        setBaseBtn.Text = "1. Update Forest Zone Location"
        setBaseBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    end
end)

-- ==========================================
-- [5. ប៊ូតុង Auto Grab & TP]
-- ==========================================
local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Size = UDim2.new(0, 360, 0, 40)
autoFarmBtn.Position = UDim2.new(0, 20, 0, 245)
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmBtn.Text = "2. Auto Grab & TP Forest: OFF"
autoFarmBtn.Font = Enum.Font.SourceSansBold
autoFarmBtn.TextSize = 18
autoFarmBtn.Parent = dashboard

autoFarmBtn.MouseButton1Click:Connect(function()
    if not savedBaseCFrame then
        autoFarmBtn.Text = "Please Set Forest Zone First!"
        task.wait(1.5)
        autoFarmBtn.Text = "2. Auto Grab & TP Forest: OFF"
        return
    end

    _G.AutoGrabTP = not _G.AutoGrabTP
    if _G.AutoGrabTP then
        autoFarmBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        autoFarmBtn.Text = "2. Auto Grab & TP Forest: ON"
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
        autoFarmBtn.Text = "2. Auto Grab & TP Forest: OFF"
    end
end)

-- ==========================================
-- [6. ប៊ូតុងថ្មី: ESP Eggs (បង្ហាញតម្លៃពងទា)]
-- ==========================================
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0, 360, 0, 35)
espBtn.Position = UDim2.new(0, 20, 0, 295)
espBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.Text = "ESP Eggs (Show Value): OFF"
espBtn.Font = Enum.Font.SourceSansBold
espBtn.TextSize = 18
espBtn.Parent = dashboard

-- មុខងារកំណត់ពណ៌ និងឈ្មោះ Value តាមសត្វ
local function getEggValueInfo(rawName)
    local nameLower = rawName:lower()
    if nameLower:match("mythic") then
        return "Mythic", Color3.fromRGB(255, 50, 255) -- ពណ៌ស្វាយ
    elseif nameLower:match("legendary") then
        return "Legendary", Color3.fromRGB(255, 100, 50) -- ពណ៌ទឹកក្រូច
    elseif nameLower:match("epic") then
        return "Epic", Color3.fromRGB(200, 50, 255) -- ពណ៌ស្វាយចាស់
    elseif nameLower:match("rare") then
        return "Rare", Color3.fromRGB(50, 150, 255) -- ពណ៌ខៀវ
    elseif nameLower:match("uncommon") then
        return "Uncommon", Color3.fromRGB(50, 255, 100) -- ពណ៌បៃតង
    else
        return "Common", Color3.fromRGB(200, 200, 200) -- ពណ៌ប្រផេះ
    end
end

-- មុខងារបង្កើតអក្សរលើក្បាលសត្វ (ESP)
local function createESP(obj)
    if obj:FindFirstChild("EggESP") then return end
    local root = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildOfClass("Part") or obj:FindFirstChildOfClass("MeshPart")
    if not root then return end

    local valueStr, color = getEggValueInfo(obj.Name)

    local bgui = Instance.new("BillboardGui")
    bgui.Name = "EggESP"
    bgui.Adornee = root
    bgui.Size = UDim2.new(0, 100, 0, 40)
    bgui.StudsOffset = Vector3.new(0, 3, 0)
    bgui.AlwaysOnTop = true

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = valueStr
    text.TextColor3 = color
    text.TextStrokeTransparency = 0 
    text.Font = Enum.Font.GothamBold
    text.TextSize = 14
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
            -- លុប ESP ចោលពេលបិទ (OFF)
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
    
    -- លុបចាស់ចេញបើមាន
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

    -- រូបភាពសញ្ញាគ្រីស (Verified Tick)
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 28, 0, 28)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://7300408655" 
    icon.Parent = frame

    -- អក្សរឈ្មោះ
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
