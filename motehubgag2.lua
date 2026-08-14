-- [[ GROW A GARDEN - AUTO PET WITH SIMPLE COOLDOWN ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Clear UI cũ
if CoreGui:FindFirstChild("CooldownPetBuyerGui") then
    CoreGui.CooldownPetBuyerGui:Destroy()
end

-- TẠO UI BẬT / TẮT
local Gui = Instance.new("ScreenGui")
Gui.Name = "CooldownPetBuyerGui"
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
local COOLDOWN_TIME = 3.5 -- Thời gian nghỉ giữa mỗi lần mua (3 - 4 giây)

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

-- HÀM KÍCH HOẠT CHẠM VÀ MUA PET
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

-- QUÉT VÀ MUA PET THEO CHU KỲ NGHỈ
task.spawn(function()
    while true do
        if isAutoEnabled then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hrp then
                local targetPet = nil

                -- Dò tìm 1 con Pet đang xuất hiện trên map
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("Model") and string.find(obj.Name:lower(), "pet") and not string.find(obj.Name:lower(), "egg") then
                        if not Players:GetPlayerFromCharacter(obj) then
                            targetPet = obj
                            break
                        end
                    end
                end

                -- Nếu tìm thấy Pet -> Tiến hành mua
                if targetPet then
                    local targetPart = targetPet:IsA("BasePart") and targetPet or targetPet:FindFirstChildWhichIsA("BasePart", true)

                    if targetPart then
                        -- 1. Dịch chuyển tức thời đến sát Pet
                        hrp.CFrame = targetPart.CFrame * CFrame.new(0, 1, 0)
                        
                        -- Thao tác mua trong 0.8 giây
                        local startTime = tick()
                        while tick() - startTime < 0.8 do
                            ForceTouchPet(targetPart)
                            task.wait(0.1)
                        end

                        -- 2. TẠM DỪNG 3.5 GIÂY (Tránh dịch chuyển liên tục)
                        task.wait(COOLDOWN_TIME)
                    end
                end
            end
        end
        task.wait(1)
    end
end)
