local PlaceId = game.PlaceId  -- الحصول على الـ PlaceId الحالي

-- تحميل Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()  
local Window = Rayfield:CreateWindow({
    Name = "drakthon",
    LoadingTitle = "loading drakrhon...",
    LoadingSubtitle = "by Drakthon",
    KeySystem = false
})

-- تبويبات عامة
local PlayerTab = Window:CreateTab("Player Settings")
local EffectsTab = Window:CreateTab("Effects")
local MiscTab = Window:CreateTab("Misc")
local FunTab = Window:CreateTab("Fun")
local TimeTab = Window:CreateTab("Time Settings")
local MusicTab = Window:CreateTab("Music")

-- تبويبات خاصة حسب الماب
if PlaceId == 2753915549 then
    -- إذا كان الماب Blox Fruits
    local BloxFruitsTab = Window:CreateTab("Blox Fruits")
    BloxFruitsTab:CreateButton({
        Name = "Run RedZ Hub",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
        end
    })
elseif PlaceId == 13772394625 or PlaceId == 16281300371 then
    -- إذا كان الماب Blade Ball
    local BladeBallTab = Window:CreateTab("Blade Ball")
    BladeBallTab:CreateButton({
        Name = "Auto Parry",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/UPD-Blade-Ball-Drop-Farm-10716"))()
        end
    })
elseif PlaceId == 9872472334 then
    -- إذا كان الماب Evade
    local EvadeTab = Window:CreateTab("Evade")
    EvadeTab:CreateButton({
        Name = "Load Evade Script",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Evade-Evade-The-Best-Free-GUI-Script-lots-of-Features-20718"))()
        end
    })
elseif PlaceId == 16200303170 then
    -- إذا كان الماب Project Smash
    local ProjectSmashTab = Window:CreateTab("Project Smash")
    ProjectSmashTab:CreateButton({
        Name = "Run Project Smash Script",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Project-Smash-OP-SCRIPT-12920"))()
        end
    })
end

-- باقي السكربتات العامة:

-- تبويب Player Settings
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

-- تبويب Effects
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

-- تبويب Fun
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
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
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
    Name = "Stop Camera Shake",
    Callback = function()
        game.Workspace.CurrentCamera.FieldOfView = 60
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

-- تبويب Time Settings
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

-- إضافة Dex في تبويب Player
PlayerTab:CreateButton({
    Name = "Enable Dex",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DexV2/DexV2/main/DexV2.lua"))()
    end
})
