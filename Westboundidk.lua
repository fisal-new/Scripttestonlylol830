-- Westbound GUI محسّن مع دعم كامل للجوال
-- تم التحديث بواسطة Claude

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- التحقق من المنصة
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- إنشاء الواجهة الرسومية
local WestboundGUI = {}

-- الألوان والتصميم
local Colors = {
    Background = Color3.fromRGB(20, 20, 30),
    Accent = Color3.fromRGB(170, 85, 0),
    Text = Color3.fromRGB(255, 255, 255),
    Button = Color3.fromRGB(40, 40, 50),
    ButtonHover = Color3.fromRGB(60, 60, 70),
    TabSelected = Color3.fromRGB(50, 50, 60),
    Toggle = Color3.fromRGB(40, 40, 50),
    ToggleEnabled = Color3.fromRGB(85, 170, 0)
}

function WestboundGUI:Create()
    -- تدمير أي واجهة سابقة إذا وجدت
    if game.CoreGui:FindFirstChild("WestboundMobileGUI") then
        game.CoreGui:FindFirstChild("WestboundMobileGUI"):Destroy()
    end
    
    -- إنشاء واجهة رئيسية
    local GUI = Instance.new("ScreenGui")
    GUI.Name = "WestboundMobileGUI"
    GUI.ResetOnSpawn = false
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- اصلاح ظهور الواجهة على الجوال
    if syn and syn.protect_gui then
        syn.protect_gui(GUI)
        GUI.Parent = game.CoreGui
    elseif gethui then
        GUI.Parent = gethui()
    else
        GUI.Parent = game.CoreGui
    end
    
    -- إطار رئيسي
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = GUI
    MainFrame.BackgroundColor3 = Colors.Background
    MainFrame.BorderSizePixel = 0
    
    -- ضبط الحجم والموضع حسب المنصة
    if isMobile then
        MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
        MainFrame.Size = UDim2.new(0, 300, 0, 400)
    else
        MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
    end
    
    -- جعل الواجهة قابلة للسحب
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function updateDrag(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)
    
    -- تنعيم الحواف
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Colors.Accent
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame
    
    -- شريط العنوان
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Colors.Accent
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = TitleBar
    
    -- الحفاظ على الزوايا العلوية فقط منحنية
    local TitleFix = Instance.new("Frame")
    TitleFix.Name = "TitleFix"
    TitleFix.Parent = TitleBar
    TitleFix.BackgroundColor3 = Colors.Accent
    TitleFix.BorderSizePixel = 0
    TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
    TitleFix.Size = UDim2.new(1, 0, 0.5, 0)
    
    -- عنوان الواجهة
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TitleBar
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -50, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "Westbound GUI Pro"
    Title.TextColor3 = Colors.Text
    Title.TextSize = isMobile and 18 or 22
    
    -- زر الإغلاق
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -25, 0, 0)
    CloseButton.Size = UDim2.new(0, 25, 1, 0)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Colors.Text
    CloseButton.TextSize = isMobile and 16 or 20
    
    CloseButton.MouseButton1Click:Connect(function()
        GUI:Destroy()
        WestboundGUI:StopESP() -- إيقاف الـ ESP عند إغلاق الواجهة
    end)
    
    -- تصغير الواجهة
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TitleBar
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Position = UDim2.new(1, -50, 0, 0)
    MinimizeButton.Size = UDim2.new(0, 25, 1, 0)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Colors.Text
    MinimizeButton.TextSize = isMobile and 20 or 24
    
    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            -- حفظ الحجم الحالي قبل التصغير
            MainFrame.OldSizeY = MainFrame.Size.Y.Offset
            -- تصغير الواجهة
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 30)}):Play()
        else
            -- إعادة الواجهة للحجم الطبيعي
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, MainFrame.OldSizeY)}):Play()
        end
    end)
    
    -- إطار التبويبات الرئيسية
    local TabsContainer = Instance.new("Frame")
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = MainFrame
    TabsContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabsContainer.BorderSizePixel = 0
    TabsContainer.Position = UDim2.new(0, 0, 0, 30)
    TabsContainer.Size = UDim2.new(0, isMobile and 80 or 120, 1, -30)
    
    local TabsCorner = Instance.new("UICorner")
    TabsCorner.CornerRadius = UDim.new(0, 8)
    TabsCorner.Parent = TabsContainer
    
    -- إصلاح زوايا التبويبات
    local TabsFix = Instance.new("Frame")
    TabsFix.Name = "TabsFix"
    TabsFix.Parent = TabsContainer
    TabsFix.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabsFix.BorderSizePixel = 0
    TabsFix.Position = UDim2.new(1, -8, 0, 0)
    TabsFix.Size = UDim2.new(0, 8, 1, 0)
    
    -- قائمة التبويبات
    local TabsList = Instance.new("ScrollingFrame")
    TabsList.Name = "TabsList"
    TabsList.Parent = TabsContainer
    TabsList.Active = true
    TabsList.BackgroundTransparency = 1
    TabsList.BorderSizePixel = 0
    TabsList.Position = UDim2.new(0, 0, 0, 5)
    TabsList.Size = UDim2.new(1, 0, 1, -10)
    TabsList.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsList.ScrollBarThickness = 2
    TabsList.ScrollingDirection = Enum.ScrollingDirection.Y
    TabsList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.Parent = TabsList
    TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Padding = UDim.new(0, 5)
    
    -- إطار المحتوى
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Position = UDim2.new(0, isMobile and 80 or 120, 0, 30)
    ContentContainer.Size = UDim2.new(1, -(isMobile and 80 or 120), 1, -30)
    
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 8)
    ContentCorner.Parent = ContentContainer
    
    -- تخزين جميع صفحات المحتوى
    local pages = {}
    
    -- دالة لإنشاء تبويب جديد
    function WestboundGUI:CreateTab(name, icon, order)
        -- زر التبويب
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabsList
        TabButton.BackgroundColor3 = Colors.Button
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0.9, 0, 0, isMobile and 40 or 35)
        TabButton.Font = Enum.Font.SourceSansSemibold
        TabButton.Text = isMobile and "" or name
        TabButton.TextColor3 = Colors.Text
        TabButton.TextSize = 14
        TabButton.LayoutOrder = order
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton
        
        -- أيقونة (للجوال)
        if isMobile then
            local IconLabel = Instance.new("TextLabel")
            IconLabel.Name = "IconLabel"
            IconLabel.Parent = TabButton
            IconLabel.BackgroundTransparency = 1
            IconLabel.Size = UDim2.new(1, 0, 1, 0)
            IconLabel.Font = Enum.Font.SourceSansBold
            IconLabel.Text = icon
            IconLabel.TextColor3 = Colors.Text
            IconLabel.TextSize = 18
        end
        
        -- صفحة المحتوى المرتبطة بالتبويب
        local ContentPage = Instance.new("ScrollingFrame")
        ContentPage.Name = name .. "Page"
        ContentPage.Parent = ContentContainer
        ContentPage.Active = true
        ContentPage.BackgroundTransparency = 1
        ContentPage.BorderSizePixel = 0
        ContentPage.Size = UDim2.new(1, 0, 1, 0)
        ContentPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        ContentPage.ScrollBarThickness = 2
        ContentPage.ScrollingDirection = Enum.ScrollingDirection.Y
        ContentPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
        ContentPage.Visible = false
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.Parent = ContentPage
        ContentPadding.PaddingLeft = UDim.new(0, 10)
        ContentPadding.PaddingRight = UDim.new(0, 10)
        ContentPadding.PaddingTop = UDim.new(0, 10)
        ContentPadding.PaddingBottom = UDim.new(0, 10)
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Parent = ContentPage
        ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 8)
        
        -- تخزين الصفحة
        pages[name] = {
            button = TabButton,
            page = ContentPage
        }
        
        -- تفعيل النقر على التبويب
        TabButton.MouseButton1Click:Connect(function()
            -- إخفاء جميع الصفحات
            for _, pageInfo in pairs(pages) do
                pageInfo.page.Visible = false
                pageInfo.button.BackgroundColor3 = Colors.Button
            end
            
            -- إظهار الصفحة المطلوبة
            ContentPage.Visible = true
            TabButton.BackgroundColor3 = Colors.TabSelected
        end)
        
        -- إرجاع الصفحة
        return ContentPage
    end
    
    -- دالة لإنشاء عنوان قسم
    function WestboundGUI:CreateSection(parent, title)
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Name = title .. "Section"
        SectionFrame.Parent = parent
        SectionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        SectionFrame.BorderSizePixel = 0
        SectionFrame.Size = UDim2.new(1, 0, 0, 30)
        
        local SectionCorner = Instance.new("UICorner")
        SectionCorner.CornerRadius = UDim.new(0, 6)
        SectionCorner.Parent = SectionFrame
        
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Name = "Title"
        SectionTitle.Parent = SectionFrame
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.Size = UDim2.new(1, 0, 1, 0)
        SectionTitle.Font = Enum.Font.SourceSansBold
        SectionTitle.Text = title
        SectionTitle.TextColor3 = Colors.Text
        SectionTitle.TextSize = 14
        
        return SectionFrame
    end
    
    -- دالة لإنشاء زر
    function WestboundGUI:CreateButton(parent, text, callback)
        local ButtonFrame = Instance.new("TextButton")
        ButtonFrame.Name = text .. "Button"
        ButtonFrame.Parent = parent
        ButtonFrame.BackgroundColor3 = Colors.Button
        ButtonFrame.BorderSizePixel = 0
        ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
        ButtonFrame.Font = Enum.Font.SourceSans
        ButtonFrame.Text = text
        ButtonFrame.TextColor3 = Colors.Text
        ButtonFrame.TextSize = isMobile and 14 or 16
        ButtonFrame.AutoButtonColor = false
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = ButtonFrame
        
        -- تأثيرات التحويم
        ButtonFrame.MouseEnter:Connect(function()
            ButtonFrame.BackgroundColor3 = Colors.ButtonHover
        end)
        
        ButtonFrame.MouseLeave:Connect(function()
            ButtonFrame.BackgroundColor3 = Colors.Button
        end)
        
        ButtonFrame.MouseButton1Click:Connect(function()
            callback()
        end)
        
        return ButtonFrame
    end
    
    -- دالة لإنشاء مفتاح تبديل
    function WestboundGUI:CreateToggle(parent, text, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Name = text .. "Toggle"
        ToggleFrame.Parent = parent
        ToggleFrame.BackgroundColor3 = Colors.Toggle
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 6)
        ToggleCorner.Parent = ToggleFrame
        
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        TextLabel.Parent = ToggleFrame
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0, 10, 0, 0)
        TextLabel.Size = UDim2.new(1, -60, 1, 0)
        TextLabel.Font = Enum.Font.SourceSans
        TextLabel.Text = text
        TextLabel.TextColor3 = Colors.Text
        TextLabel.TextSize = isMobile and 14 or 16
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local ToggleBG = Instance.new("Frame")
        ToggleBG.Name = "ToggleBG"
        ToggleBG.Parent = ToggleFrame
        ToggleBG.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        ToggleBG.BorderSizePixel = 0
        ToggleBG.Position = UDim2.new(1, -50, 0.5, -10)
        ToggleBG.Size = UDim2.new(0, 40, 0, 20)
        
        local ToggleBGCorner = Instance.new("UICorner")
        ToggleBGCorner.CornerRadius = UDim.new(1, 0)
        ToggleBGCorner.Parent = ToggleBG
        
        local ToggleIndicator = Instance.new("Frame")
        ToggleIndicator.Name = "Indicator"
        ToggleIndicator.Parent = ToggleBG
        ToggleIndicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        ToggleIndicator.BorderSizePixel = 0
        ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
        ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
        
        local IndicatorCorner = Instance.new("UICorner")
        IndicatorCorner.CornerRadius = UDim.new(1, 0)
        IndicatorCorner.Parent = ToggleIndicator
        
        local enabled = false
        
        local function updateToggle()
            if enabled then
                TweenService:Create(ToggleIndicator, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
                TweenService:Create(ToggleBG, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ToggleEnabled}):Play()
            else
                TweenService:Create(ToggleIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
                TweenService:Create(ToggleBG, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
            end
            
            callback(enabled)
        end
        
        -- كائن قابل للنقر لتفعيل التبديل (للجوال والكمبيوتر)
        local ClickArea = Instance.new("TextButton")
        ClickArea.Name = "ClickArea"
        ClickArea.Parent = ToggleFrame
        ClickArea.BackgroundTransparency = 1
        ClickArea.Size = UDim2.new(1, 0, 1, 0)
        ClickArea.Text = ""
        
        ClickArea.MouseButton1Click:Connect(function()
            enabled = not enabled
            updateToggle()
        end)
        
        return {
            frame = ToggleFrame,
            setEnabled = function(value)
                enabled = value
                updateToggle()
            end,
            getEnabled = function()
                return enabled
            end
        }
    end
    
    -- دالة لإنشاء مربع اختيار (سلايدر)
    function WestboundGUI:CreateSlider(parent, text, min, max, default, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Name = text .. "Slider"
        SliderFrame.Parent = parent
        SliderFrame.BackgroundColor3 = Colors.Toggle
        SliderFrame.BorderSizePixel = 0
        SliderFrame.Size = UDim2.new(1, 0, 0, 45)
        
        local SliderCorner = Instance.new("UICorner")
        SliderCorner.CornerRadius = UDim.new(0, 6)
        SliderCorner.Parent = SliderFrame
        
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        TextLabel.Parent = SliderFrame
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0, 10, 0, 0)
        TextLabel.Size = UDim2.new(1, -20, 0, 25)
        TextLabel.Font = Enum.Font.SourceSans
        TextLabel.Text = text
        TextLabel.TextColor3 = Colors.Text
        TextLabel.TextSize = isMobile and 14 or 16
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local ValueDisplay = Instance.new("TextLabel")
        ValueDisplay.Name = "ValueDisplay"
        ValueDisplay.Parent = SliderFrame
        ValueDisplay.BackgroundTransparency = 1
        ValueDisplay.Position = UDim2.new(0.8, 0, 0, 0)
        ValueDisplay.Size = UDim2.new(0.2, -10, 0, 25)
        ValueDisplay.Font = Enum.Font.SourceSans
        ValueDisplay.Text = tostring(default)
        ValueDisplay.TextColor3 = Colors.Text
        ValueDisplay.TextSize = isMobile and 14 or 16
        ValueDisplay.TextXAlignment = Enum.TextXAlignment.Right
        
        local SliderBG = Instance.new("Frame")
        SliderBG.Name = "SliderBG"
        SliderBG.Parent = SliderFrame
        SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        SliderBG.BorderSizePixel = 0
        SliderBG.Position = UDim2.new(0, 10, 0, 30)
        SliderBG.Size = UDim2.new(1, -20, 0, 5)
        
        local SliderBGCorner = Instance.new("UICorner")
        SliderBGCorner.CornerRadius = UDim.new(1, 0)
        SliderBGCorner.Parent = SliderBG
        
        local SliderFill = Instance.new("Frame")
        SliderFill.Name = "SliderFill"
        SliderFill.Parent = SliderBG
        SliderFill.BackgroundColor3 = Colors.Accent
        SliderFill.BorderSizePixel = 0
        SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        
        local SliderFillCorner = Instance.new("UICorner")
        SliderFillCorner.CornerRadius = UDim.new(1, 0)
        SliderFillCorner.Parent = SliderFill
        
        local SliderButton = Instance.new("TextButton")
        SliderButton.Name = "SliderButton"
        SliderButton.Parent = SliderFill
        SliderButton.AnchorPoint = Vector2.new(1, 0.5)
        SliderButton.BackgroundColor3 = Colors.Text
        SliderButton.BorderSizePixel = 0
        SliderButton.Position = UDim2.new(1, 0, 0.5, 0)
        SliderButton.Size = UDim2.new(0, 12, 0, 12)
        SliderButton.Text = ""
        SliderButton.ZIndex = 2
        
        local SliderButtonCorner = Instance.new("UICorner")
        SliderButtonCorner.CornerRadius = UDim.new(1, 0)
        SliderButtonCorner.Parent = SliderButton
        
        local value = default
        
        local function updateSlider(newValue)
            value = math.clamp(newValue, min, max)
            ValueDisplay.Text = tostring(math.floor(value))
            local scale = (value - min) / (max - min)
            SliderFill.Size = UDim2.new(scale, 0, 1, 0)
            callback(value)
        end
        
        SliderButton.MouseButton1Down:Connect(function()
            local connection
            
            connection = RunService.RenderStepped:Connect(function()
                local mousePosition = UserInputService:GetMouseLocation().X
                local sliderPosition = SliderBG.AbsolutePosition.X
                local sliderWidth = SliderBG.AbsoluteSize.X
                local relativePosition = math.clamp((mousePosition - sliderPosition) / sliderWidth, 0, 1)
                local newValue = min + (relativePosition * (max - min))
                updateSlider(newValue)
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if connection then
                        connection:Disconnect()
                    end
                end
            end)
        end)
        
        -- منطقة نقر كاملة للجوال
        local ClickArea = Instance.new("TextButton")
        ClickArea.Name = "ClickArea"
        ClickArea.Parent = SliderBG
        ClickArea.BackgroundTransparency = 1
        ClickArea.Size = UDim2.new(1, 0, 1, 0)
        ClickArea.Text = ""
        ClickArea.ZIndex = 1
        
        ClickArea.MouseButton1Down:Connect(function(x)
            local relativePosition = (x - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X
            local newValue = min + (relativePosition * (max - min))
            updateSlider(newValue)
        end)
        
        return {
            frame = SliderFrame,
            setValue = function(newValue)
                updateSlider(newValue)
            end,
            getValue = function()
                return value
            end
        }
    end
    
    -- دالة لإنشاء القائمة المنسدلة
    function WestboundGUI:CreateDropdown(parent, text, options, default, callback)
        local DropdownFrame = Instance.new("Frame")
        DropdownFrame.Name = text
