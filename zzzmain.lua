function zzzmain_OnLoad()
	SlashCmdList["CCENTER"] = zzzmain_SlashCommandHandler;
	SLASH_CCENTER1 = "/cchat";
	zprint(" Welcome to the amazing chatcolor changer")
	zprint(" ")
	zprint(" use /cchat <color> to change your chat color")
	zprint(" e.g /cchat red")
	zprint(" use /cchat normal to return to normal chat (if u want to link items properly)")
	zprint(" ^ also works with /cchat disable /cchat off ^")
	zprint(" Available colors are: ")
	zprint(" - red blue green yellow white")
	zprint(" - pink gold purple teal")
	zprint(" ")
	zprint(" use /cchat help to view this message again.")
end

function cchelp()
	zprint(" /cchat help function")
	zprint(" ")
	zprint(" use /cchat <color> to change your chat color")
	zprint(" e.g /cchat red")
	zprint(" use /cchat off   to disable coloring.(if u want to link items properly)")
	zprint(" Available colors are: ")
	zprint(" - red blue green yellow white pink gold purple teal")
	zprint(" ")
end

local ccenabled = false
local ccfunc = SendChatMessage

-- --------------------------------------------------------------
-- colors explained: c = prefix XX alpha XX red XX green XX blue
--           RED     c          FF       FF     00       00
-- HEX STUFF
-- --------------------------------------------------------------

local cRed =    "cFFFF0000"
local cGreen =  "cFF00FF00"
local cBlue =   "cFF0000FF"
local cYellow = "cFFFFFF00"
local cBrown =  "cFFA5552A"
local cWhite =  "cFFFFFFFF"
local cPink =   "cFFFF29F3"
local cGold =   "cFFFFD700"
local cPurple = "cFF800080"
local cTeal =   "cFF008080"
local cYellow2 ="cFFFDFDA0"
local cBlue2 =  "cFF78B6FD"
local cRed2 =   "cFFA10B0B"

local curcolor = cRed


function zprint(txt)
	DEFAULT_CHAT_FRAME:AddMessage(txt,0.5,1,0.7);
end

local function zSplit(pString, pPattern)
	pString = (pString .. pPattern)
	local Table = {}
	local fpat = "(.-)" .. pPattern
	local last_end = 1
	local s, e, cap = strfind(pString, fpat, 1)
	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(Table,cap)
		end
		last_end = e+1
		s, e, cap = strfind(pString, fpat, last_end)
	end
	if last_end <= strlen(pString) then
		cap = strfind(pString, last_end)
		table.insert(Table, cap)
	end
	return Table
end

function zzzmain_SlashCommandHandler(msg)

		local result = zSplit(msg," ")
		zprint("cchat command: "..msg)

		if (msg == "help" or result[1] == "help" or result[1] == nil or result[2] ~= nil) then
			cchelp()
		elseif (result[1] == "normal" or result[1] == "disable" or result[1] == "off") then
			ccdisable()
		elseif (result[1] == "red") then
			setccolor(cRed)
		elseif (result[1] == "green") then
			setccolor(cGreen)
		elseif (result[1] == "blue") then
			setccolor(cBlue)
		elseif (result[1] == "yellow") then
			setccolor(cYellow)
		elseif (result[1] == "brown") then
			setccolor(cBrown)
		elseif (result[1] == "white") then
			setccolor(cWhite)
		elseif (result[1] == "pink") then
			setccolor(cPink)
		elseif (result[1] == "gold") then
			setccolor(cGold)
		elseif (result[1] == "purple") then
			setccolor(cPurple)
		elseif (result[1] == "teal") then
			setccolor(cTeal)
		elseif (result[1] == "yellow2") then
			setccolor(cYellow2)
		elseif (result[1] == "blue2") then
			setccolor(cBlue2)
		elseif (result[1] == "red2") then
			setccolor(cRed2)
		end

end

function ccenable()
	ccenabled = true
end

function setccolor(res)
	curcolor = res
	zprint("Enabling chat color.. use /cchat disable or /cchat off to return to regular")
	zprint("Warning: You cant link items when coloring is on. Be sure to disable it.")
	ccenable()
end

function SendChatMessage(msg,type,lang,chan)
	if ccenabled == true then
		ccfunc("\124" ..curcolor.. "\124Hitem:19:0:0:0:0:0 :0: \124h" ..msg.. "\124h\124r",type,lang,chan)
	else
		ccfunc(msg,type,lang,chan)
	end
end

function ccdisable()
	ccenabled = false
end