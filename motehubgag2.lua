-- [[ AUTO BUY / TELEPORT TO RANDOM SPAWNED PETS ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Clear UI cũ
if CoreGui:FindFirstChild("AutoPetBuyerGui") then
    CoreGui.AutoPetBuyerGui:Destroy()
end

-- TỰ ĐỘNG TÌM THƯ MỤC CHỨA PET HOẶC TÌM TRONG WORKSPACE
-- (Thường Pet sẽ nằm trong Workspace, hoặc Workspace.Pets, Workspace.SpawnedPets, v.v.)
local TargetFolder = Workspace:FindFirstChild("Pets") or Workspace:FindFirstChild("SpawnedPets") or Workspace

-- HÀM MUA / DỊCH CHUYỂN ĐẾN PET
local function ProcessPet(obj)
    -- Kiểm tra xem Object xuất hiện có phải là Pet hay không (dựa vào tên hoặc thuộc tính)
    local nameLower = obj.Name:lower()
    
    -- Lọc bỏ Character của người chơi khác
    if Players:GetPlayerFromCharacter(obj) then return end

    -- Nhận diện Pet (Kiểm tra tên có chữ 'pet', hoặc có chứa Prompt/TouchInterest)
    if string.find(nameLower, "pet") or obj:FindFirstChildWhichIsA("ProximityPrompt", true) or obj:FindFirstChildWhichIsA("TouchTransporter", true) then
        
        print("🐾 Phát hiện Pet mới xuất hiện:", obj.Name)
        
        -- CÁCH A: Dịch chuyển nhân vật đến vị trí Pet để mua/nhặt
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local petCFrame = obj:GetPivot()
                char.HumanoidRootPart.CFrame = petCFrame * CFrame.new(0, 3, 0) -- Bay đến đỉnh đầu Pet
            end
        end)

        -- CÁCH B: Tự kích hoạt ProximityPrompt (Nút giữ E để mua) nếu có
        pcall(function()
            local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                fireproximityprompt(prompt)
            end
        end)

        -- CÁCH C: Thử gửi Remote buy nếu game dùng RemoteEvent
        pcall(function()
            for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                    local rName = remote.Name:lower()
                    if string.find(rName, "buypet") or string.find(rName, "claimpet") or string.find(rName, "pet") then
                        if remote:IsA("RemoteEvent") then
                            remote:FireServer(obj)
                        else
                            remote:InvokeServer(obj)
                        end
                    end
                end
            end
        end)
    end
end

-- 1. LẮNG NGHE SỰ KIỆN PET MỚI SPAWN (REAL-TIME)
TargetFolder.ChildAdded:Connect(function(child)
    task.wait(0.1) -- Đợi 0.1s để Pet load đủ dữ liệu
    ProcessPet(child)
end)

-- 2. QUÉT SẴN CÁC PET ĐÃ SPAWN TỪ TRƯỚC TRÊN BẢN ĐỒ
for _, child in ipairs(TargetFolder:GetChildren()) do
    ProcessPet(child)
end

print("⚡ Auto Pet Buyer đã kích hoạt ngầm thành công!")
