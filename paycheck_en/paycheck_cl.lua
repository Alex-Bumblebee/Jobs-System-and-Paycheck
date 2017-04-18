Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(600000) -- Change this value for the frequency of paycheck (600000 = 10 minutes)
		TriggerServerEvent('paycheck:salary')
	end
end)
