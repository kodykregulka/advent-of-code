local function processLine(line)
	local words = {}
	local last = nil
	local isUp = nil
	local errCount = 0
	for word in line:gmatch("%w+") do
		local current = tonumber(word)
		if last ~= nil then
			local diff = math.abs(last - current)
			if diff < 1 or diff > 3 then
				return false
			end

			if isUp == nil then
				--havent set a direction, we should do that
				if current > last then
					isUp = true
				else
					isUp = false
				end
			elseif isUp and current <= last then
				return false
			elseif not isUp and current >= last then
				return false
			end
		end
		last = current
	end

	--report has been processed
	if errCount < 2 then
		print("good report")
		return true
	else
		print("bad report")
		return false
	end
end


local path = "input.txt"
local file = io.open(path, "r");

local goodReports = 0
for line in io.lines(path) do
	if processLine(line) then
		goodReports = goodReports + 1
	end
end

print("Good reports: " .. goodReports)
file:close()
