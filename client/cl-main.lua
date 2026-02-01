local currentLocationId = GlobalState.blackMarketLocationId
local blackMarketPed

AddStateBagChangeHandler("blackMarketLocationId", nil, function(bagName, key, value)
	currentLocationId = value
	print(value)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if not currentLocationId then
			if blackMarketPed and DoesEntityExist(blackMarketPed) then
				DeleteEntity(blackMarketPed)
			end
			blackMarketPed = nil
			goto skip
		end

		local location = Config.Locations[currentLocationId]
		if not location then
			goto skip
		end

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local distance = #(
			vec3(pedCoords.x, pedCoords.y, pedCoords.z) - vec3(location.coords.x, location.coords.y, location.coords.z)
		)

		if distance < 50.0 then
			if not blackMarketPed then
				Utils.LoadModel(Config.BlackMarket.ped)
				local found, groundZ =
					GetGroundZFor_3dCoord(location.coords.x, location.coords.y, location.coords.z, false)
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
			end
		else
			if blackMarketPed and DoesEntityExist(blackMarketPed) then
				DeleteEntity(blackMarketPed)
			end
			blackMarketPed = nil
		end

		::skip::
	end
end)

AddEventHandler("onResourceStop", function(resource)
	if resource ~= GetCurrentResourceName() then
		return
	end

	if blackMarketPed and DoesEntityExist(blackMarketPed) then
		DeleteEntity(blackMarketPed)
	end
	blackMarketPed = nil
end)
