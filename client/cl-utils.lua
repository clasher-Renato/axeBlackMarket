Utils = {}

---@param model string|number
function Utils.LoadModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
end

---@param entity number
---@param options { label: string, action: function }
function Utils.AddTargetToEntity(entity, options)
	exports["qb-target"]:AddTargetEntity(entity, {
		options = {
			{
				label = options.label,
				action = function()
					options.action()
				end,
			},
		},
		distance = 2.0,
	})
end
