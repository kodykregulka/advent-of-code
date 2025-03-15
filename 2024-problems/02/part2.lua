--returns index of bad character
local function processLine(lineList)
	local last = nil
	local isUp = nil
	for i, word in ipairs(lineList) do
		local current = tonumber(word)
		if last ~= nil then
			local diff = math.abs(last - current)
			if diff < 1 or diff > 3 then
				return i
			end

			if isUp == nil then
				--havent set a direction, we should do that
				if current > last then
					isUp = true
				else
					isUp = false
				end
			elseif isUp and current <= last then
				return i
			elseif not isUp and current >= last then
				return i
			end
		end
		last = current
	end

	--report has been processed and is good
	return 0
end

local function copyWithRemove(mytable, removeIndex)
	local newTable = {}
	local newIndex = 1
	for i, val in ipairs(mytable) do
		if i ~= removeIndex then
			newTable[newIndex] = val
			newIndex = newIndex + 1
		end
	end
	return newTable
end

--return true if it can be processed with error correction
local function processReportWithBruteErrorCorrection(wordList)
	local badIndex = processLine(wordList)
	if badIndex == 0 then
		return true
	end

	for i, word in ipairs(wordList) do
		local newWordList = copyWithRemove(wordList, i)
		local badIndex = processLine(newWordList)
		if badIndex == 0 then
			return true
		end
	end

	return false
end


local path = "input.txt"
local file = io.open(path, "r");

local goodReports = 0
for line in io.lines(path) do
	local wordList = {}
	for word in line:gmatch("%w+") do
		wordList[#wordList + 1] = word
	end

	local isGood = processReportWithBruteErrorCorrection(wordList)

	if isGood then
		goodReports = goodReports + 1
	end
end

print("Good reports: " .. goodReports)
file:close()
