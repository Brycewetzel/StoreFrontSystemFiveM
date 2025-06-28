local QBCore = exports['qb-core']:GetCoreObject()
local Marketplace = {}

RegisterServerEvent("rod_market:getItems")
AddEventHandler("rod_market:getItems", function()
    local src = source
    TriggerClientEvent("rod_market:openMenu", src, Marketplace)
end)

RegisterServerEvent("rod_market:listItem")
AddEventHandler("rod_market:listItem", function(item, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.Functions.RemoveItem(item, amount) then
        local newItem = {
            id = math.random(100000, 999999),
            name = QBCore.Shared.Items[item].label,
            item = item,
            amount = amount,
            price = price,
            seller = Player.PlayerData.charinfo.firstname
        }
        table.insert(Marketplace, newItem)
        TriggerClientEvent("QBCore:Notify", src, "Item listed!")
    else
        TriggerClientEvent("QBCore:Notify", src, "You don’t have that item!", "error")
    end
end)

RegisterServerEvent("rod_market:buyItem")
AddEventHandler("rod_market:buyItem", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for i, v in pairs(Marketplace) do
        if v.id == data.id then
            local totalPrice = v.price * v.amount
            if Player.Functions.RemoveMoney("cash", totalPrice) then
                Player.Functions.AddItem(v.item, v.amount)
                table.remove(Marketplace, i)
                TriggerClientEvent("QBCore:Notify", src, "Item purchased!")
            else
                TriggerClientEvent("QBCore:Notify", src, "Not enough cash!", "error")
            end
            break
        end
    end
end)
