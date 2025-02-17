-----------------------------------
-- Area: Attohwa Chasm
--  NPC: ???
-- !pos -402.574 3.999 -202.750 7
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local nm = GetMobByID(ID.mob.FEELER_ANTLION)
    if not nm:isSpawned() and trade:hasItemQty(1825, 1) and trade:getItemCount() == 1 then
        player:tradeComplete()
        nm:setSpawn(npc:getXPos() - 3, npc:getYPos() - 2, npc:getZPos() - 1)
        SpawnMob(ID.mob.FEELER_ANTLION):updateClaim(player)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.OCCASIONAL_LUMPS)
end

return entity
