local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- SUPER OPTIMIZATION
pcall(function()
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)
Lighting.GlobalShadows = false

-- --- GUI ---
local playerGui = player:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Texto único, pegado
local textLabel = Instance.new("TextLabel")
textLabel.AnchorPoint = Vector2.new(0.5,0.5)
textLabel.Position = UDim2.new(0.5,0,0.5,0)
textLabel.Size = UDim2.new(0.85,0,0.4,0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "OPTIMIZER"
textLabel.Font = Enum.Font.GothamBlack
textLabel.TextScaled = true
textLabel.TextSize = 100
textLabel.TextColor3 = Color3.fromRGB(255,255,255) -- blanco neon
textLabel.TextStrokeTransparency = 1 -- sin borde negro
textLabel.TextTransparency = 1
textLabel.Parent = gui

-- --- FADE-IN Y FADE-OUT ---
local fadeInTime = 2
local visibleTime = 1
local fadeOutTime = 2

-- Fade-in
local fadeIn = TweenService:Create(textLabel, TweenInfo.new(fadeInTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
	TextTransparency = 0,
})
fadeIn:Play()

fadeIn.Completed:Connect(function()
	task.wait(visibleTime)
	-- Fade-out
	local fadeOut = TweenService:Create(textLabel, TweenInfo.new(fadeOutTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		TextTransparency = 1,
	})
	fadeOut:Play()
	fadeOut.Completed:Connect(function()
		pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
		Lighting.GlobalShadows = true
		gui:Destroy()
		print("✨ SEMEN OPTIMIZER neon completo")
	end)
end)

-- --- MOVIMIENTO TIPO OLAS DE TODA LA PALABRA ---
local t = 0
RunService.RenderStepped:Connect(function(delta)
	t = t + delta
	if textLabel.Parent then
		-- Movimiento vertical tipo ola
		local yOffset = math.sin(t*2*math.pi) * 8 -- ±8 pixels
		textLabel.Position = UDim2.new(0.5,0,0.5 + yOffset/600,0)

		-- Pulso sutil de tamaño
		local scale = 1 + math.sin(t*2*math.pi)*0.03
		textLabel.Size = UDim2.new(0.85*scale,0,0.4*scale,0)
	end
end)

-- --- CARGA INMEDIATA AL ENTRAR ---
-- Esto hace que las letras aparezcan antes de que el Character exista
textLabel.TextTransparency = 0
pcall(function()
    game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()
end)
