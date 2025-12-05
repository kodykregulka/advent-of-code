local filename = "input.txt"
local file = io.open(filename, "r") -- Open the file in read mode ("r")

if not file then
	print("Error: Could not open file " .. filename)
	return
end

local currentIndex = 50
local zeroCount = 0

--L means subtract
--R means add

for line in file:lines() do
	local dir = string.sub(line, 1, 1)
	local val_string = string.sub(line, 2)
	local val = tonumber(val_string)
	if dir == "L" then
		currentIndex = (currentIndex - val) % 100
	else
		currentIndex = (currentIndex + val) % 100
	end

	if currentIndex == 0 then
		zeroCount = zeroCount + 1
	end
end

print("number of zeros is: " .. zeroCount)
