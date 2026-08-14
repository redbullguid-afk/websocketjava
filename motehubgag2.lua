-- [[ GROW A GARDEN - INSTANT TELEPORT & AUTO TOUCH BUYER ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Clear UI cũ
if CoreGui:FindFirstChild("InstantPetBuyerGui") then
    CoreGui.InstantPetBuyerGui:Destroy()
end

-- TẠO UI BẬT / TẮT
local Gui = Instance.new("ScreenGui")
Gui.Name = "InstantPetBuyerGui"
Gui.Parent = CoreGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Gui
ToggleBtn.Size = UDim2.new(0, 150, 0, 40)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ToggleBtn.Text = "AUTO PET: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 15
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleBtn

local isAutoEnabled = false

ToggleBtn.MouseButton1Click:Connect(function()
    isAutoEnabled = not isAutoEnabled
    if isAutoEnabled then
        ToggleBtn.Text = "AUTO PET: ON"
        ToggleBtn.TextColor3 = Color3.fromRGB(85, 255, 127)
    else
        ToggleBtn.Text = "AUTO PET: OFF"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
    end
end)

-- HÀM KÍCH HOẠT CHẠM (TOUCH) ĐỂ MUA
local function ForceTouchPet(petPart)
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    
    if root and petPart then
        -- 1. Giả lập va chạm vật lý trực tiếp
        if firetouchinterest then
            pcall(function()
                firetouchinterest(root, petPart, 0)
                task.wait(0.05)
                firetouchinterest(root, petPart, 1)
            end)
        end
        
        -- 2. Kích hoạt nút bấm nếu có
        local prompt = petPart:FindFirstChildWhichIsA("ProximityPrompt", true) or petPart.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
        if prompt then
            pcall(function()
                prompt.RequiresLineOfSight = false
                fireproximityprompt(prompt)
            end)
        end
    end
end

-- HÀM DỊCH CHUYỂN TỨC THỜI & MUA PET
local function ProcessPetInstant(obj)
    if not isAutoEnabled then return end
    if not obj or not obj.Parent then return end
    if Players:GetPlayerFromCharacter(obj) then return end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    -- Tìm Part chính để chạm
    local targetPart = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart", true)
    
    if targetPart then
        -- Dịch chuyển TỨC THỜI (không bay mượt để tránh anticheat kéo lại)
        hrp.CFrame = targetPart.CFrame * CFrame.new(0, 1, 0)
        
        -- Giữ nhân vật tại vị trí 1 giây và kích hoạt mua liên tục
        local startTime = tick()
        while tick() - startTime < 1 do
            if not isAutoEnabled then break end
            hrp.CFrame = targetPart.CFrame
            ForceTouchPet(targetPart)
            task.wait(0.1)
        end
    end
end

-- QUÉT DÒ PET TỨC THỜI
task.spawn(function()
    while true do
        if isAutoEnabled then
            pcall(function()
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("Model") and string.find(obj.Name:lower(), "pet") and not string.find(obj.Name:lower(), "egg") then
                        if not Players:GetPlayerFromCharacter(obj) then
                            ProcessPetInstant(obj)
                            task.wait(0.5)
                        end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)
