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

RegisterNetEvent('ch_youness:checkMarijuana')
AddEventHandler('ch_youness:checkMarijuana', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local marijuanaItem = xPlayer.getInventoryItem('marijuana')

    if marijuanaItem.count > 0 then
        local reward = marijuanaItem.count * 10000
        xPlayer.removeInventoryItem('marijuana', marijuanaItem.count)
        xPlayer.addMoney(reward)
        TriggerClientEvent('esx:showNotification', source, ('Tu as vendu ta frappe du rif pour $%s'):format(reward))
    else
        TriggerClientEvent('esx:showNotification', source, 'Tu as pas de shit !')
    end
end)