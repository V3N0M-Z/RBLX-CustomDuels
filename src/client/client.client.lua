--Made by @V3N0M_Z
--Ref: https://github.com/V3N0M-Z/RBLX-CustomDuels

local core = require(game:GetService("ReplicatedStorage"):WaitForChild("core"))
local comm = core.ReplicatedStorage:WaitForChild("comm")
local currentEffect = "default"

local players = game:GetService("Players")
local client = players.LocalPlayer
local playerGui = client:WaitForChild("PlayerGui")

local interface = core:Get("UI")
interface.Parent = playerGui

local effectBox = interface.Frame.TextBox
local spawnDummy = interface.Frame.TextButton
local effectText = interface.Frame.TextLabel

for _, strV in ipairs(core.ReplicatedStorage:WaitForChild("InitialEffect"):GetChildren()) do
	if client.Name == strV.Name then
		currentEffect = core:GetEffect(string.lower(strV.Value)) and strV.Value or currentEffect
	end
end

effectBox.FocusLost:Connect(function()
	currentEffect = core:GetEffect(string.lower(effectBox.Text)) and effectBox.Text or currentEffect
	effectText.Text = "Current Effect: "..currentEffect
	comm:FireServer("SetEffect", currentEffect)
end)

effectText.Text = "Current Effect: "..currentEffect
comm:FireServer("SetEffect", currentEffect)

spawnDummy.MouseButton1Click:Connect(function()
	comm:FireServer("SpawnDummy")
end)

comm.OnClientEvent:Connect(function(msg, enemy, effect)
	if msg == "KillEffect" then
		
		local clone = enemy:Clone()
		clone.Parent = workspace
		clone:SetPrimaryPartCFrame(enemy.PrimaryPart.CFrame)
		
		require(core:GetEffect(effect))(core, {
			Player = core.Players:GetPlayerFromCharacter(enemy);
			Character = clone;
			Humanoid = clone.Humanoid;
		})
		
	end
end)