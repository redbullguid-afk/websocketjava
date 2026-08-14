-- [[ GROW A GARDEN - FIXED GARDEN CENTER AUTO HARVEST ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Clean dọn dẹp UI cũ
if CoreGui:FindFirstChild("GAG_GoldMenu") then
    CoreGui.GAG_GoldMenu:Destroy()
end

-- ==========================================
-- 🎨 TẠO GIAO DIỆN NẰM NGANG (GOLD & BLACK)
-- ==========================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "GAG_GoldMenu"
Gui.Parent = CoreGui

-- Nút tròn thu nhỏ / mở menu
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

-- Khung Menu Chính
local MainFrame = Instance.new("Frame")
MainFrame.Parent = Gui
MainFrame.Size = UDim2.new(0, 360, 0, 110)
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

-- Tiêu đề Menu
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "★ GROW A GARDEN HUB ★"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16

-- Nút đóng Menu (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(0.92, -5, 0.05, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ==========================================
-- 🔘 HÀM TẠO NÚT GẠT BẬT/TẮT (TOGGLE SWITCH)
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
    Label.TextSize = 14

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
local GardenCenterPos = nil -- Tọa độ gốc Vườn nhà bạn

CreateToggleSwitch(MainFrame, "AUTO PET (10s)", 20, function(state)
    isAutoPet = state
end)

CreateToggleSwitch(MainFrame, "AUTO HARVEST", 190, function(state)
    isAutoHarvest = state
    
    -- Khi vừa BẬT Auto Harvest -> Tự động lưu vị trí đứng hiện tại làm Tâm Vườn!
    if state then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            GardenCenterPos = hrp.Position
        end
    end
end)

-- ==========================================
-- 🐾 LOGIC 1: AUTO BUY PET (10S COOLDOWN)
-- ==========================================

local COOLDOWN_PET = 10

local function ForceTouchPet(petPart)
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    
    if root and petPart then
        if firetouchinterest then
            pcall(function()
                firetouchinterest(root, petPart, 0)
                task.wait(0.05)
                firetouchinterest(root, petPart, 1)
            end)
        end
        
        local prompt = petPart:FindFirstChildWhichIsA("ProximityPrompt", true) or petPart.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
        if prompt then
            pcall(function()
                prompt.RequiresLineOfSight = false
                fireproximityprompt(prompt)
            end)
        end
    end
end

task.spawn(function()
    while true do
        if isAutoPet then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hrp then
                local targetPet = nil
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("Model") and string.find(obj.Name:lower(), "pet") and not string.find(obj.Name:lower(), "egg") then
                        if not Players:GetPlayerFromCharacter(obj) then
                            targetPet = obj
                            break
                        end
                    end
                end

                if targetPet then
                    local targetPart = targetPet:IsA("BasePart") and targetPet or targetPet:FindFirstChildWhichIsA("BasePart", true)

                    if targetPart then
                        hrp.CFrame = targetPart.CFrame * CFrame.new(0, 1, 0)
                        
                        local startTime = tick()
                        while tick() - startTime < 0.8 do
                            ForceTouchPet(targetPart)
                            task.wait(0.1)
                        end

                        task.wait(COOLDOWN_PET)
                    end
                end
            end
        end
        task.wait(1)
    end
end)

-- ==========================================
-- 🌾 LOGIC 2: AUTO HARVEST CỐ ĐỊNH VƯỜN NHÀ
-- ==========================================

local function IsPlayerObject(obj)
    -- Kiểm tra xem nút bấm có thuộc về bất kỳ Người Chơi nào không
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and obj:IsDescendantOf(player.Character) then
            return true
        end
    end
    return false
end

local function TriggerCropPrompt(prompt, hrp)
    if not prompt or not prompt.Enabled then return end
    
    pcall(function()
        prompt.RequiresLineOfSight = false
        prompt.MaxActivationDistance = 9999
        
        if fireproximityprompt then
            fireproximityprompt(prompt)
        end
    end)
    
    local parentPart = prompt.Parent:IsA("BasePart") and prompt.Parent or prompt.Parent:FindFirstChildWhichIsA("BasePart", true)
    if parentPart and firetouchinterest and hrp then
        pcall(function()
            firetouchinterest(hrp, parentPart, 0)
            task.wait(0.02)
            firetouchinterest(hrp, parentPart, 1)
        end)
    end
end

-- Vòng lặp thu hoạch
task.spawn(function()
    while true do
        if isAutoHarvest and GardenCenterPos then
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                -- Quét tất cả ProximityPrompt
                for _, prompt in ipairs(Workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                        local targetPart = prompt.Parent
                        
                        -- Lọc BỎ hoàn toàn nút tương tác trên Người Chơi
                        if targetPart and not IsPlayerObject(targetPart) then
                            local pos = targetPart:IsA("BasePart") and targetPart.Position or targetPart:GetPivot().Position
                            
                            -- So sánh khoảng cách dựa trên TÂM VƯỜN ĐÃ GHIM (GardenCenterPos)
                            local distanceToGarden = (GardenCenterPos - pos).Magnitude

                            -- Chỉ thu hoạch vật thể nằm trong phạm vi 50 studs tính từ Tâm Vườn
                            if distanceToGarden <= 50 then
                                TriggerCropPrompt(prompt, hrp)
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.2)
    end
end)
