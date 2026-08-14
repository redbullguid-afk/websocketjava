-- [[ GROW A GARDEN 2 - ULTIMATE FINAL VERSION ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Dọn dẹp UI cũ
if CoreGui:FindFirstChild("GAG_GoldMenu") then
    CoreGui.GAG_GoldMenu:Destroy()
end

-- ==========================================
-- 🎨 GIAO DIỆN MENU NẰM NGANG (GOLD & BLACK)
-- ==========================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "GAG_GoldMenu"
Gui.Parent = CoreGui

local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = Gui
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
OpenBtn.Text = "🌾"
OpenBtn.TextSize = 22
OpenBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
OpenBtn.Active = true
OpenBtn.Draggable = true

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(255, 215, 0)
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

local MainFrame = Instance.new("Frame")
MainFrame.Parent = Gui
MainFrame.Size = UDim2.new(0, 520, 0, 110) -- Mở rộng menu để chứa thêm nút Auto Sell
MainFrame.Position = UDim2.new(0.08, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 12)
FrameCorner.Parent = MainFrame

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Color3.fromRGB(255, 215, 0)
FrameStroke.Thickness = 2
FrameStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "★ GROW A GARDEN 2 - ULTIMATE HUB ★"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(0.94, -5, 0.05, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ==========================================
-- 🔘 TẠO TOGGLE SWITCH
-- ==========================================

local function CreateToggleSwitch(parent, labelText, posX, callback)
    local Container = Instance.new("Frame")
    Container.Parent = parent
    Container.Size = UDim2.new(0, 150, 0, 50)
    Container.Position = UDim2.new(0, posX, 0.38, 0)
    Container.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel")
    Label.Parent = Container
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 13

    local SwitchBg = Instance.new("Frame")
    SwitchBg.Parent = Container
    SwitchBg.Size = UDim2.new(0, 50, 0, 24)
    SwitchBg.Position = UDim2.new(0.5, -25, 0.5, 0)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBg

    local SwitchStroke = Instance.new("UIStroke")
    SwitchStroke.Color = Color3.fromRGB(80, 80, 80)
    SwitchStroke.Thickness = 1.5
    SwitchStroke.Parent = SwitchBg

    local Knob = Instance.new("Frame")
    Knob.Parent = SwitchBg
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 3, 0.5, -9)
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
        
        local targetPos = toggled and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        local targetBgColor = toggled and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(40, 40, 45)
        local targetStrokeColor = toggled and Color3.fromRGB(255, 235, 120) or Color3.fromRGB(80, 80, 80)
        local targetKnobColor = toggled and Color3.fromRGB(15, 15, 15) or Color3.fromRGB(180, 180, 180)

        local tInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(Knob, tInfo, {Position = targetPos, BackgroundColor3 = targetKnobColor}):Play()
        TweenService:Create(SwitchBg, tInfo, {BackgroundColor3 = targetBgColor}):Play()
        TweenService:Create(SwitchStroke, tInfo, {Color = targetStrokeColor}):Play()

        callback(toggled)
    end)
end

local isAutoPet = false
local isAutoHarvest = false
local isAutoSell = false
local isBusy = false -- Cờ chặn xung đột chung
local GardenCenterPos = nil

CreateToggleSwitch(MainFrame, "AUTO PET", 15, function(state) isAutoPet = state end)

CreateToggleSwitch(MainFrame, "AUTO HARVEST", 180, function(state)
    isAutoHarvest = state
    if state then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then GardenCenterPos = hrp.Position end
    end
end)

CreateToggleSwitch(MainFrame, "AUTO SELL FULL", 345, function(state) isAutoSell = state end)

-- ==========================================
-- 🐾 LOGIC 1: AUTO PET (BYPASS ANTI-TELEPORT)
-- ==========================================

local COOLDOWN_PET = 12

local function SafeTeleportAndPick(targetPart)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetPart then return end

    local oldCFrame = hrp.CFrame
    isBusy = true -- Khóa các tính năng khác

    -- Dịch chuyển an toàn (chia quãng đường nếu quá xa để tránh Anti-TP)
    local targetCFrame = targetPart.CFrame * CFrame.new(0, 2, 0)
    local distance = (hrp.Position - targetPart.Position).Magnitude
    
    if distance > 150 then
        -- Teleport trung gian 1 bước an toàn
        hrp.CFrame = hrp.CFrame:Lerp(targetCFrame, 0.5)
        task.wait(0.2)
    end
    
    hrp.CFrame = targetCFrame
    task.wait(0.6) -- Chờ 0.6s để Server đồng bộ vị trí thực (CHỐNG LỖI "THỬ LẠI SAU GIÂY LÁT")

    -- Nhặt Pet
    local prompt = targetPart:FindFirstChildWhichIsA("ProximityPrompt", true) or targetPart.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt then
        pcall(function()
            prompt.RequiresLineOfSight = false
            if fireproximityprompt then fireproximityprompt(prompt) end
        end)
    end
    
    if firetouchinterest then
        pcall(function()
            firetouchinterest(hrp, targetPart, 0)
            task.wait(0.1)
            firetouchinterest(hrp, targetPart, 1)
        end)
    end

    task.wait(0.5)
    -- Quay về vị trí Vườn
    if oldCFrame then hrp.CFrame = oldCFrame end
    task.wait(0.3)
    isBusy = false
end

task.spawn(function()
    while true do
        if isAutoPet and not isBusy then
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    local targetPet = nil
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj:IsA("Model") and string.find(obj.Name:lower(), "pet") and not string.find(obj.Name:lower(), "egg") then
                            if not Players:GetPlayerFromCharacter(obj) then
                                local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                                if prompt and prompt.Enabled then
                                    targetPet = obj
                                    break
                                end
                            end
                        end
                    end

                    if targetPet then
                        local targetPart = targetPet:IsA("BasePart") and targetPet or targetPet:FindFirstChildWhichIsA("BasePart", true)
                        if targetPart then
                            SafeTeleportAndPick(targetPart)
                            task.wait(COOLDOWN_PET)
                        end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)

-- ==========================================
-- 🌾 LOGIC 2: AUTO HARVEST (FIX CÂY CAO 300 STUDS)
-- ==========================================

local function IsPlayerObject(obj)
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and obj:IsDescendantOf(player.Character) then return true end
    end
    return false
end

local function IsHarvestPrompt(prompt)
    local actionText = prompt.ActionText:lower()
    local objectText = prompt.ObjectText:lower()
    return string.find(actionText, "harvest") or string.find(objectText, "harvest")
end

task.spawn(function()
    while true do
        if isAutoHarvest and GardenCenterPos and not isBusy then
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    for _, prompt in ipairs(Workspace:GetDescendants()) do
                        if isBusy then break end
                        
                        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                            local targetPart = prompt.Parent
                            
                            if targetPart and not IsPlayerObject(targetPart) and IsHarvestPrompt(prompt) then
                                local pos = targetPart:IsA("BasePart") and targetPart.Position or targetPart:GetPivot().Position
                                
                                -- TÍNH TOÁN TÁCH BIỆT CHIỀU CAO VÀ MẶT PHẲNG
                                local flatDistance = (Vector3.new(GardenCenterPos.X, 0, GardenCenterPos.Z) - Vector3.new(pos.X, 0, pos.Z)).Magnitude
                                local heightDistance = math.abs(pos.Y - GardenCenterPos.Y)

                                -- Bán kính Vườn dưới đất: 100 studs | Chiều cao cây: Cho phép lên tới 300 studs!
                                if flatDistance <= 100 and heightDistance <= 300 then
                                    pcall(function()
                                        prompt.RequiresLineOfSight = false
                                        prompt.MaxActivationDistance = 9999
                                        if fireproximityprompt then fireproximityprompt(prompt) end
                                    end)
                                end
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.2)
    end
end)

-- ==========================================
-- 💰 LOGIC 3: AUTO SELL KHI TÚI ĐẦY (FULL INVENTORY)
-- ==========================================

local function IsInventoryFull()
    -- Quét trong PlayerGui xem có thông báo Túi Đầy (Full Inventory / Backpack Full) hay không
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if gui:IsA("TextLabel") and gui.Visible then
                local txt = gui.Text:lower()
                if string.find(txt, "full") or string.find(txt, "inventory full") or string.find(txt, "backpack full") then
                    return true
                end
            end
        end
    end
    return false
end

task.spawn(function()
    while true do
        if isAutoSell and not isBusy then
            if IsInventoryFull() then
                isBusy = true -- Tạm dừng thu hoạch để đi bán
                
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if hrp then
                    local oldCFrame = hrp.CFrame
                    
                    -- Tìm khu vực Bán (Sell Area / Merchant / Sell Circle)
                    local sellZone = Workspace:FindFirstChild("Sell", true) or Workspace:FindFirstChild("Merchant", true) or Workspace:FindFirstChild("SellZone", true)
                    
                    if sellZone then
                        local sellPart = sellZone:IsA("BasePart") and sellZone or sellZone:FindFirstChildWhichIsA("BasePart", true)
                        if sellPart then
                            hrp.CFrame = sellPart.CFrame * CFrame.new(0, 2, 0)
                            task.wait(1.5) -- Đợi 1.5s để game tự động bán hết nông sản trong túi
                            
                            -- Mua bán xong quay về lại Vườn
                            if oldCFrame then hrp.CFrame = oldCFrame end
                        end
                    end
                end
                
                task.wait(0.5)
                isBusy = false
            end
        end
        task.wait(1.5)
    end
end)
