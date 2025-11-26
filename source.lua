-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Kaladoo2/KCSH/refs/heads/main/source.lua"))()
 
local pplayer = game.Players.LocalPlayer
local wplayer = workspace:WaitForChild(pplayer.Name)
local players = game:GetService("Players")

local a = Instance.new("ScreenGui")
a.ResetOnSpawn = true
a.Parent = pplayer.PlayerGui
a.Name = "KSCH"

task.wait(1)
local function maketext(parent, text, size, name)
	local b = Instance.new("TextLabel")
	b.Text = text
	b.Size = UDim2.new(1, 0, 0, 50)
	b.Name = name
	b.BackgroundTransparency = 1
	b.BorderSizePixel = 0
	b.TextSize = size
	b.Font = Enum.Font.BuilderSans
	b.RichText = true
	b.Parent = parent
end
local function makebutton(parent, text, name)
	local b = Instance.new("TextButton")
	b.Text = text
	b.Size = UDim2.new(0, 100, 0, 50)
	b.Name = name
	b.BackgroundTransparency = 0.5
	b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	b.BorderSizePixel = 0
	b.TextSize = 20
	b.Font = Enum.Font.BuilderSans
	b.RichText = true
	b.Parent = parent
	local c = Instance.new("UICorner")
	c.Parent = b
	c.CornerRadius = UDim.new(0, 15)
end

local d = Instance.new("Frame")
d.Position = UDim2.new(0.5, 0, 0.5, 0)
d.Size = UDim2.new(0, 300, 0, 312.5)
d.BorderSizePixel = 0
d.BackgroundTransparency = 0.5
d.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
d.Parent = a
local c = Instance.new("UICorner")
c.Parent = d
c.CornerRadius = UDim.new(0, 25)

local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local dragging = false
local dragStart
local startPos

d.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = d.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
uis.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		ts:Create(d, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		}):Play()
	end
end)

local e = Instance.new("UIPadding")
e.PaddingTop = UDim.new(0, 10)
e.PaddingBottom = UDim.new(0, 10)
e.PaddingLeft = UDim.new(0, 10)
e.PaddingRight = UDim.new(0, 10)
e.Parent = d

local f = Instance.new("ScrollingFrame")
f.Size = UDim2.new(1, 0, 1, 0)
f.BackgroundTransparency = 1
f.BorderSizePixel = 0
f.ScrollBarThickness = 0
f.AutomaticCanvasSize = Enum.AutomaticSize.Y
f.CanvasSize = UDim2.new(0, 0, 0, 0)
f.Parent = d
local c = Instance.new("UIListLayout")
c.Parent = f
c.Padding = UDim.new(0, 10)
c.Wraps = true
c.FillDirection = Enum.FillDirection.Horizontal
c.HorizontalFlex = Enum.UIFlexAlignment.Fill

maketext(f, "<b>kaladoos clientside hub</b>", 30,  "1")
makebutton(f, "float <font color='#a63131'><b>off</b></font>", "2")
local gamegrav = workspace.Gravity
local floating = false
f["2"].MouseButton1Click:Connect(function()
	if floating == false then
		workspace.Gravity = 0
		wplayer.Humanoid.PlatformStand = true
		f["2"].Text = "float <font color='#39a637'><b>on</b></font>"
		floating = true
	elseif floating == true then
		workspace.Gravity = gamegrav
		wplayer.Humanoid.PlatformStand = false
		f["2"].Text = "float <font color='#a63131'><b>off</b></font>"
		floating = false
	end
end)

makebutton(f, "sit <font color='#a63131'><b>off</b></font>", "3")
local sitting = false
f["3"].MouseButton1Click:Connect(function()
	if sitting == false then
		wplayer.Humanoid.Sit = true
		f["3"].Text = "sit <font color='#39a637'><b>on</b></font>"
		sitting = true
	elseif sitting == true then
		wplayer.Humanoid.Sit = false
		f["3"].Text = "sit <font color='#a63131'><b>off</b></font>"
		sitting = false
	end
end)

makebutton(f, "fly <font color='#a63131'><b>off</b></font>", "4")
local humanoidRootPart = wplayer.HumanoidRootPart
local mouse = pplayer:GetMouse()
local flying = false
local speed = 200
local slowSpeed = 50
local acceleration = 2
local velocity = Vector3.new()
local bodyVelocity
local bodyGyro

f["4"].MouseButton1Click:Connect(function()
	flying = not flying
	wplayer.Humanoid.PlatformStand = flying

	if flying then
		bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
		bodyVelocity.Velocity = Vector3.new(0,0,0)
		bodyVelocity.Parent = humanoidRootPart

		bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(1e5,1e5,1e5)
		bodyGyro.CFrame = humanoidRootPart.CFrame
		bodyGyro.Parent = humanoidRootPart
		f["4"].Text = "fly <font color='#39a637'><b>on</b></font>"
	else
		if bodyVelocity then bodyVelocity:Destroy() end
		if bodyGyro then bodyGyro:Destroy() end
		velocity = Vector3.new()

		for _, part in pairs(wplayer:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
		f["4"].Text = "fly <font color='#a63131'><b>off</b></font>"
	end

	game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
		if flying and bodyVelocity and bodyGyro then
			local camCF = workspace.CurrentCamera.CFrame
			local UIS = game:GetService("UserInputService")
			local moveDirection = Vector3.new()

			if UIS:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + camCF.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - camCF.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - camCF.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + camCF.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.E) then moveDirection = moveDirection + Vector3.new(0,1,0) end
			if UIS:IsKeyDown(Enum.KeyCode.Q) then moveDirection = moveDirection - Vector3.new(0,1,0) end

			local currentSpeed = speed
			if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.RightShift) then
				currentSpeed = slowSpeed
			end

			if moveDirection.Magnitude > 0 then
				moveDirection = moveDirection.Unit * currentSpeed
				velocity = velocity:Lerp(moveDirection, acceleration * deltaTime)
			else
				velocity = velocity:Lerp(Vector3.new(0,0,0), acceleration * deltaTime)
			end

			bodyVelocity.Velocity = velocity
			bodyGyro.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + camCF.LookVector)

			for _, part in pairs(wplayer:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)
end)

makebutton(f, "walk <font color='#a63131'><b>off</b></font>", "5")
local walking = false

f["5"].MouseButton1Click:Connect(function()
	if not walking then
		walking = true
		f["5"].Text = "walk <font color='#39a637'><b>on</b></font>"
		wplayer.Humanoid.WalkSpeed = 6
	else
		walking = false
		f["5"].Text = "walk <font color='#a63131'><b>off</b></font>"
		wplayer.Humanoid.WalkSpeed = 16
	end
end)

--== EVERYTHING SHOULD BE ABOVE THIS ==--
maketext(f, "Player Teleports", 20, "98")
local g = Instance.new("Frame")
g.Name = "99"
g.Position = UDim2.new(0.5, 0, 0.5, 0)
g.Size = UDim2.new(1, 0, 0, 0)
g.AutomaticSize = Enum.AutomaticSize.Y
g.BorderSizePixel = 0
g.BackgroundTransparency = 1
g.Parent = f
local c = Instance.new("UIListLayout")
c.Parent = g
c.Padding = UDim.new(0, 10)
c.Wraps = true
c.FillDirection = Enum.FillDirection.Horizontal
c.HorizontalFlex = Enum.UIFlexAlignment.Fill

local function plrbtn(player)
	makebutton(g, tostring(player.Name), tostring(player.Name))
	local b = g:FindFirstChild(player.Name)
	task.wait(0.1)
	b.TextWrapped = true
	b.TextSize = 15
	b.MouseButton1Click:Connect(function()
		local trp = player.Character.HumanoidRootPart
		wplayer.HumanoidRootPart.CFrame = trp.CFrame
	end)
end
for _, player in pairs(players:GetPlayers()) do
	plrbtn(player)
	print(player.Name .. " added")
end
players.PlayerAdded:Connect(function(player)
	plrbtn(player)
	print(player.Name .. " added")
end)
players.PlayerRemoving:Connect(function(player)
	local b = g:FindFirstChild(player.Name)
	b:Destroy()
	print(player.Name .. " left")
end)
