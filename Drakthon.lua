local PlaceId = game.PlaceId  -- الحصول على الـ PlaceId الحالي

-- تحميل Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()  
local Window = Rayfield:CreateWindow({
    Name = "drakthon",        
    LoadingTitle = "loading drakrhon...", 
    LoadingSubtitle = "by Drakthon",     
    KeySystem = false                    
})

-- تبويبات
local PlayerTab = Window:CreateTab("Player Settings")
local EffectsTab = Window:CreateTab("Effects")
local MiscTab = Window:CreateTab("Misc")
local FunTab = Window:CreateTab("Fun")
local TimeTab = Window:CreateTab("Time Settings")

-- إضافة "Blox Fruits" فقط إذا كان الـ PlaceId مطابقًا
if PlaceId == 2753915549 then
    local BloxFruitsTab = Window:CreateTab("Blox Fruits")

    -- إضافة RedZ Hub
    BloxFruitsTab:CreateButton({
        Name = "RedZ Hub",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
        end
    })
end

-- إعدادات اللاعب
PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 10,
    Suffix = "Jump Power",
    CurrentValue = 50,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})

PlayerTab:CreateButton({
    Name = "Health Regen",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end
    end
})

-- التأثيرات
EffectsTab:CreateButton({
    Name = "Fire Effect",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        local fire = Instance.new("Fire")
        fire.Size = 10
        fire.Heat = 20
        fire.Parent = char.HumanoidRootPart
    end
})

EffectsTab:CreateButton({
    Name = "Sparkles Effect",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        local sparkles = Instance.new("Sparkles")
        sparkles.Parent = char.HumanoidRootPart
    end
})

-- ميزات التسلية
FunTab:CreateButton({
    Name = "Invisible",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1  
                    part.CanCollide = false
                end
            end
        end
    end
})

FunTab:CreateButton({
    Name = "Create Custom Weapon",
    Callback = function()
        local weapon = Instance.new("Tool")
        weapon.Name = "Super Sword"
        weapon.Parent = game.Players.LocalPlayer.Backpack
        weapon.GripPos = Vector3.new(0, 0, 0)
        weapon.ToolTip = "Super Weapon"
        weapon.Activated:Connect(function()
            for _, enemy in pairs(workspace:GetChildren()) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") then
                    enemy.Humanoid:TakeDamage(100)
                end
            end
        end)
    end
})

-- تبويب Misc
MiscTab:CreateButton({
    Name = "Camera Shake",
    Callback = function()
        local cameraShakeTween = game:GetService("TweenService"):Create(
            game.Workspace.CurrentCamera,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
            { FieldOfView = 70 }
        )
        cameraShakeTween:Play()
    end
})

MiscTab:CreateButton({
    Name = "Fly",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-gui-v3-30439"))()
    end
})

MiscTab:CreateButton({
    Name = "ESP",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Exunys-ESP-7126"))()
    end
})

MiscTab:CreateButton({
    Name = "NoClip",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Noclip-script-19755"))()
    end
})

MiscTab:CreateButton({
    Name = "Dex Explorer",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"))()
    end
})

MiscTab:CreateButton({
    Name = "Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
})

-- إعدادات الوقت
TimeTab:CreateSlider({
    Name = "Time of Day",
    Range = {0, 24},
    Increment = 0.1,
    Suffix = "Hour",
    CurrentValue = 12,
    Callback = function(value)
        game.Lighting.TimeOfDay = tostring(value) .. ":00:00"
    end
})

TimeTab:CreateButton({
    Name = "Freeze Time",
    Callback = function()
        game.Lighting.ClockTime = game.Lighting.ClockTime
    end
})

TimeTab:CreateButton({
    Name = "Unfreeze Time",
    Callback = function()
        game.Lighting.ClockTime = game.Lighting.ClockTime
    end
})
