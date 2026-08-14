-- [[ GROW A GARDEN - DYNAMIC AUTO SHOP DUMP ]] --

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Clear old UI
if CoreGui:FindFirstChild("GardenCheckerDynamic") then
    CoreGui.GardenCheckerDynamic:Destroy()
end

-- MAIN GUI
local GardenGui = Instance.new("ScreenGui")
GardenGui.Name = "GardenCheckerDynamic"
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
MainFrame.Size = UDim2.new(0, 420, 0, 400)
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
Title.Text = "🌱 AUTO SEED SHOP DUMP"
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
RefreshBtn.Text = "🔄 Scan Shop"
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
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 30 * 30) -- Giới hạn 30 hàng
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

-- TẠO SẴN 30 CẶP LABEL RỖNG
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
    NameLabel.Text = i .. ". Empty Slot"
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

-- HÀM TỰ ĐỘNG BẮT DỮ LIỆU TỪ SHOP THỰC TẾ
local function AutoScanShopData()
    local ExtractedData = {}
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not PlayerGui then return ExtractedData end

    -- Bỏ qua các UI cá nhân không phải Shop
    local ExcludeList = {"inventory", "backpack", "codex", "journal", "index", "craft", "setting"}

    for _, gui in ipairs(PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled then
            local gName = gui.Name:lower()
            local isExcluded = false
            for _, ex in ipairs(ExcludeList) do
                if string.find(gName, ex) then isExcluded = true break end
            end

            if not isExcluded then
                -- Tìm các khung chứa hạt giống
                for _, frame in ipairs(gui:GetDescendants()) do
                    if frame:IsA("Frame") or frame:IsA("ImageLabel") or frame:IsA("TextButton") then
                        local foundName = nil
                        local foundPrice = nil
                        local isAvailable = false

                        -- Duyệt thuộc tính con bên trong khung
                        for _, child in ipairs(frame:GetDescendants()) do
                            if child:IsA("TextLabel") or child:IsA("TextButton") then
                                local txt = child.Text
                                local lowerTxt = txt:lower()

                                -- Lấy tên (Chuỗi chữ không chứa số hay ký tự đặc biệt)
                                if not string.find(txt, "%$") and not string.match(txt, "^%d+$") and #txt > 2 then
                                    if not string.find(lowerTxt, "buy") and not string.find(lowerTxt, "stock") and not string.find(lowerTxt, "sold") then
                                        foundName = txt
                                    end
                                end

                                -- Lấy giá ($)
                                local pMatch = string.match(txt, "%$%d+") or string.match(txt, "%d+%$")
                                if pMatch then
                                    foundPrice = pMatch
                                end

                                -- Kiểm tra trạng thái Mua (In Stock)
                                if (string.find(lowerTxt, "buy") or pMatch) and child.Visible and child.TextTransparency < 0.5 then
                                    isAvailable = true
                                end
                            end
                        end

                        -- Nếu quét được thông tin có Tên hạt giống
                        if foundName then
                            table.insert(ExtractedData, {
                                Name = foundName,
                                Price = foundPrice or "Free",
                                InStock = isAvailable
                            })
                        end
                    end
                end
            end
        end
    end

    return ExtractedData
end

-- UPDATE UI FUNCTION
local function RefreshUI()
    RefreshBtn.Text = "⏳ Scanning..."
    local Data = AutoScanShopData()

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
            row.Name.Text = i .. ". ----"
            row.Name.TextColor3 = Color3.fromRGB(100, 100, 100)
            row.Status.Text = "❌ Off Stock"
            row.Status.TextColor3 = Color3.fromRGB(180, 50, 50)
        end
    end

    RefreshBtn.Text = "🔄 Scan Shop"
end

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
