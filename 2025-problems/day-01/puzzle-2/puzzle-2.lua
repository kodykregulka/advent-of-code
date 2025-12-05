local filename = "input.txt"
local file = io.open(filename, "r") -- Open the file in read mode ("r")

if not file then
	print("Error: Could not open file " .. filename)
	return
end

local currentIndex = 50
local zeroCount = 0
local zeroPass = 0

--L means subtract
--R means add

for line in file:lines() do
	local dir = string.sub(line, 1, 1)
	local val_string = string.sub(line, 2)
	local val = tonumber(val_string)

	--set direction
	if dir == "L" then
		val = val * -1
	end
	local rawIndex = currentIndex + val
	if rawIndex == 0 then
		--only count once when we land on zero
		zeroPass = zeroPass + 1
	elseif rawIndex > 0 then
		--might have gone over 100 so add how many times 100 can go into the rawindex
		zeroPass = zeroPass + math.floor(rawIndex / 100)
	else
		--going under zero
		if currentIndex == 0 then
			--don't count it as passing if we started here
			zeroPass = zeroPass + math.floor(((rawIndex * -1)) / 100)
		else
			--count as we pass zero and however any more 100 fit into
			zeroPass = zeroPass + math.floor(((rawIndex * -1) + 100) / 100)
		end
	end


	currentIndex = rawIndex % 100
	if currentIndex == 0 then
		zeroCount = zeroCount + 1
	end
end

print("number of zeros landed on is: " .. zeroCount)
print("number of zeros passed is: " .. zeroPass)
