--[[ 
    السكربت المتطور لـ Westbound - النسخة الفائقة 2.0
    متوافق مع: الموبايل، PC
    50+ من الأوامر والميزات المتقدمة مع واجهة Tabs
]]

local WestboundPro = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

-- النسخة والمعلومات
WestboundPro.Version = "2.0 Ultimate"
WestboundPro.LastUpdate = "12/03/2025"
WestboundPro.Creator = "Pro Script Team"

-- إعدادات وميزات متعددة (50+ من الأوامر)
local Config = {
    -- قسم القتال
    Combat = {
        Aimbot = {
            Enabled = false,
            Key = Enum.KeyCode.X,
            MobileButton = false,
            Sensitivity = 2,
            TeamCheck = true,
            TargetPart = "Head", -- Head, HumanoidRootPart, Torso
            FOV = 100,
            ShowFOV = true,
            FOVColor = Color3.fromRGB(255, 255, 255),
            Wallbang = false,
            SilentAim = false,
            PredictMovement = true,
            AutoShoot = false,
            TargetInfo = true,
            HitSound = true,
            HitSoundID = "rbxassetid://6607204501",
            HitSoundVolume = 1
        },
        GunMods = {
            Enabled = false,
            NoRecoil = true,
            NoSpread = true,
            RapidFire = true,
            FireRate = 0.05, -- السرعة المخصصة (أقل = أسرع)
            InfiniteAmmo = true,
            AutoReload = true,
            InstantReload = true,
            FullAuto = true,
            BulletTracer = true,
            TracerColor = Color3.fromRGB(255, 0, 0),
            CustomDamage = true,
            DamageMultiplier = 5
        },
        KillAura = {
            Enabled = false,
            Range = 20,
            TargetMultiple = true,
            Delay = 0.5,
            TeamCheck = true,
            AutoEquipWeapon = true,
            PreferredWeapon = "Revolver"
        }
    },

    -- قسم الشخصية
    Character = {
        Movement = {
            WalkSpeed = {
                Enabled = false,
                Speed = 50
            },
            JumpPower = {
                Enabled = false,
                Power = 100
            },
            InfiniteJump = false,
            NoClip = false,
            Fly = {
                Enabled = false,
                Speed = 2,
                Key = Enum.KeyCode.F
            },
            Teleport = {
                Key = Enum.KeyCode.T,
                ClickTP = false
            },
            AutoJump = false,
            BunnyHop = false,
            NoFallDamage = true,
            NoRagdoll = true
        },
        Appearance = {
            CustomCharacter = false,
            Invisible = false,
            AntiHeadshot = true,
            CustomAnimation = false,
            AnimationID = "rbxassetid://3303161675",
            GlowEffect = false,
            GlowColor = Color3.fromRGB(0, 255, 255),
            TrailEffect = false,
            TrailColor = Color3.fromRGB(255, 0, 255)
        }
    },

    -- قسم الفيجوال
    Visuals = {
        ESP = {
            Enabled = false,
            TeamCheck = true,
            BoxESP = true,
            BoxOutline = true,
            BoxColor = Color3.fromRGB(255, 0, 0),
            TracerESP = true,
            TracerColor = Color3.fromRGB(255, 0, 0),
            TracerOrigin = "Bottom", -- Top, Center, Bottom, Mouse
            NameESP = true,
            NameColor = Color3.fromRGB(255, 255, 255),
            DistanceESP = true,
            HealthESP = true,
            WeaponESP = true,
            SkeletonESP = true,
            SkeletonColor = Color3.fromRGB(255, 255, 255),
            HeadDotESP = true,
            HeadDotColor = Color3.fromRGB(255, 0, 0),
            HeadDotSize = 1,
            MaxDistance = 2000,
            Chams = {
                Enabled = false,
                Color = Color3.fromRGB(0, 255, 0),
                Transparency = 0.5,
                AlwaysOnTop = true
            }
        },
        ItemESP = {
            Enabled = false,
            MoneyESP = true,
            SafeESP = true,
            WeaponPickupESP = true,
            AmmoESP = true,
            CustomItems = {}
        },
        WorldVisuals = {
            Fullbright = false,
            NoFog = false,
            CustomTime = false,
            Time = 12, -- 0-24
            CustomSkybox = false,
            SkyboxID = "rbxassetid://6544156616",
            CustomFieldOfView = false,
            FieldOfView = 90, -- 60-120
            RemoveWater = false,
            RemoveTrees = false,
            RemoveBuildings = false,
            XRayMode = false
        }
    },

    -- قسم المساعد والأوتوماتيك
    Automation = {
        AutoFarm = {
            Enabled = false,
            CollectMoney = true,
            AutoRob = true,
            RobBanks = true,
            RobStores = true,
            SafeDistance = 10,
            TeleportToLocation = true,
            AvoidPlayers = true,
            AutoEquipGun = true,
            CollectDrops = true
        },
        AutoBuy = {
            Enabled = false,
            AutoBuyWeapon = false,
            PreferredWeapon = "Revolver",
            AutoBuyAmmo = false,
            AutoBuyArmor = false
        },
        AutoHunt = {
            Enabled = false,
            HuntAnimals = true,
            HuntPlayers = false,
            SellMeat = true,
            AvoidDanger = true
        },
        AutoMine = {
            Enabled = false,
            MineOres = true,
            SellOres = true,
            PreferredOre = "Gold"
        },
        AutoQuest = {
            Enabled = false,
            AcceptAllQuests = true,
            CompleteQuests = true,
            QuestPriority = "Reward" -- Reward, Difficulty, Time
        }
    },

    -- قسم الحماية
    Protection = {
        AntiKick = true,
        AntiTeleport = true,
        AntiReport = true,
        AntiAFK = true,
        AntiSpectate = true,
        AntiScreenshot = true,
        AntiChatLog = true,
        SpoofIdentity = true,
        AntiCheatBypass = true
    },

    -- تخصيصات واجهة المستخدم
    UI = {
        Theme = "Dark", -- Dark, Light, Custom
        CustomThemeColor = Color3.fromRGB(0, 120, 215),
        Transparency = 0.9,
        ShowKeybinds = true,
        MinimizeKey = Enum.KeyCode.RightShift,
        SaveSettings = true,
        TabsPosition = "Left", -- Left, Top, Right
        UIScale = 1, -- 0.7 - 1.5
        Draggable = true,
        ShowPerformance = true,
        ShowVersion = true,
        MobileSupport = {
            Enabled = true,
            CustomButtons = true,
            ButtonSize = UDim2.new(0, 50, 0, 50),
            ButtonPosition = "Right", -- Left, Right
            ButtonsTransparency = 0.7
        }
    },

    -- إعدادات متقدمة
    Advanced = {
        Performance = {
            ReduceAnimations = false,
            LowGraphics = false,
            DisableParticles = false,
            DisableBlur = false
        },
        Debugging = {
            Enabled = false,
            ShowStats = false,
            LogActions = false,
            SaveLogs = false
        },
        ServerHop = {
            LowPlayerCount = false,
            PreferEmptyServers = false,
            AvoidFullServers = true,
            AvoidSameServer = true
        },
        CustomScripts = {
            Enabled = false,
            Scripts = {}
        }
    }
}

-- تهيئة واجهة المستخدم مع Tabs
function WestboundPro:SetupUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WestboundProGUI"
    ScreenGui.ResetOnSpawn = false
    
    -- محاولة وضع الـ GUI في المكان المناسب
    pcall(function()
        if syn then
            syn.protect_gui(ScreenGui)
            ScreenGui.Parent = game:GetService("CoreGui")
        else
            ScreenGui.Parent = game:GetService("CoreGui")
        end
    end)
    
    -- إطار رئيسي
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 650, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
    MainFrame.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(240, 240, 240)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = Config.UI.Draggable
    MainFrame.Parent = ScreenGui
    
    -- الجزء العلوي
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(220, 220, 220)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    -- عنوان السكربت
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Westbound Pro - Ultimate Script v" .. WestboundPro.Version
    Title.TextColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
    Title.TextSize = 18
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    -- زر الإغلاق
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 3)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Parent = TopBar
    
    -- زر التصغير
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 3)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 255)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Parent = TopBar
    
    -- قائمة التبويبات (Tabs)
    local TabsFrame = Instance.new("Frame")
    TabsFrame.Name = "TabsFrame"
    TabsFrame.Size = UDim2.new(0, 150, 1, -35)
    TabsFrame.Position = UDim2.new(0, 0, 0, 35)
    TabsFrame.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(35, 35, 35) or Color3.fromRGB(230, 230, 230)
    TabsFrame.BorderSizePixel = 0
    TabsFrame.Parent = MainFrame
    
    -- مساحة المحتوى
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -150, 1, -35)
    ContentFrame.Position = UDim2.new(0, 150, 0, 35)
    ContentFrame.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(245, 245, 245)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = MainFrame
    
    -- إنشاء زر تبويب
    local function CreateTab(name, yPos, iconID)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Tab"
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.Position = UDim2.new(0, 0, 0, yPos)
        TabButton.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(210, 210, 210)
        TabButton.BorderSizePixel = 0
        TabButton.Text = name
        TabButton.TextColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
        TabButton.TextSize = 16
        TabButton.Font = Enum.Font.SourceSansSemibold
        TabButton.Parent = TabsFrame
        
        -- أيقونة (اختياري)
        if iconID then
            local IconImage = Instance.new("ImageLabel")
            IconImage.Name = "Icon"
            IconImage.Size = UDim2.new(0, 20, 0, 20)
            IconImage.Position = UDim2.new(0, 10, 0.5, -10)
            IconImage.BackgroundTransparency = 1
            IconImage.Image = iconID
            IconImage.Parent = TabButton
            
            -- تعديل نص الزر ليتناسب مع الأيقونة
            TabButton.TextXAlignment = Enum.TextXAlignment.Right
            TabButton.Text = "  " .. name
        end
        
        -- إنشاء صفحة المحتوى
        local ContentPage = Instance.new("ScrollingFrame")
        ContentPage.Name = name .. "Page"
        ContentPage.Size = UDim2.new(1, -10, 1, -10)
        ContentPage.Position = UDim2.new(0, 5, 0, 5)
        ContentPage.BackgroundTransparency = 1
        ContentPage.ScrollBarThickness = 4
        ContentPage.Visible = false
        ContentPage.ScrollingDirection = Enum.ScrollingDirection.Y
        ContentPage.CanvasSize = UDim2.new(0, 0, 4, 0) -- طويل بما يكفي للمحتوى
        ContentPage.Parent = ContentFrame
        
        -- عنوان الصفحة
        local PageTitle = Instance.new("TextLabel")
        PageTitle.Name = "PageTitle"
        PageTitle.Size = UDim2.new(1, 0, 0, 30)
        PageTitle.Position = UDim2.new(0, 0, 0, 0)
        PageTitle.BackgroundTransparency = 1
        PageTitle.Text = name .. " Settings"
        PageTitle.TextColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
        PageTitle.TextSize = 20
        PageTitle.Font = Enum.Font.SourceSansBold
        PageTitle.Parent = ContentPage
        
        TabButton.MouseButton1Click:Connect(function()
            -- إخفاء جميع الصفحات
            for _, child in pairs(ContentFrame:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            
            -- إعادة تعيين لون جميع أزرار التبويب
            for _, child in pairs(TabsFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(210, 210, 210)
                end
            end
            
            -- إظهار الصفحة المحددة وتغيير لون الزر
            ContentPage.Visible = true
            TabButton.BackgroundColor3 = Config.UI.CustomThemeColor
        end)
        
        return ContentPage
    end
    
    -- إنشاء مقطع للإعدادات
    local function CreateSection(parent, title, yPos)
        local Section = Instance.new("Frame")
        Section.Name = title .. "Section"
        Section.Size = UDim2.new(1, -20, 0, 30) -- سنقوم بتحديثه لاحقًا
        Section.Position = UDim2.new(0, 10, 0, yPos)
        Section.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(35, 35, 35) or Color3.fromRGB(225, 225, 225)
        Section.BorderSizePixel = 0
        Section.Parent = parent
        
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Name = "Title"
        SectionTitle.Size = UDim2.new(1, 0, 0, 30)
        SectionTitle.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(210, 210, 210)
        SectionTitle.BorderSizePixel = 0
        SectionTitle.Text = title
        SectionTitle.TextColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
        SectionTitle.TextSize = 16
        SectionTitle.Font = Enum.Font.SourceSansBold
        SectionTitle.Parent = Section
        
        return Section
    end
    
    -- إنشاء زر تبديل (Toggle)
    local function CreateToggle(parent, text, configPath, yPos)
        local Toggle = Instance.new("Frame")
        Toggle.Name = text .. "Toggle"
        Toggle.Size = UDim2.new(1, -20, 0, 30)
        Toggle.Position = UDim2.new(0, 10, 0, yPos)
        Toggle.BackgroundTransparency = 1
        Toggle.Parent = parent
        
        local ToggleText = Instance.new("TextLabel")
        ToggleText.Name = "Text"
        ToggleText.Size = UDim2.new(0.7, 0, 1, 0)
        ToggleText.Position = UDim2.new(0, 10, 0, 0)
        ToggleText.BackgroundTransparency = 1
        ToggleText.Text = text
        ToggleText.TextColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
        ToggleText.TextSize = 14
        ToggleText.Font = Enum.Font.SourceSans
        ToggleText.TextXAlignment = Enum.TextXAlignment.Left
        ToggleText.Parent = Toggle
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Name = "Button"
        ToggleButton.Size = UDim2.new(0, 40, 0, 20)
        ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
        ToggleButton.BackgroundColor3 = WestboundPro:GetConfigValue(configPath) and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
        ToggleButton.BorderSizePixel = 0
        ToggleButton.Text = WestboundPro:GetConfigValue(configPath) and "ON" or "OFF"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleButton.TextSize = 14
        ToggleButton.Font = Enum.Font.SourceSansBold
        ToggleButton.Parent = Toggle
        
        ToggleButton.MouseButton1Click:Connect(function()
            local currentValue = WestboundPro:GetConfigValue(configPath)
            local newValue = not currentValue
            WestboundPro:SetConfigValue(configPath, newValue)
            
            ToggleButton.BackgroundColor3 = newValue and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
            ToggleButton.Text = newValue and "ON" or "OFF"
        end)
        
        return Toggle
    end
    
    -- إنشاء منزلق (Slider)
    local function CreateSlider(parent, text, configPath, min, max, step, yPos)
        local sliderHeight = 50
        local Slider = Instance.new("Frame")
        Slider.Name = text .. "Slider"
        Slider.Size = UDim2.new(1, -20, 0, sliderHeight)
        Slider.Position = UDim2.new(0, 10, 0, yPos)
        Slider.BackgroundTransparency = 1
        Slider.Parent = parent
        
        local SliderText = Instance.new("TextLabel")
        SliderText.Name = "Text"
        SliderText.Size = UDim2.new(1, 0, 0, 20)
        SliderText.Position = UDim2.new(0, 10, 0, 0)
        SliderText.BackgroundTransparency = 1
        SliderText.Text = text .. ": " .. WestboundPro:GetConfigValue(configPath)
        SliderText.TextColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
        SliderText.TextSize = 14
        SliderText.Font = Enum.Font.SourceSans
        SliderText.TextXAlignment = Enum.TextXAlignment.Left
        SliderText.Parent = Slider
        
        local SliderTrack = Instance.new("Frame")
        SliderTrack.Name = "Track"
        SliderTrack.Size = UDim2.new(1, -20, 0, 5)
        SliderTrack.Position = UDim2.new(0, 10, 0.5, 0)
        SliderTrack.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(200, 200, 200)
        SliderTrack.BorderSizePixel = 0
        SliderTrack.Parent = Slider
        
        local currentValue = WestboundPro:GetConfigValue(configPath)
        local sliderPos = (currentValue - min) / (max - min)
        
        local SliderFill = Instance.new("Frame")
        SliderFill.Name = "Fill"
        SliderFill.Size = UDim2.new(sliderPos, 0, 1, 0)
        SliderFill.BackgroundColor3 = Config.UI.CustomThemeColor
        SliderFill.BorderSizePixel = 0
        SliderFill.Parent = SliderTrack
        
        local SliderButton = Instance.new("TextButton")
        SliderButton.Name = "Button"
        SliderButton.Size = UDim2.new(0, 15, 0, 15)
        SliderButton.Position = UDim2.new(sliderPos, -7.5, 0.5, -7.5)
        SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderButton.BorderSizePixel = 0
        SliderButton.Text = ""
        SliderButton.Parent = SliderTrack
        
        local ValueBox = Instance.new("TextBox")
        ValueBox.Name = "ValueBox"
        ValueBox.Size = UDim2.new(0, 50, 0, 20)
        ValueBox.Position = UDim2.new(1, -60, 0, 0)
        ValueBox.BackgroundColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(220, 220, 220)
        ValueBox.BorderSizePixel = 0
        ValueBox.Text = tostring(currentValue)
        ValueBox.TextColor3 = Config.UI.Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
        ValueBox.TextSize = 14
        ValueBox.Font = Enum.Font.SourceSans
        ValueBox.Parent = Slider
        
        local isDragging = false
        
        SliderButton.MouseButton1Down:Connect(function()
            isDragging = true
        end)
        
        SliderTrack.MouseButton1Down:Connect(function(x)
            local trackPos = (x - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
            trackPos = math.clamp(trackPos, 0, 1)
            
            local value = min + ((max - min) * trackPos)
            value = math.floor(value / step + 0.5) * step
            value = math.clamp(value, min, max)
            
            WestboundPro:SetConfigValue(configPath, value)
            SliderFill.Size = UDim2.new(trackPos, 0, 1, 0)
            SliderButton.Position = UDim2.new(trackPos, -7.5, 0.5, -7.5)
            SliderText.Text = text .. ": " .. value
            ValueBox.Text = tostring(value)
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
                local trackPos = (input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
                trackPos = math.clamp(trackPos, 0, 1)
                
                local value = min + ((max - min) * trackPos)
                value = math.floor(value / step + 0.5) * step
                value = math.clamp(value, min, max)
                
                WestboundPro:SetConfigValue(configPath, value)
                SliderFill.Size = UDim2.new(trackPos, 0, 1, 0)
                SliderButton.Position = UDim2.new(trackPos, -7.5, 0.5, -7.5)
                SliderText.Text = text .. ": " .. value
                ValueBox.Text = tostring(value)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)
        
        ValueBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local value = tonumber(ValueBox.Text)
                if value then
                    value = math.clamp(value, min, max)
                    value = math.floor(value / step + 0.5) * step
                    
                    local trackPos = (value - min) / (max - min)
                    
                    WestboundPro:SetConfigValue(configPath, value)
                    SliderFill.Size = UDim2.
