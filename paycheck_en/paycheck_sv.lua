-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "")

RegisterServerEvent('paycheck:salary')
AddEventHandler('paycheck:salary', function()
  	local salary = 500
	TriggerEvent('es:getPlayerFromId', source, function(user)
  	-- Adding money to the user
  	local user_id = user.identifier
  	-- Query that retrieves the user's trade
  	local executed_query = MySQL:executeQuery("SELECT salary FROM users INNER JOIN jobs ON users.job = jobs.job_id WHERE identifier = '@username'",{['@username'] = user_id})
    local result = MySQL:getResults(executed_query, {'salary'})
    local salary_job = result[1].salary
  	user:addMoney((salary + salary_job))
 	TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Paycheck received :  + "..salary.."~g~€~s~~n~Paycheck Job received : + "..salary_job.." ~g~€")
 	end)
end)
