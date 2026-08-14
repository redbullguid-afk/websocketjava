-- [[ GROW A GARDEN - MULTI-ENGINE AUTO SEED CHECKER ]] --

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Fallback Seed List (30 Items)
local DefaultSeeds = {
    "Carrot", "Strawberry", "Blueberry", "Tulip", "Tomato",
    "Apple", "Bamboo", "Corn", "Cactus", "Pineapple",
    "Mushroom", "Green Bean", "Banana", "Grape", "Mango",
    "Coconut", "Dragonfruit", "Acorn", "Cherry", "Sunflower",
    "Fire Moss", "Venus Flytrap", "Pomegranate", "Poison Apple", "Spitspore",
    "Moonflower", "Sunbulb", "Hypno Flower", "Dragon Breath", "Starfruit"
}

-- Clear old UI
if CoreGui:FindFirstChild("GardenCheckerMultiEngine") then
    CoreGui.GardenCheckerMultiEngine:Destroy()
end

-- MAIN GUI
local GardenGui = Instance.new("ScreenGui")
GardenGui.Name = "GardenCheckerMultiEngine"
GardenGui.Parent = CoreGui
GardenGui.ResetOnSpawn = false

-- TOGGLE BUTTON
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
MainFrame.Size = UDim2.new(0, 430, 0, 400)
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
Title.Text = "🌱 AUTO SEED CHECKER (MULTI-ENGINE)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- TAB BAR & STATUS
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

local StatusLabelTop = Instance.new("TextLabel")
StatusLabelTop.Parent = TabBar
StatusLabelTop.Position = UDim2.new(1, -180, 0, 0)
StatusLabelTop.Size = UDim2.new(0, 180, 1, 0)
StatusLabelTop.BackgroundTransparency = 1
StatusLabelTop.Text = "Mode: Auto-Syncing..."
StatusLabelTop.TextColor3 = Color3.fromRGB(85, 255, 127)
StatusLabelTop.Font = Enum.Font.SourceSansBold
StatusLabelTop.TextSize = 13

-- SCROLLING FRAME
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.Position = UDim2.new(0, 10, 0, 85)
ScrollFrame.Size = UDim2.new(1, -20, 1, -95)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 30 * 28)
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

-- CREATING 30 UI ROWS
local UI_Rows = {}

for i = 1, 30 do
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
    NameLabel.Text = i .. ". Loading..."
    NameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
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

    UI_Rows[i] = {Name = NameLabel, Status = StatusLabel}
end

-- BỘ LỌC ĐA NGUỒN DỮ LIỆU (MULTI-ENGINE ENGINE)
local function ScanShopData()
    local Extracted = {}

    -- 1. THỬ ĐỌC TỪ MODULESCRIPT TRONG REPLICATEDSTORAGE
    pcall(function()
        for _, mod in ipairs(ReplicatedStorage:GetDescendants()) do
            if mod:IsA("ModuleScript") and (string.find(mod.Name:lower(), "seed") or string.find(mod.Name:lower(), "shop") or string.find(mod.Name:lower(), "item")) then
                local data = require(mod)
                if type(data) == "table" then
                    for k, v in pairs(data) do
                        if type(v) == "table" then
                            local sName = v.Name or v.Item or v.SeedName or tostring(k)
                            local sPrice = v.Price or v.Cost or "On Sale"
                            local sStock = v.InStock or v.Stock
                            
                            table.insert(Extracted, {
                                Name = tostring(sName),
                                Price = type(sPrice) == "number" and ("$" .. sPrice) or tostring(sPrice),
                                InStock = (sStock == true or (type(sStock) == "number" and sStock > 0) or sStock == nil)
                            })
                        end
                    end
                end
            end
            if #Extracted >= 5 then break end
        end
    end)

    -- 2. NẾU MODULE KHÔNG CÓ, QUÉT TẤT CẢ TEXT TRONG PLAYERGUI
    if #Extracted == 0 then
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if PlayerGui then
            local StockMap = {}
            for _, txt in ipairs(PlayerGui:GetDescendants()) do
                if (txt:IsA("TextLabel") or txt:IsA("TextButton")) and txt.Visible then
                    local t = txt.Text:lower()
                    for _, seed in ipairs(DefaultSeeds) do
                        local sLower = seed:lower()
                        if string.find(t, sLower) then
                            local pMatch = string.match(txt.Text, "%$%d+") or string.match(txt.Text, "%d+%$")
                            StockMap[sLower] = pMatch or "On Sale"
                        end
                    end
                end
            end

            for _, seed in ipairs(DefaultSeeds) do
                local sLower = seed:lower()
                table.insert(Extracted, {
                    Name = seed,
                    Price = StockMap[sLower] or "On Sale",
                    InStock = StockMap[sLower] ~= nil
                })
            end
        end
    end

    -- 3. NẾU VẪN CHƯA CÓ, DÙNG DANH SÁCH DỰ PHÒNG CHUẨN (FALLBACK)
    if #Extracted == 0 then
        for _, seed in ipairs(DefaultSeeds) do
            table.insert(Extracted, {
                Name = seed,
                Price = "On Sale",
                InStock = false
            })
        end
    end

    return Extracted
end

-- UPDATE UI FUNCTION
local function RefreshUI()
    StatusLabelTop.Text = "Mode: Updating..."
    local Data = ScanShopData()

    for i = 1, 30 do
        local row = UI_Rows[i]
        local item = Data[i]

        if item then
            row.Name.Text = i .. ". " .. item.Name
            row.Name.TextColor3 = Color3.fromRGB(240, 240, 240)

            if item.InStock then
                row.Status.Text = "💲 " .. tostring(item.Price)
                row.Status.TextColor3 = Color3.fromRGB(85, 255, 127)
            else
                row.Status.Text = "❌ Out of Stock"
                row.Status.TextColor3 = Color3.fromRGB(255, 60, 60)
            end
        else
            row.Name.Text = i .. ". Slot " .. i
            row.Name.TextColor3 = Color3.fromRGB(100, 100, 100)
            row.Status.Text = "❌ Off Stock"
            row.Status.TextColor3 = Color3.fromRGB(180, 50, 50)
        end
    end
    StatusLabelTop.Text = "Mode: Active"
end

-- TỰ ĐỘNG CHẠY NGẦM LIÊN TỤC VÀ KHÔNG BAO GIỜ TREO UI
task.spawn(function()
    while true do
        RefreshUI()
        task.wait(5) -- Cập nhật tự động mỗi 5 giây ngầm
    end
end)
