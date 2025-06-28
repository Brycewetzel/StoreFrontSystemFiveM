local QBCore = exports['qb-core']:GetCoreObject()

-- Blip
CreateThread(function()
    local blip = AddBlipForCoord(Config.ShopLocation)
    SetBlipSprite(blip, Config.ShopBlip.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.ShopBlip.scale)
    SetBlipColour(blip, Config.ShopBlip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.ShopBlip.name)
    EndTextCommandSetBlipName(blip)
end)

-- Marker and interaction
CreateThread(function()
    while true do
        Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local dist = #(coords - Config.ShopLocation)

        if dist < 10.0 then
            DrawMarker(2, Config.ShopLocation.x, Config.ShopLocation.y, Config.ShopLocation.z, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 0, 255, 100, 200, false, true)
            if dist < 1.5 then
                DrawText3D(Config.ShopLocation, "[E] Open Marketplace")
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("rod_market:getItems") -- Fetch server item list
                end
            end
        else
            Wait(500)
        end
    end
end)

-- Draw Text
function DrawText3D(pos, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

-- Receive item list and open menu
RegisterNetEvent("rod_market:openMenu", function(items)
    local menu = {}

    for _, v in pairs(items) do
        table.insert(menu, {
            header = v.name .. " - $" .. v.price,
            txt = "Seller: " .. v.seller,
            params = {
                event = "rod_market:buyItem",
                args = {
                    id = v.id
                }
            }
        })
    end

    table.insert(menu, {
        header = "💸 Sell an Item",
        params = {
            event = "rod_market:sellItem"
        }
    })

    exports['qb-menu']:openMenu(menu)
end)

-- Sell menu input
RegisterNetEvent("rod_market:sellItem", function()
    local keyboard = exports['qb-input']:ShowInput({
        header = "List Item For Sale",
        submitText = "List Item",
        inputs = {
            {
                text = "Item Name (from inventory)", name = "item", type = "text", isRequired = true
            },
            {
                text = "Amount", name = "amount", type = "number", isRequired = true
            },
            {
                text = "Price per Item", name = "price", type = "number", isRequired = true
            }
        }
    })

    if keyboard then
        TriggerServerEvent("rod_market:listItem", keyboard.item, tonumber(keyboard.amount), tonumber(keyboard.price))
    end
end)
