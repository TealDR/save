script.Name = "Redacted"
script.Parent = game.StarterPlayer:FindFirstChild("StarterPlayerScripts")

local player = game:GetService("Players").LocalPlayer
local character = player.Character
local mouse = player:GetMouse()


local tweens = game:GetService("TweenService")

local disabled = false

local camera = game.Workspace.CurrentCamera
local viewing = false

local speed = 4

local bool1 = false
local startnum1 = 1
local num1 = startnum1
local num1b = speed / 10

local bool2 = false
local startnum2 = 1
local num2 = startnum1
local num2b = speed / 10

local bool3 = false
local startnum3 = 1
local num3 = startnum1
local num3b = speed / 10

local UIS = game:GetService("UserInputService")


game.StarterGui.ResetPlayerGuiOnSpawn = false
local SGUI = Instance.new("ScreenGui")
SGUI.Name = "ScriptGUI"
SGUI.Parent = player.PlayerGui

local speedDisplay = Instance.new("TextLabel")
speedDisplay.Size = UDim2.new(0.2, 0, 0.1, 0)
speedDisplay.Position = UDim2.new(0.8, 0, 0.85, 0)
speedDisplay.Text = "" .. speed
speedDisplay.Visible = true
speedDisplay.Parent = SGUI

local speedUp = Instance.new("TextButton")
speedUp.Size = UDim2.new(0.1, 0, 0.05, 0)
speedUp.Position = UDim2.new(0.8, 0, 0.95, 0)
speedUp.Text = "+"
speedUp.Visible = true
speedUp.Parent = SGUI

local speedDown = speedUp:Clone()
speedDown.Position = UDim2.new(0.9, 0, 0.95, 0)
speedDown.Text = "-"
speedDown.Visible = true
speedDown.Parent = SGUI

UIS.InputBegan:Connect(function(key, chatting)
	if (disabled) then
		while (disabled) do
			wait(1)
		end
	end

	if (chatting == false) then
		if (not game.StarterPlayer:FindFirstChild("StarterPlayerScripts"):FindFirstChild("Client")) then
			if (key.KeyCode == Enum.KeyCode.T) then
				if (mouse.Target ~= nil) then
					character:MoveTo(mouse.Hit.Position + Vector3.new(0, 3.3, 0))
				end
			end


			if (key.KeyCode == Enum.KeyCode.Y) then
				if (mouse.Target ~= nil) then
					mouse.Target.CanCollide = not mouse.Target.CanCollide
				end
			end
		end


		if (key.KeyCode == Enum.KeyCode.KeypadOne) then --Sus
			character = game.Workspace.The_shadow101101
			local humanoid = character.Humanoid
			local target = mouse.Target

			bool1 = not bool1
			
            if (mouse.Target == nil) then
                return
            end

			while (target.Parent ~= workspace) do
				target = target.Parent
			end
            if (not target:FindFirstChild("HumanoidRootPart")) then
                return
            end
			delay(0, function()
				if (bool1) then
					local cframe = character.HumanoidRootPart.CFrame
				end
				local vf = Instance.new("VectorForce")
				vf.Force = Vector3.new(0, getMass(character) * workspace.Gravity, 0)
				vf.ApplyAtCenterOfMass = true
				--vf.RelativeTo = Enum.ActuatorRelativeTo.World
				local attachment = Instance.new("Attachment")
				attachment.Parent = character.HumanoidRootPart
				vf.Attachment0 = attachment
				vf.Parent = character
				vf.Name = "vf"
				vf.Enabled = true
				local bool1b = true
				while (bool1b) do
					if (bool1) then
						setCharCollision(character, false)
						humanoid:SetStateEnabled("Freefall", false)
						humanoid:SetStateEnabled("Flying", true)
						if (target:FindFirstChild("LowerTorso")) then --If r15
							if (character:FindFirstChild("LowerTorso")) then
								character:MoveTo(target:FindFirstChild("LowerTorso").Position + Vector3.new(0, 0.90, 0))
							else
								character:MoveTo(target:FindFirstChild("LowerTorso").Position + Vector3.new(0, 2.1, 0))
							end
						else
							if (character:FindFirstChild("LowerTorso")) then --If r15
								character:MoveTo(target:FindFirstChild("HumanoidRootPart").Position)
							else
								character:MoveTo(target:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0, 1.5, 0))
							end
						end
						character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.Position + target.HumanoidRootPart.CFrame.LookVector)
						character.HumanoidRootPart.CFrame *= CFrame.new(0, 0, num1)
						num1 += num1b
						if (num1 <= startnum1 or num1 >= startnum1 + 1) then
							num1b = -num1b
						end
					else
						humanoid:SetStateEnabled("Freefall", true)
						humanoid:SetStateEnabled("Flying", false)
						setCharCollision(character, true)
						anchorChar(character, false)
						if (character:FindFirstChild("vf")) then
							character:FindFirstChild("vf").Enabled = false
							character:FindFirstChild("vf").Name = "oldvf"
							character:FindFirstChild("oldvf"):Destroy()
						end
						if (cframe) then
							character.HumanoidRootPart.CFrame = cframe
						end
						bool1b = false
						return
					end
					
					wait(0)
				end
			end)
		end


		if (key.KeyCode == Enum.KeyCode.KeypadTwo) then --Sus
			character = game.Workspace.The_shadow101101
			local humanoid = character.Humanoid
			local target = mouse.Target

			bool2 = not bool2
			
            if (mouse.Target == nil) then
                return
            end

			while (target.Parent ~= workspace) do
				target = target.Parent
			end
            if (not target:FindFirstChild("HumanoidRootPart")) then
                return
            end
			delay(0, function()
				if (bool2) then
					local cframe = character.HumanoidRootPart.CFrame
				end
				local vf = Instance.new("VectorForce")
				vf.Force = Vector3.new(0, getMass(character) * workspace.Gravity, 0)
				vf.ApplyAtCenterOfMass = true
				--vf.RelativeTo = Enum.ActuatorRelativeTo.World
				local attachment = Instance.new("Attachment")
				attachment.Parent = character.HumanoidRootPart
				vf.Attachment0 = attachment
				vf.Parent = character
				vf.Name = "vf"
				vf.Enabled = true
				local bool2b = true
				while (bool2b) do
					if (bool2) then
						setCharCollision(character, false)
						humanoid:SetStateEnabled("Freefall", false)
						humanoid:SetStateEnabled("Flying", true)
						if (target:FindFirstChild("LowerTorso")) then --If r15
							if (character:FindFirstChild("LowerTorso")) then
								character:MoveTo(target:FindFirstChild("LowerTorso").Position + Vector3.new(0, 0.90, 0))
							else
								character:MoveTo(target:FindFirstChild("LowerTorso").Position + Vector3.new(0, 2.1, 0))
							end
						else
							if (character:FindFirstChild("LowerTorso")) then --If r15
								character:MoveTo(target:FindFirstChild("HumanoidRootPart").Position)
							else
								character:MoveTo(target:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0, 1.5, 0))
							end
						end
						character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.Position + target.HumanoidRootPart.CFrame.LookVector)
						character.HumanoidRootPart.CFrame *= CFrame.new(0, 0, num2 - 3)
						num2 += num2b
						if (num2 <= startnum2 or num2 >= startnum2 + 1) then
							num2b = -num2b
						end
					else
						humanoid:SetStateEnabled("Freefall", true)
						humanoid:SetStateEnabled("Flying", false)
						setCharCollision(character, true)
						anchorChar(character, false)
						if (character:FindFirstChild("vf")) then
							character:FindFirstChild("vf").Enabled = false
							character:FindFirstChild("vf").Name = "oldvf"
							character:FindFirstChild("oldvf"):Destroy()
						end
						if (cframe) then
							character.HumanoidRootPart.CFrame = cframe
						end
						bool2b = false
						return
					end
					
					wait(0)
				end
			end)
		end


		if (key.KeyCode == Enum.KeyCode.KeypadThree) then --Sus
			character = game.Workspace.The_shadow101101
			local humanoid = character.Humanoid
			local target = mouse.Target

			bool3 = not bool3
			
            if (mouse.Target == nil) then
                return
            end

			while (target.Parent ~= workspace) do
				target = target.Parent
			end
            if (not target:FindFirstChild("HumanoidRootPart")) then
                return
            end
			delay(0, function()
				if (bool3) then
					local cframe = character.HumanoidRootPart.CFrame
				end
				local vf = Instance.new("VectorForce")
				vf.Force = Vector3.new(0, getMass(character) * workspace.Gravity, 0)
				vf.ApplyAtCenterOfMass = true
				--vf.RelativeTo = Enum.ActuatorRelativeTo.World
				local attachment = Instance.new("Attachment")
				attachment.Parent = character.HumanoidRootPart
				vf.Attachment0 = attachment
				vf.Parent = character
				vf.Name = "vf"
				vf.Enabled = true
				local bool3b = true
				while (bool3b) do
					if (bool3) then
						setCharCollision(character, false)
						humanoid:SetStateEnabled("Freefall", false)
						humanoid:SetStateEnabled("Flying", true)
						if (target:FindFirstChild("LowerTorso")) then --If r15
							if (character:FindFirstChild("LowerTorso")) then --If r15
								character:MoveTo(target:FindFirstChild("LowerTorso").Position + Vector3.new(0, -1.5, 0))
							else
								character:MoveTo(target:FindFirstChild("LowerTorso").Position + Vector3.new(0, 0.2, 0))
							end
						else
							if (character:FindFirstChild("LowerTorso")) then --If r15
								character:MoveTo(target:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0, -2.4, 0))
							else
								character:MoveTo(target:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0, -0.8, 0))
							end
						end
						character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.Position + -target.HumanoidRootPart.CFrame.LookVector)
						character.HumanoidRootPart.CFrame *= CFrame.new(0, 0, num3)
						num3 += num3b
						if (num3 <= startnum2 or num3 >= startnum3 + 1) then
							num3b = -num3b
						end
					else
						humanoid:SetStateEnabled("Freefall", true)
						humanoid:SetStateEnabled("Flying", false)
						setCharCollision(character, true)
						anchorChar(character, false)
						if (character:FindFirstChild("vf")) then
							character:FindFirstChild("vf").Enabled = false
							character:FindFirstChild("vf").Name = "oldvf"
							character:FindFirstChild("oldvf"):Destroy()
						end
						if (cframe) then
							character.HumanoidRootPart.CFrame = cframe
						end
						bool3b = false
						return
					end
					
					wait(0)
				end
			end)
		end



		if (key.KeyCode == Enum.KeyCode.Minus) then
			print("Disabled Script")
			SGUI:Destroy()
			disabled = true
		end
	end
end)


function anchorChar(char, bool)
	for _,item in ipairs(char:GetDescendants()) do
    	if item:IsA("BasePart") then
    		item.Anchored = bool
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

speedUp.Activated:Connect(function()
	if (bool1) then
		repeat wait() until num1 < 1 + speed / 10
		speed = speed + 1
	end
	if (bool2) then
		repeat wait() until num2 < 1 + speed / 10
		speed = speed + 1
	end
	if (bool3) then
		repeat wait() until num3 < 1 + speed / 10
		speed = speed + 1
	end
	--[[if (not bool1 and not bool2) then
		speed = speed + 1
	end]]
	if (speed > 8) then speed = 8 end
	num1b = speed / 10
	num2b = speed / 10
	num3b = speed / 10
	speedDisplay.Text = tostring(speed)
end)

speedDown.Activated:Connect(function()
	if (bool1) then
		repeat wait() until num1 < 1 + speed / 10
		speed = speed - 1
	end
	if (bool2) then
		repeat wait() until num2 < 1 + speed / 10
		speed = speed - 1
	end
	if (bool3) then
		repeat wait() until num3 < 1 + speed / 10
		speed = speed - 1
	end
	--[[if (not bool1 and not bool2) then
		speed = speed - 1
	end]]
	if (speed < 1) then speed = 1 end
	num1b = speed / 10
	num2b = speed / 10
	num3b = speed / 10
	speedDisplay.Text = tostring(speed)
end)

function roundNum(num, to)
	local divided = num / to
    local rounded = to * math.floor(divided)
	return rounded
end