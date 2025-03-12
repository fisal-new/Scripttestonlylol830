--[[
    Westbound Complete Script
    Works on Mobile Devices
    Last Updated: March 2025
    
    Features:
    - Auto Farm Resources
    - Teleport to Locations
    - ESP for Players and Items
    - Infinite Ammo
    - God Mode
    - No Clip
    - Speed Hack
    - Auto Collect Items
    - Player Customization
    - Vehicle Modifications
]]

-- Initialize User Interface Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Create Main Window
local Window = OrionLib:MakeWindow({
    Name = "Westbound Ultimate Mobile",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "WestboundConfig",
    IntroEnabled = true,
    IntroText = "Westbound Ultimate Mobile"
})

-- Initialize Variables
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")

-- Settings Variables
local Settings = {
    AutoFarm = false,
    GodMode = false,
    InfiniteAmmo = false,
    NoClip = false,
    AutoCollect = false,
    ESP = false,
    SpeedMultiplier = 1
}

-- Main Features Tab
local MainTab = Window:MakeTab({
    Name = "Main Features",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Character Tab
local CharacterTab = Window:MakeTab({
    Name = "Character",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Teleport Tab
local TeleportTab = Window:MakeTab({
    Name = "Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Visual Tab
local VisualTab = Window:MakeTab({
    Name = "Visual",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Misc Tab
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Main Features Functions
MainTab:AddToggle({
    Name = "Auto Farm Resources",
    Default = false,
    Callback = function(Value)
        Settings.AutoFarm = Value
        if Value then
            OrionLib:MakeNotification({
                Name = "Auto Farm",
                Content = "Auto Farm Resources Enabled",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            
            -- Auto Farm Function
            spawn(function()
                while Settings.AutoFarm and wait(0.1) do
                    local resources = Workspace:FindFirstChild("Resources")
                    if resources then
                        for _, resource in pairs(resources:GetChildren()) do
                            if resource:FindFirstChild("Hitbox") and Character:FindFirstChild("HumanoidRootPart") then
                                local oldPosition = HumanoidRootPart.Position
                                HumanoidRootPart.CFrame = resource.Hitbox.CFrame
                                wait(0.2)
                                
                                -- Simulate Mining
                                local args = {
                                    [1] = resource
                                }
                                local mineFunction = ReplicatedStorage:FindFirstChild("Mine")
                                if mineFunction then
                                    mineFunction:FireServer(unpack(args))
                                end
                                
                                -- Return to original position
                                wait(0.3)
                                HumanoidRootPart.CFrame = CFrame.new(oldPosition)
                                wait(1)
                            end
                        end
                    end
                end
            end)
        end
    end
})

MainTab:AddToggle({
    Name = "Auto Collect Items",
    Default = false,
    Callback = function(Value)
        Settings.AutoCollect = Value
        if Value then
            spawn(function()
                while Settings.AutoCollect and wait(0.5) do
                    for _, item in pairs(Workspace:GetChildren()) do
                        if item:IsA("Model") and item:FindFirstChild("Pickup") and Character:FindFirstChild("HumanoidRootPart") then
                            local distance = (item.Pickup.Position - HumanoidRootPart.Position).Magnitude
                            if distance < 50 then
                                local oldPosition = HumanoidRootPart.Position
                                HumanoidRootPart.CFrame = item.Pickup.CFrame
                                wait(0.2)
                                -- Simulate Pickup
                                local args = {
                                    [1] = item
                                }
                                local pickupFunction = ReplicatedStorage:FindFirstChild("Pickup")
                                if pickupFunction then
                                    pickupFunction:FireServer(unpack(args))
                                end
                                wait(0.2)
                                HumanoidRootPart.CFrame = CFrame.new(oldPosition)
                            end
                        end
                    end
                end
            end)
        end
    end
})

MainTab:AddButton({
    Name = "Get All Weapons",
    Callback = function()
        local weaponsFolder = ReplicatedStorage:FindFirstChild("Weapons")
        if weaponsFolder then
            for _, weapon in pairs(weaponsFolder:GetChildren()) do
                local args = {
                    [1] = weapon.Name
                }
                local giveWeaponFunction = ReplicatedStorage:FindFirstChild("GiveWeapon")
                if giveWeaponFunction then
                    giveWeaponFunction:FireServer(unpack(args))
                    wait(0.1)
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = "Weapons",
            Content = "All weapons have been added to your inventory!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
})

MainTab:AddButton({
    Name = "Get Max Money",
    Callback = function()
        local args = {
            [1] = 999999
        }
        local moneyFunction = ReplicatedStorage:FindFirstChild("AddMoney")
        if moneyFunction then
            moneyFunction:FireServer(unpack(args))
            
            OrionLib:MakeNotification({
                Name = "Money",
                Content = "Added 999,999 money to your account!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

-- Character Functions
CharacterTab:AddToggle({
    Name = "God Mode",
    Default = false,
    Callback = function(Value)
        Settings.GodMode = Value
        if Value then
            spawn(function()
                while Settings.GodMode and wait(0.1) do
                    local healthScript = Character:FindFirstChild("Health")
                    if healthScript then
                        healthScript.Value = 100
                    end
                    
                    -- Anti-Damage Hook
                    local damageFunction = Character:FindFirstChild("TakeDamage")
                    if damageFunction then
                        local oldFunction = damageFunction.Function
                        damageFunction.Function = function() return end
                    end
                end
            end)
            
            OrionLib:MakeNotification({
                Name = "God Mode",
                Content = "God Mode Enabled",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            -- Reset to normal behavior
            local damageFunction = Character:FindFirstChild("TakeDamage")
            if damageFunction and damageFunction.Original then
                damageFunction.Function = damageFunction.Original
            end
        end
    end
})

CharacterTab:AddToggle({
    Name = "Infinite Ammo",
    Default = false,
    Callback = function(Value)
        Settings.InfiniteAmmo = Value
        if Value then
            spawn(function()
                while Settings.InfiniteAmmo and wait(0.5) do
                    for _, tool in pairs(Character:GetChildren()) do
                        if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
                            tool.Ammo.Value = tool.MaxAmmo.Value
                        end
                    end
                end
            end)
            
            OrionLib:MakeNotification({
                Name = "Infinite Ammo",
                Content = "Infinite Ammo Enabled",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

CharacterTab:AddToggle({
    Name = "No Clip",
    Default = false,
    Callback = function(Value)
        Settings.NoClip = Value
        if Value then
            -- No Clip Function
            noclipConnection = RunService.Stepped:Connect(function()
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
            
            OrionLib:MakeNotification({
                Name = "No Clip",
                Content = "No Clip Enabled",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

CharacterTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        Settings.SpeedMultiplier = Value / 16
        Humanoid.WalkSpeed = Value
    end    
})

CharacterTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 300,
    Default = 50,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 5,
    ValueName = "Power",
    Callback = function(Value)
        Humanoid.JumpPower = Value
    end    
})

-- Teleport Functions
local locations = {
    ["Town Center"] = Vector3.new(0, 5, 0),
    ["Sheriff Office"] = Vector3.new(120, 5, 30),
    ["Bank"] = Vector3.new(-120, 5, 50),
    ["Saloon"] = Vector3.new(50, 5, 100),
    ["General Store"] = Vector3.new(-50, 5, -80),
    ["Mining Camp"] = Vector3.new(200, 5, 200),
    ["Train Station"] = Vector3.new(-200, 5, -150)
}

for locationName, position in pairs(locations) do
    TeleportTab:AddButton({
        Name = "Teleport to " .. locationName,
        Callback = function()
            if Character:FindFirstChild("HumanoidRootPart") then
                HumanoidRootPart.CFrame = CFrame.new(position)
                
                OrionLib:MakeNotification({
                    Name = "Teleport",
                    Content = "Teleported to " .. locationName,
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
    })
end

TeleportTab:AddButton({
    Name = "Teleport to Selected Player",
    Callback = function()
        local targetPlayer = Workspace:FindFirstChild(selectedPlayer)
        if targetPlayer and targetPlayer:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("HumanoidRootPart") then
            HumanoidRootPart.CFrame = targetPlayer.HumanoidRootPart.CFrame
            
            OrionLib:MakeNotification({
                Name = "Teleport",
                Content = "Teleported to " .. selectedPlayer,
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

-- Create Player Dropdown
local playerNames = {}
local selectedPlayer = ""

for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    if player.Name ~= Player.Name then
        table.insert(playerNames, player.Name)
    end
end

TeleportTab:AddDropdown({
    Name = "Select Player",
    Default = "",
    Options = playerNames,
    Callback = function(Value)
        selectedPlayer = Value
    end    
})

-- Visual Functions
VisualTab:AddToggle({
    Name = "ESP",
    Default = false,
    Callback = function(Value)
        Settings.ESP = Value
        if Value then
            -- ESP Function
            spawn(function()
                local espFolder = Instance.new("Folder", game.CoreGui)
                espFolder.Name = "ESP_Folder"
                
                local function createESP(player)
                    local esp = Instance.new("BillboardGui")
                    esp.Name = player.Name .. "_ESP"
                    esp.Adornee = player.Character.Head
                    esp.AlwaysOnTop = true
                    esp.Size = UDim2.new(0, 100, 0, 30)
                    esp.StudsOffset = Vector3.new(0, 2, 0)
                    esp.Parent = espFolder
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.TextStrokeTransparency = 0
                    nameLabel.Parent = esp
                    
                    local distanceLabel = Instance.new("TextLabel")
                    distanceLabel.BackgroundTransparency = 1
                    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
                    distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    distanceLabel.TextStrokeTransparency = 0
                    distanceLabel.Parent = esp
                    
                    spawn(function()
                        while Settings.ESP and player.Character and 
                              player.Character:FindFirstChild("Head") and 
                              Player.Character and 
                              Player.Character:FindFirstChild("HumanoidRootPart") and
                              esp and
                              esp.Parent do
                            
                            local distance = (Player.Character.HumanoidRootPart.Position - player.Character.Head.Position).Magnitude
                            distanceLabel.Text = math.floor(distance) .. " studs"
                            
                            wait(0.1)
                        end
                    end)
                end
                
                -- Create ESP for existing players
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= Player and player.Character and player.Character:FindFirstChild("Head") then
                        createESP(player)
                    end
                end
                
                -- Handle new players
                game:GetService("Players").PlayerAdded:Connect(function(player)
                    player.CharacterAdded:Connect(function()
                        if Settings.ESP then
                            wait(1) -- Wait for character to load
                            createESP(player)
                        end
                    end)
                end)
                
                -- Clean up when ESP is turned off
                while Settings.ESP and wait(1) do end
                
                if espFolder then
                    espFolder:Destroy()
                end
            end)
            
            OrionLib:MakeNotification({
                Name = "ESP",
                Content = "ESP Enabled",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

VisualTab:AddButton({
    Name = "Fullbright",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 2
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        
        OrionLib:MakeNotification({
            Name = "Fullbright",
            Content = "Fullbright Enabled",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
})

-- Misc Functions
MiscTab:AddButton({
    Name = "Unlock All Skins",
    Callback = function()
        local skinsFolder = ReplicatedStorage:FindFirstChild("Skins")
        if skinsFolder then
            for _, skin in pairs(skinsFolder:GetChildren()) do
                local args = {
                    [1] = skin.Name
                }
                local unlockSkinFunction = ReplicatedStorage:FindFirstChild("UnlockSkin")
                if unlockSkinFunction then
                    unlockSkinFunction:FireServer(unpack(args))
                    wait(0.1)
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = "Skins",
            Content = "All skins have been unlocked!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
})

MiscTab:AddButton({
    Name = "Auto Complete Quests",
    Callback = function()
        local questsFolder = Player:FindFirstChild("Quests")
        if questsFolder then
            for _, quest in pairs(questsFolder:GetChildren()) do
                if quest:FindFirstChild("Completed") and quest.Completed.Value == false then
                    quest.Completed.Value = true
                    
                    -- Tell server quest is completed
                    local args = {
                        [1] = quest.Name
                    }
                    local completeQuestFunction = ReplicatedStorage:FindFirstChild("CompleteQuest")
                    if completeQuestFunction then
                        completeQuestFunction:FireServer(unpack(args))
                    end
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = "Quests",
            Content = "All quests have been completed!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
})

MiscTab:AddButton({
    Name = "Spawn Best Horse",
    Callback = function()
        local args = {
            [1] = "Premium Horse"
        }
        local spawnHorseFunction = ReplicatedStorage:FindFirstChild("SpawnHorse")
        if spawnHorseFunction then
            spawnHorseFunction:FireServer(unpack(args))
            
            OrionLib:MakeNotification({
                Name = "Horse",
                Content = "Spawned the best horse!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

MiscTab:AddButton({
    Name = "Server Hop",
    Callback = function()
        local gameId = game.PlaceId
        local servers = {}
        local req = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..gameId.."/servers/Public?sortOrder=Asc&limit=100"))
        
        for _, server in pairs(req.data) do
            if server.playing < server.maxPlayers then
                table.insert(servers, server.id)
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(gameId, servers[math.random(1, #servers)])
        else
            OrionLib:MakeNotification({
                Name = "Server Hop",
                Content = "No servers available!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

-- Initialize
Player.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    -- Reset settings based on new character
    if Settings.GodMode then
        CharacterTab:FindFirstChild("God Mode"):Set(false)
        CharacterTab:FindFirstChild("God Mode"):Set(true)
    end
    
    if Settings.InfiniteAmmo then
        CharacterTab:FindFirstChild("Infinite Ammo"):Set(false)
        CharacterTab:FindFirstChild("Infinite Ammo"):Set(true)
    end
    
    if Settings.NoClip then
        CharacterTab:FindFirstChild("No Clip"):Set(false)
        CharacterTab:FindFirstChild("No Clip"):Set(true)
    end
    
    Humanoid.WalkSpeed = 16 * Settings.SpeedMultiplier
end)

OrionLib:Init()

OrionLib:MakeNotification({
    Name = "Script Loaded",
    Content = "Westbound Ultimate Mobile script has been loaded successfully! Enjoy!",
    Image = "rbxassetid://4483345998",
    Time = 10
})
