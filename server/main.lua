-- Export que interactúa con el objeto "caja de cigarros". Al usar la caja, identifica el tipo específico
-- de caja y otorga al jugador el cigarro correspondiente según la marca.

exports('cigarbox', function(event, item, inventory, slot, data)
    local source = inventory.id
    if event == 'usedItem' then
        if item.name == "radahn_redwood" then
            exports.ox_inventory:AddItem(source, "radahn_cigar", 1)
        elseif item.name == "radahn_redwood_light" then
            exports.ox_inventory:AddItem(source, "radahn_cigar", 1)
        elseif item.name == "radahn_estancia" then
            exports.ox_inventory:AddItem(source, "radahn_cigar_premium", 1)
        elseif item.name == "radahn_premium" then
            exports.ox_inventory:AddItem(source, "radahn_cigar", 1)
        end
        if Config.Actions then
            TriggerClientEvent('radahn_smoke:PickCigar', source, item.label)
        end
    end
end)
exports('craftCigar', function(event, item, inventory, slot, data)
    local source = inventory.id
    if event == 'usingItem' then
        local result = exports.ox_inventory:GetInventoryItems(source)
        local paperFound = nil
        for k, value in pairs(result) do
            if value.name == "radahn_paper" then
                paperFound = {
                    slot = value.slot,
                    name = value.name,
                    durability = value.metadata.durability or 100
                }
            end
        end

        if not paperFound then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Error',
                description = 'No tienes papel para liar el cigarro.',
                type = 'error'
            })
            return false
        end
        local total = paperFound.durability - 2
        if total < 0 then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Error',
                description = 'No tienes papel suficiente.',
                type = 'error'
            })
            return false
        elseif total == 0 then
            exports.ox_inventory:RemoveItem(source, paperFound.name, 1, nil, paperFound.slot)
        end
        
        exports.ox_inventory:SetDurability(source, paperFound.slot, total)
    end
    if event == 'usedItem' then
        exports.ox_inventory:AddItem(source, "radahn_cigar_custom", 1)
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Éxito',
            description = 'Te has liado un cigarro.',
            type = 'success'
        })
        if Config.Actions then
            TriggerClientEvent('radahn_smoke:craftCigar', source)
        end
    end
end)

exports('usecigar', function(event, item, inventory, slot, data)
    local source = inventory.id
    local lighterFound = nil
    if event == 'usingItem' then
        local result = exports.ox_inventory:GetInventoryItems(source)
        for k, value in pairs(result) do
            if Config.Lighters[value.name] then
                lighterFound = {
                    slot = value.slot,
                    name = value.name,
                    durability = value.metadata.durability or 100
                }
                break
            end
        end
        if not lighterFound then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Error',
                description = 'No tienes un encendedor para encender el cigarro.',
                type = 'error'
            })
            return false
        end
        if lighterFound.durability - Config.Lighters[lighterFound.name] < 0 then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Error',
                description = 'El encendedor está vacío.',
                type = 'error'
            })
            return false
        end
        local total = lighterFound.durability - Config.Lighters[lighterFound.name]

        exports.ox_inventory:SetDurability(source, lighterFound.slot, total)
    end

    if event == 'usedItem' then
        if Config.Actions then
            TriggerClientEvent('radahn_smoke:useCigar', source)
        end
        TriggerClientEvent("radahn_smoke_startSmoking", source, item.name)
    end
end)

RegisterNetEvent("radahn_smoke:transferCigar", function(targetId, count, cigarette)
    local source = source
    local xTarget = ESX.GetPlayerFromId(targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xTarget then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Error',
            description = 'El jugador no está conectado o no se encuentra cerca.',
            type = 'error'
        })
        return
    end
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Éxito',
        description = 'Has entregado el cigarro a ' .. xTarget.getName() .. '.',
        type = 'success'
    })
    TriggerClientEvent('ox_lib:notify', targetId, {
        title = 'Éxito',
        description = 'Has recibido un cigarro de ' .. xPlayer.getName() .. '.',
        type = 'success'
    })
    TriggerClientEvent("radahn_smoke_startSmoking", targetId, cigarette, count)
end)
