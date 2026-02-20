local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RainbowMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ================= LOGO =================
local logo = Instance.new("ImageButton")
logo.Parent = screenGui
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://80116220431239"
logo.Size = UDim2.new(0,90,0,90)
logo.AnchorPoint = Vector2.new(0.5,0.5)
logo.Position = UDim2.new(0.5,0,0.5,0)
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

task.wait(0.5)
TweenService:Create(
	logo,
	TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{Position = UDim2.new(0,70,1,-70)}
):Play()

-- ================= VÒNG RGB LOGO =================
local circle = Instance.new("Frame")
circle.Parent = screenGui
circle.Size = UDim2.new(0,110,0,110)
circle.AnchorPoint = Vector2.new(0.5,0.5)
circle.BackgroundTransparency = 1
Instance.new("UICorner", circle).CornerRadius = UDim.new(1,0)

local stroke = Instance.new("UIStroke", circle)
stroke.Thickness = 6

local hue = 0
RunService.RenderStepped:Connect(function()
	circle.Position = logo.Position
	hue += 0.005
	if hue > 1 then hue = 0 end
	stroke.Color = Color3.fromHSV(hue,1,1)
	circle.Rotation += 1
end)

-- ================= MENU =================
local main = Instance.new("Frame")
main.Parent = screenGui
main.Size = UDim2.new(0,450,0,300)
main.Position = UDim2.new(0.5,-225,0.5,-150)
main.BorderSizePixel = 0
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0,15)

local menuStroke = Instance.new("UIStroke", main)
menuStroke.Thickness = 2

local menuHue = 0
RunService.RenderStepped:Connect(function()
	menuHue += 0.003
	if menuHue > 1 then menuHue = 0 end
	main.BackgroundColor3 = Color3.fromHSV(menuHue,0.7,1)
	menuStroke.Color = Color3.fromHSV(menuHue,1,1)
end)

-- ================= DRAG =================
local dragging = false
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	main.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (
	input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch) then
		update(input)
	end
end)

-- ================= TEXTBOX =================
local scriptBox = Instance.new("TextBox")
scriptBox.Parent = main
scriptBox.Size = UDim2.new(1,-20,0.5,0)
scriptBox.Position = UDim2.new(0,10,0,10)
scriptBox.MultiLine = true
scriptBox.TextWrapped = true
scriptBox.ClearTextOnFocus = false
scriptBox.Text = "-- Script here"
scriptBox.TextColor3 = Color3.new(1,1,1)
scriptBox.BackgroundColor3 = Color3.fromRGB(0,0,0)
scriptBox.BorderSizePixel = 0
Instance.new("UICorner", scriptBox).CornerRadius = UDim.new(0,10)

-- ================= R6 =================
local r6Btn = Instance.new("TextButton")
r6Btn.Parent = main
r6Btn.Size = UDim2.new(0.3,0,0,35)
r6Btn.Position = UDim2.new(0.35,0,0.55,0)
r6Btn.Text = "R6"
r6Btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
r6Btn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", r6Btn).CornerRadius = UDim.new(0,10)

r6Btn.MouseButton1Click:Connect(function()
	local plr = Players.LocalPlayer
	local char = plr.Character or plr.CharacterAdded:Wait()
	if char:FindFirstChild("Humanoid")
	and char.Humanoid.RigType == Enum.HumanoidRigType.R15 then
		local desc = Players:GetHumanoidDescriptionFromUserId(plr.CharacterAppearanceId)
		local newChar = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R6)
		newChar.Name = plr.Name
		if newChar:FindFirstChild("HumanoidRootPart") then
			newChar.PrimaryPart = newChar.HumanoidRootPart
			newChar:SetPrimaryPartCFrame(char.HumanoidRootPart.CFrame)
		end
		char:Destroy()
		newChar.Parent = workspace
		plr.Character = newChar
		workspace.CurrentCamera.CameraSubject = newChar:WaitForChild("Humanoid")
	end
end)

-- ================= RAIN TACOS BUTTON =================
local rainBtn = Instance.new("TextButton")
rainBtn.Parent = main
rainBtn.Size = UDim2.new(0.3,0,0,35)
rainBtn.Position = UDim2.new(0.35,0,0.7,0)
rainBtn.Text = "Rain Tacos"
rainBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
rainBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", rainBtn).CornerRadius = UDim.new(0,10)

-- ================= BUTTON ROW =================
local exeBtn = Instance.new("TextButton")
exeBtn.Parent = main
exeBtn.Size = UDim2.new(0.32,-10,0,40)
exeBtn.Position = UDim2.new(0.02,0,1,-50)
exeBtn.Text = "Exe"
exeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
exeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", exeBtn).CornerRadius = UDim.new(0,10)

local reBtn = Instance.new("TextButton")
reBtn.Parent = main
reBtn.Size = UDim2.new(0.32,-10,0,40)
reBtn.Position = UDim2.new(0.34,0,1,-50)
reBtn.Text = "RE"
reBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
reBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", reBtn).CornerRadius = UDim.new(0,10)

local clearBtn = Instance.new("TextButton")
clearBtn.Parent = main
clearBtn.Size = UDim2.new(0.32,-10,0,40)
clearBtn.Position = UDim2.new(0.66,0,1,-50)
clearBtn.Text = "Clear"
clearBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
clearBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0,10)

exeBtn.MouseButton1Click:Connect(function()
	pcall(function()
		loadstring(scriptBox.Text)()
	end)
end)

reBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.Health = 0
	end
end)

clearBtn.MouseButton1Click:Connect(function()
	scriptBox.Text = ""
end)

-- ================= RAIN SYSTEM =================
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")

local MAP_SIZE = 800
local HEIGHT = 300
local TACO_SIZE = 50
local SPAWN_DELAY = 0.12

local tacoMeshId = "rbxassetid://14846869"
local tacoTextureId = "rbxassetid://14846834"
local musicId = "rbxassetid://142376088"

local raining = false
local sound

local function createTaco()
	local taco = Instance.new("Part")
	taco.Size = Vector3.new(10,10,10)
	taco.Position = Vector3.new(
		math.random(-MAP_SIZE, MAP_SIZE),
		HEIGHT,
		math.random(-MAP_SIZE, MAP_SIZE)
	)
	taco.Anchored = false
	taco.CanCollide = false
	taco.Material = Enum.Material.Neon
	taco.Color = Color3.fromHSV(math.random(),1,1)
	taco.Parent = workspace

	local mesh = Instance.new("SpecialMesh", taco)
	mesh.MeshType = Enum.MeshType.FileMesh
	mesh.MeshId = tacoMeshId
	mesh.TextureId = tacoTextureId
	mesh.Scale = Vector3.new(TACO_SIZE,TACO_SIZE,TACO_SIZE)

	taco.Velocity = Vector3.new(0,-60,0)

	taco.Touched:Connect(function()
		local explosion = Instance.new("Explosion")
		explosion.Position = taco.Position
		explosion.BlastRadius = 18
		explosion.BlastPressure = 0
		explosion.Parent = workspace
		taco:Destroy()
	end)

	Debris:AddItem(taco, 15)
end

local function rainLoop()
	while raining do
		createTaco()
		task.wait(SPAWN_DELAY)
	end
end

rainBtn.MouseButton1Click:Connect(function()
	raining = not raining
	if raining then
		rainBtn.Text = "Stop Rain"
		if not sound then
			sound = Instance.new("Sound")
			sound.SoundId = musicId
			sound.Volume = 3
			sound.Looped = true
			sound.RollOffMode = Enum.RollOffMode.Inverse
			sound.RollOffMaxDistance = 100000
			sound.Parent = SoundService
			sound:Play()
		end
		task.spawn(rainLoop)
	else
		rainBtn.Text = "Rain Tacos"
		if sound then
			sound:Stop()
			sound:Destroy()
			sound = nil
		end
	end
end)

-- ================= TOGGLE =================
logo.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
