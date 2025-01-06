-- Objet "Packet de shit n'est plus dropable aprés modification de ox_inventory" modifier dans resources/[esx]/ox_inventory/modules/inventory/server.lua
--local function dropItem(source, playerInventory, fromData, data)
--    if fromData.name == 'packet_de_shit' then
--        return false, { error = 'Vous ne pouvez pas jeter cet item' }
--    end


ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('ch_youness:giveCryptedPhone')
AddEventHandler('ch_youness:giveCryptedPhone', function()
    local source = source
    exports.ox_inventory:AddItem(source, 'crypted_phone', 1)
    exports.ox_inventory:AddItem(source, 'packet_de_shit', 5)
    TriggerClientEvent('ch_youness:sendGPS', source)
end)

ESX.RegisterServerCallback('ch_youness:checkshitphone', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('crypted_phone')
    local item2 = xPlayer.getInventoryItem('packet_de_shit')
    cb(item.count > 0 or item2.count > 0)
end)

RegisterNetEvent('ch_youness:sendGPS')
AddEventHandler('ch_youness:sendGPS', function()
    local source = source
    local x, y, z = 56.057144, 165.824173, 104.783936
    TriggerClientEvent('ch_youness:setGPS', source, x, y, z)
end)

RegisterNetEvent('ch_youness:checkShit')
AddEventHandler('ch_youness:checkShit', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local ShitItem = xPlayer.getInventoryItem('packet_de_shit')

    if ShitItem.count > 0 then
        local reward = ShitItem.count * 10000
        xPlayer.removeInventoryItem('packet_de_shit', ShitItem.count)
        xPlayer.addMoney(reward)
        TriggerClientEvent('esx:showNotification', source, ('Tu as vendu ta frappe du rif pour $%s'):format(reward))
    else
        TriggerClientEvent('esx:showNotification', source, 'Tu as pas de shit !')
    end
end)