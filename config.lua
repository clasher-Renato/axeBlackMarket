Config = {}

Config.BlackMarket = {
	label = "BlackMarket",
	ped = `g_m_importexport_01`,
	interactText = "Open BlackMarket",
	shopTitle = "BlackMarket",
	durationInMinutes = 2, -- How long the black market is open for
	timeToChangeLocationInMinutes = 0.1, -- How long to wait before changing the location
	textWhenBlackMerchantLeft = "The black market is closed, come back later.",
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

Config.BlackMarketItems = {
	{
		name = "weapon_pistol",
		price = 1000,
		amount = {
			min = 0,
			max = 1,
		},
	},
	{
		name = "phone",
		price = 250,
		amount = {
			min = 1,
			max = 5,
		},
	},
}
