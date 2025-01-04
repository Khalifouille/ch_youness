ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('ch_youness:pedKilled')
AddEventHandler('ch_youness:pedKilled', function(killerId)
    exports.ox_inventory:AddItem(killerId, 'crypted_phone', 1)
end)

RegisterNetEvent('ch_youness:giveCryptedPhone')
AddEventHandler('ch_youness:giveCryptedPhone', function()
    local source = source
    exports.ox_inventory:AddItem(source, 'crypted_phone', 1)
    TriggerClientEvent('ch_youness:sendGPS', source)
end)

ESX.RegisterServerCallback('ch_youness:checkCryptedPhone', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('crypted_phone')
    cb(item.count > 0)
end)

RegisterNetEvent('ch_youness:sendGPS')
AddEventHandler('ch_youness:sendGPS', function()
    local source = source
    local x, y, z = 56.057144, 165.824173, 104.783936
    TriggerClientEvent('ch_youness:setGPS', source, x, y, z)
end)