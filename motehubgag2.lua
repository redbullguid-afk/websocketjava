-- [[ GROW A GARDEN 2 - ADVANCED NOCLIP & FAST HARVEST ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Cleanup UI cũ
if CoreGui:FindFirstChild("GAG_GoldMenu") then
    CoreGui.GAG_GoldMenu:Destroy()
end

-- ==========================================
-- 🎨 GIAO DIỆN MENU (GOLD & BLACK)
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
MainFrame.Size = UDim2.new(0, 520, 0, 110)
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
Title.Text = "★ GROW A GARDEN 2 - PRO HUB ★"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 15

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
-- 🔘 TOGGLE SWITCH
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
local isBusy = false -- Khóa ưu tiên chống xung đột
local isNoclipping = false

CreateToggleSwitch(MainFrame, "AUTO PET (FLY)", 15, function(state) isAutoPet = state end)
CreateToggleSwitch(MainFrame, "AUTO HARVEST", 180, function(state) isAutoHarvest = state end)
CreateToggleSwitch(MainFrame, "AUTO SELL FULL", 345, function(state) isAutoSell = state end)

-- ==========================================
-- 🔓 SYSTEM NOCLIP NÂNG CAO (BYPASS ANTI-CHEAT)
-- ==========================================

RunService.Stepped:Connect(function()
    if isNoclipping then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

local function EnableNoclip(state)
    isNoclipping = state
    if not state then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- ==========================================
-- 🛸 HÀM BAY TWEEN CHẬM & MƯỢT (SPEED 45)
-- ==========================================

local function FlyTo(targetCFrame, speed)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    speed = speed or 45 -- Giảm tốc độ để không bị Server kéo giật lại
    EnableNoclip(true)

    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local duration = distance / speed

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    
    tween:Play()
    tween.Completed:Wait()
    
    EnableNoclip(false)
end

-- ==========================================
-- 🌾 LOGIC 1: AUTO HARVEST SIÊU TỐC (DỊCH GIỮA VƯỜN)
-- ==========================================

local function FindGardenCenter()
    -- Tìm khu vực vườn của người chơi hoặc Plot trung tâm
    local plots = Workspace:FindFirstChild("Plots") or Workspace:FindFirstChild("Farms")
    if plots then
        for _, plot in ipairs(plots:GetChildren()) do
            if string.find(plot.Name:lower(), LocalPlayer.Name:lower()) or plot:FindFirstChild(LocalPlayer.Name) then
                return plot:GetPivot()
            end
        end
    end
    -- Fallback nếu không thấy plot riêng: đứng tại vị trí hiện tại
    local char = LocalPlayer.Character
    return char and char:GetPivot()
end

local function IsHarvestPrompt(prompt)
    local actionText = prompt.ActionText:lower()
    local objectText = prompt.ObjectText:lower()
    return string.find(actionText, "harvest") or string.find(objectText, "harvest") or string.find(actionText, "pick")
end

task.spawn(function()
    local movedToCenter = false

    while true do
        if isAutoHarvest and not isBusy then
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    -- Dịch chuyển 1 lần vào giữa vườn
                    if not movedToCenter then
                        local gardenCenter = FindGardenCenter()
                        if gardenCenter then
                            hrp.CFrame = gardenCenter * CFrame.new(0, 3, 0)
                            movedToCenter = true
                            task.wait(0.3)
                        end
                    end

                    -- Bỏ giới hạn khoảng cách cho tất cả ProximityPrompt
                    for _, prompt in ipairs(Workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") and IsHarvestPrompt(prompt) then
                            prompt.RequiresLineOfSight = false
                            prompt.MaxActivationDistance = 999999
                            prompt.HoldDuration = 0
                        end
                    end

                    -- Thu hoạch siêu tốc (Xử lý song song bằng task.spawn)
                    for _, prompt in ipairs(Workspace:GetDescendants()) do
                        if isBusy or not isAutoHarvest then break end

                        if prompt:IsA("ProximityPrompt") and prompt.Enabled and IsHarvestPrompt(prompt) then
                            task.spawn(function()
                                pcall(function()
                                    if fireproximityprompt then
                                        fireproximityprompt(prompt)
                                    end
                                end)
                            end)
                        end
                    end
                end
            end)
        else
            movedToCenter = false
        end
        task.wait(0.05) -- Tần số quét siêu nhanh
    end
end)

-- ==========================================
-- 💰 LOGIC 2: AUTO SELL (XỬ LÝ THOẠI NPC CHÍNH XÁC)
-- ==========================================

local function ClickStevenOption1()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return end

    -- Quét tất cả các nút bấm trong UI đối thoại
    for _, obj in ipairs(playerGui:GetDescendants()) do
        if obj:IsA("TextButton") or obj:IsA("TextLabel") then
            local txt = obj.Text:lower()
            -- Bấm đúng tùy chọn #1 Sell Inventory
            if string.find(txt, "sell inventory") or string.find(txt, "#1") or string.find(txt, "sell all") then
                local btn = obj:IsA("TextButton") and obj or obj.Parent
                if btn and btn:IsA("TextButton") then
                    pcall(function()
                        for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do
                            conn:Fire()
                        end
                        if firesignal then
                            firesignal(btn.MouseButton1Click)
                        end
                    end)
                end
            end
        end
    end
end

local function IsInventoryFull()
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
                isBusy = true -- Khóa Auto Harvest để tránh xung đột
                
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    local oldCFrame = hrp.CFrame
                    local sellZone = Workspace:FindFirstChild("Steven", true) or Workspace:FindFirstChild("Merchant", true) or Workspace:FindFirstChild("Sell", true)

                    if sellZone then
                        local sellPart = sellZone:IsA("BasePart") and sellZone or sellZone:FindFirstChildWhichIsA("BasePart", true)
                        if sellPart then
                            -- Bay mượt với Noclip tới NPC Steven với tốc độ 45
                            FlyTo(sellPart.CFrame * CFrame.new(0, 0, -4), 45)
                            task.wait(0.5)

                            -- Bấm nói chuyện với NPC Steven
                            local sellPrompt = sellZone:FindFirstChildWhichIsA("ProximityPrompt", true) or sellPart:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if sellPrompt then
                                pcall(function()
                                    sellPrompt.RequiresLineOfSight = false
                                    if fireproximityprompt then fireproximityprompt(sellPrompt) end
                                end)
                            end

                            task.wait(0.8)

                            -- Liên tục kích hoạt tùy chọn #1 Sell Inventory
                            local timer = tick()
                            while tick() - timer < 3 do
                                ClickStevenOption1()
                                task.wait(0.2)
                            end

                            -- Bay mượt quay trở về vị trí cũ trong vườn
                            FlyTo(oldCFrame, 45)
                        end
                    end
                end

                task.wait(0.5)
                isBusy = false -- Mở khóa lại Auto Harvest
            end
        end
        task.wait(1)
    end
end)

-- ==========================================
-- 🐾 LOGIC 3: AUTO PET (FLY CHẬM & NOCLIP)
-- ==========================================

local COOLDOWN_PET = 12

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
                            isBusy = true -- Khóa Auto Harvest
                            local oldCFrame = hrp.CFrame

                            -- Bay mượt tới vị trí Pet với tốc độ 45
                            FlyTo(targetPart.CFrame * CFrame.new(0, 2, 0), 45)
                            task.wait(0.5)

                            local prompt = targetPart:FindFirstChildWhichIsA("ProximityPrompt", true) or targetPet:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if prompt then
                                pcall(function()
                                    prompt.RequiresLineOfSight = false
                                    if fireproximityprompt then fireproximityprompt(prompt) end
                                end)
                            end

                            task.wait(0.5)
                            -- Bay mượt quay về vườn
                            FlyTo(oldCFrame, 45)

                            task.wait(0.3)
                            isBusy = false
                            task.wait(COOLDOWN_PET)
                        end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)
