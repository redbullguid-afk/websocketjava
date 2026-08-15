-- [[ GROW A GARDEN 2 - SEED STOCK MONITOR (5-MIN RESTOCK) ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Cleanup UI cũ
if CoreGui:FindFirstChild("GAG_SeedMonitor") then
    CoreGui.GAG_SeedMonitor:Destroy()
end

-- ==========================================
-- 🎨 GIAO DIỆN BANG SEED MONITOR
-- ==========================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "GAG_SeedMonitor"
Gui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Parent = Gui
MainFrame.Size = UDim2.new(0, 420, 0, 500)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
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
Title.Size = UDim2.new(1, -40, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "🌱 SEED STOCK MONITOR (5M RESTOCK)"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local TimerLabel = Instance.new("TextLabel")
TimerLabel.Parent = MainFrame
TimerLabel.Size = UDim2.new(1, -20, 0, 25)
TimerLabel.Position = UDim2.new(0, 10, 0, 40)
TimerLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TimerLabel.Text = "⏱ Restock In: --:--"
TimerLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
TimerLabel.Font = Enum.Font.SourceSansBold
TimerLabel.TextSize = 14

local TimerCorner = Instance.new("UICorner")
TimerCorner.CornerRadius = UDim.new(0, 6)
TimerCorner.Parent = TimerLabel

local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Parent = MainFrame
ScrollContainer.Size = UDim2.new(1, -20, 1, -80)
ScrollContainer.Position = UDim2.new(0, 10, 0, 72)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollContainer.ScrollBarThickness = 6

local UIList = Instance.new("UIListLayout")
UIList.Parent = ScrollContainer
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 4)

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end)

-- ==========================================
-- ⚙️ LOGIC THỜI GIAN & RESTOCK (5 PHÚT)
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

-- ==========================================
-- 🔍 LOGIC QUÉT 30 HẠT GIỐNG
-- ==========================================

local function ScanSeedStock()
    -- Xóa các item cũ trong danh sách
    for _, child in ipairs(ScrollContainer:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local seedList = {}
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    
    -- 1. Quét dữ liệu từ UI Seed Shop trong PlayerGui hoặc Workspace
    local shopGui = playerGui and (playerGui:FindFirstChild("SeedShop", true) or playerGui:FindFirstChild("Shop", true) or playerGui:FindFirstChild("Seeds", true))
    
    if shopGui then
        for _, item in ipairs(shopGui:GetDescendants()) do
            if item:IsA("Frame") or item:IsA("ImageLabel") or item:IsA("TextButton") then
                local nameLabel = item:FindFirstChild("SeedName") or item:FindFirstChild("Title") or item:FindFirstChild("Name")
                local priceLabel = item:FindFirstChild("Price") or item:FindFirstChild("Cost")
                local stockLabel = item:FindFirstChild("Stock") or item:FindFirstChild("Amount") or item:FindFirstChild("InStock")

                if nameLabel and nameLabel:IsA("TextLabel") then
                    local sName = nameLabel.Text
                    local sPrice = priceLabel and priceLabel.Text or "N/A"
                    local sStock = "Out of Stock"
                    
                    if stockLabel then
                        if stockLabel:IsA("TextLabel") then
                            sStock = stockLabel.Text
                        elseif stockLabel:IsA("BoolValue") then
                            sStock = stockLabel.Value and "In Stock" or "Out of Stock"
                        end
                    else
                        -- Thuật toán đoán stock qua thuộc tính Visible hoặc Text
                        local textAll = (item:IsA("TextLabel") or item:IsA("TextButton")) and item.Text or ""
                        if string.find(textAll:lower(), "buy") or string.find(textAll:lower(), "in stock") then
                            sStock = "In Stock"
                        end
                    end

                    table.insert(seedList, {
                        Name = sName,
                        Price = sPrice,
                        Stock = sStock
                    })
                end
            end
        end
    end

    -- 2. Dự phòng nếu UI chưa load đủ: Quét dữ liệu từ ReplicatedStorage/Workspace
    if #seedList < 5 then
        local seedFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Seeds", true) or Workspace:FindFirstChild("SeedShop", true)
        if seedFolder then
            for _, seedObj in ipairs(seedFolder:GetChildren()) do
                local name = seedObj.Name
                local price = seedObj:FindFirstChild("Price") and tostring(seedObj.Price.Value) or "N/A"
                local stock = seedObj:FindFirstChild("Stock") and tostring(seedObj.Stock.Value) or "In Stock"
                
                table.insert(seedList, {
                    Name = name,
                    Price = price,
                    Stock = stock
                })
            end
        end
    end

    -- Render kết quả lên UI
    for i, data in ipairs(seedList) do
        if i > 30 then break end -- Giới hạn tối đa 30 hạt giống

        local ItemFrame = Instance.new("Frame")
        ItemFrame.Parent = ScrollContainer
        ItemFrame.Size = UDim2.new(1, 0, 0, 32)
        ItemFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 34)

        local ItemCorner = Instance.new("UICorner")
        ItemCorner.CornerRadius = UDim.new(0, 6)
        ItemCorner.Parent = ItemFrame

        local NameTxt = Instance.new("TextLabel")
        NameTxt.Parent = ItemFrame
        NameTxt.Size = UDim2.new(0.45, 0, 1, 0)
        NameTxt.Position = UDim2.new(0, 8, 0, 0)
        NameTxt.BackgroundTransparency = 1
        NameTxt.Text = i .. ". " .. data.Name
        NameTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameTxt.Font = Enum.Font.SourceSansBold
        NameTxt.TextSize = 13
        NameTxt.TextXAlignment = Enum.TextXAlignment.Left

        local PriceTxt = Instance.new("TextLabel")
        PriceTxt.Parent = ItemFrame
        PriceTxt.Size = UDim2.new(0.25, 0, 1, 0)
        PriceTxt.Position = UDim2.new(0.45, 0, 0, 0)
        PriceTxt.BackgroundTransparency = 1
        PriceTxt.Text = "💵 " .. data.Price
        PriceTxt.TextColor3 = Color3.fromRGB(255, 215, 0)
        PriceTxt.Font = Enum.Font.SourceSans
        PriceTxt.TextSize = 12

        local StockTxt = Instance.new("TextLabel")
        StockTxt.Parent = ItemFrame
        StockTxt.Size = UDim2.new(0.28, -5, 1, 0)
        StockTxt.Position = UDim2.new(0.7, 0, 0, 0)
        StockTxt.BackgroundTransparency = 1
        
        local isInStock = string.find(data.Stock:lower(), "in stock") or string.find(data.Stock:lower(), "còn") or (tonumber(data.Stock) and tonumber(data.Stock) > 0)
        StockTxt.Text = isInStock and "✔ IN STOCK" or "✖ OUT"
        StockTxt.TextColor3 = isInStock and Color3.fromRGB(80, 255, 100) or Color3.fromRGB(255, 70, 70)
        StockTxt.Font = Enum.Font.SourceSansBold
        StockTxt.TextSize = 12
    end
end

-- ==========================================
-- 🔄 VÒNG LẶP CẬP NHẬT ĐỒNG HỒ & SCAN
-- ==========================================

task.spawn(function()
    ScanSeedStock() -- Quét lần đầu ngay khi bật script
    
    local lastScanMin = -1
    
    while true do
        local m, s = GetNextRestockTime()
        TimerLabel.Text = string.format("⏱ Restock In: %02d:%02d", m, s)
        
        -- Khi đồng hồ về 00:00 (mốc restock 5 phút), tự động quét lại dữ liệu mới
        local currentMin = os.date("*t").min
        if m == 0 and s == 0 and lastScanMin ~= currentMin then
            lastScanMin = currentMin
            TimerLabel.Text = "🔄 Restocking... Scanning Seeds!"
            task.wait(1)
            ScanSeedStock()
        end
        
        task.wait(1)
    end
end)
