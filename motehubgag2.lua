-- [[ GROW A GARDEN - SAFE AUTO PET BUYER (HOLD TIME FIX) ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Clear UI cũ
if CoreGui:FindFirstChild("SafeAutoPetGui") then
    CoreGui.SafeAutoPetGui:Destroy()
end

-- TẠO UI BẬT / TẮT
local Gui = Instance.new("ScreenGui")
Gui.Name = "SafeAutoPetGui"
Gui.Parent = CoreGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Gui
ToggleBtn.Size = UDim2.new(0, 140, 0, 40)
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

-- HÀM KIỂM TRA XEM CÓ PHẢI NPC HOẶC NGƯỜI CHƠI KHÔNG
local function IsNPCOrPlayer(model)
    if Players:GetPlayerFromCharacter(model) then return true end
    if model:FindFirstChildWhichIsA("Humanoid") then return true end
    
    local nameLower = model.Name:lower()
    if string.find(nameLower, "npc") or string.find(nameLower, "shopkeeper") or string.find(nameLower, "merchant") or string.find(nameLower, "quest") then
        return true
    end

    return false
end

-- HÀM KÍCH HOẠT NÚT GIỮ E (BYPASS HOLD TIME)
local function FirePromptWithHold(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then return end

    -- Lấy thời gian cần giữ của game (ví dụ: 1.5 giây hay 2 giây)
    local holdTime = prompt.HoldDuration or 0

    pcall(function()
        -- CÁCH A: Thử ép thời gian giữ về 0 để mua tức thì
        prompt.HoldDuration = 0
        fireproximityprompt(prompt)
    end)

    -- CÁCH B: Dự phòng nếu game chống chỉnh HoldDuration (Giả lập giữ phím chuẩn)
    task.spawn(function()
        pcall(function()
            if promptInputWillBegin then
                promptInputWillBegin(prompt)
                task.wait(holdTime + 0.1) -- Giữ đúng số giây game yêu cầu
                promptInputEnded(prompt)
            end
        end)
    end)
end

-- HÀM XỬ LÝ MUA/TELEPORT PET AN TOÀN
local function ProcessSafePet(obj)
    if not isAutoEnabled then return end
    if not obj or not obj.Parent then return end

    -- Bỏ qua NPC và Người chơi
    if IsNPCOrPlayer(obj) then return end

    local nameLower = obj.Name:lower()

    -- Lọc vật thể có chứa từ 'pet'
    if string.find(nameLower, "pet") and not string.find(nameLower, "egg") then
        
        local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
        
        if prompt then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    -- Bay tới vị trí Pet
                    local targetCFrame = obj:GetPivot()
                    char.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 3, 0)
                    
                    task.wait(0.15)
                    -- Thực thi giữ nút mua Pet
                    FirePromptWithHold(prompt)
                end
            end)
        end
    end
end

-- VÒNG LẶP QUÉT ĐỊNH KỲ
task.spawn(function()
    while true do
        if isAutoEnabled then
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj:IsA("Model") or obj:IsA("BasePart") then
                    ProcessSafePet(obj)
                end
            end
        end
        task.wait(1.5)
    end
end)
