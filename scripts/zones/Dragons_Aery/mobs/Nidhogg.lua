-----------------------------------
-- Area: Dragons Aery
--  HNM: Nidhogg
-----------------------------------
local ID = require("scripts/zones/Dragons_Aery/IDs")
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes

    -- Despawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobFight = function(mob, target)
    local battletime = mob:getBattleTime()
    local twohourTime = mob:getLocalVar("twohourTime")

    if twohourTime == 0 then
        mob:setLocalVar("twohourTime", math.random(30, 90))
    end

    if battletime >= twohourTime then
        mob:useMobAbility(1053) -- Legitimately captured super_buff ID
        mob:setLocalVar("twohourTime", battletime + math.random(60, 120))
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.NIDHOGG_SLAYER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
