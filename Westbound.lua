-- Westbound Mobile Complete Script (Optimized for Direct Loadstring)
-- Works with: loadstring(game:HttpGet(""))()

-- Ensure the UI Library loads correctly
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
if not OrionLib then
    warn("Failed to load Orion UI Library! Trying alternative method...")
    OrionLib = loadstring(game:HttpGet("https://pastebin.com/raw/xLRUSiKx"))()
    if not OrionLib then
        error("Could not load UI library - please check your internet connection")
        return
    end
end

-- Making sure the script works on mobile
local isMobile = (game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled)
if isMobile then
    -- Mobile-specific optimizations
    game:GetService("UserInputService").TouchTapInWorld:Connect(function()
        -- This helps with mobile input
    end)
end

-- Initialize Variables
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")

-- Create Main Window - Simplified UI for mobile
local Window = OrionLib:MakeWindow({
    Name = "Westbound Mobile v2.0",
    HidePremium = true, -- Better for mobile
    SaveConfig = true,
    ConfigFolder = "WestboundMobile",
    IntroEnabled = true,
    IntroText = "Westbound Mobile"
})

-- Notification to confirm script is running
OrionLib:MakeNotification({
    Name = "Script is Running",
    Content = "Westbound Mobile script is now active!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

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
    Name = "💰 Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Character Tab
local CharacterTab = Window:MakeTab({
    Name = "👤 Character",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Teleport Tab
local TeleportTab = Window:MakeTab({
    Name = "🌐 Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Visual Tab
local VisualTab = Window:MakeTab({
    Name = "👁️ Visual",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Misc Tab
local MiscTab = Window:MakeTab({
    Name = "⚙️ Misc",
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
                    pcall(function()
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
                    end)
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
                    pcall(function()
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
                    end)
                end
            end)
        end
    end
})

MainTab:AddButton({
    Name = "Get All Weapons",
    Callback = function()
        pcall(function()
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
        end)
    end
})

MainTab:AddButton({
    Name = "Get Max Money (999,999)",
    Callback = function()
        pcall(function()
            local args = {
                [1] = 999999
            }
            local moneyFunction = ReplicatedStorage:FindFirstChild("AddMoney") or ReplicatedStorage:FindFirstChild("Money")
            if moneyFunction then
                moneyFunction:FireServer(unpack(args))
                
                OrionLib:MakeNotification({
                    Name = "Money",
                    Content = "Added 999,999 money to your account!",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            else
                -- Try alternative money paths
                for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                    if v:IsA("RemoteEvent") and (v.Name:lower():find("money") or v.Name:lower():find("cash") or v.Name:lower():find("currency")) then
                        v:FireServer(999999)
                        
                        OrionLib:MakeNotification({
                            Name = "Money",
                            Content = "Attempted to add money using alternative method",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        })
                        break
                    end
                end
            end
        end)
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
                    pcall(function()
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
                        
                        -- Alternative health methods
                        if Character:FindFirstChildOfClass("Humanoid") then
                            Character:FindFirstChildOfClass("Humanoid").Health = Character:FindFirstChildOfClass("Humanoid").MaxHealth
                        end
                    end)
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
            pcall(function()
                local damageFunction = Character:FindFirstChild("TakeDamage")
                if damageFunction and damageFunction.Original then
                    damageFunction.Function = damageFunction.Original
                end
            end)
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
                    pcall(function()
                        for _, tool in pairs(Character:GetChildren()) do
                            if tool:IsA("Tool") then
                                -- Find ammo values
                                local ammo = tool:FindFirstChild("Ammo") or tool:FindFirstChild("AmmoCount") or tool:FindFirstChild("CurrentAmmo")
                                local maxAmmo = tool:FindFirstChild("MaxAmmo") or tool:FindFirstChild("MaxAmmoCount")
                                
                                if ammo and maxAmmo then
                                    ammo.Value = maxAmmo.Value
                                elseif ammo and not maxAmmo then
                                    ammo.Value = 999
                                end
                                
                                -- Find and bypass reload cooldowns
                                local reloadCooldown = tool:FindFirstChild("ReloadCooldown")
                                if reloadCooldown then
                                    reloadCooldown.Value = 0
                                end
                            end
                        end
                    end)
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
                pcall(function()
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
            end)
            
            OrionLib:MakeNotification({
                Name = "No Clip",
                Content = "No Clip Enabled - You can walk through walls",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                pcall(function()
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.CanCollide = true
                        end
                    end
                end)
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
        pcall(function()
            Settings.SpeedMultiplier = Value / 16
            Humanoid.WalkSpeed = Value
        end)
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
        pcall(function()
            Humanoid.JumpPower = Value
        end)
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
            pcall(function()
                if Character:FindFirstChild("HumanoidRootPart") then
                    HumanoidRootPart.CFrame = CFrame.new(position)
                    
                    OrionLib:MakeNotification({
                        Name = "Teleport",
                        Content = "Teleported to " .. locationName,
                        Image = "rbxassetid://4483345998",
                        Time = 3
                    })
                end
            end)
        end
    })
end

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

TeleportTab:AddButton({
    Name = "Teleport to Selected Player",
    Callback = function()
        pcall(function()
            if selectedPlayer ~= "" then
                local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayer)
                if targetPlayer and targetPlayer.Character and 
                   targetPlayer.Character:FindFirstChild("HumanoidRootPart") and 
                   Character:FindFirstChild("HumanoidRootPart") then
                   
                    HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                    
                    OrionLib:MakeNotification({
                        Name = "Teleport",
                        Content = "Teleported to " .. selectedPlayer,
                        Image = "rbxassetid://4483345998",
                        Time = 3
                    })
                end
            else
                OrionLib:MakeNotification({
                    Name = "Error",
                    Content = "Please select a player first!",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
            end
        end)
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
                pcall(function()
                    local espFolder = Instance.new("Folder")
                    espFolder.Name = "ESP_Folder"
                    espFolder.Parent = game.CoreGui
                    
                    local function createESP(player)
                        if player.Name ~= Player.Name and player.Character and player.Character:FindFirstChild("Head") then
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
                                while Settings.ESP and 
                                      player and 
                                      player.Character and 
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
                    end
                    
                    -- Create ESP for existing players
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        createESP(player)
                    end
                    
                    -- Handle new players
                    game:GetService("Players").PlayerAdded:Connect(function(player)
                        if Settings.ESP then
                            player.CharacterAdded:Connect(function()
                                wait(1) -- Wait for character to load
                                createESP(player)
                            end)
                        end
                    end)
                    
                    -- Clean up when ESP is turned off
                    while Settings.ESP and wait(1) do end
                    
                    if espFolder then
                        espFolder:Destroy()
                    end
                end)
            end)
            
            OrionLib:MakeNotification({
                Name = "ESP",
                Content = "ESP Enabled - You can see all players",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

VisualTab:AddButton({
    Name = "Fullbright",
    Callback = function()
        pcall(function()
            local Lighting = game:GetService("Lighting")
            Lighting.Brightness = 2
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            
            -- Save original lighting settings for restore
            _G.OriginalLightingSettings = {
                Brightness = Lighting.Brightness,
                ClockTime = Lighting.ClockTime,
                FogEnd = Lighting.FogEnd,
                GlobalShadows = Lighting.GlobalShadows,
                OutdoorAmbient = Lighting.OutdoorAmbient
            }
            
            OrionLib:MakeNotification({
                Name = "Fullbright",
                Content = "Fullbright Enabled - Map is now fully bright",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end)
    end
})

-- Misc Functions
MiscTab:AddButton({
    Name = "Unlock All Skins",
    Callback = function()
        pcall(function()
            local foundSkins = false
            
            -- Try multiple paths for skins
            local skinPaths = {
                ReplicatedStorage:FindFirstChild("Skins"),
                ReplicatedStorage:FindFirstChild("PlayerSkins"),
                ReplicatedStorage:FindFirstChild("Cosmetics"),
                game:GetService("ReplicatedStorage"):FindFirstChild("Skins")
            }
            
            for _, skinsFolder in pairs(skinPaths) do
                if skinsFolder then
                    foundSkins = true
                    for _, skin in pairs(skinsFolder:GetChildren()) do
                        local args = {
                            [1] = skin.Name
                        }
                        
                        -- Try different remote names
                        local unlockFunctions = {
                            ReplicatedStorage:FindFirstChild("UnlockSkin"),
                            ReplicatedStorage:FindFirstChild("EquipSkin"),
                            ReplicatedStorage:FindFirstChild("PurchaseSkin"),
                            ReplicatedStorage:FindFirstChild("GetSkin")
                        }
                        
                        for _, func in pairs(unlockFunctions) do
                            if func then
                                func:FireServer(unpack(args))
                                wait(0.05)
                            end
                        end
                    end
                end
            end
            
            if not foundSkins then
                -- Backup method - try to find any skin-related remotes
                for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                    if v:IsA("RemoteEvent") and (v.Name:lower():find("skin") or v.Name:lower():find("cosmetic") or v.Name:lower():find("outfit")) then
                        v:FireServer("all")
                        v:FireServer("unlock_all")
                        v:FireServer(true)
                        wait(0.05)
                    end
                end
            end
            
            OrionLib:MakeNotification({
                Name = "Skins",
                Content = "Attempted to unlock all skins!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end)
    end
})

MiscTab:AddButton({
    Name = "Auto Complete Quests",
    Callback = function()
        pcall(function()
            local foundQuests = false
            
            -- Look for quests in player
            local questsFolder = Player:FindFirstChild("Quests")
            if questsFolder then
                foundQuests = true
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
            
            -- Try alternative quest locations
            if not foundQuests then
                for _, questFolder in pairs({Player, ReplicatedStorage, game:GetService("ReplicatedStorage")}) do
                    for _, folder in pairs(questFolder:GetChildren()) do
                        if folder.Name:lower():find("quest") or folder.Name:lower():find("mission") or folder.Name:lower():find("task") then
                            foundQuests = true
                            -- Fire generic completion events
                            for _, questEvent in pairs(ReplicatedStorage:GetDescendants()) do
                                if questEvent:IsA("RemoteEvent") and (questEvent.Name:lower():find("quest") or questEvent.Name:lower():find("complete") or questEvent.Name:lower():find("mission")) then
                                    questEvent:FireServer("complete_all")
                                    questEvent:FireServer("complete")
                                    questEvent:FireServer(true)
                                    questEvent:FireServer("all")
                                end
                            end
                            break
                        end
                    end
                    if foundQuests then break end
                end
            end
            
            OrionLib:MakeNotification({
                Name = "Quests",
                Content = "Attempted to complete all quests!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end)
    end
})

MiscTab:AddButton({
    Name = "Spawn Best Horse",
    Callback = function()
        pcall(function()
            local horseNames = {"Premium Horse", "Fast Horse", "Best Horse", "Golden Horse", "Elite Horse"}
            
            local spawnFunctions = {
                ReplicatedStorage:FindFirstChild("SpawnHorse"),
                ReplicatedStorage:FindFirstChild("SummonHorse"),
                ReplicatedStorage:FindFirstChild("GetHorse"),
                ReplicatedStorage:FindFirstChild("RequestHorse")
            }
            
            local success = false
            for _, func in pairs(spawnFunctions) do
                if func then
                    for _, horseName in pairs(horseNames) do
                        local args = {
                            [1] = horseName
                        }
                        func:FireServer(unpack(args))
                        wait(0.1)
                    end
                    success = true
                end
            end
            
            if not success then
                -- Backup method - try to find any horse-related remotes
                for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                    if v:IsA("RemoteEvent") and (v.Name:lower():find("horse") or v.Name:lower():find("mount") or v.Name:lower():find("animal")) then
                        v:FireServer("best")
                        v:FireServer("premium")
                        v:FireServer("gold")
                        wait(0.1)
                    end
                end
            end
            
            OrionLib:MakeNotification({
                Name = "Horse",
                Content = "Attempted to spawn the best horse!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end)
    end
})

MiscTab:AddButton({
    Name = "Server Hop",
    Callback = function()
        pcall(function()
            local gameId = game.PlaceId
            local servers = {}
            
            OrionLib:MakeNotification({
                Name = "Server Hop",
                Content = "Finding a new server...",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            
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
                    Content = "No servers available! Try again later.",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end)
    end
})

MiscTab:AddButton({
    Name = "Rejoin Same Server",
    Callback = function()
        pcall(function()
            TeleportService:Teleport(game.PlaceId, Player)
            
            OrionLib:MakeNotification({
                Name = "Rejoin",
                Content = "Rejoining the same server...",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end)
    end
})

-- Mobile optimizations
if isMobile then
    -- Add specific mobile-friendly button
    MiscTab:AddButton({
        Name = "Mobile UI Fix",
        Callback = function()
            pcall(function()
                -- This tries to fix common mobile UI issues
                for _, gui in pairs(Player.PlayerGui:GetChildren()) do
                    if gui:IsA("ScreenGui") then
                        gui.IgnoreGuiInset = true
                    end
                end
                
                for _, ui in pairs(game.CoreGui:GetChildren()) do
                    if ui:IsA("ScreenGui") then
                        ui.IgnoreGuiInset = true
                    end
                end
                
                OrionLib:MakeNotification({
                    Name = "Mobile Fix",
                    Content = "Applied mobile UI fixes!",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end)
        end
    })
end

-- Initialize
Player.CharacterAdded:Connect(function(newCharacter)
    Character = newChar
