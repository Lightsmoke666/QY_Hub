--[[
    ============================================================
    WindUI 完整功能示例脚本
    作者: Footagesus (WindUI库) | 示例整理: AI Assistant
    版本: v1.6.65
    说明: 本脚本演示了 WindUI 的所有组件和功能
          直接复制到 Roblox 注入器执行即可看到效果
    ============================================================
]]

-- ============================================================
-- 第一步：加载 WindUI 库
-- ============================================================
-- 方式1：从本地文件加载（如果你的注入器支持 readfile 且 mainUI.lua 在同目录）
-- 方式2：从 GitHub 直接加载最新版（推荐，无需本地文件）

-- 从 GitHub 加载 WindUI 最新版（需要网络连接）
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

if not WindUI then
    error("WindUI 加载失败，请检查网络连接或注入器是否支持 HttpGet")
end

-- ============================================================
-- 第二步：创建窗口 (Window)
-- ============================================================
-- CreateWindow 是入口，所有 UI 都依附于窗口存在
-- 参数说明：
--   Title          : 窗口标题，显示在左上角
--   Author         : 作者信息，显示在标题下方（可选）
--   Folder         : 配置保存文件夹名称，用于自动保存设置
--   Icon           : 窗口图标，使用 WindUI 内置图标名称
--   Theme          : 主题名称，可选 Dark/Light/Rose/Plant/Red/Indigo/Sky/Violet/Amber 等
--   Size           : 窗口大小，UDim2.fromOffset(宽, 高)
--   Transparent    : 是否启用窗口透明/亚克力效果
--   Acrylic        : 是否启用毛玻璃背景（需要 Transparent=true）
--   NewElements    : 是否启用新版元素样式
--   HideSearchBar  : 是否隐藏左侧搜索栏
--   OpenButton     : 浮动打开按钮配置（移动端/快捷打开）
--   Topbar         : 顶部栏配置
--   KeySystem      : 密钥系统配置（可选，用于脚本授权验证）
-- ============================================================

local Window = WindUI:CreateWindow({
    Title = "WindUI 完整功能演示",
    Author = "by QY开发",
    Folder = "QYHubConfig",          -- 配置保存文件夹名
    Icon = "solar:folder-2-bold-duotone",
    Theme = "Dark",                  -- 可切换: Dark, Light, Rose, Plant, Red, Indigo, Sky, Violet, Amber
    -- Size = UDim2.fromOffset(700, 500),
    Transparent = true,              -- 启用透明效果
    Acrylic = true,                  -- 启用毛玻璃(Acrylic)背景
    NewElements = true,              -- 使用新版组件样式
    HideSearchBar = false,           -- 显示左侧搜索栏

    -- 浮动打开按钮配置（当窗口关闭后显示的悬浮球）
    OpenButton = {
        Title = "打开 UI",
        CornerRadius = UDim.new(1, 0),      -- 圆角半径，1=完全圆形
        StrokeThickness = 2,                -- 边框粗细
        Enabled = true,                     -- 是否启用
        Draggable = true,                   -- 是否可以拖动位置
        OnlyMobile = false,                 -- 是否仅在移动端显示
        Scale = 0.5,                        -- 按钮缩放比例
        Color = ColorSequence.new(          -- 渐变色
            Color3.fromHex("#30FF6A"),
            Color3.fromHex("#e7ff2f")
        ),
    },

    -- 顶部栏配置
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",                -- 窗口控制按钮样式: "Default" 或 "Mac"
    },

    -- 密钥系统（可选，去掉这段则不需要密钥）
    --[[
    KeySystem = {
        Title = "密钥验证",
        Subtitle = "请输入密钥以继续",
        SaveKey = true,                     -- 是否记住密钥
        Key = {"FREE-KEY-123", "VIP-456"},  -- 有效密钥列表
        -- KeyValidator = function(key) return key == "SECRET" end, -- 自定义验证函数
    },
    --]]
})

-- ============================================================
-- 窗口级功能方法
-- ============================================================

-- 设置 UI 整体缩放比例
-- Window:SetUIScale(0.8)

-- 添加右上角标签（常用于显示版本号）
Window:Tag({
    Title = "v" .. WindUI.Version,
    Icon = "github",
    Color = Color3.fromHex("#1c1c1c"),
    Border = true,
})

-- ============================================================
-- 第三步：创建侧边栏分组 (Section)
-- ============================================================
-- Section 用于在左侧边栏对 Tab 进行分组，让结构更清晰
-- 例如："主要功能"、"设置" 这样的分组标题

local MainSection = Window:Section({ Title = "主要功能" })
local ElementSection = Window:Section({ Title = "组件展示" })
local AdvancedSection = Window:Section({ Title = "高级功能" })
local SettingsSection = Window:Section({ Title = "系统设置" })

-- ============================================================
-- 第四步：创建标签页 (Tab)
-- ============================================================
-- Tab 是窗口内的主要页面，点击左侧栏切换
-- 参数说明：
--   Title      : 标签名称
--   Desc       : 描述文字（鼠标悬停显示）
--   Icon       : 图标名称
--   IconColor  : 图标颜色
--   IconShape  : 图标形状: "Square" 或 nil(圆形)
--   Border     : 是否显示边框

-- ==================== Tab 1: 概览 ====================
local OverviewTab = MainSection:Tab({
    Title = "概览",
    Desc = "WindUI 基础功能概览",
    Icon = "solar:home-2-bold",
    IconColor = Color3.fromHex("#83889E"),
    IconShape = "Square",
    Border = true,
})

-- Paragraph（文本段落）：用于展示说明文字
OverviewTab:Paragraph({
    Title = "欢迎使用 WindUI",
    Content = "这是一个功能完整的 Roblox UI 库演示。\n左侧可以切换不同页面，每个页面展示了不同的组件功能。",
})

OverviewTab:Space() -- Space：添加空行间隔，让排版更舒适

-- Button（按钮）：最基础的交互组件
-- 参数：Title(标题), Desc(描述), Icon(图标), Color(颜色), Callback(点击回调)
OverviewTab:Button({
    Title = "点击我 (Button)",
    Desc = "这是一个基础按钮示例",
    Icon = "mouse",
    Callback = function()
        print("[WindUI] 按钮被点击了！")
    end,
})

OverviewTab:Space()

-- Toggle（开关）：布尔值切换组件
-- 参数：Title, Desc, Value(默认值), Callback(状态变化回调)
local MyToggle = OverviewTab:Toggle({
    Title = "启用功能 (Toggle)",
    Desc = "点击切换开关状态",
    Value = false,
    Callback = function(Value)
        print("[WindUI] 开关状态:", Value)
    end,
})

OverviewTab:Space()

-- Slider（滑块）：数值选择组件
-- 参数：Title, Desc, Value{Min, Max, Default}, Step(步进), Width, Callback
OverviewTab:Slider({
    Title = "数值调节 (Slider)",
    Desc = "拖动滑块调整数值",
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Step = 1,
    Width = 200,
    Callback = function(Value)
        print("[WindUI] 滑块数值:", Value)
    end,
})

-- ==================== Tab 2: 按钮详解 ====================
local ButtonTab = ElementSection:Tab({
    Title = "按钮",
    Icon = "solar:cursor-square-bold",
    IconColor = Color3.fromHex("#257AF7"),
    IconShape = "Square",
    Border = true,
})

ButtonTab:Paragraph({
    Title = "Button 组件说明",
    Content = "Button 支持多种样式：普通按钮、带颜色按钮、触发通知、高亮效果、锁定状态等。",
})

ButtonTab:Space()

-- 普通按钮
ButtonTab:Button({
    Title = "普通按钮",
    Callback = function()
        print("普通按钮点击")
    end,
})

ButtonTab:Space()

-- 带自定义颜色的按钮
ButtonTab:Button({
    Title = "蓝色按钮 (自定义颜色)",
    Color = Color3.fromHex("#305dff"),
    Icon = "",
    Callback = function() end,
})

ButtonTab:Space()

-- 触发通知的按钮
ButtonTab:Button({
    Title = "发送通知 (Notify)",
    Desc = "点击弹出右上角通知",
    Callback = function()
        -- Notify（通知）：在屏幕右上角弹出提示
        -- 参数：Title, Content, Icon, Duration(秒), CanClose(是否可手动关闭)
        WindUI:Notify({
            Title = "通知标题",
            Content = "这是一条测试通知消息！\n支持多行文本显示。",
            Icon = "solar:bell-bold",
            Duration = 5,          -- 显示5秒后自动消失
            CanClose = true,       -- 允许用户手动关闭
        })
    end,
})

ButtonTab:Space()

-- 高亮按钮（点击后高亮自身）
local HighlightBtn
HighlightBtn = ButtonTab:Button({
    Title = "高亮按钮 (Highlight)",
    Icon = "sparkles",
    Callback = function()
        HighlightBtn:Highlight() -- 调用 Highlight() 让按钮闪烁高亮
        print("按钮高亮！")
    end,
})

ButtonTab:Space()

-- 锁定状态的按钮（无法点击，常用于权限不足时）
ButtonTab:Button({
    Title = "锁定按钮 (Locked)",
    Desc = "当前无法使用此功能",
    Locked = true,                      -- 锁定状态
    LockedTitle = "需要 VIP 权限",      -- 鼠标悬停时显示的提示
})

-- ==================== Tab 3: 开关详解 ====================
local ToggleTab = ElementSection:Tab({
    Title = "开关",
    Icon = "solar:check-square-bold",
    IconColor = Color3.fromHex("#10C550"),
    IconShape = "Square",
    Border = true,
})

ToggleTab:Paragraph({
    Title = "Toggle 组件说明",
    Content = "Toggle 提供两种视觉样式：默认开关(Switch) 和 复选框(Checkbox)。",
})

ToggleTab:Space()

-- 默认样式的开关
ToggleTab:Toggle({
    Title = "默认开关",
    Value = true,
    Callback = function(v)
        print("默认开关:", v)
    end,
})

ToggleTab:Space()

-- Checkbox 样式的开关
ToggleTab:Toggle({
    Title = "复选框样式 (Checkbox)",
    Type = "Checkbox",          -- 切换为复选框外观
    Value = false,
    Callback = function(v)
        print("复选框:", v)
    end,
})

ToggleTab:Space()

-- 带描述的开关
ToggleTab:Toggle({
    Title = "带描述的开关",
    Desc = "这是一个带有详细说明文字的开关组件",
    Callback = function(v)
        print("带描述开关:", v)
    end,
})

ToggleTab:Space()

-- 锁定的开关
ToggleTab:Toggle({
    Title = "锁定开关",
    Locked = true,
    LockedTitle = "此功能暂未开放",
})

-- ==================== Tab 4: 滑块详解 ====================
local SliderTab = ElementSection:Tab({
    Title = "滑块",
    Icon = "solar:square-transfer-horizontal-bold",
    IconColor = Color3.fromHex("#ECA201"),
    IconShape = "Square",
    Border = true,
})

SliderTab:Paragraph({
    Title = "Slider 组件说明",
    Content = "Slider 用于数值选择，支持拖动、文本框输入、Tooltip提示、步进值、图标等。",
})

SliderTab:Space()

-- 基础滑块
SliderTab:Slider({
    Title = "基础滑块",
    Desc = "范围 0 ~ 100，默认值 50",
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Step = 1,
    Callback = function(value)
        print("基础滑块:", value)
    end,
})

SliderTab:Space()

-- 带 Tooltip 的滑块（鼠标悬停显示当前值）
SliderTab:Slider({
    Title = "带 Tooltip 的滑块",
    Desc = "鼠标悬停在滑块上可看到当前数值",
    IsTooltip = true,           -- 启用悬停提示
    IsTextbox = false,          -- 禁用文本框输入，只允许拖动
    Value = {
        Min = 0,
        Max = 200,
        Default = 100,
    },
    Step = 1,
    Callback = function(value)
        print("Tooltip滑块:", value)
    end,
})

SliderTab:Space()

-- 带图标的滑块（左右两侧显示图标）
SliderTab:Slider({
    Title = "带图标的滑块",
    Desc = "左侧太阳小图标，右侧太阳大图标",
    IsTooltip = true,
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Step = 1,
    Icons = {
        From = "sfsymbols:sunMinFill",   -- 左侧图标（最小值端）
        To = "sfsymbols:sunMaxFill",     -- 右侧图标（最大值端）
    },
    Callback = function(value)
        print("图标滑块:", value)
    end,
})

-- ==================== Tab 5: 下拉菜单 ====================
local DropdownTab = ElementSection:Tab({
    Title = "下拉菜单",
    Icon = "solar:hamburger-menu-bold",
    IconColor = Color3.fromHex("#7775F2"),
    IconShape = "Square",
    Border = true,
})

DropdownTab:Paragraph({
    Title = "Dropdown 组件说明",
    Content = "Dropdown 支持两种模式：\n1. 简单模式：纯字符串列表，选中后返回字符串\n2. 高级模式：每个选项可带图标、描述、独立回调",
})

DropdownTab:Space()

-- 简单下拉菜单
DropdownTab:Dropdown({
    Title = "简单下拉菜单",
    Desc = "选择一个选项",
    Values = {"选项 A", "选项 B", "选项 C", "选项 D"},
    Value = "选项 A",           -- 默认选中值
    Callback = function(value)
        print("简单下拉选择:", value)
    end,
})

DropdownTab:Space()

-- 高级下拉菜单（每个选项有独立的图标、描述和点击回调）
DropdownTab:Dropdown({
    Title = "高级下拉菜单",
    Desc = "每个选项都有独立功能",
    Values = {
        {
            Title = "新建文件",
            Desc = "创建一个新文件",
            Icon = "file-plus",
            Callback = function()
                print("执行：新建文件")
            end,
        },
        {
            Title = "复制链接",
            Desc = "复制分享链接",
            Icon = "copy",
            Callback = function()
                print("执行：复制链接")
            end,
        },
        {
            Title = "编辑文件",
            Desc = "进入编辑模式",
            Icon = "file-pen",
            Callback = function()
                print("执行：编辑文件")
            end,
        },
        {
            Type = "Divider",       -- 分隔线，用于分组视觉隔离
        },
        {
            Title = "删除文件",
            Desc = "永久删除（不可恢复）",
            Icon = "trash",
            Callback = function()
                print("执行：删除文件")
            end,
        },
    },
    Callback = function(value)
        -- 高级模式下，如果选项有独立 Callback，会优先触发独立回调
        print("下拉菜单选中:", value)
    end,
})

-- ==================== Tab 6: 输入框 ====================
local InputTab = ElementSection:Tab({
    Title = "输入框",
    Icon = "solar:password-minimalistic-input-bold",
    IconColor = Color3.fromHex("#EF4F1D"),
    IconShape = "Square",
    Border = true,
})

InputTab:Paragraph({
    Title = "Input 组件说明",
    Content = "Input 支持单行输入和 Textarea 多行输入两种模式。",
})

InputTab:Space()

-- 单行输入框
InputTab:Input({
    Title = "单行输入",
    Desc = "输入后按回车或失去焦点触发回调",
    Placeholder = "请输入内容...",
    Callback = function(text)
        print("单行输入内容:", text)
    end,
})

InputTab:Space()

-- 多行文本输入框 (Textarea)
InputTab:Input({
    Title = "多行文本 (Textarea)",
    Desc = "适合输入长文本",
    Type = "Textarea",          -- 切换为多行模式
    Placeholder = "在这里输入多行文本...",
    Callback = function(text)
        print("多行输入内容:", text)
    end,
})

InputTab:Space()

-- 带图标的输入框
InputTab:Input({
    Title = "带图标的输入框",
    Icon = "search",
    Placeholder = "搜索...",
    Callback = function(text)
        print("搜索内容:", text)
    end,
})

-- ==================== Tab 7: 快捷键 ====================
local KeybindTab = ElementSection:Tab({
    Title = "快捷键",
    Icon = "command",
    IconColor = Color3.fromHex("#33C759"),
    IconShape = "Square",
    Border = true,
})

KeybindTab:Paragraph({
    Title = "Keybind 组件说明",
    Content = "Keybind 用于绑定键盘按键，常用于设置功能快捷键（如一键飞行、一键传送等）。",
})

KeybindTab:Space()

-- 快捷键绑定
KeybindTab:Keybind({
    Title = "功能快捷键",
    Desc = "按下想要绑定的按键",
    Value = "F",                -- 默认按键
    Callback = function(key)
        print("[WindUI] 快捷键被触发，绑定的按键是:", tostring(key))
    end,
})

KeybindTab:Space()

-- 另一个快捷键示例
KeybindTab:Keybind({
    Title = "一键隐藏 UI",
    Desc = "按下此键切换窗口显示/隐藏",
    Value = "Insert",           -- Insert 键是常见的 UI 切换键
    Callback = function(key)
        print("[WindUI] Insert 键触发")
    end,
})

-- ==================== Tab 8: 颜色选择器 ====================
local ColorTab = ElementSection:Tab({
    Title = "颜色选择",
    Icon = "palette",
    IconColor = Color3.fromHex("#be185d"),
    IconShape = "Square",
    Border = true,
})

ColorTab:Paragraph({
    Title = "Colorpicker 组件说明",
    Content = "Colorpicker 提供直观的色板选择，支持 HEX、RGB 输入和透明度调节。",
})

ColorTab:Space()

-- 颜色选择器
ColorTab:Colorpicker({
    Title = "选择颜色",
    Desc = "点击展开颜色面板",
    Default = Color3.fromHex("#30ff6a"),  -- 默认绿色
    Callback = function(color)
        print("[WindUI] 选择的颜色:", tostring(color))
    end,
})

ColorTab:Space()

-- 带透明度的颜色选择器
ColorTab:Colorpicker({
    Title = "带透明度的颜色",
    Desc = "支持调节透明度 (Alpha)",
    Default = Color3.fromHex("#ff3050"),
    Transparency = 0.5,         -- 默认透明度 0.5
    Callback = function(color, transparency)
        print("[WindUI] 颜色:", tostring(color), "透明度:", transparency)
    end,
})

-- ==================== Tab 9: 代码展示 ====================
local CodeTab = ElementSection:Tab({
    Title = "代码块",
    Icon = "terminal",
    IconColor = Color3.fromHex("#00d4ff"),
    IconShape = "Square",
    Border = true,
})

CodeTab:Paragraph({
    Title = "Code 组件说明",
    Content = "Code 组件用于展示格式化的代码片段，支持语法高亮风格的显示。",
})

CodeTab:Space()

-- 代码展示
CodeTab:Code({
    Title = "示例代码",
    Code = [[
-- 这是一个 Lua 代码示例
local function hello(name)
    print("Hello, " .. name .. "!")
end

hello("WindUI")
    ]],
})

-- ==================== Tab 10: 通知与对话框 ====================
local NotifyTab = AdvancedSection:Tab({
    Title = "通知/对话框",
    Icon = "solar:bell-bold",
    IconColor = Color3.fromHex("#ECA201"),
    IconShape = "Square",
    Border = true,
})

NotifyTab:Paragraph({
    Title = "通知与对话框说明",
    Content = "WindUI 提供了全局通知(Notify)和模态对话框(Dialog/Poup)两种交互方式。",
})

NotifyTab:Space()

-- 发送基础通知
NotifyTab:Button({
    Title = "发送基础通知",
    Callback = function()
        WindUI:Notify({
            Title = "基础通知",
            Content = "这是一条最简单的通知消息。",
            Duration = 3,
        })
    end,
})

NotifyTab:Space()

-- 发送带图标的通知
NotifyTab:Button({
    Title = "发送带图标通知",
    Callback = function()
        WindUI:Notify({
            Title = "任务完成",
            Content = "你的设置已成功保存到本地！",
            Icon = "solar:check-square-bold",
            Duration = 5,
            CanClose = true,
        })
    end,
})

NotifyTab:Space()

-- 弹出对话框
NotifyTab:Button({
    Title = "弹出对话框 (Dialog)",
    Callback = function()
        -- Dialog（对话框）：居中弹出的模态窗口，必须用户响应后才能继续
        Window:Dialog({
            Title = "确认操作",
            Content = "你确定要执行此操作吗？\n此操作不可撤销。",
            Width = 360,
            Buttons = {
                {
                    Title = "取消",
                    Variant = "Tertiary",   -- 按钮样式: Primary(主色), Secondary(次要), Tertiary(灰色)
                    Callback = function()
                        print("用户点击了取消")
                    end,
                },
                {
                    Title = "确认执行",
                    Variant = "Primary",
                    Callback = function()
                        print("用户点击了确认")
                        WindUI:Notify({
                            Title = "已执行",
                            Content = "操作已成功完成！",
                        })
                    end,
                },
            },
        })
    end,
})

NotifyTab:Space()

-- Popup（快捷弹窗）
NotifyTab:Button({
    Title = "弹出 Popup",
    Callback = function()
        WindUI:Popup({
            Title = "欢迎",
            Icon = "bird",
            Content = "欢迎使用 WindUI 示例脚本！",
            Buttons = {
                { Title = "知道了", Variant = "Primary" },
            },
        })
    end,
})

-- ==================== Tab 11: 布局组件 ====================
local LayoutTab = AdvancedSection:Tab({
    Title = "布局组件",
    Icon = "layout",
    IconColor = Color3.fromHex("#7775F2"),
    IconShape = "Square",
    Border = true,
})

LayoutTab:Paragraph({
    Title = "Group 与 Section 布局",
    Content = "Group 可以将多个组件并排显示，Section 是带标题的可折叠区域。",
})

LayoutTab:Space()

-- Group：将组件放在同一行/列分组中
local DemoGroup = LayoutTab:Group({})

DemoGroup:Button({
    Title = "组内按钮 1",
    Justify = "Center",
    Callback = function()
        print("组内按钮1")
    end,
})

DemoGroup:Space()

DemoGroup:Toggle({
    Title = "组内开关",
    Callback = function(v)
        print("组内开关:", v)
    end,
})

LayoutTab:Space()

-- Section（可折叠区域）：带标题的折叠面板
local CollapseSection = LayoutTab:Section({
    Title = "可折叠区域 (Section)",
    Desc = "点击标题可以展开/收起内容",
    Box = true,                 -- 是否显示外框
    BoxBorder = true,           -- 外框是否带边框
    Opened = true,              -- 默认是否展开
})

CollapseSection:Button({
    Title = "折叠区域内的按钮",
    Callback = function()
        print("折叠区域按钮点击")
    end,
})

CollapseSection:Space()

CollapseSection:Toggle({
    Title = "折叠区域内的开关",
    Callback = function(v)
        print("折叠区域开关:", v)
    end,
})

LayoutTab:Space()

-- Image：展示图片（支持 rbxassetid 或 HTTP 链接）
LayoutTab:Paragraph({
    Title = "Image 图片组件",
    Content = "可以在 UI 中展示图片，支持设置宽高比和圆角。",
})

LayoutTab:Image({
    Image = "rbxassetid://89641024074289",  -- 也可以使用 "https://..." 外部链接（如果游戏允许）
    AspectRatio = "16:9",                   -- 宽高比
    Radius = 12,                            -- 圆角半径
})

-- ==================== Tab 12: 主题与设置 ====================
local ThemeTab = SettingsSection:Tab({
    Title = "主题设置",
    Icon = "palette",
    IconColor = Color3.fromHex("#10C550"),
    IconShape = "Square",
    Border = true,
})

ThemeTab:Paragraph({
    Title = "Theme 主题切换",
    Content = "WindUI 内置多种主题，可以实时切换。\n当前支持: Dark, Light, Rose, Plant, Red, Indigo, Sky, Violet, Amber",
})

ThemeTab:Space()

-- 主题切换按钮列表
local themes = {"Dark", "Light", "Rose", "Plant", "Red", "Indigo", "Sky", "Violet", "Amber"}
for _, themeName in ipairs(themes) do
    ThemeTab:Button({
        Title = "切换到 " .. themeName .. " 主题",
        Callback = function()
            -- SetTheme 可以实时切换整个 UI 的主题颜色
            WindUI:SetTheme(themeName)
            WindUI:Notify({
                Title = "主题已切换",
                Content = "当前主题: " .. themeName,
                Duration = 2,
            })
        end,
    })
    ThemeTab:Space()
end

-- ==================== Tab 13: 窗口控制 ====================
local ControlTab = SettingsSection:Tab({
    Title = "窗口控制",
    Icon = "settings",
    IconColor = Color3.fromHex("#83889E"),
    IconShape = "Square",
    Border = true,
})

ControlTab:Paragraph({
    Title = "Window 控制方法",
    Content = "这里演示了窗口的各种控制方法。",
})

ControlTab:Space()

-- 切换窗口显示/隐藏
ControlTab:Button({
    Title = "切换窗口显示 (Toggle)",
    Desc = "隐藏或显示主窗口",
    Callback = function()
        Window:Toggle()
    end,
})

ControlTab:Space()

-- 切换全屏
ControlTab:Button({
    Title = "切换全屏 (ToggleFullscreen)",
    Callback = function()
        Window:ToggleFullscreen()
    end,
})

ControlTab:Space()

-- 切换透明度效果
ControlTab:Button({
    Title = "切换 Acrylic 效果",
    Callback = function()
        Window:ToggleTransparency()
    end,
})

ControlTab:Space()

-- 修改 UI 缩放
ControlTab:Slider({
    Title = "UI 缩放比例",
    Desc = "调整整个界面的缩放大小",
    Value = {
        Min = 0.5,
        Max = 1.5,
        Default = 1.0,
    },
    Step = 0.1,
    Callback = function(value)
        Window:SetUIScale(value)
    end,
})

ControlTab:Space()

-- 销毁窗口
ControlTab:Button({
    Title = "销毁窗口 (Destroy)",
    Desc = "彻底销毁整个 UI（无法恢复）",
    Color = Color3.fromHex("#ff4830"),
    Icon = "trash",
    Callback = function()
        Window:Dialog({
            Title = "确认销毁",
            Content = "确定要销毁整个 UI 吗？\n此操作不可撤销。",
            Buttons = {
                {
                    Title = "取消",
                    Variant = "Tertiary",
                },
                {
                    Title = "确认销毁",
                    Variant = "Primary",
                    Callback = function()
                        Window:Destroy()
                    end,
                },
            },
        })
    end,
})

-- ============================================================
-- 脚本加载完成提示
-- ============================================================
WindUI:Notify({
    Title = "WindUI 示例已加载",
    Content = "所有组件已就绪，点击左侧标签页开始体验！",
    Icon = "solar:check-square-bold",
    Duration = 4,
})

print("[WindUI] 示例脚本加载完成！版本:", WindUI.Version)
