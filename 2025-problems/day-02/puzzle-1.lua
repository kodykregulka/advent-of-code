local filename = "test.txt"
local file = io.open(filename, "r") -- Open the file in read mode ("r")

if not file then
	print("Error: Could not open file " .. filename)
	return
end

local content = file:read("*all")
file:close()

local function split(input, delim)
	local result = {}
	for substring in string.gmatch(input, "([^" .. delim .. "]+)") do
		table.insert(result, substring)
	end
	return result
end

local rangeList = {}
local commaList = split(content, ",")
for i, val in ipairs(commaList) do
	local tempList = split(val, "-")
	local range = {}
	if tempList[1] == nil or tempList[2] == nil then
		error("bad input: " .. val)
	end
	range.first = tonumber(tempList[1])
	range.firstDigits = #tempList[1]
	range.last = tonumber(tempList[2])
	range.lastDigits = #tempList[2]
	table.insert(rangeList, range)
end


-- for i, val in ipairs(rangeList) do
-- 	print(i .. ": " .. val.first .. " : " .. val.last)
-- end

--2 digit needs 11
--4 digits needs 101
--6 digits needs 1001
--8 idgits needs 10001

local invalidIdList = {}

local function addToInvalidList(num)
	table.insert(invalidIdList, num)
	print(num)
end

local function checkRange(range, invalidIdList)
	print("checking range: " .. range.first .. " : " .. range.last)
	local current = range.first
	local currentDigits = range.firstDigits
	local currentMax = math.pow(10, currentDigits) - 1
	if currentMax > range.last then
		currentMax = range.last
	end
	local currentDiv = math.pow(10, currentDigits - 1) + 1 --TODO single digit
	while true do
		--loop for digits
		if currentDigits % 2 == 1 then
			print("odd digits, trying to increment")
			--odd digits, cannot be invalid
			if currentDigits < range.lastDigits then
				--increase to next even digit number
				currentDigits = currentDigits + 1
				--increase current to first number in that digit range
				current = math.pow(10, currentDigits - 1)
				currentMax = math.pow(10, currentDigits) - 1
				if currentMax > range.last then
					currentMax = range.last
				end
				--next
			else
				--end of range
				return invalidIdList
			end
		else
			--even digits, there could be some invalids in here!
			local rem = current % currentDiv
			if rem == 0 then
				--found one!
				addToInvalidList(current)
			end

			--figure out the next current
			while current <= currentMax do
				local next = current + (currentDiv - rem)
				print("current:" .. current .. " next:" .. next)
				if next <= currentMax then
					--still within the current digit range
					--this is an invalid!
					current = next
					addToInvalidList(current)
					--next
				elseif next <= range.last and (currentDigits + 2) <= range.lastDigits then
					--need to go to next digit range
					print("going to next digit range " .. currentDigits .. "->" .. (currentDigits + 2))
					currentDigits = currentDigits + 2

					--put current at start of next digit range
					current = math.pow(10, currentDigits - 1)
					currentMax = math.pow(10, currentDigits) - 1
					if currentMax > range.last then
						currentMax = range.last
					end
					print("new current: " .. current)
					print("new max: " .. currentMax)
					--next
				else
					--done
					return invalidIdList
				end
			end
		end
	end
end

for i, val in ipairs(rangeList) do
	--print(i .. ": " .. val.first .. " : " .. val.last)
	checkRange(val, invalidIdList)
	print("invalid count: " .. #invalidIdList)
end

local sum = 0
for i, val in ipairs(invalidIdList) do
	print(i .. ": " .. val)
	sum = sum + val
end

print("key is: " .. sum)

--here is fuckup
--invalid count: 4
-- checking range: 1188511880 : 1188511890
-- current:1188511880 next:2000000002
-- invalid count: 4
