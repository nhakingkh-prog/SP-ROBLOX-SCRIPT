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
dashboard.Size = UDim2.new(0, 400, 0, 420) -- បង្កើនកម្ពស់ដើម្បីដាក់ប៊ូតុង Telegram
dashboard.Position = UDim2.new(0.5, -200, 0.5, -210)
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
                    if obj:Is
