local currentLocationId = GlobalState.blackMarketLocationId

AddStateBagChangeHandler("blackMarketLocationId", nil, function(bagName, key, value)
	print(value)
end)
