-- LocalScript / Executor: Ly Hoang Khang UI Pro
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "LyHoangKhangUI_Pro"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- FRAME CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = gui
MainFrame.Size = UDim2.new(0, 280, 0, 70)
MainFrame.Position = UDim2.new(0.5, -140, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = false
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép kéo thả

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 2
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke.Color = Color3.fromRGB(255, 255, 255)

-- GRADIENT CHO FRAME (DI CHUYỂN)
local MainGrad = Instance.new("UIGradient", MainFrame)
MainGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 0, 80)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 40, 200)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 0, 80))
}

local StrokeGrad = Instance.new("UIGradient", Stroke)
StrokeGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 100, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}

-- CHỮ HIỂN THỊ
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Ly Hoang Khang"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 25

-----------------------------------------------------------
-- KHUNG NHẬP SIZE (ẨN/HIỆN)
-----------------------------------------------------------
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Parent = MainFrame
SettingsFrame.Size = UDim2.new(1, 0, 0, 40)
SettingsFrame.Position = UDim2.new(0, 0, 1, 10) -- Nằm dưới frame chính
SettingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SettingsFrame.BackgroundTransparency = 0.2
SettingsFrame.Visible = false -- Mặc định ẩn

Instance.new("UICorner", SettingsFrame).CornerRadius = UDim.new(0, 8)

-- Ô nhập Width
local InputW = Instance.new("TextBox")
InputW.Parent = SettingsFrame
InputW.Size = UDim2.new(0.4, 0, 0.7, 0)
InputW.Position = UDim2.new(0.07, 0, 0.15, 0)
InputW.PlaceholderText = "Width (280)"
InputW.Text = ""
InputW.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InputW.TextColor3 = Color3.new(1, 1, 1)
InputW.Font = Enum.Font.Gotham
InputW.TextSize = 12
Instance.new("UICorner", InputW)

-- Ô nhập Height
local InputH = Instance.new("TextBox")
InputH.Parent = SettingsFrame
InputH.Size = UDim2.new(0.4, 0, 0.7, 0)
InputH.Position = UDim2.new(0.53, 0, 0.15, 0)
InputH.PlaceholderText = "Height (70)"
InputH.Text = ""
InputH.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InputH.TextColor3 = Color3.new(1, 1, 1)
InputH.Font = Enum.Font.Gotham
InputH.TextSize = 12
Instance.new("UICorner", InputH)

-----------------------------------------------------------
-- NÚT MŨI TÊN (TOGGLE)
-----------------------------------------------------------
local ArrowBtn = Instance.new("TextButton")
ArrowBtn.Parent = MainFrame
ArrowBtn.Size = UDim2.new(0, 25, 0, 25)
ArrowBtn.Position = UDim2.new(0.5, -12, 0, -20) -- Nằm trên cùng
ArrowBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ArrowBtn.Text = "v" -- Mũi tên xuống
ArrowBtn.TextColor3 = Color3.new(1, 1, 1)
ArrowBtn.Font = Enum.Font.GothamBold
ArrowBtn.AutoButtonColor = true
Instance.new("UICorner", ArrowBtn).CornerRadius = UDim.new(1, 0)

local isOpen = false
ArrowBtn.MouseButton1Click:Connect(function()
	isOpen = not isOpen
	SettingsFrame.Visible = isOpen
	ArrowBtn.Text = isOpen and "^" or "v"
end)

-----------------------------------------------------------
-- LOGIC XỬ LÝ SIZE
-----------------------------------------------------------
local function UpdateSize()
	local w = tonumber(InputW.Text) or MainFrame.Size.X.Offset
	local h = tonumber(InputH.Text) or MainFrame.Size.Y.Offset
	
	-- Giới hạn size không quá nhỏ hoặc quá to
	w = math.clamp(w, 100, 800)
	h = math.clamp(h, 40, 500)
	
	TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, w, 0, h)}):Play()
end

InputW.FocusLost:Connect(UpdateSize)
InputH.FocusLost:Connect(UpdateSize)

-----------------------------------------------------------
-- HIỆU ỨNG GRADIENT DI CHUYỂN (LOOP)
-----------------------------------------------------------
task.spawn(function()
	local offset = 0
	while true do
		offset = offset + 0.02
		if offset > 1 then offset = -1 end
		
		MainGrad.Offset = Vector2.new(offset, 0)
		StrokeGrad.Rotation = StrokeGrad.Rotation + 1
		
		task.wait(0.02)
	end
end)

-- Hiệu ứng nhỏ khi di chuột vào nút
ArrowBtn.MouseEnter:Connect(function()
	TweenService:Create(ArrowBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(150, 50, 255)}):Play()
end)
ArrowBtn.MouseLeave:Connect(function()
	TweenService:Create(ArrowBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
end)
