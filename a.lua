-- LocalScript / Executor: Ly Hoang Khang UI
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "LyHoangKhangUI_Final"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- GRADIENT MÀU TÍM CHUNG
local PurpleGradient = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 110)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 60, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 0, 110))
}

-- KHUNG CHÍNH (QUAY LẠI SIZE ĐẸP 280x70)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = gui
MainFrame.Size = UDim2.new(0, 280, 0, 70)
MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 15)

local MainGrad = Instance.new("UIGradient", MainFrame)
MainGrad.Color = PurpleGradient
MainGrad.Rotation = 45

-- CHỮ HIỂN THỊ
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Ly Hoang Khang"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 24

-----------------------------------------------------------
-- NÚT MŨI TÊN (CÓ GRADIENT & CÁCH XA KHUNG)
-----------------------------------------------------------
local ArrowBtn = Instance.new("TextButton")
ArrowBtn.Parent = MainFrame
ArrowBtn.Size = UDim2.new(0, 35, 0, 30)
ArrowBtn.Position = UDim2.new(0.5, -17, 0, -45) -- Cách xa khung 45 pixel lên trên
ArrowBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ArrowBtn.Text = "v"
ArrowBtn.TextColor3 = Color3.new(1, 1, 1)
ArrowBtn.Font = Enum.Font.GothamBold
ArrowBtn.TextSize = 20
ArrowBtn.AutoButtonColor = false
ArrowBtn.BorderSizePixel = 0

local ArrowCorner = Instance.new("UICorner", ArrowBtn)
ArrowCorner.CornerRadius = UDim.new(0, 8)

local ArrowGrad = Instance.new("UIGradient", ArrowBtn)
ArrowGrad.Color = PurpleGradient

-----------------------------------------------------------
-- KHUNG NHẬP SIZE (ẨN/HIỆN)
-----------------------------------------------------------
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Parent = MainFrame
SettingsFrame.Size = UDim2.new(1, 0, 0, 45)
SettingsFrame.Position = UDim2.new(0, 0, 1, 12)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SettingsFrame.BackgroundTransparency = 0.3
SettingsFrame.Visible = false

Instance.new("UICorner", SettingsFrame).CornerRadius = UDim.new(0, 10)

-- Ô nhập Width
local InputW = Instance.new("TextBox")
InputW.Parent = SettingsFrame
InputW.Size = UDim2.new(0.4, 0, 0.7, 0)
InputW.Position = UDim2.new(0.07, 0, 0.15, 0)
InputW.PlaceholderText = "W (280)"
InputW.Text = ""
InputW.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputW.TextColor3 = Color3.new(1, 1, 1)
InputW.Font = Enum.Font.Gotham
InputW.TextSize = 14
Instance.new("UICorner", InputW)

-- Ô nhập Height
local InputH = Instance.new("TextBox")
InputH.Parent = SettingsFrame
InputH.Size = UDim2.new(0.4, 0, 0.7, 0)
InputH.Position = UDim2.new(0.53, 0, 0.15, 0)
InputH.PlaceholderText = "H (70)"
InputH.Text = ""
InputH.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputH.TextColor3 = Color3.new(1, 1, 1)
InputH.Font = Enum.Font.Gotham
InputH.TextSize = 14
Instance.new("UICorner", InputH)

-----------------------------------------------------------
-- LOGIC ĐÓNG MỞ & CẬP NHẬT SIZE
-----------------------------------------------------------
local isOpen = false
ArrowBtn.MouseButton1Click:Connect(function()
	isOpen = not isOpen
	SettingsFrame.Visible = isOpen
	ArrowBtn.Text = isOpen and "^" or "v"
end)

local function UpdateSize()
	local w = tonumber(InputW.Text) or MainFrame.Size.X.Offset
	local h = tonumber(InputH.Text) or MainFrame.Size.Y.Offset
	
	-- Giới hạn size để không bị lỗi
	w = math.clamp(w, 50, 1000)
	h = math.clamp(h, 20, 800)
	
	TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, w, 0, h)}):Play()
end

InputW.FocusLost:Connect(UpdateSize)
InputH.FocusLost:Connect(UpdateSize)

-----------------------------------------------------------
-- VÒNG LẶP GRADIENT DI CHUYỂN
-----------------------------------------------------------
task.spawn(function()
	local offset = 0
	while true do
		offset = offset + 0.02
		if offset > 1.5 then offset = -1.5 end
		
		MainGrad.Offset = Vector2.new(offset, 0)
		ArrowGrad.Offset = Vector2.new(offset, 0)
		
		task.wait(0.02)
	end
end)
