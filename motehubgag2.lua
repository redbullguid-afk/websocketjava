-- [[ GROW A GARDEN - RAW SEED STOCK CHECKER ]] --

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- English Seed List (30 Items)
local SeedList = {
    "Carrot", "Strawberry", "Blueberry", "Tulip", "Tomato",
    "Apple", "Bamboo", "Corn", "Cactus", "Pineapple",
    "Mushroom", "Green Bean", "Banana", "Grape", "Mango",
    "Coconut", "Dragonfruit", "Acorn", "Cherry", "Sunflower",
    "Fire Moss", "Venus Flytrap", "Pomegranate", "Poison Apple", "Spitspore",
    "Moonflower", "Sunbulb", "Hypno Flower", "Dragon Breath", "Starfruit"
}

-- Clear old UI
if CoreGui:FindFirstChild("GardenCheckerFinal") then
    CoreGui.GardenCheckerFinal:Destroy()
end

-- MAIN GUI
local GardenGui = Instance.new("ScreenGui")
GardenGui.Name = "GardenCheckerFinal"
GardenGui.Parent = CoreGui
GardenGui.ResetOnSpawn = false

-- TOGGLE BUTTON (HORIZONTAL)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Parent = GardenGui
ToggleBtn.Size = UDim2.new(0, 130, 0, 35)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ToggleBtn.Text = "MENU: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = GardenGui
MainFrame.Size = UDim2.new(0, 420, 0, 380)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Title.Text = "🌱 SEED SHOP CHECKER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- TAB BAR (TAB 1: INFO)
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.Position = UDim2.new(0, 10, 0, 45)
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.BackgroundTransparency = 1

local Tab1Btn = Instance.new("TextButton")
Tab1Btn.Parent = TabBar
Tab1Btn.Size = UDim2.new(0, 100, 1, 0)
Tab1Btn.BackgroundColor3 = Color3.fromRGB(45, 120, 210)
Tab1Btn.Text = "Tab 1: Info"
Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1Btn.Font = Enum.Font.SourceSansBold
Tab1Btn.TextSize = 14

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 5)
TabCorner.Parent = Tab1Btn

-- SCROLLING FRAME
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.Position = UDim2.new(0, 10, 0, 85)
ScrollFrame.Size = UDim2.new(1, -20, 1, -95)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 30 * #SeedList)
ScrollFrame.ScrollBarThickness = 6

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

-- TOGGLE LOGIC
local menuOpen = false
ToggleBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MainFrame.Visible = menuOpen
    if menuOpen then
        ToggleBtn.Text = "MENU: ON"
        ToggleBtn.TextColor3 = Color3.fromRGB(85, 255, 127)
    else
        ToggleBtn.Text = "MENU: OFF"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
    end
end)

-- GENERATE ROWS
local SeedRows = {}

for i, seedName in ipairs(SeedList) do
    local Row = Instance.new("Frame")
    Row.Parent = ScrollFrame
    Row.Size = UDim2.new(1, -10, 0, 26)
    Row.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    
    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 4)
    RowCorner.Parent = Row

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Parent = Row
    NameLabel.Position = UDim2.new(0, 8, 0, 0)
    NameLabel.Size = UDim2.new(0.6, 0, 1, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = i .. ". " .. seedName
    NameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Font = Enum.Font.SourceSans
    NameLabel.TextSize = 14

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Parent = Row
    StatusLabel.Position = UDim2.new(0.6, 0, 0, 0)
    StatusLabel.Size = UDim2.new(0.4, -8, 1, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "❌ Out of Stock"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
    StatusLabel.Font = Enum.Font.SourceSansBold
    StatusLabel.TextSize = 14

    SeedRows[seedName:lower()] = StatusLabel
end

-- THU THẬP DỮ LIỆU BÁN HÀNG BẰNG CÁC PHƯƠNG PHÁP RAW
local CacheStock = {}

local function ScanRawGameData()
    local FoundItems = {}

    -- 1. Quét sâu toàn bộ ReplicatedStorage cho các Value/String chứa thông tin Hạt
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        local oName = obj.Name:lower()
        for _, seed in ipairs(SeedList) do
            local sLower = seed:lower()
            if string.find(oName, sLower) then
                -- Kiểm tra nếu obj là StringValue / NumberValue hay Table
                local price = "On Sale"
                if obj:IsA("ValueBase") then
                    price = "$" .. tostring(obj.Value)
                elseif obj:FindFirstChild("Price") then
                    price = "$" .. tostring(obj.Price.Value)
                end
                FoundItems[sLower] = price
            end
        end
    end

    -- 2. Quét trực tiếp các Text UI đang Active
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if PlayerGui then
        for _, gui in ipairs(PlayerGui:GetDescendants()) do
            if gui:IsA("TextLabel") and gui.Visible and gui.Text ~= "" then
                local txt = gui.Text:lower()
                for _, seed in ipairs(SeedList) do
                    local sLower = seed:lower()
                    if string.find(txt, sLower) then
                        local priceMatch = string.match(gui.Text, "%$%d+") or string.match(gui.Text, "%d+")
                        FoundItems[sLower] = priceMatch and ("$" .. priceMatch) or "On Sale"
                    end
                end
            end
        end
    end

    return FoundItems
end

-- UPDATE FUNCTION
local function RefreshStatus()
    local CurrentStock = ScanRawGameData()

    for _, seed in ipairs(SeedList) do
        local key = seed:lower()
        local label = SeedRows[key]

        if CurrentStock[key] or CacheStock[key] then
            local priceVal = CurrentStock[key] or CacheStock[key]
            label.Text = "💲 " .. tostring(priceVal)
            label.TextColor3 = Color3.fromRGB(85, 255, 127) -- Xanh lá
        else
            label.Text = "❌ Out of Stock"
            label.TextColor3 = Color3.fromRGB(255, 60, 60) -- Đỏ
        end
    end
end

-- TỰ ĐỘNG CHẮN BẮT GÓI TIN DỮ LIỆU SHOP SERVER (REMOTE LISTENER)
for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
    if remote:IsA("RemoteEvent") then
        remote.OnClientEvent:Connect(function(...)
            local args = {...}
            for _, arg in ipairs(args) do
                if type(arg) == "table" then
                    for k, v in pairs(arg) do
                        local nameStr = tostring(k):lower() .. " " .. tostring(v):lower()
                        for _, seed in ipairs(SeedList) do
                            local sLower = seed:lower()
                            if string.find(nameStr, sLower) then
                                CacheStock[sLower] = "In Stock"
                            end
                        end
                    end
                end
            end
            RefreshStatus()
        end)
    end
end

-- AUTO RUN & AUTO CHECK EVERY 5 MINS (00, 05, 10, 15...)
task.spawn(function()
    RefreshStatus()
    
    while task.wait(1) do
        local now = os.date("*t")
        if now.min % 5 == 0 and now.sec == 0 then
            RefreshStatus()
            task.wait(1)
        end
    end
end)
