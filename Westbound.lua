-- // إنشاء الـ GUI الرئيسي
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local TabsFrame = Instance.new("Frame")
local TeleportTab = Instance.new("TextButton")
local PlayerTab = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")

-- // إضافة إلى PlayerGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- // إعدادات الإطار الرئيسي
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- // العنوان
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "Westbound Script"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

-- // زر الإغلاق
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- // إطار التبويبات
TabsFrame.Size = UDim2.new(1, 0, 0, 40)
TabsFrame.Position = UDim2.new(0, 0, 0, 30)
TabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabsFrame.Parent = MainFrame

-- // زر التبويبات
local function CreateTabButton(name, position)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0.5, -5, 1, 0)
    TabButton.Position = UDim2.new(position, 0, 0, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 16
    TabButton.Parent = TabsFrame
    return TabButton
end

TeleportTab = CreateTabButton("Teleport", 0)
PlayerTab = CreateTabButton("Player", 0.5)

-- // إطار المحتوى
ContentFrame.Size = UDim2.new(1, -10, 1, -80)
ContentFrame.Position = UDim2.new(0, 5, 0, 80)
ContentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ContentFrame.Parent = MainFrame

UICorner2.CornerRadius = UDim.new(0, 10)
UICorner2.Parent = ContentFrame

-- // دالة لإنشاء الأزرار
local function CreateButton(parent, text, position, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Position = UDim2.new(0.05, 0, position, 0)
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 16
    Button.Parent = parent
    Button.MouseButton1Click:Connect(callback)
end

-- // وظائف التنقل
local function InstantTeleport(position)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

local function SmoothTeleport(position)
    local TweenService = game:GetService("TweenService")
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = player.Character.HumanoidRootPart
        local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local tweenGoal = {CFrame = CFrame.new(position)}
        local tween = TweenService:Create(rootPart, tweenInfo, tweenGoal)
        tween:Play()
    end
end

-- // محتوى تبويب "Teleport"
local TeleportFrame = Instance.new("Frame")
TeleportFrame.Size = UDim2.new(1, 0, 1, 0)
TeleportFrame.Parent = ContentFrame

CreateButton(TeleportFrame, "Instant TP - البنك", 0.1, function()
    InstantTeleport(Vector3.new(-260.8359680175781, 13.350004196166992, -171.7518310546875)) -- إحداثيات البنك
end)

CreateButton(TeleportFrame, "Smooth TP - المتجر", 0.3, function()
    SmoothTeleport(Vector3.new(700, 10, -100))
end)

CreateButton(TeleportFrame, "نسخ الإحداثيات", 0.5, function()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        setclipboard(tostring(player.Character.HumanoidRootPart.Position))
    end
end)

-- // محتوى تبويب "Player"
local PlayerFrame = Instance.new("Frame")
PlayerFrame.Size = UDim2.new(1, 0, 1, 0)
PlayerFrame.Parent = ContentFrame
PlayerFrame.Visible = false

CreateButton(PlayerFrame, "زيادة السرعة", 0.1, function()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 50
    end
end)

CreateButton(PlayerFrame, "تفعيل القفز العالي", 0.3, function()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 100
    end
end)

-- // التحكم في التبويبات
TeleportTab.MouseButton1Click:Connect(function()
    TeleportFrame.Visible = true
    PlayerFrame.Visible = false
end)

PlayerTab.MouseButton1Click:Connect(function()
    TeleportFrame.Visible = false
    PlayerFrame.Visible = true
end)

print("✅ سكربت GUI المحسن لـ Westbound جاهز!")
