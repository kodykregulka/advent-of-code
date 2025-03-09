print("Hello world")

function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k, v in pairs(o) do
			if type(k) ~= 'number' then k = '"' .. k .. '"' end
			s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

local path = "input.txt"
local file = io.open(path, "r");

local list1 = {}
local list2 = {}

local lines = {}
for line in io.lines(path) do
	local words = {}
	for word in line:gmatch("%w+") do
		table.insert(words, word)
	end
	table.insert(list1, words[1])
	table.insert(list2, words[2])
end

print(dump(list1))
print(dump(list2))

--table.sort(list1)
--table.sort(list2)

local counts = {}
for i, v in ipairs(list2) do
	if counts[v] == nil then
		counts[v] = 1
	else
		counts[v] = counts[v] + 1
	end
end


print(dump(counts))

local sims = 0
for i, v in ipairs(list1) do
	if counts[v] ~= nil then
		sims = (v * counts[v]) + sims
	end
end

print(sims)



file:close()
