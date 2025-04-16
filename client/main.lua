local smoking = nil
local particle = nil
local count = nil
local activeItem = nil
local cigarMounth = false
RegisterNetEvent("radahn_smoke:PickCigar", function(cigarName)
    ExecuteCommand("me Abre la caja de cigarros de marca " .. cigarName .. " y saca un cigarro.")
end)

RegisterNetEvent("radahn_smoke:useCigar", function()
    ExecuteCommand("me coge un cigarro y el mechero, se lo lleva a la boca y lo enciende")
end)

RegisterNetEvent("radahn_smoke:craftCigar", function()
    ExecuteCommand("me comienza a liarse un cigarro con el papel de fumar y el tabaco.")
end)


AddStateBagChangeHandler("activecigar", nil, function(bagName, key, value)
    local entity = GetEntityFromStateBagName(bagName)
    lib.requestNamedPtfxAsset('core', 5000)
    UseParticleFxAssetNextCall("core")
    local objectPosition = Config.Positions[value]
    particle = StartNetworkedParticleFxLoopedOnEntity("ent_anim_cig_smoke", entity, objectPosition.ptfx.x,
        objectPosition.ptfx.y, objectPosition.ptfx.z, 0.0, 0.0, 0.0, 0.5, false, false, false)
end)



RegisterNetEvent("radahn_smoke_startSmoking", function(itemName, uses)
    if smoking then
        DeleteObject(smoking)
        smoking = nil
        count = nil
    end
    count = uses or 10
    activeItem = itemName
    local playerPed = PlayerPedId()

    local gender = GetPlayerGender(playerPed)
    if gender == "female" then
        local animationNumber = math.random(1, #Config.Animations.female)
        lib.requestAnimDict(Config.Animations.female[animationNumber].dict, 5000)
        TaskPlayAnim(playerPed, Config.Animations.female[animationNumber].dict,
            Config.Animations.female[animationNumber].anim, 8.0, -8.0, -1, 50, 0, false, false, false)
    else
        local animationNumber = math.random(1, #Config.Animations.male)
        lib.requestAnimDict(Config.Animations.male[animationNumber].dict, 5000)
        TaskPlayAnim(playerPed, Config.Animations.male[animationNumber].dict,
            Config.Animations.male[animationNumber].anim, 8.0, -8.0, -1, 50, -1, false, false, false)
    end

    local playerCoords = GetEntityCoords(playerPed)
    local boneIndex = GetPedBoneIndex(playerPed, 28422)
    local itemObject = Config.Models[itemName]
    lib.requestModel(itemObject, 5000)
    local objectPosition = Config.Positions[itemName]
    local object = CreateObject(itemObject, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)

    Entity(PlayerPedId()).state:set("smoking", true, true)
    Entity(object).state:set("activecigar", itemName, true)

    AttachEntityToEntity(object, playerPed, boneIndex, objectPosition.x, objectPosition.y, objectPosition.z,
        objectPosition.rot.x, objectPosition.rot.y,
        objectPosition.rot.z, true, true, false, false, 1, true)
    SetModelAsNoLongerNeeded(Config.Models[itemName])
    smoking = object
    StartSmoking(itemName)
    Wait(5000)
end)


function GetPlayerGender(playerPed)
    local playerModel = GetEntityModel(playerPed)
    local maleHash = GetHashKey("mp_m_freemode_01")
    local femaleHash = GetHashKey("mp_f_freemode_01")
    if playerModel == maleHash then
        return "male"
    elseif playerModel == femaleHash then
        return "female"
    end
end

function StartSmoking(cigarette)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()

        while smoking do
            Citizen.Wait(0)
            local dialogText = [[
    [CLICK IZQUIERDO] - Fumar
    [CLICK DERECHO] - Poner en la boca
    [Z] Transferir al usuario más cercano
    [X] Tirar al suelo
    ]] .. "[" .. count .. "] Usos restantes"
            lib.showTextUI(dialogText, {})
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            if IsPedDeadOrDying(playerPed, true) or IsPedInjured(playerPed) or IsPedRagdoll(playerPed) then
                StopCigarette(playerPed)
                lib.hideTextUI()
                break
            end
            if IsControlJustPressed(0, 25) then -- Poner cigarro en la boca
                ToggleCigaretteInMouth(playerPed)
            end

            if IsControlJustPressed(0, 18) then -- Fumar cigarro
                SmokeCigarette(playerPed)
                lib.showTextUI(dialogText, {})
            end
            if IsControlJustPressed(0, 20) then -- Transferir cigarro
                local playerCoords = GetEntityCoords(playerPed)
                local nearestPlayer, nearestPlayerPed, coords = lib.getClosestPlayer(playerCoords, 5.0, false)
                TransferCigar(nearestPlayer, nearestPlayerPed, cigarette)
                lib.hideTextUI()
            end
            if IsControlJustPressed(0, 73) then -- Tirar cigarro
                DropCigarette(playerPed)
                lib.hideTextUI()
            end
        end
        lib.hideTextUI()
        StopParticleFxLooped(particle, 0)
        particle = nil
        smoking = nil
        count = nil
        activeItem = nil
        cigarMounth = false
        ClearPedTasks(playerPed)
    end)
end

function TransferCigar(nearestPlayer, nearestPlayerPed, cigarette)
    if not smoking then return end
    local targetId = GetPlayerServerId(nearestPlayer)
    local AlreadyHasCigar = Entity(nearestPlayerPed).state.smoking
    if AlreadyHasCigar then
        lib.notify({
            title = "Error al transferir",
            description = "El jugador ya tiene un cigarro en la mano.",
            type = "error",
            position = "top",
            duration = 5000,
        })
        return
    end
    StopParticleFxLooped(particle, 0)
    particle = nil
    ClearPedTasks(PlayerPedId())
    DeleteObject(smoking)
    smoking = nil

    TriggerServerEvent("radahn_smoke:transferCigar", targetId, count, cigarette)
    Entity(PlayerPedId()).state:set("smoking", false, true)
    count = nil
end



function ToggleCigaretteInMouth(playerPed)
    if not cigarMounth then
        local gender = GetPlayerGender(playerPed)
        local timeout = 3000
        if gender == "female" then
            lib.requestAnimDict("amb@world_human_smoking@female@idle_a", 5000)
            TaskPlayAnim(playerPed, "amb@world_human_smoking@female@idle_a",
                "idle_b", 8.0, -8.0, -1, 50, 0, false, false, false)
            timeout = 5000
        else
            lib.requestAnimDict("amb@world_human_aa_smoke@male@idle_a", 5000)
            TaskPlayAnim(playerPed, "amb@world_human_aa_smoke@male@idle_a",
                "idle_c", 8.0, -8.0, -1, 50, -1, false, false, false)
            timeout = 3000
        end
        cigarMounth = true
        if lib.progressBar({
                duration = timeout,
                label = 'Colocando cigarro de la boca...',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                },
            }) then
            ClearPedTasks(playerPed)
            DetachEntity(smoking, true, false)
            local mounthPositions = Config.MounthPositions[activeItem]
            AttachEntityToEntity(smoking, playerPed, 99, mounthPositions.x, mounthPositions.y, mounthPositions.z, mounthPositions.rot.x, mounthPositions.rot.y,mounthPositions.rot.z, true, true, false, false, 2, true)
        end
    else
        local gender = GetPlayerGender(playerPed)
        local timeout = 3000
        local mounthPositions = Config.MounthPositions[activeItem]
        if gender == "female" then
            lib.requestAnimDict("amb@world_human_smoking@female@idle_a", 5000)
            TaskPlayAnim(playerPed, "amb@world_human_smoking@female@idle_a",
                "idle_b", 8.0, -8.0, -1, 50, 0, false, false, false)
                
                AttachEntityToEntity(smoking, playerPed, 99, mounthPositions.x, mounthPositions.y, mounthPositions.z, mounthPositions.rot.x, mounthPositions.rot.y,mounthPositions.rot.z, true, true, false, false, 2, true)
            timeout = 5000
        else
            lib.requestAnimDict("amb@world_human_aa_smoke@male@idle_a", 5000)
            TaskPlayAnim(playerPed, "amb@world_human_aa_smoke@male@idle_a",
                "idle_c", 8.0, -8.0, -1, 50, -1, false, false, false)
                AttachEntityToEntity(smoking, playerPed, 99, mounthPositions.x - 0.03, mounthPositions.y, mounthPositions.z, mounthPositions.rot.x, mounthPositions.rot.y,mounthPositions.rot.z, true, true, false, false, 2, true)
            timeout = 3000
        end

        if lib.progressBar({
                duration = timeout,
                label = 'Quitando el cigarro de la boca...',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                },
            }) then
            cigarMounth = false
            local objectPosition = Config.Positions[activeItem]
            local boneIndex = GetPedBoneIndex(playerPed, 28422)
            AttachEntityToEntity(smoking, playerPed, boneIndex,
                objectPosition.x,
                objectPosition.y,
                objectPosition.z,
                objectPosition.rot.x,
                objectPosition.rot.y,
                objectPosition.rot.z,
                true, true, false, false, 2, true)
        end
    end
end

function SmokeCigarette(playerPed)
    local gender = GetPlayerGender(playerPed)
    if gender == "female" then
        if not cigarMounth then
            local animationNumber = math.random(1, #Config.Animations.female)
            local animDict = Config.Animations.female[animationNumber].dict
            local animClip = Config.Animations.female[animationNumber].anim
            TaskPlayAnim(playerPed, animDict, animClip, 8.0, -8.0, -1, 50, 0, false, false, false)
        end
    else
        if not cigarMounth then
            local animationNumber = math.random(1, #Config.Animations.male)
            local animDict = Config.Animations.male[animationNumber].dict
            local animClip = Config.Animations.male[animationNumber].anim
            TaskPlayAnim(playerPed, animDict, animClip, 8.0, -8.0, -1, 50, 0, false, false, false)
        end
    end

    if lib.progressBar({
            duration = 8000,
            label = 'Fumando',
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
            },
        }) then
        count = count - 1
        if count <= 0 then
            DropCigarette(playerPed)
        end
    end
end

function DropCigarette(playerPed)
    local dropCigarAnim = {
        dic = "amb@world_human_smoking@male@male_a@exit",
        anim = "exit",
    }
    lib.requestAnimDict(dropCigarAnim.dic, 5000)
    TaskPlayAnim(playerPed, dropCigarAnim.dic, dropCigarAnim.anim, 8.0, -8.0, -1, 50, 0, false, false,
        false)
    if lib.progressBar({
            duration = 2000,
            label = 'Tirando cigarro',
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
            },
        }) then
        SetEntityAsNoLongerNeeded(smoking)
        DetachEntity(smoking, true, false)
        ClearPedTasks(playerPed)
        Entity(playerPed).state:set("smoking", false, true)
        activeItem = nil
        smoking = nil
        count = nil
    end
end

function StopCigarette(playerPed)
    Entity(playerPed).state:set("smoking", false, true)
    StopParticleFxLooped(particle, 0)
    ClearPedTasks(playerPed)
    DeleteObject(smoking)
    smoking = nil
    count = nil
    particle = nil
end
