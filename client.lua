local spawned = false
local ped
ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    local pedModel = "a_m_m_hasjew_01"
    local x, y, z = 524.742859, -826.852722, 15.31140

    RequestModel(GetHashKey(pedModel))
    while not HasModelLoaded(GetHashKey(pedModel)) do
        Citizen.Wait(1)
    end

    if not HasModelLoaded(GetHashKey(pedModel)) then
        return
    end

    if not spawned then
        ped = CreatePed(4, GetHashKey(pedModel), x, y, z - 1.0, 0.0, true, true)
        if not DoesEntityExist(ped) then
            return
        end

        FreezeEntityPosition(ped, true)
        if not NetworkGetEntityIsNetworked(ped) then
            NetworkRegisterEntityAsNetworked(ped)
        end
        spawned = true

        SetEntityAsMissionEntity(ped, true, true)
        SetPedFleeAttributes(ped, 0, 0)
        SetPedCombatAttributes(ped, 46, 1)
        SetPedArmour(ped, 100)
        SetPedMaxHealth(ped, 200)
        SetPedRelationshipGroupHash(ped, GetHashKey("CIVMALE"))
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedCanRagdoll(ped, true)
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, true)
        SetModelAsNoLongerNeeded(GetHashKey(pedModel))
        -- TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(2)
        SetTextProportional(1)
        SetTextColour(245, 245, 245, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end

RegisterNetEvent('ch_youness:setGPS')
AddEventHandler('ch_youness:setGPS', function(x, y, z)
    SetNewWaypoint(x, y)
    ShowNotification('~r~MEC CHELOU : ~w~Check ton GPS !')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if spawned and DoesEntityExist(ped) then
            local pedCoords = GetEntityCoords(ped)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - pedCoords)

            if distance < 5.0 then
                DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 0.9, "MECHOUI")

                if IsControlJustPressed(1, 51) then
                    ESX.TriggerServerCallback('ch_youness:checkCryptedPhone', function(hasPhone)
                        if hasPhone then
                            ShowNotification('~r~MEC CHELOU : ~w~Je t\'ai deja donner une mission fils de cramptouille !')
                        else
                            TriggerServerEvent('ch_youness:giveCryptedPhone')
                        end
                    end)
                end
            end

            if IsPedDeadOrDying(ped, true) then
                local killer = GetPedSourceOfDeath(ped)
                if killer and IsEntityAPed(killer) and IsPedAPlayer(killer) then
                    local killerId = NetworkGetPlayerIndexFromPed(killer)
                    -- TriggerServerEvent('ch_youness:pedKilled', GetPlayerServerId(killerId))
                end
                spawned = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DrawMarker(1, 56.057144, 165.824173, 104.783936 - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local isInMarker = false
        local markerCoords = vector3(56.057144, 165.824173, 104.783936)
        local markerRadius = 1.0

        if #(coords - markerCoords) < markerRadius then
            isInMarker = true
        end

        if isInMarker then
            ESX.ShowHelpNotification('Appuie sur  ~INPUT_CONTEXT~ pour vendre la frappe du rif !')

            if IsControlJustReleased(0, 38) then
                TriggerServerEvent('ch_youness:checkShit')
            end
        end
    end
end)