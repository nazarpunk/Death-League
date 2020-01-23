local pipe = io.popen('powershell -Command -', 'w')
pipe:write([[(New-Object Net.WebClient).DownloadFile('wrong/file', 'wrong.lua')]]):close()