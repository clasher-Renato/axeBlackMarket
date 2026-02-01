GlobalState.blackMarketLocationId = nil
local TIME_TO_CHANGE_LOCATION_IN_MINUTES = Config.BlackMarket.timeToChangeLocationInMinutes * 1000 * 60
local DURATION_IN_MINUTES = Config.BlackMarket.durationInMinutes * 1000 * 60
local currentLocationId
local blackMarketShopId = "blackmarket_shop"

local function registeBlackMarketShop()
	local items = {}

	for _, item in ipairs(Config.BlackMarketItems) do
		local amount = math.random(item.amount.min, item.amount.max)
		items[#items + 1] = {
			name = item.name,
			price = item.price,
			amount = amount,
		}
	end

	exports["qb-inventory"]:CreateShop({
		name = blackMarketShopId,
		label = Config.BlackMarket.label,
		slots = #items,
		items = items,
	})
end

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
		registeBlackMarketShop()
		updateBlackMarket()
	end)
end

local function startBlackMarket()
	registeBlackMarketShop()
	Citizen.Wait(TIME_TO_CHANGE_LOCATION_IN_MINUTES)
	updateBlackMarket()
end

RegisterNetEvent("axeBlackMarket:server:openBlackMarket", function()
	local src = source

	if not currentLocationId then
		return
	end

	exports["qb-inventory"]:OpenShop(src, blackMarketShopId)
end)

startBlackMarket()
