Config = {}

Config.BlackMarket = {
	label = "BlackMarket",
	ped = `g_m_importexport_01`,
	interactText = "Open BlackMarket",
	durationInMinutes = 1, -- How long the black market is open for
	timeToChangeLocationInMinutes = 1, -- How long to wait before changing the location
}

Config.Locations = {
	{
		coords = vector4(145.96, -1058.95, 30.19, 64.87),
		tip = "Find me behind the city bank.",
	},
	{
		coords = vector4(-102.4, 6345.04, 31.58, 212.4),
		tip = "Find me in the paleto motel.",
	},
}
