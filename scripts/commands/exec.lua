-----------------------------------
-- func: exec
-- desc: Allows you to execute a Lua string directly from chat.
-----------------------------------

cmdprops =
{
    permission = 4,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!exec <Lua string>")
end

function onTrigger(player, str)
    -- Ensure a command was given..
    if str == nil or string.len(str) == 0 then
        error(player, "You must enter a string to execute.")
        return
    end

    -- For safety measures we will nuke the os table..
    local old_os = os
    os = nil

    -- Define "player" and "target" inside the string for use by the caller
    local define_player = "local player = GetPlayerByName(\"" .. player:getName() .. "\"); "
    local define_target = "local target = player:getCursorTarget(); "

    -- Ensure the command compiles / is valid..
    local scriptObj, err0 = loadstring(define_player .. define_target .. str)
    if scriptObj == nil then
        player:PrintToPlayer("Failed to load the given string.")
        player:PrintToPlayer(err0)
        os = old_os
        return
    end

    -- Execute the string..
    local successfullyExecuted, errorMessage = pcall(scriptObj)
    if not successfullyExecuted then
        player:PrintToPlayer("Error calling: " .. str .. "\n" .. errorMessage)
    end

    -- Restore the os table..
    os = old_os
end
