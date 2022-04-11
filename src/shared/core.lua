--Made by @V3N0M_Z

local services = {
	"ABTestService";
	"AdService";
	"AnalyticsService";
	"AppStorageService";
	"AppUpdateService";
	"AssetService";
	"AvatarEditorService";
	"BadgeService";
	"BrowserService";
	"CacheableContentProvider";
	"ChangeHistoryService";
	"Chat";
	"ClusterPacketCache";
	"CollectionService";
	"ContentProvider";
	"ContextActionService";
	"ControllerService";
	"CookiesService";
	"CoreGui";
	"CorePackages";
	"CoreScriptSyncService";
	"CSGDictionaryService";
	"DataStoreService";
	"Debris";
	"DebuggerManager";
	"EventIngestService";
	"FlagStandService";
	"FlyweightService";
	"FriendService";
	"GamepadService";
	"GamePassService";
	"Geometry";
	"GoogleAnalyticsConfiguration";
	"GroupService";
	"GuidRegistryService";
	"GuiService";
	"HapticService";
	"HeightmapImporterService";
	"Hopper";
	"HttpRbxApiService";
	"HttpService";
	"ILegacyStudioBridge";
	"InsertService";
	"InternalContainer";
	"InternalSyncService";
	"JointsService";
	"KeyboardService";
	"KeyframeSequenceProvider";
	"Lighting";
	"LocalizationService";
	"LocalStorageService";
	"LoginService";
	"LogService";
	"LuaWebService";
	"MarketplaceService";
	"MemStorageService";
	"MeshContentProvider";
	"MessagingService";
	"MouseService";
	"NetworkSettings";
	"NonReplicatedCSGDictionaryService";
	"NotificationService";
	"PackageService";
	"PathfindingService";
	"PermissionsService";
	"PhysicsService";
	"PlayerEmulatorService";
	"Players";
	"PluginDebugService";
	"PluginGuiService";
	"PointsService";
	"PolicyService";
	"ProximityPromptService";
	"RbxAnalyticsService";
	"ReplicatedFirst";
	"ReplicatedScriptService";
	"ReplicatedStorage";
	"RobloxPluginGuiService";
	"RobloxReplicatedStorage";
	"RunService";
	"RuntimeScriptService";
	"ScriptContext";
	"ScriptService";
	"Selection";
	"ServerScriptService";
	"ServerStorage";
	"SessionService";
	"SocialService";
	"SolidModelContentProvider";
	"SoundService";
	"SpawnerService";
	"StarterGui";
	"StarterPack";
	"StarterPlayer";
	"Stats";
	"StudioData";
	"TaskScheduler";
	"Teams";
	"TeleportService";
	"TestService";
	"TextService";
	"ThirdPartyUserService";
	"TimerService";
	"TouchInputService";
	"TweenService";
	"UGCValidationService";
	"UnvalidatedAssetService";
	"UserInputService";
	"UserService";
	"UserStorageService";
	"VersionControlService";
	"VirtualUser";
	"Visit";
	"VRService";		
}

local core = {}

core.__index = function(self, k)
	return table.find(services, k) and game:GetService(k) or core[k]
end

function core:Get(...)
	local items = {}
	for i, v in ipairs {...} do
		items[i] = self._assets:FindFirstChild(v) and self._assets:FindFirstChild(v):Clone() or error(v.." does not exist in the Assets folder!")
	end
	return table.unpack(items)
end

function core.new(instance, parent)
	local tab = setmetatable({
		_instance = (type(instance) == "string" and Instance.new(instance)) or instance
	}, {
		__index = function(tab, index)
			if string.lower(index) == "get" then
				return tab._instance
			else
				if not pcall(function() return tab._instance[index] end) then
					error("Not a valid property!")
				end
				return function(value) tab._instance[index] = value return tab end
			end
		end
	})
	tab._instance.Parent = parent
	return tab 
end

function core:GetEffect(eff)
	return self._effects:FindFirstChild(eff)
end

function core:PlaySound(audio, parent, callback, ...)
	task.defer(function(...)
		audio = self:Get(audio)
		audio.Parent = parent and parent or self.SoundService
		if not audio.IsLoaded then
			audio.Loaded:Wait()
		end
		audio:Play()
		audio.Ended:Wait()
		audio:Destroy()
		if callback then
			callback(...)
		end			
	end, ...)
end

function core:Cleanup(enemy)
	enemy.Character:Destroy()
	if enemy.Player and enemy.Player == self.Players.LocalPlayer then
		self._comm:FireServer("LoadCharacter")
	end
end

function core.init()
	local self = setmetatable({}, core)
	self._comm = self.ReplicatedStorage:WaitForChild("comm")
	self._assets = self.ReplicatedStorage:WaitForChild("Assets")
	self._effects = self.ReplicatedStorage:WaitForChild("Effects")
	return self
end

return core.init()