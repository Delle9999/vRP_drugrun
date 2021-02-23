local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "vrp_drugrun") 
vRP = Proxy.getInterface("vRP")

RegisterServerEvent('coke:done')
AddEventHandler('coke:done', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local antal = math.random(1000,2000)
    vRP.giveInventoryItem({user_id,"dirty_money",antal,true})
    TriggerClientEvent('ferdigmission', source)
end)

RegisterServerEvent('hamp:done')
AddEventHandler('hamp:done', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local antal = math.random(1000,2000)
    vRP.giveInventoryItem({user_id,"dirty_money",antal,true})
    TriggerClientEvent('ferdigmission', source)
end)

RegisterServerEvent('givmdma')
AddEventHandler('givmdma', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local money = vRP.getMoney({user_id})
    if money > 500 then
        vRP.tryPayment({user_id,500})
        vRP.giveInventoryItem({user_id,"mdma",10,true})
        TriggerClientEvent('harafleveretmdma')
    else
        TriggerClientEvent('harikraed', source)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke råd!', length = 2500, style = { ['background-color'] = '#1e5d76', ['color'] = '#ffffff' } })
    end
end)

RegisterServerEvent('afleveretmdma')
AddEventHandler('afleveretmdma', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasInventoryItem({user_id, "mdma", 10, false}) then
        local money = math.random(1000,2000)
        vRP.giveInventoryItem({user_id,"dirty_money",money,true})
        TriggerClientEvent('ferdigmission', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Mangler 10 mdma piller!', length = 2500, style = { ['background-color'] = '#1e5d76', ['color'] = '#ffffff' } })
    end
end)
