script.Name = "Client"
script.Parent = game.StarterPlayer:FindFirstChild("StarterPlayerScripts")

local space = game.Workspace

local player = game:GetService("Players").LocalPlayer
local character = player.Character
local mouse = player:GetMouse()
local camera = space.CurrentCamera

local viewing = false

local players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")

local FullBrightEnabled = false
local NormalLightingSettings = {}
NormalLightingSettings.Brightness = lighting.Brightness
NormalLightingSettings.FogEnd = lighting.FogEnd
NormalLightingSettings.GlobalShadows = lighting.GlobalShadows
NormalLightingSettings.Ambient = lighting.Ambient

local godmode = false
local normhealth

local motor6ds = {}


local mobility = {}
mobility.speed = false
local baseSpeed = character.Humanoid.WalkSpeed
local speedMulti = 10 --0.05
mobility.jump = false
local baseJP = character.Humanoid.JumpPower
local baseJH = character.Humanoid.JumpHeight
local jumpMulti = 5 --0.005


local disabled = false

local menuCam = {}
menuCam.firstPerson = false
menuCam.oldMaxZoom = player.CameraMaxZoomDistance

local anchor = false

local flying = false
local flyingdir = {}
flyingdir.f = false
flyingdir.b = false
flyingdir.l = false
flyingdir.r = false
flyingdir.u = false
flyingdir.d = false

local swimming = false

local stand = false
local standnum = 0

local floating = false
local gravityMulti = 0 --0.01
local baseGrav = space.Gravity

local snap


local xray = false
local playerlist


local slow = false


game.StarterGui.ResetPlayerGuiOnSpawn = false

local SGUI = Instance.new("ScreenGui")
SGUI.Name = "ScriptGUI"
local Frame = Instance.new("Frame")
Frame.Parent = SGUI
local textLabel = Instance.new("TextLabel")
textLabel.Name = "TextLabel"
textLabel.Parent = Frame
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.Size = UDim2.new(0.8, 0, 0.8, 0)
textLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
textLabel.TextSize = 25
SGUI.Parent = player.PlayerGui
local Corner = Instance.new("UICorner")
Corner.Parent = Frame
Corner.CornerRadius = UDim.new(0.05, 0)

Frame.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
Frame.Size = UDim2.new(UDim.new(0.15, 0), UDim.new(0.3, 0))
Frame.Position = UDim2.new(0.85, 0, 0.7, 0)

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.25, 0, 0.1, 0)
speedInput.Position = UDim2.new(0.25, 0, 0.4, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextSize = 25
speedInput.Text = 10
speedInput.PlaceholderText = "Speed multiplier (Base is 10)"
speedInput.Visible = false
speedInput.Parent = SGUI
local jumpInput = speedInput:Clone()
jumpInput.Position = UDim2.new(0.5, 0, 0.4, 0)
jumpInput.Text = 5
jumpInput.PlaceholderText = "Jump multiplier (Base is 5)"
jumpInput.Parent = SGUI

local gravityInput = jumpInput:Clone()
gravityInput.Size = UDim2.new(0.5, 0, 0.1, 0)
gravityInput.Position = UDim2.new(0.25, 0, 0.5, 0)
gravityInput.Text = 0
gravityInput.PlaceholderText = "Gravity multiplier (Base is 0)"
gravityInput.Visible = false
gravityInput.Parent = SGUI

local teleInput = Instance.new("TextBox")
teleInput.Size = UDim2.new(0.35, 0, 0.1, 0)
teleInput.Position = UDim2.new(0.25, 0, 0.7, 0)
teleInput.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
teleInput.TextColor3 = Color3.fromRGB(255, 255, 255)
teleInput.TextSize = 25
teleInput.Text = ""
teleInput.PlaceholderText = "Enter a player name to teleport"
teleInput.Visible = false
teleInput.Parent = SGUI
local teleButton = Instance.new("TextButton")
teleButton.Size = UDim2.new(0.15, 0, 0.1, 0)
teleButton.Position = UDim2.new(0.6, 0, 0.7, 0)
teleButton.BackgroundColor3 = Color3.fromRGB(32, 33, 36)
teleButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
teleButton.BorderMode = Enum.BorderMode.Inset
teleButton.BorderSizePixel = 2
teleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleButton.TextSize = 40
teleButton.Text = "Teleport"
teleButton.Visible = false
teleButton.Parent = SGUI

local snapInput = gravityInput:Clone()
snapInput.Size = UDim2.new(0.35, 0, 0.1, 0)
snapInput.Position = UDim2.new(0.25, 0, 0.6, 0)
snapInput.Text = 2
snapInput.PlaceholderText = "Building Snap Input (Base is 2)"
snapInput.Visible = false
snapInput.Parent = SGUI
local snapTypeButton = teleButton:Clone()
snapTypeButton.Size = UDim2.new(0.15, 0, 0.1, 0)
snapTypeButton.Position = UDim2.new(0.6, 0, 0.6, 0)
snapTypeButton.Text = "Part"
snapTypeButton.Visible = false
snapTypeButton.Parent = SGUI

local toggleFullBright = teleButton:Clone()
toggleFullBright.Size = UDim2.new(0.5, 0, 0.1, 0)
toggleFullBright.Position = UDim2.new(0.25, 0, 0.8, 0)
toggleFullBright.Text = "Toggle FullBright"
teleButton.Visible = false
toggleFullBright.Parent = SGUI


player.CharacterAdded:Connect(function(char)
	char.Humanoid.RequiresNeck = false
end)

UIS.InputBegan:Connect(function(key, chatting)
	if (chatting == false) then
		if (disabled) then
			while (true) do
				wait(1)
			end
		end


		--[[]]if (key.KeyCode == Enum.KeyCode.T) then --Teleport
			character = player.Character
			if (mouse.Target ~= nil) then
				character:MoveTo(mouse.Hit.Position + Vector3.new(0, 3.3, 0))
			end
			if (mouse.Target == nil) then
				if (space:FindFirstChild("TempScriptTPPart", true)) then
					character:MoveTo(space:FindFirstChild("TempScriptTPPart", true).Position + Vector3.new(0, 3.3, 0))
				end
			end
		end


		if (key.KeyCode == Enum.KeyCode.Y) then --Inverse Part Collision
			if (mouse.Target ~= nil) then
				mouse.Target.CanCollide = not mouse.Target.CanCollide
			end
		end


		if (key.KeyCode == Enum.KeyCode.U) then --Inverse Part Anchor
			if (mouse.Target ~= nil) then
				mouse.Target.Anchored = not mouse.Target.Anchored
			end
		end


		if (key.KeyCode == Enum.KeyCode.N) then--Glass Bridge
			for key, thing in ipairs(space:GetDescendants()) do
    			if (thing:FindFirstChild("GlassBreak")) then
					if (thing:FindFirstChild("TouchInterest")) then
						thing:Destroy()
					end
				end
			end
		end


		if (key.KeyCode == Enum.KeyCode.Z) then --Add Parts
			canQuery(character, true)
			if (mouse.Target ~= nil) then
				local type
				if (snapTypeButton.Text == "Truss") then
					type = "TrussPart"
				elseif (snapTypeButton.Text == "TP Part") then
					type = "Part"
				else
					type = snapTypeButton.Text
				end
				local mousePos = mouse.Hit.Position
				local position = Vector3.new(roundNum(mousePos.X, 1), roundNum(mousePos.Y, 1) + snap / 2, roundNum(mousePos.Z, 1))
				if (mouse.Target.Name == "TempScriptPart") then
					local oldsnap = snap
					if (type == "TrussPart") then
						snap = 2
					end
					if (mouse.TargetSurface == Enum.NormalId.Top) then
						position = mouse.target.Position + Vector3.new(0, oldsnap, 0)
					elseif (mouse.TargetSurface == Enum.NormalId.Bottom) then
						position = mouse.target.Position - Vector3.new(0, oldsnap, 0)
					elseif (mouse.TargetSurface == Enum.NormalId.Left) then
						position = mouse.target.Position - Vector3.new(snap, 0, 0)
					elseif (mouse.TargetSurface == Enum.NormalId.Right) then
						position = mouse.target.Position + Vector3.new(snap, 0, 0)
					elseif (mouse.TargetSurface == Enum.NormalId.Front) then
						position = mouse.target.Position - Vector3.new(0, 0, snap)
					elseif (mouse.TargetSurface == Enum.NormalId.Back) then
						position = mouse.target.Position + Vector3.new(0, 0, snap)
					end
					snap = oldsnap
				end
				local part = Instance.new(type)
				if (snapTypeButton.Text == "TP Part") then
					part.Name = "TempScriptTPPart"
					part.Material = Enum.Material.Neon
					part.BrickColor = BrickColor.new("Lilac")
				else
					part.Name = "TempScriptPart"
				end
				part.Size = Vector3.new(snap, snap, snap)
				if (type == "TrussPart") then
					part.Size = Vector3.new(2, snap, 2)
				end
				part.Position = position
				if (type == "TrussPart") then
					--part.Position -= Vector3.new(0, snap / 2, 0)
				end
				local studAnchored = false
				part.Anchored = studAnchored
				part.Parent = mouse.Target
				local weld = Instance.new("WeldConstraint")
				weld.Name = "TempScriptWeld"
				weld.Part0 = part
				weld.Part1 = mouse.Target
				weld.Parent = part
			end
			canQuery(character, false)
		end


		if (key.KeyCode == Enum.KeyCode.X) then --Delete Parts
			if (mouse.Target ~= nil) then
				local target = mouse.Target
				if (not string.find(mouse.Target.Name, "TempScript")) then
					local clone = mouse.Target:Clone()
					local parent = mouse.Target.Parent
					local pos = mouse.Target.Position
					clone.Parent = game:GetService("ReplicatedStorage")
					delay(2, function()
						clone.Parent = parent
					end)
				else
					for _,item in ipairs(mouse.Target:GetDescendants()) do
    					if (target.Parent) then
							item.Parent = target.Parent
						else
							item.Parent = space
						end
					end
				end
				target:Destroy()
			end
		end


		--[[if (key.KeyCode == Enum.KeyCode.Q) then
			character = player.Character
			if (character:FindFirstChild("Torso")) then
				if (character:FindFirstChild("Torso"):FindFirstChild("Left Shoulder")) then
					character.Humanoid.RequiresNeck = false
					local neck = character:FindFirstChild("Torso"):FindFirstChild("Neck")
					motor6ds.neck = neck:Clone()
					local leftArm = character:FindFirstChild("Torso"):FindFirstChild("Left Shoulder")
					motor6ds.larm = leftArm:Clone()
					local rightArm = character:FindFirstChild("Torso"):FindFirstChild("Right Shoulder")
					motor6ds.rarm = rightArm:Clone()
					local leftLeg = character:FindFirstChild("Torso"):FindFirstChild("Left Hip")
					motor6ds.lleg = leftLeg:Clone()
					local rightLeg = character:FindFirstChild("Torso"):FindFirstChild("Right Hip")
					motor6ds.rleg = rightLeg:Clone()
					delay(0, function()
						--cpart(neck.Part1)
						--neck:Destroy()

						cpart(leftArm.Part1)
						leftArm:Destroy()
						cpart(rightArm.Part1)
						rightArm:Destroy()

						cpart(leftLeg.Part1)
						leftLeg:Destroy()
						cpart(rightLeg.Part1)
						rightLeg:Destroy()
					end)
				else
					if (not character:FindFirstChild("Torso"):FindFirstChild("Neck")) then
						motor6ds.neck.Parent = character:FindFirstChild("Torso")
						motor6ds.neck.Enabled = true
						motor6ds.neck.Part0 = character:FindFirstChild("Torso")
						motor6ds.neck.Part1 = character:FindFirstChild("Head")
					end
					if (not character:FindFirstChild("Torso"):FindFirstChild("Left Shoulder")) then
						motor6ds.larm.Parent = character:FindFirstChild("Torso")
						motor6ds.larm.Enabled = true
						motor6ds.larm.Part0 = character:FindFirstChild("Torso")
						motor6ds.larm.Part1 = character:FindFirstChild("Left Arm")
					end
					if (not character:FindFirstChild("Torso"):FindFirstChild("Right Shoulder")) then
						motor6ds.rarm.Parent = character:FindFirstChild("Torso")
						motor6ds.rarm.Enabled = true
						motor6ds.rarm.Part0 = character:FindFirstChild("Torso")
						motor6ds.rarm.Part1 = character:FindFirstChild("Right Arm")
					end
					if (not character:FindFirstChild("Torso"):FindFirstChild("Left Hip")) then
						motor6ds.lleg.Parent = character:FindFirstChild("Torso")
						motor6ds.lleg.Enabled = true
						motor6ds.lleg.Part0 = character:FindFirstChild("Torso")
						motor6ds.lleg.Part1 = character:FindFirstChild("Left Leg")
					end
					if (not character:FindFirstChild("Torso"):FindFirstChild("Right Hip")) then
						motor6ds.rleg.Parent = character:FindFirstChild("Torso")
						motor6ds.rleg.Enabled = true
						motor6ds.rleg.Part0 = character:FindFirstChild("Torso")
						motor6ds.rleg.Part1 = character:FindFirstChild("Right Leg")
					end
				end
			end
		end]]


		if (key.KeyCode == Enum.KeyCode.G) then --God Mode
			character = player.Character
			local humanoid = character.Humanoid
			if (godmode) then
				--humanoid.HealthChanged:Disconnect()


				humanoid.MaxHealth = normhealth
				humanoid.Health = normhealth

				humanoid.BreakJointsOnDeath = true

				godmode = false
				print("Godmode Disabled")
			else
				normhealth = humanoid.MaxHealth

				humanoid.HealthChanged:Connect(function()
					if (humanoid.MaxHealth ~= 999999999999999 or humanoid.Health ~= 999999999999999) then
					humanoid.Health = 999999999999999
					humanoid.MaxHealth = 999999999999999
					humanoid.Health = humanoid.MaxHealth
					end
				end)
				
				humanoid.BreakJointsOnDeath = false
				humanoid.Died:Connect(function()
					--humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead,false)
					humanoid.Health = humanoid.MaxHealth
				end)

				humanoid.MaxHealth = 999999999999999
				humanoid.Health = humanoid.MaxHealth
				godmode = true
				print("Godmode Enabled")
			end
		end


		if (key.KeyCode == Enum.KeyCode.V) then --Speed
			character = player.Character
			mobility.speed = not mobility.speed
		end

		if (key.KeyCode == Enum.KeyCode.B) then --Jump
			character = player.Character
			mobility.jump = not mobility.jump
		end

		if (key.KeyCode == Enum.KeyCode.L) then --Anchor
			character = player.Character
			local humanoid = character.Humanoid
			anchor = not anchor
			anchorChar(character, anchor)
		end


		if (key.KeyCode == Enum.KeyCode.J) then --Stand Ability
			character = player.Character
			local humanoid = character.Humanoid
			local target = mouse.Target

            if (mouse.Target == nil and stand == true) then
                stand = false
                return
            end
            if (mouse.Target == nil) then
                return
            end

			while (target.Parent ~= space) do
				target = target.Parent
			end
            if (not target:FindFirstChild("HumanoidRootPart")) then
                if (stand == true) then
                    stand = false
                end
                return
            end
			if (stand == false) then
				print("You are now " .. target.Name .. "'s Stand")
			end
            stand = not stand
			delay(0, function()
				local bool = true
				while (bool) do
					if (stand) then
						if (disabled) then return end
						humanoid:SetStateEnabled("Freefall", false)
						humanoid:SetStateEnabled("Flying", true)
						space.Gravity = 0
						character:MoveTo(target.HumanoidRootPart.Position)
						character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.Position + target.HumanoidRootPart.CFrame.LookVector)
                        if (character:FindFirstChild("UpperTorso")) then--If R15
						    character.HumanoidRootPart.CFrame *= CFrame.new(-2, 1.5, 3)
                        else
                            character.HumanoidRootPart.CFrame *= CFrame.new(-2, 2.5, 3)
                        end
					else
						humanoid:SetStateEnabled("Freefall", true)
						humanoid:SetStateEnabled("Flying", false)
						space.Gravity = baseGrav
						anchorChar(character, false)
						bool = false
						break
					end
					wait(0)
				end
			end)
		end

		if (key.KeyCode == Enum.KeyCode.Semicolon) then
			FullBrightEnabled = not FullBrightEnabled
		end
		if (key.KeyCode == Enum.KeyCode.Quote) then
			saveinstace(game)
		end

		--[[if (key.KeyCode == Enum.KeyCode.C) then --Camera
			character = player.Character
			if (mouse.Target ~= nil) then
				viewing = not viewing
				if (viewing) then
					camera.CameraSubject = mouse.Target
				else
					camera.CameraType = Enum.CameraType.Custom
					camera.CameraSubject = character.Humanoid
				end
			end
            if (mouse.Target == nil) then
                if (viewing == true) then
                    viewing = false
                    camera.CameraType = Enum.CameraType.Custom
					camera.CameraSubject = character.Humanoid
                end
            end
		end]]


		if (key.KeyCode == Enum.KeyCode.K) then --xray
			xray = not xray
			playerlist = players:GetPlayers()
			if (xray) then
				playerlist = players:GetPlayers()
				for _,curplayer in ipairs(playerlist) do
    				togglePlayerHighlight(curplayer.Character, true)
				end
			else
				playerlist = players:GetPlayers()
				for _,curplayer in ipairs(playerlist) do
    				togglePlayerHighlight(curplayer.Character, false)
				end
			end
		end


		if (key.KeyCode == Enum.KeyCode.P) then --Floating
			floating = not floating
			if (floating) then
				space.Gravity = baseGrav * gravityMulti
			else
				space.Gravity = baseGrav
			end
		end

		if (key.KeyCode == Enum.KeyCode.F) then --Flying
			character = player.Character
			local humanoid = character.Humanoid
			flying = not flying
			if (flying == true) then
				local bv = Instance.new("BodyVelocity", character.HumanoidRootPart)
				bv.MaxForce = Vector3.new(50000, 50000, 50000)
				local bg = Instance.new("BodyGyro", character.HumanoidRootPart)
				bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
				humanoid:ChangeState(Enum.HumanoidStateType.Freefall, false)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
				humanoid:ChangeState(Enum.HumanoidStateType.Flying)
				setCharCollision(character, false)
				delay(0, function()
					while (flying) do
						humanoid:ChangeState(Enum.HumanoidStateType.Flying)
						--humanoid.PlatformStand = true
						bg.CFrame = camera.CFrame
						character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.Position + camera.CFrame.LookVector)
						if (flyingdir.f == true) then
							bv.Velocity = camera.CFrame.LookVector * 65
						end
						if (flyingdir.b == true) then
							bv.Velocity = camera.CFrame.LookVector * -65
						end
						--[[if (flyingdir.u == true) then
							character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
						end
						if (flyingdir.d == true) then
							character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0)
						end]]
						
						local falsevariables = 0
						for i, variable in pairs(flyingdir) do
							if (variable == false) then
								falsevariables += 1
							end
						end
						if (falsevariables == 6) then
							bv.Velocity = Vector3.new(0, 0, 0)
						end
						wait(0)
					end
					setCharCollision(character, true)
					humanoid.PlatformStand = false
					space.Gravity = baseGrav
				end)
				
			else
				if (character.HumanoidRootPart:FindFirstChild("BodyVelocity")) then
					character.HumanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
				end
				if (character.HumanoidRootPart:FindFirstChild("BodyGyro")) then
					character.HumanoidRootPart:FindFirstChild("BodyGyro"):Destroy()
				end
				humanoid:SetStateEnabled("Freefall", true)
				humanoid:SetStateEnabled("Flying", false)
			end
		end

		if (flying) then
			if (key.KeyCode == Enum.KeyCode.W) then
				flyingdir.f = true
			end
			if (key.KeyCode == Enum.KeyCode.S) then
				flyingdir.b = true
			end
			if (key.KeyCode == Enum.KeyCode.A) then
				flyingdir.l = true
			end
			if (key.KeyCode == Enum.KeyCode.D) then
				flyingdir.r = true
			end
			if (key.KeyCode == Enum.KeyCode.Space) then
				flyingdir.u = true
			end
			if (key.KeyCode == Enum.KeyCode.LeftControl) then
				flyingdir.d = true
			end
		end


		if (key.KeyCode == Enum.KeyCode.H) then --Swimming
			character = player.Character
			local humanoid = character.Humanoid
			swimming = not swimming
			if (swimming) then
				humanoid:SetStateEnabled("GettingUp", false)
				humanoid:SetStateEnabled("Freefall", true)
				humanoid:ChangeState("Swimming")
			else
				humanoid:SetStateEnabled("GettingUp", true)
				humanoid:SetStateEnabled("Freefall", true)
			end
		end



		
		if (key.KeyCode == Enum.KeyCode.M) then
			toggleMenuVisibility()
		end


		if (key.KeyCode == Enum.KeyCode.Equals) then --Disable Script
			print("Disabled Script")
			if (player.PlayerGui:FindFirstChild("ScriptGUI")) then
				player.PlayerGui:FindFirstChild("ScriptGUI"):Destroy()
			end
			script.Name = "Disabled Client"
			disabled = true
		end
	end
end)

UIS.InputEnded:Connect(function(key)
	if (flying) then
		if (key.KeyCode == Enum.KeyCode.W) then
			flyingdir.f = false
		end
		if (key.KeyCode == Enum.KeyCode.S) then
			flyingdir.b = false
		end
		if (key.KeyCode == Enum.KeyCode.A) then
			flyingdir.l = false
		end
		if (key.KeyCode == Enum.KeyCode.D) then
			flyingdir.r = false
		end
		if (key.KeyCode == Enum.KeyCode.Space) then
			flyingdir.u = false
		end
		if (key.KeyCode == Enum.KeyCode.LeftControl) then
			flyingdir.d = false
		end
	end
end)

function toggleMenuVisibility()
	if (player.CameraMaxZoomDistance == 0) then
		player.CameraMaxZoomDistance = 10
	elseif (player.CameraMaxZoomDistance == 10 and menuCam.oldMaxZoom == 0) then
		player.CameraMaxZoomDistance = 0
	end
	if (player.CameraMode == Enum.CameraMode.LockFirstPerson) then
		menuCam.firstPerson = true
		player.CameraMode = Enum.CameraMode.Classic
	elseif (player.CameraMode == Enum.CameraMode.Classic and menuCam.firstPerson == true) then
		player.CameraMode = Enum.CameraMode.LockFirstPerson
	end
	teleInput.Visible = not teleInput.Visible
	teleButton.Visible = not teleButton.Visible
	speedInput.Visible = not speedInput.Visible
	jumpInput.Visible = not jumpInput.Visible
	gravityInput.Visible = not gravityInput.Visible
	toggleFullBright.Visible = not toggleFullBright.Visible
	snapInput.Visible = not snapInput.Visible
	snapTypeButton.Visible = not snapTypeButton.Visible
end

function setHealth(humanoid)
	humanoid.MaxHealth = 1/0
	humanoid.Health = humanoid.MaxHealth
end

function anchorChar(character, bool)
	for _,item in ipairs(character:GetDescendants()) do
    	if item:IsA("BasePart") then
    		item.Anchored = bool
    	end
	end
end

function canQuery(model, bool)
	for _,item in ipairs(character:GetDescendants()) do
    	if item:IsA("BasePart") then
    		item.CanQuery = bool
    	end
	end
end

function setCharCollision(char, bool)
	for _,item in ipairs(game.Workspace:GetDescendants()) do
		if (item:IsA("BasePart")) then
			item.CanCollide = bool
		end
	end
end

function togglePlayerHighlight(character, bool)
	if (bool) then
		local highlight = Instance.new("Highlight")
		highlight.Name = "ScriptHighlight"
		highlight.Adornee = character
		highlight.Enabled = true
		highlight.FillColor = Color3.fromRGB(175, 80, 255)
		highlight.FillTransparency = 0.5
		highlight.OutlineColor = Color3.new(140, 90, 190)
		highlight.OutlineTransparency = 0.1
		highlight.Parent = character
	else
		if (character:FindFirstChild("ScriptHighlight")) then
			character:FindFirstChild("ScriptHighlight").Enabled = false
			character:FindFirstChild("ScriptHighlight"):Destroy()
		end
	end
end

function getMass(model)
    assert(model and model:IsA("Model"), "Model argument of getMass must be a model.");
    local mass = 0;
    for i,v in pairs(model:GetDescendants()) do
        if(v:IsA("BasePart")) then
            mass += v.Mass;
        end
    end
    return mass;
end

teleButton.Activated:Connect(function()
	for _,item in ipairs(space:GetChildren()) do
    	if (string.lower(item.Name) == string.lower(teleInput.Text)) then
			if (item:FindFirstChild("HumanoidRootPart")) then
				character:MoveTo(item.HumanoidRootPart.Position)
			end
		end
	end
end)

snapTypeButton.Activated:Connect(function() --Snap Type
	if (snapTypeButton.Text == "Part") then
		snapTypeButton.Text = "Truss"
	elseif (snapTypeButton.Text == "Truss") then
		snapTypeButton.Text = "TP Part"
	elseif (snapTypeButton.Text == "TP Part") then
		snapTypeButton.Text = "Part"
	end
end)

toggleFullBright.Activated:Connect(function()
	FullBrightEnabled = not FullBrightEnabled
end)


delay(1, function()
	while (true) do
		if (disabled) then return end
		if (speedInput.Text ~= "") then
			speedMulti = tonumber(speedInput.Text)
		else
			speedMulti = 10
		end
		if (jumpInput.Text ~= "") then
			jumpMulti = tonumber(jumpInput.Text)
		else
			jumpMulti = 5
		end
		if (gravityInput.Text ~= "") then
			gravityMulti = tonumber(gravityInput.Text)
		else
			gravityMulti = 0
		end
		if (snapInput.Text ~= "") then
			if (tonumber(snapInput.Text) > 64) then
				snapInput.Text = "64"
			elseif (snapTypeButton.Text == "TP Part") then
				snapInput.Text = "1"
			end
			snap = tonumber(snapInput.Text)
		else
			snap = 2
		end
		Frame.TextLabel.Text =  "Swimming: " .. tostring(swimming) .. "\nSpeed: " .. tostring(mobility.speed) .. "\nJump: " .. tostring(mobility.jump) .. "\nGodmode: " .. tostring(godmode) .. "\nAnchored: " .. tostring(anchor) .. "\nGravity: " .. tostring(floating) .. "\nStand Mode: " .. tostring(stand)
		wait(1)
	end
end)

delay(1, function()
	while (true) do
		if (disabled) then
			return
		end
		if (FullBrightEnabled) then
			lighting.Brightness = 1
			lighting.FogEnd = 786543
			lighting.GlobalShadows = false
			lighting.Ambient = Color3.fromRGB(178, 178, 178)
		else
			lighting.Brightness = NormalLightingSettings.Brightness
			lighting.FogEnd = NormalLightingSettings.FogEnd
			lighting.GlobalShadows = NormalLightingSettings.GlobalShadows
			lighting.Ambient = NormalLightingSettings.Ambient
		end
		wait(5)
	end
end)

delay(0, function()
while (true) do
	if (not character.Humanoid) then return end
	if (mobility.speed) then
		character.Humanoid.WalkSpeed = baseSpeed * speedMulti
	else
		character.Humanoid.WalkSpeed = baseSpeed
	end
	if (mobility.jump) then
		character.Humanoid.JumpHeight = math.floor(baseJH * jumpMulti)
		character.Humanoid.JumpPower = math.floor(baseJP * jumpMulti)
	else
		character.Humanoid.JumpHeight = baseJH
		character.Humanoid.JumpPower = baseJP
	end
	wait(0.5)
end
end)

character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
	if (mobility.speed) then
		if (character.Humanoid.WalkSpeed ~= --[[math.floor]](baseSpeed * speedMulti)) then
			character.Humanoid.WalkSpeed = --[[math.floor]](baseSpeed * speedMulti)
		end
	end
end)
character.Humanoid:GetPropertyChangedSignal("JumpHeight"):Connect(function()
	if (mobility.jump) then
		if (character.Humanoid.JumpHeight ~= --[[math.floor]](baseJH * jumpMulti)) then
			character.Humanoid.JumpHeight = --[[math.floor]](baseJH * jumpMulti)
		end
	end
end)
character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
	if (mobility.jump) then
		if (character.Humanoid.JumpPower ~= math.floor(baseJP * jumpMulti)) then
			character.Humanoid.JumpPower = math.floor(baseJP * jumpMulti)
		end
	end
end)


function roundNum(num, to)
	local divided = num / to
    local rounded = to * math.floor(divided)
	return rounded
end

function cpart(p)
	local rp = Instance.new("Part")
	rp.Name = "colpart"
	rp.Size = p.Size/1.4
	rp.Massless = true 				
	rp.CFrame = p.CFrame 
	rp.Transparency = 1
	rp.Parent = p
	local wc = Instance.new("WeldConstraint",rp)
	wc.Part0 = rp 
	wc.Part1 = p 
end 


function slowMode()
	speedInput.Text = 0.05 --0.05
	jumpInput.Text = 0.005 --0.005
	gravityInput.Text = 0.01 --0.01
end

if (slow) then
	slowMode()
end