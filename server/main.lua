-- Update vehicle state when server starts to ensure all vehicles are in the depot.
Citizen.CreateThread(function()
	if Config.UpdateStateOnLoad then
		Citizen.Wait(5000)
		exports.ghmattimysql:execute('UPDATE player_vehicles SET state=1 WHERE state=0')
		print("Returned any vehicles missing from the garage.")
	end
end)

-- Update state when player disconnects.
AddEventHandler('playerDropped', function(reason)
	if Config.UpdateStateOnPlayerDisconnect then
		local Player = QBCore.Functions.GetPlayer(source)
		local citizenid = Player.PlayerData.citizenid

		exports.ghmattimysql:execute('UPDATE player_vehicles SET state=1 WHERE state=0 AND citizenid=@citizenid', {['@citizenid'] = citizenid})
		print('Player ' .. GetPlayerName(source) .. ' dropped. Returned any active vehicles to the garage.')
	end
end)