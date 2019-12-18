local luacurl = require "luacurl"
function FileDownload(url)
	local curl = luacurl.new()
	curl:setopt(luacurl.OPT_URL, url)
	curl:setopt(luacurl.OPT_FOLLOWLOCATION, true)
	curl:setopt(luacurl.OPT_SSL_VERIFYPEER, false)
	local s = ''
	curl:setopt(luacurl.OPT_WRITEFUNCTION, function(p, chunk)
		s = s .. chunk
		return #chunk
	end)
	curl:setopt(luacurl.OPT_PROGRESSFUNCTION, function(p, dltotal, dlnow)
		print(url, dltotal, dlnow)
	end)
	curl:setopt(luacurl.OPT_NOPROGRESS, false)
	assert(curl:perform())
	local out, count = s:gsub('[\r\n|\n]+', '\r')
	return out
end