local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

local currentLocationId = GlobalState.blackMarketLocationId
local blackMarketPed
local blackMarketZone

local function deletePed()
	if blackMarketPed and DoesEntityExist(blackMarketPed) then
		Utils.RemoveTargetFromEntity(blackMarketPed, Config.BlackMarket.interactText)
		DeleteEntity(blackMarketPed)
	end
	blackMarketPed = nil
end

local function createBlackMarketZone()
	if not currentLocationId then
		return
	end

	local location = Config.Locations[currentLocationId]
	if not location then
		return
	end

	if blackMarketZone then
		blackMarketZone:destroy()
	end

	blackMarketZone = CircleZone:Create(Config.Locations[currentLocationId].coords, 50.0, {
		name = "blackMarketZone",
		debugPoly = false,
	})

	blackMarketZone:onPlayerInOut(function(isPointInside, point)
		if isPointInside then
			Utils.LoadModel(Config.BlackMarket.ped)
			local found, groundZ = GetGroundZFor_3dCoord(location.coords.x, location.coords.y, location.coords.z, false)
			blackMarketPed = CreatePed(
				0,
				Config.BlackMarket.ped,
				location.coords.x,
				location.coords.y,
				found and groundZ or location.coords.z,
				location.coords.w,
				false,
				false
			)
			SetModelAsNoLongerNeeded(Config.BlackMarket.ped)
			SetEntityInvincible(blackMarketPed, true)
			FreezeEntityPosition(blackMarketPed, true)
			SetEntityHeading(blackMarketPed, location.coords.w)
			SetEntityAsMissionEntity(blackMarketPed, true, true)

			Utils.AddTargetToEntity(blackMarketPed, {
				label = Config.BlackMarket.interactText,
				action = function()
					TriggerServerEvent("axeBlackMarket:server:openBlackMarket")
				end,
			})
		else
			deletePed()
		end
	end)
end

AddStateBagChangeHandler("blackMarketLocationId", nil, function(bagName, key, value)
	currentLocationId = value

	if currentLocationId == nil then
		if blackMarketZone then
			blackMarketZone:destroy()
		end
		deletePed()
		QBCore.Functions.Notify({ text = Config.BlackMarket.textWhenBlackMerchantLeft, caption = "BlackMarket" })
		return
	end

	local location = Config.Locations[currentLocationId]

	if not location then
		return
	end

	local playerData = QBCore.Functions.GetPlayerData()
	if playerData.job then
		if Config.Notifications.Jobs[playerData.job.name] or Config.Notifications.Gangs[playerData.gang.name] then
			QBCore.Functions.Notify({ text = location.tip, caption = "BlackMarket" })
		end
	end

	createBlackMarketZone()
end)

createBlackMarketZone()

AddEventHandler("onResourceStop", function(resource)
	if resource ~= GetCurrentResourceName() then
		return
	end
	deletePed()
end)
