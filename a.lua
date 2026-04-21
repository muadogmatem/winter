-- LocalScript / Executor

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.Name = "LyHoangKhangUI"

-- ===== MAIN FRAME =====
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 320, 0, 80)
frame.Position = UDim2.new(0.5, -160, 0.15, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,20,40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,18)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(200,150,255)

-- ===== GRADIENT BACKGROUND =====
local grad = Instance.new("UIGradient", frame)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(90,0,140)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170,70,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(230,190,255))
}
grad.Rotation = 0

-- animation gradient
task.spawn(function()
	while true do
		grad.Rotation += 0.5
		task.wait(0.02)
	end
end)

-- ===== TITLE =====
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,-40,0,40)
title.Position = UDim2.new(0,20,0,10)
title.BackgroundTransparency = 1
title.Text = "Ly Hoang Khang"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

-- ===== TOGGLE BUTTON (>) =====
local toggle = Instance.new("TextButton")
toggle.Parent = frame
toggle.Size = UDim2.new(0,30,0,30)
toggle.Position = UDim2.new(1,-35,0,10)
toggle.Text = ">"
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true
toggle.BackgroundColor3 = Color3.fromRGB(120,60,200)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BorderSizePixel = 0

Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

-- ===== SIZE PANEL =====
local sizePanel = Instance.new("Frame")
sizePanel.Parent = frame
sizePanel.Size = UDim2.new(1,-20,0,0)
sizePanel.Position = UDim2.new(0,10,0,60)
sizePanel.BackgroundColor3 = Color3.fromRGB(60,30,100)
sizePanel.BorderSizePixel = 0
sizePanel.ClipsDescendants = true

Instance.new("UICorner", sizePanel).CornerRadius = UDim.new(0,12)

local panelGrad = Instance.new("UIGradient", sizePanel)
panelGrad.Color = grad.Color

-- ===== TEXTBOX INPUT =====
local sizeBox = Instance.new("TextBox")
sizeBox.Parent = sizePanel
sizeBox.Size = UDim2.new(1,-20,0,35)
sizeBox.Position = UDim2.new(0,10,0,10)
sizeBox.PlaceholderText = "Nhập size (vd: 350)"
sizeBox.Text = ""
sizeBox.Font = Enum.Font.Gotham
sizeBox.TextScaled = true
sizeBox.TextColor3 = Color3.new(1,1,1)
sizeBox.BackgroundColor3 = Color3.fromRGB(100,50,180)
sizeBox.BorderSizePixel = 0

Instance.new("UICorner", sizeBox).CornerRadius = UDim.new(0,10)

-- ===== TOGGLE LOGIC =====
local opened = false

toggle.MouseButton1Click:Connect(function()
	opened = not opened
	
	if opened then
		toggle.Text = "v"
		TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, frame.Size.X.Offset, 0, 140)}):Play()
		TweenService:Create(sizePanel, TweenInfo.new(0.3), {Size = UDim2.new(1,-20,0,60)}):Play()
	else
		toggle.Text = ">"
		TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, frame.Size.X.Offset, 0, 80)}):Play()
		TweenService:Create(sizePanel, TweenInfo.new(0.3), {Size = UDim2.new(1,-20,0,0)}):Play()
	end
end)

-- ===== SIZE INPUT LOGIC =====
sizeBox.FocusLost:Connect(function(enter)
	if enter then
		local number = tonumber(sizeBox.Text)
		if number then
			number = math.clamp(number, 220, 600)
			frame.Size = UDim2.new(0, number, 0, frame.Size.Y.Offset)
		end
	end
end)
