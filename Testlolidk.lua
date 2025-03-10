-- الحصول على الـ PlaceId الحالي
local PlaceId = game.PlaceId  

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
local SocialTab = Window:CreateTab("Social")

-- تبويبات خاصة حسب الماب
if PlaceId == 2753915549 then
    local BloxFruitsTab = Window:CreateTab("Blox Fruits")
    BloxFruitsTab:CreateButton({
        Name = "Run RedZ Hub",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
        end
   })
elseif PlaceId == 189707 then
    local NaturalTab = Window:CreateTab("Natural")
    NaturalTab:CreateButton({
        Name = "NDS",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Natural-Disaster-Survival-NullFire-NDS-24033"))()
         end 
    })
    NaturalTab:CreateButton({
        Name = "i was here",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Natural-Disaster-Survival-I-was-here-3355"))()
        end
    })
elseif PlaceId == 2474168535 then
    local WestboundTab = Window:CreateTab("west bound")
    WestboundTab:CreateButton({
        Name = "Script1 only pc",
        Callback = function()
                loadstring(game:HttpGet("https://rawscripts.net/raw/Westbound-Speed-and-Aimbot-and-ESP-and-Teleports-and-More-6503"))()
         end 
    })
    WestboundTab:CreateButton({
        Name = "script2 only pc",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Westbound-pro-7125"))()
        end
    })
elseif PlaceId == 13772394625 or PlaceId == 16281300371 then
    local BladeBallTab = Window:CreateTab("Blade Ball")
    BladeBallTab:CreateButton({
        Name = "Auto Parry",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/UPD-Blade-Ball-Drop-Farm-10716"))()
        end
    })
elseif PlaceId == 9872472334 then
    local EvadeTab = Window:CreateTab("Evade")
    EvadeTab:CreateButton({
        Name = "Load Evade Script",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Evade-Evade-The-Best-Free-GUI-Script-lots-of-Features-20718"))()
        end
    })
elseif PlaceId == 116495829188952 then
    local DeadRailsTab = Window:CreateTab("Dead Rails")
    DeadRailsTab:CreateButton({
        Name = "SpiderX Hub",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Dead-Rails-Alpha-New-Update-SpiderXHub-30981"))()
        end
    })
elseif PlaceId == 16200303170 then
    local ProjectSmashTab = Window:CreateTab("Project Smash")
    ProjectSmashTab:CreateButton({
        Name = "Load Script",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Project-Smash-OP-SCRIPT-12920"))()
        end
    })
elseif PlaceId == 115110570222234 or PlaceId == 18668065416 then
    local BlueLockTab = Window:CreateTab("Blue Lock")
    BlueLockTab:CreateButton({
        Name = "Load Blue Lock Script",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/UPD-Blue-Lock:-Rivals-Rat-Hub-7-UNDETECTED-FREE-STYLE-CHANGER-AND-FLOW-NO-KEY-7-31266"))()
        end
    })
  BlueLockTab:CreateButton({
        Name = "script blue lock don ",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/UPD-Blue-Lock:-Rivals-Good-script-for-new-update-free-Don-Lorenzo-30729"))()
        end
    })
elseif PlaceId == 16732694052 then
    local FischTab = Window:CreateTab("Fisch")
    FischTab:CreateButton({
        Name = "Run Fisch Script",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Fisch-MOBY-Vixie-BEST-OP-AUTO-FISCH-KEYLESS-AND-FREE-30739"))()
        end
    })
elseif PlaceId == 142823291 then
    local MM2Tab = Window:CreateTab("MM2")
    MM2Tab:CreateButton({
        Name = "Run Oblivion AUTO EXE",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Oblivion-AUTO-EXE-V1-6063"))()
        end
    })
elseif PlaceId == 4924922222 then
    local BrookhavenTab = Window:CreateTab("Brookhaven")
    BrookhavenTab:CreateButton({
        Name = "Load Brookhaven RP Script",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-lraq-31077"))()
        end
    })
    BrookhavenTab:CreateButton({
        Name = "S7 Hub",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-S7-hub-30753"))()
        end
    })
end
})
elseif PlaceId == 107326628277908 then
    local beacarTab = Window:CreateTab("Be a Car")
    beacarTab:CreateButton({
        Name = "be a car script",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Be-a-Car-Inf-Csh-Frm-31206"))()
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

PlayerTab:CreateSlider({
    Name = "Health",
    Range = {0, 100},
    Increment = 1,
    Suffix = "Health",
    CurrentValue = 100,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.Health = value
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

-- تبويب Player Settings: إضافة Dex
PlayerTab:CreateButton({
    Name = "Enable Dex",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DexV2/DexV2/main/DexV2.lua"))()
    end
})

-- تبويب Social: دعوة سيرفر Discord
SocialTab:CreateButton({
    Name = "Join Our Discord",
    Callback = function()
        setclipboard("https://discord.gg/W3VwkUj6kf")
        print("تم نسخ رابط الدعوة إلى الحافظة!")
    end
})

-- تبويب Music: زر نسخ ID Map
MusicTab:CreateButton({
    Name = "Copy ID Map",
    Callback = function()
        setclipboard(tostring(PlaceId))
        print("تم نسخ ID الماب إلى الحافظة!")
    end
})
