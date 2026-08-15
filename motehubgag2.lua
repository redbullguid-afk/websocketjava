-- [[ GROW A GARDEN 2 - FIXED SELL & AREA HARVEST ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
Title.Text = "★ GROW A GARDEN 2 - FIXED HUB ★"
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
local isBusy = false
local MyGardenPos = nil

CreateToggleSwitch(MainFrame, "AUTO PET (FLY)", 15, function(state) isAutoPet = state end)

CreateToggleSwitch(MainFrame, "AUTO HARVEST", 180, function(state) 
    isAutoHarvest = state 
    if state then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then MyGardenPos = hrp.Position end
    end
end)

CreateToggleSwitch(MainFrame, "AUTO SELL FULL", 345, function(state) isAutoSell = state end)

-- ==========================================
-- 🛸 HÀM BAY TWEEN AN TOÀN
-- ==========================================

local function FlyTo(targetCFrame, speed)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    speed = speed or 65
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local duration = distance / speed

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    
    tween:Play()
    tween.Completed:Wait()
end

-- ==========================================
-- 🐾 LOGIC 1: AUTO PET
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
                            
                            FlyTo(targetPart.CFrame * CFrame.new(0, 2, 0), 70)
                            task.wait(0.4)

                            local prompt = targetPart:FindFirstChildWhichIsA("ProximityPrompt", true) or targetPet:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if prompt then
                                pcall(function()
                                    prompt.RequiresLineOfSight = false
                                    if fireproximityprompt then fireproximityprompt(prompt) end
                                end)
                            end

                            task.wait(0.5)
                            FlyTo(oldCFrame, 80)
                            
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

-- ==========================================
-- 🌾 LOGIC 2: AUTO HARVEST (QUÉT VÙNG VƯỜN BẮT BỘC)
-- ==========================================

local function IsHarvestPrompt(prompt)
    local actionText = prompt.ActionText:lower()
    local objectText = prompt.ObjectText:lower()
    return string.find(actionText, "harvest") or string.find(objectText, "harvest")
end

task.spawn(function()
    while true do
        if isAutoHarvest and not isBusy then
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    for _, prompt in ipairs(Workspace:GetDescendants()) do
                        if isBusy then break end
                        
                        if prompt:IsA("ProximityPrompt") and prompt.Enabled and IsHarvestPrompt(prompt) then
                            local targetPart = prompt.Parent
                            if targetPart then
                                local pos = targetPart:IsA("BasePart") and targetPart.Position or targetPart:GetPivot().Position
                                
                                -- Nếu đã lưu vị trí vườn, ưu tiên quét trong bán kính Vườn nhà
                                local inRange = true
                                if MyGardenPos then
                                    local dist = (Vector3.new(MyGardenPos.X, 0, MyGardenPos.Z) - Vector3.new(pos.X, 0, pos.Z)).Magnitude
                                    inRange = dist <= 120
                                end

                                if inRange then
                                    pcall(function()
                                        prompt.RequiresLineOfSight = false
                                        prompt.MaxActivationDistance = 99999
                                        if fireproximityprompt then fireproximityprompt(prompt) end
                                    end)
                                end
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.15)
    end
end)

-- ==========================================
-- 💰 LOGIC 3: AUTO SELL (GỬI EVENT & BẬT UI BÁN)
-- ==========================================

local function TriggerSellAction()
    -- 1. Tìm và gửi RemoteEvent Bán nông sản trong ReplicatedStorage
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            if string.find(name, "sell") or string.find(name, "merchant") then
                pcall(function()
                    if obj:IsA("RemoteEvent") then
                        obj:FireServer()
                    else
                        obj:InvokeServer()
                    end
                end)
            end
        end
    end

    -- 2. Tự động bấm nút "Sell All" nếu giao diện Menu Bán hiện lên
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, btn in ipairs(playerGui:GetDescendants()) do
            if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                local txt = btn.Name:lower()
                if btn:IsA("TextButton") then txt = txt .. " " .. btn.Text:lower() end
                
                if string.find(txt, "sell all") or string.find(txt, "sellall") or string.find(txt, "confirm sell") then
                    pcall(function()
                        for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do
                            conn:Fire()
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
                isBusy = true
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if hrp then
                    local oldCFrame = hrp.CFrame
                    local sellZone = Workspace:FindFirstChild("Sell", true) or Workspace:FindFirstChild("Merchant", true) or Workspace:FindFirstChild("SellZone", true)
                    
                    if sellZone then
                        local sellPart = sellZone:IsA("BasePart") and sellZone or sellZone:FindFirstChildWhichIsA("BasePart", true)
                        if sellPart then
                            -- Bay tới vị trí NPC
                            FlyTo(sellPart.CFrame * CFrame.new(0, 2, 0), 80)
                            task.wait(0.3)

                            -- Kích hoạt ProximityPrompt của NPC
                            local sellPrompt = sellZone:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if sellPrompt then
                                pcall(function()
                                    sellPrompt.RequiresLineOfSight = false
                                    if fireproximityprompt then fireproximityprompt(sellPrompt) end
                                end)
                            end

                            -- Thực hiện Bán qua Event / UI
                            local sellTimer = tick()
                            while tick() - sellTimer < 2 do
                                TriggerSellAction()
                                task.wait(0.3)
                            end

                            -- Bay về vị trí cũ
                            FlyTo(oldCFrame, 80)
                        end
                    end
                end
                isBusy = false
            end
        end
        task.wait(1)
    end
end)
