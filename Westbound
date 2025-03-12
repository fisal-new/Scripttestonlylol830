-- سكربت قوي جدًا للعبة Westbound
-- تم إنشاؤه بواسطة Claude

local WestboundMap = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- إعدادات الخريطة
WestboundMap.Settings = {
    MapName = "Desert Outlaw",
    MaxPlayers = 16,
    TimeLimit = 600, -- بالثواني
    WeatherTypes = {"Sunny", "Cloudy", "Rainy", "Foggy", "Stormy"},
    CurrentWeather = "Sunny",
    DayNightCycle = true,
    SpawnPoints = {},
    LootSpots = {},
    SafeZones = {},
    DangerZones = {}
}

-- كائنات اللعبة
WestboundMap.GameObjects = {
    Buildings = {},
    Vehicles = {},
    NPCs = {},
    Weapons = {},
    Items = {},
    Treasures = {}
}

-- نظام الطقس المتقدم
function WestboundMap:SetupWeatherSystem()
    local sky = Instance.new("Sky")
    sky.Name = "MapSky"
    sky.Parent = game.Lighting
    
    -- تأثيرات الطقس
    local weatherEffects = {
        Sunny = function()
            game.Lighting.Brightness = 2
            game.Lighting.Ambient = Color3.fromRGB(150, 150, 150)
            game.Lighting.FogEnd = 10000
            sky.SunTextureId = "rbxassetid://1084351190"
            sky.SkyboxBk = "rbxassetid://152717857"
            sky.SkyboxDn = "rbxassetid://152717860"
            sky.SkyboxFt = "rbxassetid://152717859"
            sky.SkyboxLf = "rbxassetid://152717858"
            sky.SkyboxRt = "rbxassetid://152717861"
            sky.SkyboxUp = "rbxassetid://152717862"
        end,
        
        Cloudy = function()
            game.Lighting.Brightness = 1
            game.Lighting.Ambient = Color3.fromRGB(100, 100, 100)
            game.Lighting.FogEnd = 5000
            sky.SunTextureId = "rbxassetid://1084351190"
            sky.SkyboxBk = "rbxassetid://570557514"
            sky.SkyboxDn = "rbxassetid://570557775"
            sky.SkyboxFt = "rbxassetid://570557559"
            sky.SkyboxLf = "rbxassetid://570557620"
            sky.SkyboxRt = "rbxassetid://570557672"
            sky.SkyboxUp = "rbxassetid://570557727"
        end,
        
        Rainy = function()
            game.Lighting.Brightness = 0.5
            game.Lighting.Ambient = Color3.fromRGB(70, 70, 80)
            game.Lighting.FogEnd = 2000
            
            -- إضافة تأثير المطر
            local rainEffect = Instance.new("ParticleEmitter")
            rainEffect.Name = "RainEffect"
            rainEffect.Parent = workspace.Terrain
            rainEffect.Rate = 500
            rainEffect.Speed = NumberRange.new(50, 70)
            rainEffect.Lifetime = NumberRange.new(3, 5)
            rainEffect.Color = ColorSequence.new(Color3.fromRGB(200, 200, 255))
            rainEffect.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.1),
                NumberSequenceKeypoint.new(1, 0.1)
            })
            rainEffect.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.5),
                NumberSequenceKeypoint.new(1, 0.5)
            })
            
            -- إضافة صوت المطر
            local rainSound = Instance.new("Sound")
            rainSound.Name = "RainSound"
            rainSound.SoundId = "rbxassetid://3813559392"
            rainSound.Volume = 0.5
            rainSound.Looped = true
            rainSound.Parent = workspace
            rainSound:Play()
        end,
        
        Foggy = function()
            game.Lighting.Brightness = 0.7
            game.Lighting.Ambient = Color3.fromRGB(90, 90, 90)
            game.Lighting.FogEnd = 200
            game.Lighting.FogColor = Color3.fromRGB(220, 220, 230)
        end,
        
        Stormy = function()
            game.Lighting.Brightness = 0.3
            game.Lighting.Ambient = Color3.fromRGB(50, 50, 60)
            game.Lighting.FogEnd = 1000
            
            -- إضافة تأثير العاصفة
            local stormEffect = Instance.new("ParticleEmitter")
            stormEffect.Name = "StormEffect"
            stormEffect.Parent = workspace.Terrain
            stormEffect.Rate = 800
            stormEffect.Speed = NumberRange.new(70, 100)
            stormEffect.Lifetime = NumberRange.new(3, 6)
            stormEffect.Color = ColorSequence.new(Color3.fromRGB(180, 180, 230))
            stormEffect.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.15),
                NumberSequenceKeypoint.new(1, 0.15)
            })
            
            -- إضافة صوت الرعد
            local thunderSound = Instance.new("Sound")
            thunderSound.Name = "ThunderSound"
            thunderSound.SoundId = "rbxassetid://5578930180"
            thunderSound.Volume = 2
            thunderSound.Parent = workspace
            
            -- تشغيل أصوات الرعد بشكل عشوائي
            spawn(function()
                while WestboundMap.Settings.CurrentWeather == "Stormy" do
                    if math.random(1, 100) <= 20 then
                        thunderSound:Play()
                        
                        -- إضافة وميض البرق
                        game.Lighting.Brightness = 2
                        wait(0.1)
                        game.Lighting.Brightness = 0.3
                    end
                    wait(math.random(5, 15))
                end
            end)
        end
    }
    
    -- تطبيق الطقس الحالي
    weatherEffects[WestboundMap.Settings.CurrentWeather]()
    
    -- تغيير الطقس بشكل عشوائي
    spawn(function()
        while wait(300) do -- تغيير كل 5 دقائق
            local newWeather = WestboundMap.Settings.WeatherTypes[math.random(1, #WestboundMap.Settings.WeatherTypes)]
            WestboundMap:ChangeWeather(newWeather)
        end
    end)
    
    return weatherEffects
end

-- تغيير الطقس
function WestboundMap:ChangeWeather(weatherType)
    -- إزالة التأثيرات السابقة
    if workspace:FindFirstChild("RainEffect") then
        workspace.RainEffect:Destroy()
    end
    
    if workspace:FindFirstChild("RainSound") then
        workspace.RainSound:Stop()
        workspace.RainSound:Destroy()
    end
    
    if workspace:FindFirstChild("StormEffect") then
        workspace.StormEffect:Destroy()
    end
    
    if workspace:FindFirstChild("ThunderSound") then
        workspace.ThunderSound:Stop()
        workspace.ThunderSound:Destroy()
    end
    
    -- تطبيق الطقس الجديد
    WestboundMap.Settings.CurrentWeather = weatherType
    local weatherEffects = WestboundMap:SetupWeatherSystem()
    weatherEffects[weatherType]()
    
    -- إعلام اللاعبين بتغير الطقس
    for _, player in pairs(Players:GetPlayers()) do
        local notification = Instance.new("Message")
        notification.Text = "تغير الطقس إلى: " .. weatherType
        notification.Parent = player:WaitForChild("PlayerGui")
        game.Debris:AddItem(notification, 5)
    end
end

-- إنشاء دورة الليل والنهار
function WestboundMap:SetupDayNightCycle()
    if not WestboundMap.Settings.DayNightCycle then
        return
    end
    
    local cycleLength = 600 -- 10 دقائق للدورة الكاملة
    local timeValue = Instance.new("NumberValue")
    timeValue.Name = "DayTime"
    timeValue.Value = 0
    timeValue.Parent = ReplicatedStorage
    
    -- تحديث الوقت
    spawn(function()
        while true do
            for i = 0, 100, 1 do
                timeValue.Value = i
                
                -- ضبط الإضاءة بناءً على الوقت
                local clockTime
                if i < 50 then
                    -- النهار (6:00 صباحًا إلى 6:00 مساءً)
                    clockTime = 6 + (i / 50) * 12
                else
                    -- الليل (6:00 مساءً إلى 6:00 صباحًا)
                    clockTime = 18 + ((i - 50) / 50) * 12
                    if clockTime >= 24 then
                        clockTime = clockTime - 24
                    end
                end
                
                game.Lighting.ClockTime = clockTime
                
                -- تعديل السطوع والأجواء بناءً على الوقت
                if clockTime >= 5 and clockTime <= 7 then
                    -- شروق الشمس
                    game.Lighting.Brightness = 0.5 + (clockTime - 5) * 0.75
                    game.Lighting.Ambient = Color3.fromRGB(
                        100 + (clockTime - 5) * 25,
                        100 + (clockTime - 5) * 25,
                        120 + (clockTime - 5) * 15
                    )
                elseif clockTime >= 7 and clockTime <= 17 then
                    -- نهار كامل
                    game.Lighting.Brightness = 2
                    game.Lighting.Ambient = Color3.fromRGB(150, 150, 150)
                elseif clockTime >= 17 and clockTime <= 19 then
                    -- غروب الشمس
                    game.Lighting.Brightness = 2 - (clockTime - 17) * 0.75
                    game.Lighting.Ambient = Color3.fromRGB(
                        150 - (clockTime - 17) * 25,
                        150 - (clockTime - 17) * 25,
                        150 - (clockTime - 17) * 15
                    )
                else
                    -- ليل كامل
                    game.Lighting.Brightness = 0.5
                    game.Lighting.Ambient = Color3.fromRGB(100, 100, 120)
                    game.Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 80)
                end
                
                wait(cycleLength / 100)
            end
        end
    end)
end

-- إنشاء نقاط التفتيش واستمرار جمع الكنوز
function WestboundMap:CreateLootSystem()
    local lootSpots = {
        {Position = Vector3.new(100, 10, 200), Type = "Treasure", RespawnTime = 300},
        {Position = Vector3.new(-150, 5, -80), Type = "Weapons", RespawnTime = 180},
        {Position = Vector3.new(50, 2, -120), Type = "Food", RespawnTime = 120},
        {Position = Vector3.new(-20, 15, 90), Type = "Gold", RespawnTime = 240},
        {Position = Vector3.new(200, 8, -50), Type = "Ammo", RespawnTime = 150}
    }
    
    for i, spot in ipairs(lootSpots) do
        WestboundMap.Settings.LootSpots[i] = spot
        
        -- إنشاء تمثيل مرئي لنقطة اللوت
        local marker = Instance.new("Part")
        marker.Name = "LootSpot_" .. spot.Type .. "_" .. i
        marker.Position = spot.Position
        marker.Size = Vector3.new(2, 2, 2)
        marker.Anchored = true
        marker.CanCollide = false
        marker.Material = Enum.Material.Neon
        
        -- تلوين نقاط اللوت بناءً على النوع
        if spot.Type == "Treasure" then
            marker.Color = Color3.fromRGB(255, 215, 0) -- ذهبي
        elseif spot.Type == "Weapons" then
            marker.Color = Color3.fromRGB(255, 0, 0) -- أحمر
        elseif spot.Type == "Food" then
            marker.Color = Color3.fromRGB(0, 255, 0) -- أخضر
        elseif spot.Type == "Gold" then
            marker.Color = Color3.fromRGB(255, 200, 0) -- أصفر ذهبي
        elseif spot.Type == "Ammo" then
            marker.Color = Color3.fromRGB(100, 100, 100) -- رمادي
        end
        
        marker.Parent = workspace.LootSpots
        
        -- إضافة تأثير توهج
        local pointLight = Instance.new("PointLight")
        pointLight.Color = marker.Color
        pointLight.Range = 10
        pointLight.Brightness = 5
        pointLight.Parent = marker
        
        -- إضافة تأثير دوران
        spawn(function()
            while wait() do
                marker.CFrame = marker.CFrame * CFrame.Angles(0, math.rad(1), 0)
            end
        end)
        
        -- نظام إعادة ظهور اللوت
        spawn(function()
            while wait(spot.RespawnTime) do
                -- إخفاء اللوت عند استخدامه
                local isLooted = false
                
                if isLooted then
                    marker.Transparency = 1
                    pointLight.Enabled = false
                    
                    -- إنتظار لإعادة الظهور
                    wait(spot.RespawnTime)
                    
                    -- إعادة ظهور اللوت
                    marker.Transparency = 0
                    pointLight.Enabled = true
                    isLooted = false
                    
                    -- إعلام اللاعبين القريبين
                    for _, player in pairs(Players:GetPlayers()) do
                        local character = player.Character
                        if character and (character:FindFirstChild("HumanoidRootPart").Position - spot.Position).Magnitude < 100 then
                            local notification = Instance.new("Message")
                            notification.Text = "تجديد اللوت من نوع " .. spot.Type .. " بالقرب منك!"
                            notification.Parent = player:WaitForChild("PlayerGui")
                            game.Debris:AddItem(notification, 5)
                        end
                    end
                end
            end
        end)
    end
end

-- إنشاء المناطق الآمنة والخطرة
function WestboundMap:CreateZones()
    -- المناطق الآمنة
    local safeZones = {
        {Position = Vector3.new(0, 0, 0), Size = Vector3.new(50, 20, 50), Name = "Town Center"},
        {Position = Vector3.new(200, 5, 200), Size = Vector3.new(40, 20, 40), Name = "Ranch House"}
    }
    
    for i, zone in ipairs(safeZones) do
        WestboundMap.Settings.SafeZones[i] = zone
        
        -- إنشاء منطقة مرئية للمنطقة الآمنة
        local zonePart = Instance.new("Part")
        zonePart.Name = "SafeZone_" .. zone.Name
        zonePart.Position = zone.Position
        zonePart.Size = zone.Size
        zonePart.Anchored = true
        zonePart.CanCollide = false
        zonePart.Transparency = 0.8
        zonePart.Color = Color3.fromRGB(0, 255, 0) -- أخضر للمناطق الآمنة
        zonePart.Material = Enum.Material.ForceField
        zonePart.Parent = workspace.Zones
        
        -- إعداد حدث للدخول والخروج من المنطقة الآمنة
        zonePart.Touched:Connect(function(hit)
            local character = hit.Parent
            if character and character:FindFirstChild("Humanoid") then
                local player = Players:GetPlayerFromCharacter(character)
                if player then
                    -- إعلام اللاعب أنه في منطقة آمنة
                    local notification = Instance.new("Message")
                    notification.Text = "أنت الآن في منطقة آمنة: " .. zone.Name
                    notification.Parent = player:WaitForChild("PlayerGui")
                    game.Debris:AddItem(notification, 3)
                    
                    -- تعيين علامة للاعب لحمايته
                    character:SetAttribute("InSafeZone", true)
                end
            end
        end)
        
        zonePart.TouchEnded:Connect(function(hit)
            local character = hit.Parent
            if character and character:FindFirstChild("Humanoid") then
                local player = Players:GetPlayerFromCharacter(character)
                if player then
                    -- إعلام اللاعب أنه غادر المنطقة الآمنة
                    local notification = Instance.new("Message")
                    notification.Text = "لقد غادرت المنطقة الآمنة: " .. zone.Name
                    notification.Parent = player:WaitForChild("PlayerGui")
                    game.Debris:AddItem(notification, 3)
                    
                    -- إزالة علامة الحماية
                    character:SetAttribute("InSafeZone", false)
                end
            end
        end)
    end
    
    -- المناطق الخطرة
    local dangerZones = {
        {Position = Vector3.new(-200, 5, -200), Size = Vector3.new(60, 20, 60), Name = "Bandit Hideout", DamagePerSecond = 5},
        {Position = Vector3.new(150, 5, -150), Size = Vector3.new(40, 20, 40), Name = "Quicksand", DamagePerSecond = 10}
    }
    
    for i, zone in ipairs(dangerZones) do
        WestboundMap.Settings.DangerZones[i] = zone
        
        -- إنشاء منطقة مرئية للمنطقة الخطرة
        local zonePart = Instance.new("Part")
        zonePart.Name = "DangerZone_" .. zone.Name
        zonePart.Position = zone.Position
        zonePart.Size = zone.Size
        zonePart.Anchored = true
        zonePart.CanCollide = false
        zonePart.Transparency = 0.7
        zonePart.Color = Color3.fromRGB(255, 0, 0) -- أحمر للمناطق الخطرة
        zonePart.Material = Enum.Material.ForceField
        zonePart.Parent = workspace.Zones
        
        -- إضافة تأثير بصري للمنطقة الخطرة
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
        particleEmitter.Lifetime = NumberRange.new(1, 2)
        particleEmitter.Rate = 50
        particleEmitter.Speed = NumberRange.new(5, 10)
        particleEmitter.Parent = zonePart
        
        -- إعداد نظام الضرر المستمر
        local playersInZone = {}
        
        zonePart.Touched:Connect(function(hit)
            local character = hit.Parent
            if character and character:FindFirstChild("Humanoid") then
                local player = Players:GetPlayerFromCharacter(character)
                if player and not playersInZone[player.UserId] then
                    -- إعلام اللاعب أنه في منطقة خطرة
                    local notification = Instance.new("Message")
                    notification.Text = "تحذير! أنت في منطقة خطرة: " .. zone.Name
                    notification.Parent = player:WaitForChild("PlayerGui")
                    game.Debris:AddItem(notification, 3)
                    
                    -- تتبع اللاعب للضرر المستمر
                    playersInZone[player.UserId] = true
                    
                    -- بدء نظام الضرر
                    spawn(function()
                        while playersInZone[player.UserId] do
                            local character = player.Character
                            if character and character:FindFirstChild("Humanoid") then
                                -- لا تضر اللاعبين في المناطق الآمنة
                                if not character:GetAttribute("InSafeZone") then
                                    character.Humanoid:TakeDamage(zone.DamagePerSecond)
                                    
                                    -- تأثير بصري للضرر
                                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                                    if humanoidRootPart then
                                        local damageEffect = Instance.new("ParticleEmitter")
                                        damageEffect.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
                                        damageEffect.Lifetime = NumberRange.new(0.5, 1)
                                        damageEffect.Rate = 50
                                        damageEffect.Speed = NumberRange.new(2, 5)
                                        damageEffect.Parent = humanoidRootPart
                                        game.Debris:AddItem(damageEffect, 1)
                                    end
                                end
                            end
                            wait(1)
                        end
                    end)
                end
            end
        end)
        
        zonePart.TouchEnded:Connect(function(hit)
            local character = hit.Parent
            if character and character:FindFirstChild("Humanoid") then
                local player = Players:GetPlayerFromCharacter(character)
                if player then
                    -- إعلام اللاعب أنه غادر المنطقة الخطرة
                    local notification = Instance.new("Message")
                    notification.Text = "لقد غادرت المنطقة الخطرة: " .. zone.Name
                    notification.Parent = player:WaitForChild("PlayerGui")
                    game.Debris:AddItem(notification, 3)
                    
                    -- إيقاف نظام الضرر
                    playersInZone[player.UserId] = false
                end
            end
        end)
    end
end

-- نظام المناسبات الخاصة
function WestboundMap:SetupSpecialEvents()
    local events = {
        {
            Name = "الغزو",
            Chance = 10, -- نسبة 10% لحدوث الحدث كل 10 دقائق
            Duration = 180, -- 3 دقائق
            Action = function()
                -- إعلام جميع اللاعبين
                for _, player in pairs(Players:GetPlayers()) do
                    local notification = Instance.new("Message")
                    notification.Text = "حدث خاص: الغزو! دافع عن المدينة من الهجوم!"
                    notification.Parent = player:WaitForChild("PlayerGui")
                    game.Debris:AddItem(notification, 10)
                end
                
                -- تغيير لون السماء
                local originalSkyColor = game.Lighting.Ambient
                game.Lighting.Ambient = Color3.fromRGB(255, 100, 100)
                
                -- إنشاء الأعداء
                local enemyCount = math.min(20, #Players:GetPlayers() * 3)
                for i = 1, enemyCount do
                    -- أماكن تفريخ عشوائية حول المدينة
                    local spawnAngle = math.rad(math.random(0, 360))
                    local spawnRadius = math.random(100, 200)
                    local spawnPos = Vector3.new(
                        math.cos(spawnAngle) * spawnRadius,
                        10,
                        math.sin(spawnAngle) * spawnRadius
                    )
                    
                    -- إنشاء العدو
                    local enemy = Instance.new("Model")
                    enemy.Name = "Raider_" .. i
                    
                    local enemyPart = Instance.new("Part")
                    enemyPart.Name = "HumanoidRootPart"
                    enemyPart.Size = Vector3.new(2, 2, 1)
                    enemyPart.Position = spawnPos
                    enemyPart.Anchored = false
                    enemyPart.CanCollide = true
                    enemyPart.Parent = enemy
                    
                    local enemyHumanoid = Instance.new("Humanoid")
                    enemyHumanoid.MaxHealth = 100
                    enemyHumanoid.Health = 100
                    enemyHumanoid.Parent = enemy
                    
                    local enemyTorso = Instance.new("Part")
                    enemyTorso.Name = "Torso"
                    enemyTorso.Size = Vector3.new(2, 2, 1)
                    enemyTorso.Position = spawnPos + Vector3.new(0, 0, 0)
                    enemyTorso.Anchored = false
                    enemyTorso.CanCollide = true
                    enemyTorso.Color = Color3.fromRGB(139, 0, 0) -- لون أحمر داكن
                    enemyTorso.Parent = enemy
                    
                    -- ربط الأجزاء معًا
                    local weld = Instance.new("Weld")
                    weld.Part0 = enemyPart
                    weld.Part1 = enemyTorso
                    weld.C0 = CFrame.new(0, 0, 0)
                    weld.Parent = enemyPart
                    
                    enemy.Parent = workspace.Enemies
                    
                    -- جعل العدو يتحرك نحو المدينة
                    spawn(function()
                        while enemy.Parent and enemyHumanoid.Health > 0 do
                            -- العثور على أقرب لاعب
                            local closestPlayer = nil
                            local closestDistance = math.huge
                            
                            for _, player in pairs(Players:GetPlayers()) do
                                local character = player.Character
                                if character and character:FindFirstChild("HumanoidRootPart") then
                                    local distance = (character.HumanoidRootPart.Position - enemyPart.Position).Magnitude
                                    if distance < closestDistance then
                                        closestPlayer = character
                                        closestDistance = distance
                                    end
                                end
                            end
                            
                            -- التحرك نحو أقرب لاعب
                            if closestPlayer then
                                local direction = (closestPlayer.HumanoidRootPart.Position - enemyPart.Position).Unit
                                enemyHumanoid:MoveTo(enemyPart.Position + direction * 5)
                                
                                -- هجوم عند الاقتراب
                                if closestDistance < 5 then
                                    local playerHumanoid = closestPlayer:FindFirstChild("Humanoid")
                                    if playerHumanoid and not closestPlayer:GetAttribute("InSafeZone") then
                                        playerHumanoid:TakeDamage(10)
                                        
                                        -- تأثير بصري للهجوم
                                        local attackEffect = Instance.new("ParticleEmitter")
                                        attackEffect.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
                                        attackEffect.Lifetime = NumberRange.new(0.3, 0.5)
                                        attackEffect.Rate = 100
                                        attackEffect.Speed = NumberRange.new(5, 10)
                                        attackEffect.Parent = closestPlayer.HumanoidRootPart
                                        game.Debris:AddItem(attackEffect, 0.5)
                                    end
                                end
                            else
                                -- التحرك نحو وسط المدينة إذا لم يكن هناك لاعبون
                                enemyHumanoid:MoveTo(Vector3.new(0, 0, 0))
                            end
                            
                            wait(0.5)
                        end
                        
                        -- مكافأة عند هزيمة العدو
