-- [[ GROW A GARDEN 2 - FREEDOM STEAL (0.2S/FRUIT) & FIX GARDEN UNLOCK ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("GAG_GoldMenu") then
    CoreGui.GAG_GoldMenu:Destroy()
end

-- ==========================================
-- 🎨 GIAO DIỆN MENU
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

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(255, 215, 0)
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

local MainFrame = Instance.new("Frame")
MainFrame.Parent = Gui
MainFrame.Size = UDim2.new(0, 680, 0, 110)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
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
CloseBtn.Position = UDim2.new(0.95, -5, 0.05, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ==========================================
-- 🔘 TOGGLE SWITCHES
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
local isAutoSteal = false
local isAutoSell = false
local isBusy = false
local isNoclipping = false
local isInventoryFull = false

CreateToggleSwitch(MainFrame, "AUTO PET (FLY)", 15, function(state) isAutoPet = state end)
CreateToggleSwitch(MainFrame, "AUTO HARVEST", 180, function(state) isAutoHarvest = state end)
CreateToggleSwitch(MainFrame, "AUTO STEAL (AURA)", 345, function(state) isAutoSteal = state end)
CreateToggleSwitch(MainFrame, "AUTO SELL (FULL)", 510, function(state) isAutoSell = state end)

-- ==========================================
-- 🔓 UNLOCK / UNFREEZE GARDEN BUTTON & CHARACTER TELEPORT
-- ==========================================

RunService.RenderStepped:Connect(function()
    -- 1. Mở khóa thuộc tính nút bấm UI
    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
    if pGui then
        for _, guiObj in ipairs(pGui:GetDescendants()) do
            if guiObj:IsA("GuiObject") then
                if guiObj.Visible == false and (string.find(guiObj.Name:lower(), "garden") or string.find(guiObj.Name:lower(), "teleport") or string.find(guiObj.Name:lower(), "home")) then
                    guiObj.Visible = true
                end
            end
            if guiObj:IsA("TextButton") or guiObj:IsA("ImageButton") then
                if guiObj.Active == false then
                    guiObj.Active = true
                end
            end
        end
    end

    -- 2. Dọn dẹp trạng thái khóa di chuyển / Teleport trên Character
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if humanoid.WalkSpeed == 0 then
                humanoid.WalkSpeed = 16 -- Phục hồi tốc độ di chuyển ban đầu
            end
            humanoid.PlatformStand = false
        end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            if hrp.Anchored then
                hrp.Anchored = false -- Mở khóa CFrame cho phép Teleport
            end
            -- Dọn dẹp các mối nối (Weld/BodyVelocity) mà game tự gán vào người khi trộm
            for _, child in ipairs(hrp:GetChildren()) do
                if child:IsA("WeldConstraint") or child:IsA("Weld") or child:IsA("BodyVelocity") or child:IsA("BodyPosition") then
                    child:Destroy()
                end
            end
        end
    end
end)

-- ==========================================
-- 📦 GIÁM SÁT ĐẦY TÚI ĐỒ
-- ==========================================

task.spawn(function()
    while true do
        pcall(function()
            local pGui = LocalPlayer:FindFirstChild("PlayerGui")
            if pGui then
                local foundFullMsg = false
                for _, obj in ipairs(pGui:GetDescendants()) do
                    if obj:IsA("TextLabel") and obj.Visible then
                        local txt = obj.Text:lower()
                        if string.find(txt, "full") or string.find(txt, "max") or string.find(txt, "đầy") or string.find(txt, "inventory full") then
                            foundFullMsg = true
                            break
                        end
                    end
                end
                isInventoryFull = foundFullMsg
            end
        end)
        task.wait(0.2)
    end
end)

-- ==========================================
-- 🔓 NOCLIP & FLY TWEEN
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

local function FlyTo(targetCFrame, speed)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    speed = speed or 40
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
-- 🌾 LOGIC 1: AUTO HARVEST
-- ==========================================

local function FindGardenCenter()
    local plots = Workspace:FindFirstChild("Plots") or Workspace:FindFirstChild("Farms")
    if plots then
        for _, plot in ipairs(plots:GetChildren()) do
            if string.find(plot.Name:lower(), LocalPlayer.Name:lower()) or plot:FindFirstChild(LocalPlayer.Name) then
                return plot:GetPivot()
            end
        end
    end
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
                    if not movedToCenter then
                        local gardenCenter = FindGardenCenter()
                        if gardenCenter then
                            hrp.CFrame = gardenCenter * CFrame.new(0, 3, 0)
                            movedToCenter = true
                            task.wait(0.3)
                        end
                    end

                    for _, prompt in ipairs(Workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") and IsHarvestPrompt(prompt) then
                            prompt.RequiresLineOfSight = false
                            prompt.MaxActivationDistance = 999999
                            prompt.HoldDuration = 0
                        end
                    end

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
        task.wait(0.05)
    end
end)

-- ==========================================
-- 🥷 LOGIC 2: AUTO STEAL AURA (0.2S / 1 QUẢ - BÁN KÍNH 50 STUDS)
-- ==========================================

local function IsStealPrompt(prompt)
    local actionText = prompt.ActionText:lower()
    local objectText = prompt.ObjectText:lower()
    return string.find(actionText, "steal") or string.find(objectText, "steal") or string.find(actionText, "trộm")
end

task.spawn(function()
    while true do
        if isAutoSteal and not isBusy then
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    local stoleAny = false

                    for _, prompt in ipairs(Workspace:GetDescendants()) do
                        if isBusy or not isAutoSteal then break end

                        if prompt:IsA("ProximityPrompt") and prompt.Enabled and IsStealPrompt(prompt) then
                            local parentPart = prompt.Parent:IsA("BasePart") and prompt.Parent or prompt.Parent:FindFirstChildWhichIsA("BasePart", true)
                            
                            if parentPart then
                                local dist = (hrp.Position - parentPart.Position).Magnitude
                                if dist <= 50 then
                                    prompt.RequiresLineOfSight = false
                                    prompt.MaxActivationDistance = 60
                                    prompt.HoldDuration = 0

                                    pcall(function()
                                        if fireproximityprompt then
                                            fireproximityprompt(prompt)
                                        end
                                    end)

                                    stoleAny = true
                                    break -- Trộm 1 quả mỗi chu kỳ
                                end
                            end
                        end
                    end

                    if stoleAny then
                        task.wait(0.2) -- Thời gian chờ đúng 0.2s theo yêu cầu
                    else
                        task.wait(0.1)
                    end
                end
            end)
        else
            task.wait(0.3)
        end
    end
end)

-- ==========================================
-- 💰 LOGIC 3: AUTO SELL (TỰ ĐỘNG BÁN KHI ĐẦY TÚI ĐỒ)
-- ==========================================

local function FindStevenNPC()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (string.find(obj.Name:lower(), "steven") or string.find(obj.Name:lower(), "merchant")) then
            return obj
        end
    end
    for _, prompt in ipairs(Workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local act = prompt.ActionText:lower()
            local objT = prompt.ObjectText:lower()
            if string.find(act, "talk") or string.find(act, "sell") or string.find(objT, "steven") then
                return prompt.Parent
            end
        end
    end
    return nil
end

local function ClickSellInventoryOption()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return false end

    for _, btn in ipairs(playerGui:GetDescendants()) do
        if btn:IsA("TextButton") or btn:IsA("ImageButton") then
            local txt = ""
            if btn:IsA("TextButton") then txt = btn.Text:lower() end
            
            if string.find(txt, "sell inventory") or string.find(txt, "sell inventory\"") or string.find(txt, "#1") then
                if btn.Visible then
                    pcall(function()
                        if firesignal then
                            firesignal(btn.MouseButton1Click)
                        end
                        for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do
                            conn:Fire()
                        end
                    end)
                    return true
                end
            end
        end
    end
    return false
end

task.spawn(function()
    while true do
        if isAutoSell and isInventoryFull and not isBusy then
            isBusy = true
            
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    local oldCFrame = hrp.CFrame
                    local steven = FindStevenNPC()

                    if steven then
                        local targetPart = steven:IsA("BasePart") and steven or steven:FindFirstChildWhichIsA("BasePart", true)
                        
                        if targetPart then
                            FlyTo(targetPart.CFrame * CFrame.new(0, 0, -2.5), 40)
                            task.wait(0.4)

                            local prompt = steven:FindFirstChildWhichIsA("ProximityPrompt", true) or targetPart:FindFirstChildWhichIsA("ProximityPrompt", true) or (targetPart.Parent and targetPart.Parent:FindFirstChildWhichIsA("ProximityPrompt", true))
                            if prompt then
                                prompt.RequiresLineOfSight = false
                                prompt.MaxActivationDistance = 50
                                if fireproximityprompt then
                                    fireproximityprompt(prompt)
                                end
                            end

                            task.wait(0.6)

                            for i = 1, 5 do
                                local success = ClickSellInventoryOption()
                                task.wait(0.3)
                                if success then break end
                            end

                            task.wait(0.5)
                            FlyTo(oldCFrame, 40)
                        end
                    end
                end
            end)

            isInventoryFull = false
            isBusy = false
            task.wait(2)
        else
            task.wait(0.5)
        end
    end
end)

-- ==========================================
-- 🐾 LOGIC 4: AUTO PET
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
                            isBusy = true
                            local oldCFrame = hrp.CFrame

                            FlyTo(targetPart.CFrame * CFrame.new(0, 2, 0), 40)
                            task.wait(0.5)

                            local prompt = targetPart:FindFirstChildWhichIsA("ProximityPrompt", true) or targetPet:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if prompt then
                                pcall(function()
                                    prompt.RequiresLineOfSight = false
                                    if fireproximityprompt then fireproximityprompt(prompt) end
                                end)
                            end

                            task.wait(0.5)
                            FlyTo(oldCFrame, 40)

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
