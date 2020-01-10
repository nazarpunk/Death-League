DECLENSION = {
	ru = function(number, dec1, dec4, dec5)
		number = math.fmod(math.abs(number), 100)
		if number >= 11 and number <= 19 then
			return dec5
		else
			local i = math.fmod(number, 10)
			if i == 1 then return dec1
			elseif i >= 2 and i <= 4 then
				return dec4
			end
			return dec5
		end
		return dec1
	end
}
for i = 1, 30 do
	print(i, DECLENSION.ru(i, ' банан', ' банана', ' бананов'))
end
