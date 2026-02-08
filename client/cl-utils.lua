Utils = {}

---@param model string|number
function Utils.LoadModel(model)
	if not model then
		print("INVALID PED MODEL WHEN LOADING PED")
		return
	end

	if not IsModelValid(model) then
		print("INVALID PED MODEL WHEN LOADING PED")
		return
	end

	local timeout = 10000
	local currentTime = 0
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(100)
		currentTime = currentTime + 100
		if currentTime > timeout then
			print("TIMEOUT WHEN LOADING PED")
			return
		end
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

---@param entity number
---@param label string
function Utils.RemoveTargetFromEntity(entity, label)
	exports["qb-target"]:RemoveTargetEntity(entity, label)
end
