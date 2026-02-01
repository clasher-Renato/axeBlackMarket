local TIME_TO_CHANGE_LOCATION_IN_MINUTES = Config.BlackMarket.timeToChangeLocationInMinutes * 1000 * 60
local DURATION_IN_MINUTES = Config.BlackMarket.durationInMinutes * 1000 * 60
local currentLocationId

---@param noLocation? boolean
local function setBlackMarketLocation(noLocation)
	if noLocation then
		currentLocationId = nil
		GlobalState.blackMarketLocationId = nil
		return
	end

	currentLocationId = math.random(1, #Config.Locations)
	GlobalState.blackMarketLocationId = currentLocationId
end

local function updateBlackMarket()
	setBlackMarketLocation()
	Citizen.Wait(DURATION_IN_MINUTES)
	setBlackMarketLocation(true)
	SetTimeout(TIME_TO_CHANGE_LOCATION_IN_MINUTES, function()
		updateBlackMarket()
	end)
end

local function startBlackMarket()
	Citizen.Wait(TIME_TO_CHANGE_LOCATION_IN_MINUTES)
	updateBlackMarket()
end

startBlackMarket()
