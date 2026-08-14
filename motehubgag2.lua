-- [[ CÔNG CỤ DÒ TÌM PET (KHÔNG TELEPORT) ]] --

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Hàm quét dọn các đường vẽ cũ
local function ClearLines()
    for _, v in ipairs(Workspace:GetChildren()) do
        if v.Name == "PetTracer" then v:Destroy() end
    end
end

-- Vòng lặp tìm kiếm
task.spawn(function()
    while true do
        ClearLines()
        
        for _, obj in ipairs(Workspace:GetDescendants()) do
            -- Dò tìm Model có chữ "Pet" trong tên (không phải trứng, không phải người)
            if obj:IsA("Model") and string.find(obj.Name:lower(), "pet") and not string.find(obj.Name:lower(), "egg") then
                
                -- Bỏ qua nhân vật người chơi
                if not Players:GetPlayerFromCharacter(obj) then
                    
                    print("✅ Đã tìm thấy một con Pet tên:", obj.Name)
                    
                    -- Vẽ đường kẻ màu đỏ từ người bạn đến con Pet
                    pcall(function()
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") and obj:GetPivot() then
                            local startPart = char.HumanoidRootPart
                            local endPos = obj:GetPivot().Position
                            
                            local distance = (startPart.Position - endPos).Magnitude
                            
                            local part = Instance.new("Part")
                            part.Name = "PetTracer"
                            part.Anchored = true
                            part.CanCollide = false
                            part.Material = Enum.Material.Neon
                            part.Color = Color3.new(1, 0, 0)
                            part.Size = Vector3.new(0.2, 0.2, distance)
                            part.CFrame = CFrame.lookAt(startPart.Position, endPos) * CFrame.new(0, 0, -distance/2)
                            part.Parent = Workspace
                        end
                    end)
                    
                end
            end
        end
        task.wait(2)
    end
end)
