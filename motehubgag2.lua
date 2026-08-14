-- [[ GROW A GARDEN - 100% AUTOMATIC SERVER REMOTE CHECKER ]] --

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Clear old UI
if CoreGui:FindFirstChild("GardenCheckerAutoRemote") then
    CoreGui.GardenCheckerAutoRemote:Destroy()
end

-- MAIN GUI
local GardenGui = Instance.new("ScreenGui")
GardenGui.Name = "GardenCheckerAutoRemote"
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
Title.Text = "⚡ 100% AUTO SEED CHECKER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

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
StatusLabelTop.Text = "Status: Auto-Fetching..."
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
    NameLabel.Text = i .. ". Fetching..."
    NameLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
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

-- TỰ ĐỘNG BẮT VÀ ĐỌC DATA TRỰC TIẾP TỪ SERVER REMOTE
local function AutoFetchFromServer()
    local ServerData = {}

    -- Tìm tất cả RemoteFunction trong ReplicatedStorage
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            if string.find(name, "shop") or string.find(name, "merchant") or string.find(name, "seed") or string.find(name, "get") or string.find(name, "data") then
                pcall(function()
                    local result = obj:InvokeServer("GetShopData") or obj:InvokeServer("Shop") or obj:InvokeServer()
                    if type(result) == "table" then
                        for k, v in pairs(result) do
                            if type(v) == "table" then
                                local itemName = v.Name or v.Item or v.SeedName or tostring(k)
                                local itemPrice = v.Price or v.Cost or "On Sale"
                                local stockStatus = (v.Stock and v.Stock > 0) or (v.InStock == true) or (v.Available == true) or true

                                table.insert(ServerData, {
                                    Name = tostring(itemName),
                                    Price = type(itemPrice) == "number" and ("$" .. itemPrice) or tostring(itemPrice),
                                    InStock = stockStatus
                                })
                            end
                        end
                    end
                end)
            end
        end
    end

    return ServerData
end

-- UPDATE UI FUNCTION
local function RefreshUI()
    StatusLabelTop.Text = "Status: Syncing..."
    local Data = AutoFetchFromServer()

    for i = 1, 30 do
        local row = UI_Rows[i]
        local item = Data[i]

        if item then
            row.Name.Text = i .. ". " .. item.Name
            row.Name.TextColor3 = Color3.fromRGB(240, 240, 240)

            if item.InStock then
                row.Status.Text = "💲 " .. item.Price
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
    StatusLabelTop.Text = "Status: Connected"
end

-- TỰ ĐỘNG CHẠY NGẦM LIÊN TỤC (TỰ CẬP NHẬT MỖI 5 PHÚT HOẶC MỖI LẦN RESET SHOP)
task.spawn(function()
    while true do
        RefreshUI()
        task.wait(10) -- Tự động cập nhật ngầm định kỳ
    end
end)
