local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local balancePart = character:WaitForChild("BalancePart")

-- GUI text boxes for customizing balance handling
local balanceForceTextBox = script:WaitForChild("BalanceForceTextBox")
local balanceDampingTextBox = script:WaitForChild("BalanceDampingTextBox")
local balanceMaxVelocityTextBox = script:WaitForChild("BalanceMaxVelocityTextBox")
local gripStrengthTextBox = script:WaitForChild("GripStrengthTextBox")

-- Get values from GUI text boxes
local balanceForce = balanceForceTextBox.Text:GetNumber()
local balanceDamping = balanceDampingTextBox.Text:GetNumber()
local balanceMaxVelocity = balanceMaxVelocityTextBox.Text:GetNumber()
local gripStrength = gripStrengthTextBox.Text:GetNumber()
local crouchSpeedMultiplier = 0.5

local crouching = false
local gripping = false

-- Crouch animation
local crouchAnim = Instance.new("Animation")
crouchAnim.AnimationId = "rbxassetid://12345678"
local crouchTrack = humanoid:LoadAnimation(crouchAnim)

-- UI indicators
local gripIndicator = script:WaitForChild("GripIndicator")
local crouchIndicator = script:WaitForChild("CrouchIndicator")

-- Update balance based on current state and values from GUI text boxes
local function updateBalance(dt)
    if crouching then
        return
    end

    local velocity = balancePart.Velocity
    local force = -velocity * balanceForce
    if gripping then
        force = force * gripStrength
    end
    balancePart.Velocity = velocity * balanceDamping + force * dt
    balancePart.Velocity = balancePart.Velocity:Clamp(-balanceMaxVelocity, balanceMaxVelocity)
end

-- Toggle crouching state and update UI and animations
local function toggleCrouch()
    crouching = not crouching
    crouchIndicator.Visible = crouching
    humanoid.Sit = crouching
    humanoid.WalkSpeed = humanoid.WalkSpeed * (crouching and crouchSpeedMultiplier or 1/crouchSpeedMultiplier)
    if crouching then
        crouchTrack:Play()
    else
        crouchTrack:Stop()
    end
end

-- Toggle gripping state and update UI
local function toggleGrip()
    gripping = not gripping
    gripIndicator.Visible = gripping
end

-- Update balance every frame
local last
