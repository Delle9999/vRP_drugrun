local delay = 200
local valgt = true

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(delay)
        while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1275.73828125,-1710.3096923828,54.771480560303, true) <= 2 do
            delay = 1
            Citizen.Wait(delay)
            DrawMarker(20, 1275.73828125,-1710.3096923828,54.771480560303, 0,0,0,0,0,0,0.5001,0.5001,0.5001, 7, 102, 198, 180,0,0,0,10)
            DrawText3Ds(1275.73828125,-1710.3096923828,54.771480560303, "~b~[E]~w~ - Start Mission")
            if IsControlJustReleased(0, 38) then 
                TriggerEvent('openui:menuopen')
            end
        end
        delay = 200
    end
end)

RegisterNetEvent("openui:menuopen")
AddEventHandler("openui:menuopen", function()
    SetNuiFocus(true, true)
    Citizen.Wait(100)
    SendNUIMessage({status = true})
end)
-- Drug Locals --
local aflever = false

RegisterNUICallback("farve1", function (data, callback)
    if valgt == true then
        valgt = false
        SetNewWaypoint(1261.9052734375,324.57275390625)
        createfailedped()
        exports['mythic_notify']:SendAlert('inform',"Du har nu valgt Kokain Missionen. Kør til din GPS, og skaf den stjålede bil")
        local spawncar = true
        local lockpick = true
        local vehiclehash = GetHashKey("speedo")
        RequestModel(vehiclehash)
        while not HasModelLoaded(vehiclehash) do
            RequestModel(vehiclehash)
            Citizen.Wait(1)
        end
        local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 15.0, 0)
        local spawned_car = CreateVehicle(vehiclehash,1261.9052734375,324.57275390625,81.990928649902, true, false)
        SetEntityAsMissionEntity(spawned_car, true, true)
        spawncar = false
        lockStatus = GetVehicleDoorLockStatus(spawned_car)
        if lockStatus == 0 or lockStatus == 1 then
            SetVehicleDoorsLocked(spawned_car, 2)
            SetVehicleDoorsLockedForPlayer(spawned_car, PlayerId(), false)
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(1)
                    if lockpick == true then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1261.9052734375,324.57275390625,81.990928649902, true) <= 2.5 then
                                DrawText3Ds(1261.9052734375,324.57275390625,81.990928649902, "~b~[E]~w~ - for at ~y~Lockpicke Bilen")
                                if IsControlJustReleased(0, 38) then 
                                    TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                                    lockpick = false
                                    exports['mythic_progbar']:Progress({name = "firstaid_action", duration = 5000, label = "Lockpicker Køretøj...", useWhileDead = false, canCancel = true, controlDisables = {disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true}})
                                    Citizen.Wait(5000)
                                    ClearPedTasksImmediately(GetPlayerPed(-1))
                                    SetVehicleDoorsLocked(spawned_car, 1)
                                    exports['mythic_notify']:SendAlert('inform',"Du har nu lockpicked køretøjet")
                                    aflever = true
                                    if IsPedInVehicle(PlayerPedId(),GetVehiclePedIsIn(PlayerPedId()),true) == true then
                                        exports['mythic_notify']:SendAlert('inform',"Transporter køretøjet tilbage.")
                                        SetNewWaypoint(1275.73828125,-1710.3096923828)
                                        AfleverKoretoj()
                                    end
                                end
                            end
                    end
                end
            end)
        end
    else
        exports['mythic_notify']:SendAlert('inform',"Du har allerede en mission igang.")
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local afleveret = false
        if aflever == true then
            if valgt == false then
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1279.9342041016,-1731.5393066406,52.597984313965, true) <= 5 then
                    if afleveret == false then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                            DrawMarker(20, 1279.9342041016,-1731.5393066406,52.597984313965, 0,0,0,0,0,0,0.5001,0.5001,0.5001, 7, 102, 198, 180,0,0,0,10)
                            DrawText3Ds(1279.9342041016,-1731.5393066406,52.597984313965, "~b~[E]~w~ - Aflever Køretøj")
                            if IsControlJustReleased(0, 38) then 
                                afleveret = true
                                SetEntityAsMissionEntity(GetVehiclePedIsIn(GetPlayerPed(-1)), true, true)
                                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))  
                                exports['mythic_notify']:SendAlert('inform',"Du har nu aflevert bilen, og har modtaget din beløning.")
                                TriggerServerEvent('coke:done')
                            end
                        end
                    end
                end
            end

        end
    end
end)

RegisterCommand('afslutmission', function()
    valgt = true
    exports['mythic_notify']:SendAlert('inform',"Din nuværende mission er nu resat")
end)

function createfailedped()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local hashKey = GetHashKey("ig_casey")
    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(500)
    end
    guard6 = CreatePed(4, hashKey, 1262.2750244141,313.59701538086,85.99048614502,56.10228729248, false, false)

    SetPedShootRate(guard6,  750)
    SetPedCombatAttributes(guard6, 46, true)
    SetPedFleeAttributes(guard6, 0, 0)
    SetPedAsEnemy(guard6,true)
    SetPedMaxHealth(guard6, 900)
    SetPedAlertness(guard6, 3)
    SetPedCombatRange(guard6, 0)
    SetPedCombatMovement(guard6, 3)
    TaskCombatPed(guard6, GetPlayerPed(-1), 0,16)
   -- TaskLeaveVehicle(guard, vehicle, 0)
    GiveWeaponToPed(guard6, GetHashKey("WEAPON_PISTOL"), 5000, true, true)
    SetPedRelationshipGroupHash( guard6, GetHashKey("HATES_PLAYER"))
end

function enemys()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local hashKey = GetHashKey("a_m_m_farmer_01")
    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(500)
    end
    guard6 = CreatePed(4, hashKey, 2218.1159667969,5615.671875,54.735157012939,5.5996985435486, false, false)

    SetPedShootRate(guard6,  750)
    SetPedCombatAttributes(guard6, 46, true)
    SetPedFleeAttributes(guard6, 0, 0)
    SetPedAsEnemy(guard6,true)
    SetPedMaxHealth(guard6, 900)
    SetPedAlertness(guard6, 3)
    SetPedCombatRange(guard6, 0)
    SetPedCombatMovement(guard6, 3)
    TaskCombatPed(guard6, GetPlayerPed(-1), 0,16)
   -- TaskLeaveVehicle(guard, vehicle, 0)
    GiveWeaponToPed(guard6, GetHashKey("WEAPON_PISTOL"), 5000, true, true)
    SetPedRelationshipGroupHash( guard6, GetHashKey("HATES_PLAYER"))
end

RegisterNUICallback("farve2", function (data, callback)
    if valgt == true then
        valgt = false
        exports['mythic_notify']:SendAlert('inform',"Du har nu valgt Hamp Missionen. Kør til din GPS")
        enemys()
        local vilaflevere = true
        local afleverkasse = true
        local object = createProp(2195.7270507813,5592.515625,54.545471191406)
        SetNewWaypoint(2194.1228027344,5593.82421875)
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(1)
                if afleverkasse == true then
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2194.0856933594,5593.9243164063,53.754402160645, true) <= 5 then
                        DrawMarker(20, 2194.2353515625,5593.794921875,53.752964019775, 0,0,0,0,0,0,0.5001,0.5001,0.5001, 7, 102, 198, 180,0,0,0,10)
                        DrawText3Ds(2194.2353515625,5593.794921875,53.752964019775, "~b~[E]~w~ - Tag Kasse")
                        if IsControlJustReleased(0, 38) then 
                            afleverkasse = false
                            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                            exports['mythic_progbar']:Progress({name = "firstaid_action", duration = 5000, label = "Samler kasse op...", useWhileDead = false, canCancel = true, controlDisables = {disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true}})
                            Citizen.Wait(5000)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                            DeleteObject(object)
                            madpak = CreateObject(GetHashKey("hei_prop_drug_statue_box_big"), 0, 0, 0, true, true, true)
                            AttachEntityToEntity(madpak, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
                            exports['mythic_notify']:SendAlert('inform',"Aflever nu kassen tilbage")
                            SetNewWaypoint(1275.73828125,-1710.3096923828)
                            Citizen.CreateThread(function()
                                while true do 
                                    Citizen.Wait(1)
                                    if vilaflevere == true then
                                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1268.6319580078,-1710.4681396484,54.771492004395, true) <= 5 then
                                            DrawMarker(20, 1268.6319580078,-1710.4681396484,54.771492004395, 0,0,0,0,0,0,0.5001,0.5001,0.5001, 7, 102, 198, 180,0,0,0,10)
                                            DrawText3Ds(1268.6319580078,-1710.4681396484,54.771492004395, "~b~[E]~w~ - Aflever kasse")
                                            if IsControlJustReleased(0, 38) then 
                                                vilaflevere = false
                                                TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                                                exports['mythic_progbar']:Progress({name = "firstaid_action", duration = 5000, label = "Samler kasse op...", useWhileDead = false, canCancel = true, controlDisables = {disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true}})
                                                Citizen.Wait(5000)
                                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                                DeleteObject(madpak)
                                                exports['mythic_notify']:SendAlert('inform',"Du har nu aflevert kassen, og har modtaget din beløning.")
                                                TriggerServerEvent('hamp:done')
                                            end
                                        end
                                    end
                                end
                            end)   
                        end
                    end
                end
            end
        end)
    else
        exports['mythic_notify']:SendAlert('inform',"Du har allerede en mission igang.")
    end
end)

function createProp(x, y, z)
    local prop = "hei_prop_drug_statue_box_big"
    propspawn = CreateObject(GetHashKey(prop), x, y, z, 1, 1, 1)
end

local afleverdrugs = true

RegisterNUICallback("farve3", function (data, callback)
    if valgt == true then
        valgt = false
        exports['mythic_notify']:SendAlert('inform',"Du har nu valgt MDMA missionen. Find dealeren og handel med ham")
        local hashKey = GetHashKey("s_m_y_dealer_01")
    
        RequestModel(hashKey)
        while not HasModelLoaded(hashKey) do
            RequestModel(hashKey)
            Citizen.Wait(500)
        end
        guard6 = CreatePed(4, hashKey, 1477.3278808594,-1917.5895996094,70.450965881348,252.52233886719, false, false)
        FreezeEntityPosition(guard6, true)
        local tekst = true
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(1)
                if tekst == true then
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1477.3278808594,-1917.5895996094,71.450965881348, true) <= 3 then
                        DrawText3Ds(1477.3278808594,-1917.5895996094,71.450965881348, "~b~[E]~w~ - Handel med dealer")
                        if IsControlJustReleased(0, 38) then 
                            local random = math.random(1,2)
                            if random == 1 then
                                exports['mythic_notify']:SendAlert('inform',"Du har gjort dealeren utilfreds")
                                tekst = false
                                FreezeEntityPosition(guard6, false)
                                SetPedShootRate(guard6,  750)
                                SetPedCombatAttributes(guard6, 46, true)
                                SetPedFleeAttributes(guard6, 0, 0)
                                SetPedAsEnemy(guard6,true)
                                SetPedMaxHealth(guard6, 900)
                                SetPedAlertness(guard6, 3)
                                SetPedCombatRange(guard6, 0)
                                SetPedCombatMovement(guard6, 3)
                                TaskCombatPed(guard6, GetPlayerPed(-1), 0,16)
                                GiveWeaponToPed(guard6, GetHashKey("WEAPON_PISTOL"), 5000, true, true)
                                SetPedRelationshipGroupHash( guard6, GetHashKey("HATES_PLAYER"))
                            else
                                if random == 2 then
                                    exports['mythic_notify']:SendAlert('inform',"Dealeren har accepteret din handel. Han ønsker 500,- for pillerne.")
                                    tekst = false
                                    Citizen.Wait(2500)
                                    Citizen.CreateThread(function()
                                        while true do
                                            Citizen.Wait(1)
                                            if afleverdrugs == true then
                                                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1477.3278808594,-1917.5895996094,71.450965881348, true) <= 3 then
                                                    DrawText3Ds(1477.3278808594,-1917.5895996094,71.450965881348, "~b~[E]~w~ - Aflever ~r~500 KR")
                                                    if IsControlJustReleased(0, 38) then 
                                                        TriggerServerEvent('givmdma')
                                                    end
                                                end
                                            end
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        exports['mythic_notify']:SendAlert('inform',"Du har allerede en mission igang.")
    end
end)

RegisterNetEvent('harikraed')
AddEventHandler('harikraed', function()
    afleverdrugs = true
end)

RegisterNetEvent('harafleveretmdma')
AddEventHandler('harafleveretmdma', function()
    afleverdrugs = false
    local mdma = true
    SetNewWaypoint(1272.3948974609,-1711.5767822266)
    exports['mythic_notify']:SendAlert('inform',"Aflever nu pillerne tilbage.")
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if mdma == true then
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1272.3948974609,-1711.5767822266,54.771438598633, true) <= 2 then
                    DrawText3Ds(1272.3948974609,-1711.5767822266,54.771438598633, "~b~[E]~w~ - Aflever piller")
                    if IsControlJustReleased(0, 38) then 
                        mdma = false
                        TriggerServerEvent('afleveretmdma')
                    end
                end
            end
        end
    end)
end)

RegisterNUICallback("farve4", function (data, callback)
    if valgt == true then
        valgt = false
    else
        exports['mythic_notify']:SendAlert('inform',"Du har allerede en mission igang.")
    end
end)
 
RegisterNUICallback("Luk", function (data, callback)
    SetNuiFocus(false, false)
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

RegisterNetEvent('ferdigmission')
AddEventHandler('ferdigmission', function()
    valgt = true
end)

AddEventHandler("onResourceStop",function(a)if a==GetCurrentResourceName()then SetNuiFocus(false,false) end end)