-- [[ GROW A GARDEN 2 - REMOTE SEED SCANNER (NO FLY) ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Cleanup UI cũ
if CoreGui:FindFirstChild("GAG_RemoteHub") then
    CoreGui.GAG_RemoteHub:Destroy()
end

-- ==========================================
-- 🎨 GIAO DIỆN HUB & NÚT TẮT/BẬT
-- ==========================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "GAG_RemoteHub"
Gui.Parent = CoreGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Gui
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleBtn.Text = "🌾"
ToggleBtn.TextSize = 22
ToggleBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 215, 0)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Parent = Gui
MainFrame.Size = UDim2.new(0, 420, 0, 480)
MainFrame.Position = UDim2.new(0.08, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.Active = true
MainFrame.Draggable = true

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Color3.fromRGB(255, 215, 0)
FrameStroke.Thickness = 2
FrameStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "★ GROW A GARDEN 2 - REMOTE HUB ★"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(0.92, 0, 0.01, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ==========================================
-- 🔘 TOGGLE SWITCH
-- ==========================================

local isAutoPet = false
local isAutoHarvest = false
local isBusy = false
local isNoclipping = false

local function CreateToggleSwitch(parent, labelText, posX, posY, callback)
    local Container = Instance.new("Frame")
    Container.Parent = parent
    Container.Size = UDim2.new(0, 180, 0, 35)
    Container.Position = UDim2.new(0, posX, 0, posY)
    Container.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel")
    Label.Parent = Container
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SwitchBg = Instance.new("Frame")
    SwitchBg.Parent = Container
    SwitchBg.Size = UDim2.new(0, 44, 0, 22)
    SwitchBg.Position = UDim2.new(0.68, 0, 0.2, 0)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBg

    local Knob = Instance.new("Frame")
    Knob.Parent = SwitchBg
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = UDim2.new(0, 3, 0.5, -8)
    Knob.BackgroundColor3 = Color3.fromRGB(180, 180, 180)

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Parent = SwitchBg
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""

    local toggled = false
    ClickBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        local targetPos = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        local targetBgColor = toggled and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(40, 40, 45)

        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = targetBgColor}):Play()

        callback(toggled)
    end)
end

CreateToggleSwitch(MainFrame, "AUTO HARVEST", 10, 35, function(state) isAutoHarvest = state end)
CreateToggleSwitch(MainFrame, "AUTO PET (FLY)", 210, 35, function(state) isAutoPet = state end)

-- Bảng Đồng hồ & Danh Sách Hạt Giống
local TimerLabel = Instance.new("TextLabel")
TimerLabel.Parent = MainFrame
TimerLabel.Size = UDim2.new(1, -20, 0, 25)
TimerLabel.Position = UDim2.new(0, 10, 0, 75)
TimerLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TimerLabel.Text = "⏱ Restock In: --:--"
TimerLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
TimerLabel.Font = Enum.Font.SourceSansBold
TimerLabel.TextSize = 13

local TimerCorner = Instance.new("UICorner")
TimerCorner.CornerRadius = UDim.new(0, 6)
TimerCorner.Parent = TimerLabel

local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Parent = MainFrame
ScrollContainer.Size = UDim2.new(1, -20, 1, -115)
ScrollContainer.Position = UDim2.new(0, 10, 0, 105)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollContainer.ScrollBarThickness = 5

local UIList = Instance.new("UIListLayout")
UIList.Parent = ScrollContainer
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 4)

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end)

-- ==========================================
-- 📡 REMOTE SEED SCANNER (QUÉT TỪ XA KHÔNG FLY)
-- ==========================================

local function GetRemoteSeedData()
    local seedList = {}

    -- 1. Tìm các RemoteFunction trong ReplicatedStorage liên quan đến Shop/Seeds
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            if string.find(name, "seed") or string.find(name, "shop") or string.find(name, "getstock") then
                pcall(function()
                    local data = obj:InvokeServer()
                    if type(data) == "table" then
                        for k, v in pairs(data) do
                            if type(v) == "table" then
                                table.insert(seedList, {
                                    Name = v.Name or v.Title or tostring(k),
                                    Price = v.Price or v.Cost or "100",
                                    Stock = v.Stock or v.Amount or (v.InStock and "In Stock" or "Out")
                                })
                            end
                        end
                    end
                end)
            end
        end
    end

    -- 2. Quét trực tiếp Modules/Values trong ReplicatedStorage nếu Remote không trả về dữ liệu
    if #seedList == 0 then
        local seedsFolder = ReplicatedStorage:FindFirstChild("Seeds", true) or ReplicatedStorage:FindFirstChild("SeedData", true) or Workspace:FindFirstChild("SeedShop", true)
        
        if seedsFolder then
            for _, item in ipairs(seedsFolder:GetChildren()) do
                local name = item.Name
                local price = "N/A"
                local stock = "Out of Stock"

                -- Lấy giá trị thuộc tính Attributes hoặc Value
                local pVal = item:FindFirstChild("Price") or item:FindFirstChild("Cost")
                if pVal then
                    price = tostring(pVal.Value)
                else
                    price = tostring(item:GetAttribute("Price") or item:GetAttribute("Cost") or "50 Gold")
                end

                local sVal = item:FindFirstChild("Stock") or item:FindFirstChild("InStock") or item:FindFirstChild("Amount")
                if sVal then
                    if sVal:IsA("BoolValue") then
                        stock = sVal.Value and "In Stock" or "Out of Stock"
                    else
                        stock = tostring(sVal.Value)
                    end
                else
                    local attrStock = item:GetAttribute("Stock")
                    if attrStock ~= nil then
                        stock = tostring(attrStock)
                    else
                        stock = "In Stock" -- Mặc định nếu tồn tại Item
                    end
                end

                table.insert(seedList, {Name = name, Price = price, Stock = stock})
            end
        end
    end

    return seedList
end

local function RenderSeedUI()
    for _, child in ipairs(ScrollContainer:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local seedData = GetRemoteSeedData()

    for i, data in ipairs(seedData) do
        if i > 30 then break end

        local ItemFrame = Instance.new("Frame")
        ItemFrame.Parent = ScrollContainer
        ItemFrame.Size = UDim2.new(1, 0, 0, 30)
        ItemFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 34)

        local ItemCorner = Instance.new("UICorner")
        ItemCorner.CornerRadius = UDim.new(0, 5)
        ItemCorner.Parent = ItemFrame

        local NameTxt = Instance.new("TextLabel")
        NameTxt.Parent = ItemFrame
        NameTxt.Size = UDim2.new(0.45, 0, 1, 0)
        NameTxt.Position = UDim2.new(0, 8, 0, 0)
        NameTxt.BackgroundTransparency = 1
        NameTxt.Text = i .. ". " .. data.Name
        NameTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameTxt.Font = Enum.Font.SourceSansBold
        NameTxt.TextSize = 12
        NameTxt.TextXAlignment = Enum.TextXAlignment.Left

        local PriceTxt = Instance.new("TextLabel")
        PriceTxt.Parent = ItemFrame
        PriceTxt.Size = UDim2.new(0.25, 0, 1, 0)
        PriceTxt.Position = UDim2.new(0.45, 0, 0, 0)
        PriceTxt.BackgroundTransparency = 1
        PriceTxt.Text = "💵 " .. data.Price
        PriceTxt.TextColor3 = Color3.fromRGB(255, 215, 0)
        PriceTxt.Font = Enum.Font.SourceSans
        PriceTxt.TextSize = 11

        local StockTxt = Instance.new("TextLabel")
        StockTxt.Parent = ItemFrame
        StockTxt.Size = UDim2.new(0.28, -5, 1, 0)
        StockTxt.Position = UDim2.new(0.7, 0, 0, 0)
        StockTxt.BackgroundTransparency = 1

        local sStr = tostring(data.Stock):lower()
        local isInStock = string.find(sStr, "in stock") or string.find(sStr, "true") or string.find(sStr, "còn") or (tonumber(sStr) and tonumber(sStr) > 0)
        
        StockTxt.Text = isInStock and "✔ IN STOCK" or "✖ OUT"
        StockTxt.TextColor3 = isInStock and Color3.fromRGB(80, 255, 100) or Color3.fromRGB(255, 70, 70)
        StockTxt.Font = Enum.Font.SourceSansBold
        StockTxt.TextSize = 11
    end
end

-- ==========================================
-- 🌾 AUTO HARVEST & AUTO PET LOGIC
-- ==========================================

local function FindGardenCenter()
    local plots = Workspace:FindFirstChild("Plots") or Workspace:FindFirstChild("Farms")
    if plots then
        for _, plot in ipairs(plots:GetChildren()) do
            if string.find(plot.Name:lower(), LocalPlayer.Name:lower()) or plot:FindFirstChild(LocalPlayer.Name) then
                return plot:GetPivot()
            end
        end
    end
    local char = LocalPlayer.Character
    return char and char:GetPivot()
end

task.spawn(function()
    local movedToCenter = false
    while true do
        if isAutoHarvest and not isBusy then
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    if not movedToCenter then
                        local gardenCenter = FindGardenCenter()
                        if gardenCenter then
                            hrp.CFrame = gardenCenter * CFrame.new(0, 3, 0)
                            movedToCenter = true
                            task.wait(0.3)
                        end
                    end

                    for _, prompt in ipairs(Workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            local act = prompt.ActionText:lower()
                            if string.find(act, "harvest") or string.find(act, "pick") then
                                prompt.RequiresLineOfSight = false
                                prompt.MaxActivationDistance = 999999
                                prompt.HoldDuration = 0

                                task.spawn(function()
                                    pcall(function()
                                        if fireproximityprompt then fireproximityprompt(prompt) end
                                    end)
                                end)
                            end
                        end
                    end
                end
            end)
        else
            movedToCenter = false
        end
        task.wait(0.05)
    end
end)

-- ==========================================
-- ⏱ TỰ ĐỘNG CẬP NHẬT RESTOCK MỖI 5 PHÚT
-- ==========================================

local function GetNextRestockTime()
    local now = os.date("*t")
    local currentMin = now.min
    local currentSec = now.sec
    
    local nextMin = math.ceil((currentMin + (currentSec > 0 and 1 or 0)) / 5) * 5
    if nextMin == currentMin and currentSec == 0 then
        nextMin = currentMin + 5
    end
    
    local diffMin = nextMin - currentMin - 1
    local diffSec = 60 - currentSec
    if diffSec == 60 then
        diffSec = 0
        diffMin = diffMin + 1
    end
    
    return diffMin, diffSec
end

task.spawn(function()
    task.wait(1)
    RenderSeedUI()

    local lastScanMin = -1

    while true do
        local m, s = GetNextRestockTime()
        TimerLabel.Text = string.format("⏱ Restock In: %02d:%02d", m, s)

        local currentMin = os.date("*t").min
        if m == 0 and s == 0 and lastScanMin ~= currentMin then
            lastScanMin = currentMin
            TimerLabel.Text = "🔄 Remote Refreshing Seed Stock..."
            task.wait(1)
            RenderSeedUI()
        end

        task.wait(1)
    end
end)
