-- [[ GROW A GARDEN - SEED CHECKER SCRIPT (DELTA EXECUTOR) ]] --

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Danh sách 30 hạt giống (Tên hiển thị Tiếng Việt => Tên trong Game Tiếng Anh)
local SeedList = {
    {vn = "1. Cà rốt", en = "Carrot"},
    {vn = "2. Dâu tây", en = "Strawberry"},
    {vn = "3. Việt quất", en = "Blueberry"},
    {vn = "4. Hoa tulip", en = "Tulip"},
    {vn = "5. Cà chua", en = "Tomato"},
    {vn = "6. Táo", en = "Apple"},
    {vn = "7. Tre", en = "Bamboo"},
    {vn = "8. Ngô", en = "Corn"},
    {vn = "9. Xương rồng", en = "Cactus"},
    {vn = "10. Dứa", en = "Pineapple"},
    {vn = "11. Nấm", en = "Mushroom"},
    {vn = "12. Đậu xanh", en = "Green Bean"},
    {vn = "13. Chuối", en = "Banana"},
    {vn = "14. Nho", en = "Grape"},
    {vn = "15. Xoài", en = "Mango"},
    {vn = "16. Dừa", en = "Coconut"},
    {vn = "17. Quả rồng", en = "Dragonfruit"},
    {vn = "18. Quả sồi", en = "Acorn"},
    {vn = "19. Anh đào", en = "Cherry"},
    {vn = "20. Hoa hướng dương", en = "Sunflower"},
    {vn = "21. Rêu lửa", en = "Fire Moss"},
    {vn = "22. Bẫy ruồi sao kim", en = "Venus Flytrap"},
    {vn = "23. Lựu", en = "Pomegranate"},
    {vn = "24. Quả táo độc", en = "Poison Apple"},
    {vn = "25. Phun nòng độc", en = "Spitspore"},
    {vn = "26. Hoa trăng", en = "Moonflower"},
    {vn = "27. Hoa nắng", en = "Sunflower"},
    {vn = "28. Hoa nở thôi miên", en = "Hypno Flower"},
    {vn = "29. Hơi thở của rồng", en = "Dragon Breath"},
    {vn = "30. Trái cây sao", en = "Starfruit"}
}

-- Xóa ScreenGui cũ nếu có
if CoreGui:FindFirstChild("GardenCheckerGui") then
    CoreGui.GardenCheckerGui:Destroy()
end

-- TẠO UI CHÍNH
local GardenGui = Instance.new("ScreenGui")
GardenGui.Name = "GardenCheckerGui"
GardenGui.Parent = CoreGui
GardenGui.ResetOnSpawn = false

-- NÚT NẰM NGANG BẬT/TẮT MENU (TOGGLE BUTTON)
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
ToggleBtn.Draggable = true -- Cho phép kéo thả nút

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- KHUNG MENU CHÍNH
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

-- TIÊU ĐỀ MENU
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

-- TẠO TAB (TAB 1: INFO)
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

-- KHU VỰC DANH SÁCH (SCROLLING FRAME)
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

-- HÀM BẬT/TẮT MENU
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

-- TẠO DÒNG CHO TỪNG HẠT GIỐNG
local SeedRows = {}

for i, seed in ipairs(SeedList) do
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
    NameLabel.Text = seed.vn .. " (" .. seed.en .. ")"
    NameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Font = Enum.Font.SourceSans
    NameLabel.TextSize = 14

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Parent = Row
    StatusLabel.Position = UDim2.new(0.6, 0, 0, 0)
    StatusLabel.Size = UDim2.new(0.4, -8, 1, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "[ ❌ Out of Stock ]"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
    StatusLabel.Font = Enum.Font.SourceSansBold
    StatusLabel.TextSize = 14

    SeedRows[seed.en] = StatusLabel
end

-- HÀM CHECK CỬA HÀNG TRONG GAME
local function CheckShopData()
    -- Lấy Folder dữ liệu Cửa hàng (Được cấu hình tương thích với hầu hết Game Grow a Garden)
    local ShopFolder = ReplicatedStorage:FindFirstChild("Shop") or ReplicatedStorage:FindFirstChild("SeedShop") or workspace:FindFirstChild("Shop")
    
    for _, seed in ipairs(SeedList) do
        local label = SeedRows[seed.en]
        local isAvailable = false
        local price = 0

        if ShopFolder then
            local seedItem = ShopFolder:FindFirstChild(seed.en)
            if seedItem then
                -- Kiểm tra trạng thái On Stock & Giá
                local inStockVal = seedItem:FindFirstChild("InStock") or seedItem:FindFirstChild("Stock")
                local priceVal = seedItem:FindFirstChild("Price") or seedItem:FindFirstChild("Cost")

                if priceVal then price = priceVal.Value end
                if inStockVal then
                    if typeof(inStockVal.Value) == "boolean" then
                        isAvailable = inStockVal.Value
                    elseif typeof(inStockVal.Value) == "number" then
                        isAvailable = inStockVal.Value > 0
                    end
                else
                    isAvailable = true -- Nếu tìm thấy item trong Shop
                end
            end
        end

        -- Cập nhật giao diện UI
        if isAvailable then
            label.Text = "💲 $" .. tostring(price)
            label.TextColor3 = Color3.fromRGB(85, 255, 127) -- Xanh lá cây
        else
            label.Text = "❌ Out of Stock"
            label.TextColor3 = Color3.fromRGB(255, 60, 60) -- Đỏ
        end
    end
end

-- QUẢN LÝ THỜI GIAN RESET (CỨ 5 PHÚT MỘT LẦN: 00, 05, 10, 15...)
task.spawn(function()
    CheckShopData() -- Check ngay khi bật script
    
    while task.wait(1) do
        local now = os.date("*t")
        local minute = now.min
        local second = now.sec
        
        -- Kiểm tra nếu phút chia hết cho 5 và giây bắt đầu bằng 0 (Đúng mốc thời gian reset)
        if minute % 5 == 0 and second == 0 then
            CheckShopData()
            task.wait(1) -- Tránh bị lặp nhiều lần trong cùng 1 giây
        end
    end
end)
