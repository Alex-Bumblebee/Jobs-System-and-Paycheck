-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "")

RegisterServerEvent('paycheck:salary')
AddEventHandler('paycheck:salary', function()
  	local salary = 500
	TriggerEvent('es:getPlayerFromId', source, function(user)
  	-- Adding money to the user
  	user:addMoney((salary))
 	TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Paycheck received :  + "..salary.." ~g~$")
 	end)
end)
