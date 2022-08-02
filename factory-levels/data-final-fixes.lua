for i = 1, 25, 1 do
	local assemblyLeveled = data.raw["assembling-machine"]["assembling-machine-1-level-" .. i]

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		assemblyLeveled.base_productivity = 0.0025 * i
	end

	data:extend({ assemblyLeveled })
end

for i = 1, 50, 1 do
	local assemblyLeveled = data.raw["assembling-machine"]["assembling-machine-2-level-" .. i]

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		assemblyLeveled.base_productivity = 0.0025 * i
	end

	data:extend({ assemblyLeveled })
end

for i = 1, 100, 1 do
	local assemblyLeveled = data.raw["assembling-machine"]["assembling-machine-3-level-" .. i]

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		assemblyLeveled.base_productivity = 0.0025 * i
	end

	data:extend({ assemblyLeveled })
end