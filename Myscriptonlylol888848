local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()  -- تحميل Rayfield UI
local Window = Rayfield:CreateWindow({
    Name = "Rayfield UI Example",        -- اسم النافذة
    LoadingTitle = "Loading Rayfield...", -- عنوان التحميل
    LoadingSubtitle = "by Drakthon",     -- الاسم الخاص بك
    KeySystem = false                    -- غلق نظام المفاتيح (إذا أردت تفعيله اتركه true)
})

-- تبويبات (Tabs) في واجهة Rayfield
local PlayerTab = Window:CreateTab("Player Settings")  -- تبويب إعدادات اللاعب
local EffectsTab = Window:CreateTab("Effects")         -- تبويب التأثيرات
local MiscTab = Window:CreateTab("Misc")               -- تبويب Misc
local FunTab = Window:CreateTab("Fun")                 -- تبويب التسلية

-- إعدادات سرعة اللاعب
PlayerTab:CreateSlider({
    Name = "Walk Speed",                -- اسم الشرائح
    Range = {16, 200},                  -- نطاق السرعة
    Increment = 1,                      -- الزيادة في كل مرة
    Suffix = "Speed",                   -- النص المعروض بعد القيمة
    CurrentValue = 16,                  -- القيمة الحالية
    Callback = function(value)          -- وظيفة لتغيير السرعة
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

-- إعدادات قفز اللاعب
PlayerTab:CreateSlider({
    Name = "Jump Power",                -- اسم الشرائح
    Range = {50, 300},                  -- نطاق القفز
    Increment = 10,                     -- الزيادة في كل مرة
    Suffix = "Jump Power",              -- النص المعروض بعد القيمة
    CurrentValue = 50,                  -- القيمة الحالية
    Callback = function(value)          -- وظيفة لتغيير القفز
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})

-- إعدادات صحة اللاعب (Health)
PlayerTab:CreateSlider({
    Name = "Health",                    -- اسم الشرائح
    Range = {0, 500},                   -- نطاق الصحة
    Increment = 10,                     -- الزيادة في كل مرة
    Suffix = "Health",                  -- النص المعروض بعد القيمة
    CurrentValue = 100,                 -- القيمة الحالية
    Callback = function(value)          -- وظيفة لتغيير الصحة
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = value
        end
    end
})

-- إعدادات الجاذبية
PlayerTab:CreateSlider({
    Name = "Gravity",                    -- اسم الشرائح
    Range = {0, 196},                    -- نطاق الجاذبية
    Increment = 1,                       -- الزيادة في كل مرة
    Suffix = "Gravity",                  -- النص المعروض بعد القيمة
    CurrentValue = 196,                  -- القيمة الحالية (الجاذبية الافتراضية)
    Callback = function(value)           -- وظيفة لتغيير الجاذبية
        game.Workspace.Gravity = value
    end
})

-- تأثير النار على اللاعب
EffectsTab:CreateButton({
    Name = "Fire Effect",               -- اسم الزر
    Callback = function()               -- وظيفة لتفعيل تأثير النار
        local player = game.Players.LocalPlayer
        local char = player.Character
        local fire = Instance.new("Fire")
        fire.Size = 10
        fire.Heat = 20
        fire.Parent = char.HumanoidRootPart
    end
})

-- تأثير البرق على اللاعب
EffectsTab:CreateButton({
    Name = "Sparkles Effect",           -- اسم الزر
    Callback = function()               -- وظيفة لتفعيل تأثير اللمعان
        local player = game.Players.LocalPlayer
        local char = player.Character
        local sparkles = Instance.new("Sparkles")
        sparkles.Parent = char.HumanoidRootPart
    end
})

-- إضافة زر لجعل الشخصية غير مرئية (Invisible)
FunTab:CreateButton({
    Name = "Invisible",                 -- اسم الزر
    Callback = function()               -- وظيفة لجعل الشخصية غير مرئية
        local player = game.Players.LocalPlayer
        local char = player.Character
        if char then
            -- جعل الشخصية غير مرئية
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1  -- جعل الأجزاء شفافة
                    part.CanCollide = false -- إيقاف التصادم مع الأجزاء
                end
            end
            -- تغيير الأجزاء الأخرى مثل الـ Humanoid
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff -- إخفاء شريط الصحة
            end
        end
    end
})

-- زر لتحريك الكاميرا
local cameraShakeTween = nil
MiscTab:CreateButton({
    Name = "Camera Shake",             -- اسم الزر
    Callback = function()               -- وظيفة لتحريك الكاميرا
        if cameraShakeTween then
            cameraShakeTween:Cancel() -- إذا كانت الكاميرا تتحرك بالفعل، إيقافها أولاً
        end
        cameraShakeTween = game:GetService("TweenService"):Create(
            game.Workspace.CurrentCamera,
            TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
            { FieldOfView = 70 }
        )
        cameraShakeTween:Play() -- تشغيل حركة الكاميرا
    end
})

-- زر لإيقاف تحريك الكاميرا
MiscTab:CreateButton({
    Name = "Stop Camera Shake",        -- اسم الزر
    Callback = function()               -- وظيفة لإيقاف تحريك الكاميرا
        if cameraShakeTween then
            cameraShakeTween:Cancel() -- إيقاف حركة الكاميرا
            -- إعادة الـ FieldOfView إلى القيمة الأصلية
            game.Workspace.CurrentCamera.FieldOfView = 60
        end
    end
})

-- إضافة ميزة الطيران
MiscTab:CreateButton({
    Name = "Fly",                       -- اسم الزر
    Callback = function()               -- وظيفة لتفعيل الطيران
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-gui-v3-30439"))()  -- تحميل سكربت الطيران
    end
})

-- إضافة زر Dex Explorer
MiscTab:CreateButton({
    Name = "Dex Explorer",              -- اسم الزر
    Callback = function()               -- وظيفة لفتح Dex Explorer
        -- تحميل سكربت Dex Explorer الجديد
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Dex-Explorer-No-Key-29915"))() 
    end
})

-- إضافة زر ESP
MiscTab:CreateButton({
    Name = "ESP",                       -- اسم الزر
    Callback = function()               -- وظيفة لتفعيل ESP
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Exunys-ESP-7126"))()  -- تحميل سكربت ESP
    end
})

-- إضافة زر Fling
MiscTab:CreateButton({
    Name = "Fling",                     -- اسم الزر
    Callback = function()               -- وظيفة لتفعيل Fling
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fling-gui-v1-NEW-30872"))()  -- تحميل سكربت Fling
    end
})

-- إضافة زر Anti Fling
MiscTab:CreateButton({
    Name = "Anti Fling",                -- اسم الزر
    Callback = function()               -- وظيفة لتفعيل Anti Fling
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Anti-Void-24788"))()  -- تحميل سكربت Anti Fling
    end
})

-- إضافة زر نسخ الصورة الرمزية
MiscTab:CreateButton({
    Name = "Copy Avatar",             -- اسم الزر
    Callback = function()             -- وظيفة نسخ الصورة الرمزية
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Universal-Copy-Avatar-29837"))()  -- تحميل سكربت نسخ الصورة الرمزية
    end
})

-- إشعار عند تحميل السكربت
Window:CreateNotification({
    Title = "Rayfield UI Loaded",       -- عنوان الإشعار
    Content = "UI Loaded Successfully!", -- محتوى الإشعار
    Duration = 5                        -- مدة الإشعار
})
