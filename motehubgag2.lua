-- [[ GROW A GARDEN - AUTO PET (DEEP SEARCH FIX) ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Clear UI cũ
if CoreGui:FindFirstChild("DeepAutoPetGui") then
    CoreGui.DeepAutoPetGui:Destroy()
end

-- TẠO UI BẬT / TẮT
local Gui = Instance.new("ScreenGui")
Gui.Name = "DeepAutoPetGui"
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

-- HÀM KIỂM TRA NPC / PLAYER DỰA VÀO CẤU TRÚC
local function IsPlayerOrCharacter(obj)
    if Players:GetPlayerFromCharacter(obj) then return true end
    if obj.Parent and Players:GetPlayerFromCharacter(obj.Parent) then return true end
    if LocalPlayer.Character and obj:IsDescendantOf(LocalPlayer.Character) then return true end
    return false
end

-- HÀM KÍCH HOẠT MUA PET
local function BuyPetPrompt(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then return end
    
    pcall(function()
        prompt.RequiresLineOfSight = false
    end)

    local holdTime = prompt.HoldDuration or 0.5

    task.spawn(function()
        local startTime = tick()
        while tick() - startTime <= (holdTime + 0.3) do
            pcall(function()
                fireproximityprompt(prompt)
            end)
            task.wait(0.05)
        end
    end)
end

-- QUÉT TẤT CẢ PROXIMITY PROMPT TRÊN BẢN ĐỒ
local function FindAndTeleportToPet()
    if not isAutoEnabled then return end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    -- Quét toàn bộ ProximityPrompt có trong Workspace
    for _, prompt in ipairs(Workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            local parentModel = prompt.Parent
            
            -- Lùi lên lấy Model chứa con Pet
            while parentModel and not parentModel:IsA("Model") and parentModel ~= Workspace do
                parentModel = parentModel.Parent
            end

            if parentModel and parentModel ~= Workspace and not IsPlayerOrCharacter(parentModel) then
                local nameLower = parentModel.Name:lower()
                local promptObjectLower = prompt.ObjectText:lower()
                local promptActionLower = prompt.ActionText:lower()

                -- Kiểm tra từ khóa Mua / Pet
                local isPet = string.find(nameLower, "pet") 
                           or string.find(promptObjectLower, "pet") 
                           or string.find(promptActionLower, "buy") 
                           or string.find(promptActionLower, "take")
                           or string.find(promptActionLower, "claim")

                if isPet and not string.find(nameLower, "egg") and not string.find(nameLower, "shop") then
                    
                    -- Dịch chuyển tới đứng sát Pet
                    local petPos = prompt.Parent:IsA("BasePart") and prompt.Parent.Position or parentModel:GetPivot().Position
                    hrp.CFrame = CFrame.new(petPos + Vector3.new(0, 1, 2), petPos)

                    task.wait(0.2)
                    BuyPetPrompt(prompt)
                    break -- Xử lý 1 con mỗi lần quét
                end
            end
        end
    end
end

-- VÒNG LẶP QUÉT TẬN GỐC
task.spawn(function()
    while true do
        if isAutoEnabled then
            pcall(FindAndTeleportToPet)
        end
        task.wait(1.5)
    end
end)
