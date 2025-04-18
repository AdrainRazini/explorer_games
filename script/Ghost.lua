-- // Ghost.lua | Script de desync visual

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- UI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "GhostUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Ghost Mode"
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

local activateBtn = Instance.new("TextButton", frame)
activateBtn.Size = UDim2.new(0.9, 0, 0, 30)
activateBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
activateBtn.Text = "Ativar Ghost"
activateBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
activateBtn.TextColor3 = Color3.new(1, 1, 1)
activateBtn.Font = Enum.Font.SourceSans
activateBtn.TextSize = 16

local deactivateBtn = Instance.new("TextButton", frame)
deactivateBtn.Size = UDim2.new(0.9, 0, 0, 30)
deactivateBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
deactivateBtn.Text = "Desativar Ghost"
deactivateBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
deactivateBtn.TextColor3 = Color3.new(1, 1, 1)
deactivateBtn.Font = Enum.Font.SourceSans
deactivateBtn.TextSize = 16

-- Ghost Logic
local ghosting = false
local frozenPosition = hrp.Position
local ghostConnection

activateBtn.MouseButton1Click:Connect(function()
    if ghosting then return end
    ghosting = true
    frozenPosition = hrp.Position

    ghostConnection = RunService.Stepped:Connect(function()
        if ghosting and hrp then
            hrp.Velocity = Vector3.zero
            hrp.CFrame = CFrame.new(frozenPosition)
        end
    end)
end)

deactivateBtn.MouseButton1Click:Connect(function()
    ghosting = false
    if ghostConnection then
        ghostConnection:Disconnect()
        ghostConnection = nil
    end
end)
