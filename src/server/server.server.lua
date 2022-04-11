--Made by @V3N0M_Z--Made by @V3N0M_Z
--Ref: https://github.com/V3N0M-Z/RBLX-CustomDuels

local core = require(game:GetService("ReplicatedStorage"):WaitForChild("core"))
local comm = game:GetService("ReplicatedStorage"):WaitForChild("comm")

for _, eff in ipairs(core._effects:GetChildren()) do
	eff.Name = string.lower(eff.Name)
end

comm.OnServerEvent:Connect(function(client, msg, ...)
	if msg == "SpawnDummy" then
		if not client.Character then return end
		local clone = core:Get("Dummy")
		--clone.Name = client.Name.."'s Greatest Enemy"
		clone:SetPrimaryPartCFrame(client.Character.PrimaryPart.CFrame * CFrame.new(0, 0, -7) * CFrame.Angles(0, math.pi, 0))
		clone.Parent = workspace
	elseif msg == "LoadCharacter" then
		client:LoadCharacter()
	elseif msg == "SetEffect" then
		if not client.Character then return end
		client.Character:SetAttribute("Effect", ...)
	end
end)