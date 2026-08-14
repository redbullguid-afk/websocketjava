-- [[ GROW A GARDEN - DIRECT SERVER HOOK CHECKER ]] --

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
if CoreGui:FindFirstChild("GardenCheckerDirect") then
    CoreGui.GardenCheckerDirect:Destroy()
end

-- MAIN GUI
local GardenGui = Instance.new("ScreenGui")
GardenGui.Name = "GardenCheckerDirect"
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
MainFrame.Size = UDim2.new(0, 420, 0, 390)
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

-- TAB BAR & REFRESH BUTTON
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

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Parent = TabBar
RefreshBtn.Position = UDim2.new(1, -110, 0, 0)
RefreshBtn.Size = UDim2.new(0, 110, 1, 0)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 90)
RefreshBtn.Text = "🔄 Refresh"
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.Font = Enum.Font.SourceSansBold
RefreshBtn.TextSize = 14

local RefCorner = Instance.new("UICorner")
RefCorner.CornerRadius = UDim.new(0, 5)
RefCorner.Parent = RefreshBtn

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

-- TRUY VẤN DỮ LIỆU CHÍNH XÁC (FETCH SHOP DATA)
local function FetchActiveShop()
    local StockMap = {}

    -- Phương pháp 1: Gọi RemoteFunction nếu game dùng Server Query
    for _, rf in ipairs(ReplicatedStorage:GetDescendants()) do
        if rf:IsA("RemoteFunction") and (string.find(rf.Name:lower(), "shop") or string.find(rf.Name:lower(), "get") or string.find(rf.Name:lower(), "merchant")) then
            pcall(function()
                local res = rf:InvokeServer("GetShop") or rf:InvokeServer()
                if type(res) == "table" then
                    for k, v in pairs(res) do
                        local nameStr = (type(v) == "table" and (v.Name or v.Item)) or tostring(k)
                        local priceStr = (type(v) == "table" and (v.Price or v.Cost)) or "In Stock"
                        for _, seed in ipairs(SeedList) do
                            local sLower = seed:lower()
                            if string.find(nameStr:lower(), sLower) then
                                StockMap[sLower] = type(priceStr) == "number" and ("$" .. priceStr) or priceStr
                            end
                        end
                    end
                end
            end)
        end
    end

    -- Phương pháp 2: Quét trực tiếp các Text Elements trên PlayerGui khi mở NPC
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if PlayerGui then
        for _, textObj in ipairs(PlayerGui:GetDescendants()) do
            if textObj:IsA("TextLabel") or textObj:IsA("TextButton") then
                local str = textObj.Text:lower()
                for _, seed in ipairs(SeedList) do
                    local sLower = seed:lower()
                    if string.find(str, sLower) then
                        -- Lấy giá tiền gần kề
                        local priceMatch = string.match(textObj.Text, "%$%d+") or string.match(textObj.Text, "%d+")
                        if priceMatch then
                            StockMap[sLower] = "$" .. priceMatch
                        else
                            StockMap[sLower] = "In Stock"
                        end
                    end
                end
            end
        end
    end

    return StockMap
end

-- UPDATE UI FUNCTION
local function RefreshUI()
    RefreshBtn.Text = "⏳ Checking..."
    local Stock = FetchActiveShop()

    for _, seed in ipairs(SeedList) do
        local key = seed:lower()
        local label = SeedRows[key]

        if Stock[key] then
            label.Text = "💲 " .. tostring(Stock[key])
            label.TextColor3 = Color3.fromRGB(85, 255, 127)
        else
            label.Text = "❌ Out of Stock"
            label.TextColor3 = Color3.fromRGB(255, 60, 60)
        end
    end
    RefreshBtn.Text = "🔄 Refresh"
end

-- BUTTON CLICK EVENT
RefreshBtn.MouseButton1Click:Connect(RefreshUI)

-- AUTO RUN & TIMED CHECK (EVERY 5 MINS)
task.spawn(function()
    RefreshUI()
    while task.wait(1) do
        local now = os.date("*t")
        if now.min % 5 == 0 and now.sec == 0 then
            RefreshUI()
            task.wait(1)
        end
    end
end)
