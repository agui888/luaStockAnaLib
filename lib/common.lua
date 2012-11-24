--encoding=utf-8

Matlab = {}

Matlab.sum = function(data)
	local sum = 0
	for i = 1, #data do
		sum = sum + data[i]
	end
	return sum
end

Matlab.arrayslice = function(values,i1,i2)
	local res = {}
	local n = #values
	-- default values for range
	i1 = i1 or 1
	i2 = i2 or n
	if i2 < 0 then
		i2 = n + i2 + 1
	elseif i2 > n then
		i2 = n
	end
	if i1 < 1 or i1 > n then
		return {}
	end
	local k = 1
	for i = i1,i2 do
		res[k] = values[i]
		k = k + 1
	end
	return res
end

Matlab.max = function(data)
	local i
	local max = data[1]
	local maxi = 1
	for i = 1, #data do
		if max <= data[i] then
			maxi = i
			max = data[i]
		end
	end
	return max, maxi
end

Matlab.min = function(data)
	local i
	local min = data[1]
	local mini = 1
	for i = 1, #data do
		if min >= data[i] then
			mini = i
			min = data[i]
		end
	end
	return min, mini
end

TableUtil = {
	-- 深层拷贝一个table
	clone = function (object)
		local lookup_table = {}
		local function _copy(object)
			if type(object) ~= "table" then
				return object
			elseif lookup_table[object] then
				return lookup_table[object]
			end
			local new_table = {}
			lookup_table[object] = new_table
			for index, value in pairs(object) do
				new_table[_copy(index)] = _copy(value)
			end
			return setmetatable(new_table, getmetatable(object))
		end
		return _copy(object)
	end,
	-- 树桩打印Table
	print = function(root, outputFunc)
		if not DEBUG_MODE then return end
		
		if type(root) ~= "table" then
			return
		end
		local cache = {  [root] = "." }
		local function _dump(t,space,name)
			local temp = {}
			for k,v in pairs(t) do
				local key = tostring(k)
				if cache[v] then
					table.insert(temp,"+" .. key .. " {" .. cache[v].."}")
				elseif type(v) == "table" then
					local new_key = name .. "." .. key
					cache[v] = new_key
					table.insert(temp,"+" .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. string.rep(" ",#key),new_key))
				else
					table.insert(temp,"+" .. key .. " [" .. tostring(v).."]")
				end
			end
			return table.concat(temp,"\n"..space)
		end
		myPrint = outputFunc or print
		myPrint(_dump(root, "",""))
	end,
	
	getNum = function(object)
	    local num = 0
	    for k, v in pairs(object) do
		     num = num + 1
		end 
		return num
	end,
	
	-- 检查数字索引，并转成String
	checkNumIndex = function(t)
		if type(t) ~= "table" then
			return
		end
		for k,v in pairs(t) do
			if type(k) == "number" then
				t[k] = nil
				t[tostring(k)] = v
				_print("Converted!!!!!!!!!")
			end
		end
	end,
	
	-- 排序的object pairs
	pairsByKeys = function(t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0                 -- iterator variable
		local iter = function ()    -- iterator function
		   i = i + 1
		   if a[i] == nil then return nil
		   else return a[i], t[a[i]]
		   end
		end
		return iter
	end,
	
	mergeSort = function(t,l,r,f)
		if l < r then
			local m = math.floor((l+r)/2)
			TableUtil.mergeSort(t,l,m,f)
			TableUtil.mergeSort(t,m+1,r,f)
			TableUtil.merge(t,l,m,r,f)
		end
	end,
	
	merge = function(t,l,m,r,f)
		local b = {}
		local c = {}
		local k = 0
		local j = 0
		local q = 0
		for k = l,m do
			b[tostring(k)] = t[tostring(k)]
		end
		for j = m+1,r do
			c[tostring(j)] = t[tostring(j)]
		end
		k = l
		j = m+1
		for q = l,r do
			if f(b[tostring(k)],c[tostring(j)]) then
				t[tostring(q)] = b[tostring(k)]
				k = k + 1
			else
				t[tostring(q)] = c[tostring(j)]
				j = j + 1
			end
		end
	end
}
