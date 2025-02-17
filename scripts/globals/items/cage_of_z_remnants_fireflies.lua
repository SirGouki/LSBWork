-----------------------------------
-- ID: 5398
-- Z. Rem. Fireflies
-- Transports the user out of Zhayolm Remnants
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/teleports")
require("scripts/globals/zone")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getZoneID() == xi.zone.ZHAYOLM_REMNANTS then
        return 0
    end
    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.Z_REM, 0, 1)
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.items.CAGE_OF_Z_REMNANTS_FIREFLIES)
end

return itemObject
