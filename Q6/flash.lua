local combat = {}
local num_jumps = 6
local animationDelay = 50

for i = 1, num_jumps do
	combat[i] = Combat()
	combat[i]:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
end

local unwanted_tilestates = { TILESTATE_PROTECTIONZONE, TILESTATE_HOUSE, TILESTATE_FLOORCHANGE, TILESTATE_TELEPORT, TILESTATE_BLOCKSOLID, TILESTATE_BLOCKPATH }

local function executeCombat(info, i)
    local toPosition = false
    toPosition = info.player:getPosition()
    toPosition:sendMagicEffect(CONST_ME_TELEPORT)
    toPosition:getNextPosition(info.player:getDirection(), 1)

    local tile = toPosition and Tile(toPosition)
    if not tile then
        return false
    end

    for _, tilestate in pairs(unwanted_tilestates) do
        if tile:hasFlag(tilestate) then
            info.player:sendCancelMessage("You can't dash any further.")
            return false
        end
    end

    info.player:teleportTo(toPosition)

    return combat[i]:execute(info.player, info.variant)
end


function onCastSpell(creature, variant, isHotkey)
	local info = {player = creature, variant = variant, combat = combat}
    for i = 1, num_jumps do 
        addEvent(executeCombat, animationDelay * i , info, i) 
    end
end