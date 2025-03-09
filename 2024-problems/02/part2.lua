--returns index of bad character
local function processLine(lineList)
	local last = nil
	local isUp = nil
	for i, word in ipairs(lineList) do
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
				last = current
			elseif isUp and current <= last then
				return false
			elseif not isUp and current >= last then
				return false
			end
		end
		last = current
	end

	--report has been processed and is good
	return true
end


local path = "input.txt"
local file = io.open(path, "r");

local goodReports = 0
for line in io.lines(path) do
	local wordList = {}
	for word in line:gmatch("%w+") do
		wordList[#wordList + 1] = word
	end

	if processLine(wordList) then
		goodReports = goodReports + 1
	end
end

print("Good reports: " .. goodReports)
file:close()
