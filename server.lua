ESX = exports['es_extended']:getSharedObject()

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        local pedModel = 'a_m_y_hipster_01'
        local x, y, z = 84.870331, -448.483521, 37.536255
        TriggerClientEvent('ch_youness:createPed', -1, pedModel, x, y, z)
    end
end)

RegisterNetEvent('ch_youness:pedKilled')
AddEventHandler('ch_youness:pedKilled', function(killerId)
    exports.ox_inventory:AddItem(killerId, 'crypted_phone', 1)
end)

RegisterNetEvent('ch_youness:giveCryptedPhone')
AddEventHandler('ch_youness:giveCryptedPhone', function()
    local source = source
    exports.ox_inventory:AddItem(source, 'crypted_phone', 1)
end)

ESX.RegisterServerCallback('ch_youness:checkCryptedPhone', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('crypted_phone')
    cb(item.count > 0)
end)