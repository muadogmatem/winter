-- LocalScript / Executor: Ly Hoang Khang UI Pro (V2)
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "LyHoangKhangUI_V2"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- CẤU HÌNH MÀU GRADIENT CHUNG
local PurpleGradient = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 0, 80)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 50, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 0, 80))
}

-- FRAME CHÍNH (Size mặc định 200x20)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = gui
MainFrame.Size = UDim2.new(0, 200, 0, 20)
MainFrame.Position = UDim2.new(0.5, -100, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 6) -- Bo góc nhỏ hơn cho hợp với size 20

local MainGrad = Instance.new("UIGradient", MainFrame)
MainGrad.Color = PurpleGradient

-- CHỮ HIỂN THỊ (Căn chỉnh cho vừa size 20)
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Ly Hoang Khang"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true -- Tự động co giãn chữ theo khung

-----------------------------------------------------------
-- NÚT MŨI TÊN (CÓ GRADIENT & CÁCH XA KHUNG)
-----------------------------------------------------------
local ArrowBtn = Instance.new("TextButton")
ArrowBtn.Parent = MainFrame
ArrowBtn.Size = UDim2.new(0, 30, 0, 25)
ArrowBtn.Position = UDim2.new(0.5, -15, 0, -35) -- Cách xa khung 35 pixel lên phía trên
ArrowBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ArrowBtn.Text = "v"
ArrowBtn.TextColor3 = Color3.new(1, 1, 1)
ArrowBtn.Font = Enum.Font.GothamBold
ArrowBtn.TextSize = 18
ArrowBtn.AutoButtonColor = false
ArrowBtn.BorderSizePixel = 0

local ArrowCorner = Instance.new("UICorner", ArrowBtn)
ArrowCorner.CornerRadius = UDim.new(0, 8)

local ArrowGrad = Instance.new("UIGradient", ArrowBtn)
ArrowGrad.Color = PurpleGradient

-----------------------------------------------------------
-- KHUNG NHẬP SIZE
-----------------------------------------------------------
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Parent = MainFrame
SettingsFrame.Size = UDim2.new(1, 40, 0, 40)
SettingsFrame.Position = UDim2.new(0, -20, 1, 10)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SettingsFrame.BackgroundTransparency = 0.3
SettingsFrame.Visible = false

Instance.new("UICorner", SettingsFrame).CornerRadius = UDim.new(0, 8)

-- Ô nhập Width
local InputW = Instance.new("TextBox")
InputW.Parent = SettingsFrame
InputW.Size = UDim2.new(0.4, 0, 0.6, 0)
InputW.Position = UDim2.new(0.07, 0, 0.2, 0)
InputW.PlaceholderText = "W (200)"
InputW.Text = ""
InputW.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InputW.TextColor3 = Color3.new(1, 1, 1)
InputW.Font = Enum.Font.Gotham
InputW.TextSize = 12
Instance.new("UICorner", InputW)

-- Ô nhập Height
local InputH = Instance.new("TextBox")
InputH.Parent = SettingsFrame
InputH.Size = UDim2.new(0.4, 0, 0.6, 0)
InputH.Position = UDim2.new(0.53, 0, 0.2, 0)
InputH.PlaceholderText = "H (20)"
InputH.Text = ""
InputH.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InputH.TextColor3 = Color3.new(1, 1, 1)
InputH.Font = Enum.Font.Gotham
InputH.TextSize = 12
Instance.new("UICorner", InputH)

-----------------------------------------------------------
-- LOGIC ĐÓNG MỞ & UPDATE SIZE
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
	
	-- Giới hạn tối thiểu để không bị mất khung
	w = math.clamp(w, 50, 800)
	h = math.clamp(h, 15, 500)
	
	TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, w, 0, h)}):Play()
end

InputW.FocusLost:Connect(UpdateSize)
InputH.FocusLost:Connect(UpdateSize)

-----------------------------------------------------------
-- HIỆU ỨNG GRADIENT DI CHUYỂN
-----------------------------------------------------------
task.spawn(function()
	local offset = 0
	while true do
		offset = offset + 0.025
		if offset > 1.5 then offset = -1.5 end
		
		-- Di chuyển gradient của khung và nút mũi tên
		MainGrad.Offset = Vector2.new(offset, 0)
		ArrowGrad.Offset = Vector2.new(offset, 0)
		
		task.wait(0.03)
	end
end)
