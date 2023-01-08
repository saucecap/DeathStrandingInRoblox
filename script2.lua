local player = game.Players.LocalPlayer
local character = player.Character
if character == nil then
    print("Character is not loaded yet, waiting for it to be added...")
    character = player:WaitForChild("Character")
end
local humanoid = character:WaitForChild("Humanoid")
if humanoid == nil then
    print("Humanoid is not loaded yet, waiting for it to be added...")
    humanoid = character:WaitForChild("Humanoid")
end

-- Create the health bar GUI
local healthBar = Instance.new("ScreenGui")
local healthBarFrame = Instance.new("Frame")
local healthBarFill = Instance.new("Frame")
local healthText = Instance.new("TextLabel")

healthBar.Name = "HealthBar"
healthBar.Parent = player:WaitForChild("PlayerGui")
healthBarFrame.Name = "HealthBarFrame"
healthBarFrame.Parent = healthBar
healthBarFill.Name = "HealthBarFill"
healthBarFill.Parent = healthBarFrame
healthText.Name = "HealthText"
healthText.Parent = healthBarFrame

-- Set the properties of the health bar GUI
healthBarFrame.Position = UDim2.new(0.5, -150, 0, 10)
healthBarFrame.Size = UDim2.new(0, 300, 0, 50)
healthBarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
healthBarFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)

healthBarFill.Position = UDim2.new(0, 0, 0, 0)
healthBarFill.Size = UDim2.new(0, 300, 1, 0)
healthBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

healthText.Position = UDim2.new(0, 0, 0, 0)
healthText.Size = UDim2.new(1, 0, 1, 0)
healthText.Text = "100"
healthText.TextColor3 = Color3.fromRGB(255, 255, 255)
healthText.TextSize = 24
healthText.TextWrapped = true
healthText.TextXAlignment = Enum.TextXAlignment.Left
healthText.TextYAlignment = Enum.TextYAlignment.Center

-- Update the health bar fill and text whenever the humanoid's health changes
humanoid.HealthChanged:Connect(function(newHealth, oldHealth)
    local healthPercent = newHealth / humanoid.MaxHealth
    healthBarFill.Size = UDim2.new(healthPercent, 0, 1, 0)
    healthText.Text = string.format("%d", math.floor(newHealth))
end)
