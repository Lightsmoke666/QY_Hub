local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "QY Hub",
    Author = "QY开发",
    Folder = "QYHub",
    Icon = "solar:folder-2-bold-duotone",
    Theme = "Dark",
    Transparent = true,
    Acrylic = true,
    Size = UDim2.fromOffset(700, 500),
    Topbar = {
        Height = 44,
        ButtonsType = "Default",
    },
    HideTopbarButtons = true,
    OpenButton = {
        Title = "QY",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 2,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Scale = 0.5,
        Color = ColorSequence.new(Color3.fromHex("#ff3050"), Color3.fromHex("#e7ff2f")),
    },
})

Window:SetUIScale(1.0)

Window:Tag({
    Title = "BetaV0.1",
    Icon = "github",
    Color = Color3.fromHex("#ff3050"),
    Border = true,
})

local SettingsTab = Window:Tab({
    Title = "设置",
    Icon = "solar:settings-bold",
    IconColor = Color3.fromHex("#ff3050"),
})

SettingsTab:Paragraph({
    Title = "QY Hub 设置面板",
    Content = "在这里自定义你的 UI 外观",
})

SettingsTab:Space()

local themeSection = SettingsTab:Section({
    Title = "主题切换",
    Box = true,
    Opened = true,
})

local themes = {"Dark", "Light", "Rose", "Plant", "Red", "Indigo", "Sky", "Violet", "Amber"}
for _, themeName in ipairs(themes) do
    themeSection:Button({
        Title = "切换 " .. themeName,
        Callback = function()
            WindUI:SetTheme(themeName)
            WindUI:Notify({
                Title = "主题已切换",
                Content = "当前主题: " .. themeName,
                Duration = 2,
            })
        end,
    })
    themeSection:Space()
end

SettingsTab:Space()

local colorSection = SettingsTab:Section({
    Title = "自定义颜色",
    Box = true,
    Opened = true,
})

colorSection:Colorpicker({
    Title = "主色调",
    Desc = "选择你的自定义主题色",
    Default = Color3.fromHex("#ff3050"),
    Callback = function(color)
        WindUI:AddTheme({
            Name = "QYCustom",
            Accent = Color3.fromHex("#18181b"),
            Dialog = Color3.fromHex("#1a1a1a"),
            Text = Color3.fromHex("#ffffff"),
            Placeholder = Color3.fromHex("#a1a1a1"),
            Background = Color3.fromHex("#101010"),
            Button = color,
            Icon = color,
            Toggle = color,
            Slider = color,
            Checkbox = color,
            Primary = color,
            PanelBackground = Color3.fromHex("#ffffff"),
            PanelBackgroundTransparency = 0.95,
            LabelBackground = Color3.fromHex("#000000"),
            LabelBackgroundTransparency = 0.83,
            ElementBackground = Color3.fromHex("#2A2A2C"),
            ElementBackgroundTransparency = 0,
        })
        WindUI:SetTheme("QYCustom")
        WindUI:Notify({
            Title = "自定义主题已应用",
            Content = "主色调已更新",
            Duration = 2,
        })
    end,
})

SettingsTab:Space()

local windowSection = SettingsTab:Section({
    Title = "窗口设置",
    Box = true,
    Opened = true,
})

windowSection:Toggle({
    Title = "毛玻璃效果 (Acrylic)",
    Value = true,
    Callback = function(v)
        Window:ToggleTransparency(v)
        WindUI:Notify({
            Title = "效果已切换",
            Content = v and "毛玻璃已启用" or "毛玻璃已禁用",
            Duration = 2,
        })
    end,
})

windowSection:Space()

windowSection:Slider({
    Title = "窗口宽度",
    Value = {
        Min = 500,
        Max = 900,
        Default = 700,
    },
    Step = 10,
    Callback = function(value)
        Window.UIElements.Main.Main.Size = UDim2.fromOffset(value, Window.UIElements.Main.Main.AbsoluteSize.Y)
    end,
})

windowSection:Slider({
    Title = "窗口高度",
    Value = {
        Min = 350,
        Max = 700,
        Default = 500,
    },
    Step = 10,
    Callback = function(value)
        Window.UIElements.Main.Main.Size = UDim2.fromOffset(Window.UIElements.Main.Main.AbsoluteSize.X, value)
    end,
})

SettingsTab:Space()

local buttonSection = SettingsTab:Section({
    Title = "浮动按钮",
    Box = true,
    Opened = true,
})

buttonSection:Input({
    Title = "按钮文字",
    Placeholder = "输入按钮上的文字",
    Callback = function(text)
        Window.UIElements.Topbar.OpenButton.TextButton.Text = text
        WindUI:Notify({
            Title = "已更新",
            Content = "按钮文字已改为: " .. text,
            Duration = 2,
        })
    end,
})

buttonSection:Colorpicker({
    Title = "按钮渐变色",
    Default = Color3.fromHex("#ff3050"),
    Callback = function(color)
        Window.UIElements.Topbar.OpenButton.TextButton.UIGradient.Color = ColorSequence.new(color, Color3.fromHex("#e7ff2f"))
        WindUI:Notify({
            Title = "已更新",
            Content = "按钮颜色已更新",
            Duration = 2,
        })
    end,
})

local realDestroy = Window.Destroy
Window.Destroy = function(...)
    Window:Dialog({
        Title = "关闭窗口",
        Content = "你确定要关闭窗口吗？关闭后无法再次打开。",
        Buttons = {
            {
                Title = "取消",
                Variant = "Secondary",
                Callback = function() end,
            },
            {
                Title = "关闭窗口",
                Variant = "Primary",
                Callback = function()
                    realDestroy(Window)
                end,
            },
        },
    })
end
