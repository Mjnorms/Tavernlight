AREA_FRIGO = {
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 1, 1, 0, 0, 0, 0},
        {1, 1, 0, 2, 0, 1, 1},
        {0, 1, 1, 0, 0, 0, 0},
        {0, 0, 1, 1, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0},
        {0, 0, 1, 0, 1, 1, 0},
        {0, 0, 0, 2, 0, 1, 0},
        {0, 0, 1, 1, 1, 1, 0},
        {0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 1, 2, 1, 1, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 2, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    }
}
-- in order to create the illusion of a churning storm, I needed areas to rotate through
-- made sure that the large tornados are constant while the small ones pop in and out

-- ms of delay between each area combat
local animationDelay = 250
-- times to loop through the table of areas 
local  loops = 3

-- create a table of combats 
local combat = {}
for i = 1, #AREA_FRIGO do
	combat[i] = Combat()
	combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
	combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
	combat[i]:setArea(createCombatArea(AREA_FRIGO[i]))
end

-- need a callback function for the events we are going to add with delay
local function executeCombat(info, i)
	if ( not info.player or not info.player:isPlayer() ) then
		return false
	end
	info.combat[i]:execute(info.player, info.variant)
end

function onCastSpell(player, variant)

	-- not sure about how much damage this spell should do
	-- took the damage calculations from eternal winter
    local level = player:getLevel()
    local magicLevel = player:getMagicLevel()
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50

	-- create a table of variables our callback will need
	local info = {player = player, variant = variant, combat = combat}

	for j = 0, loops - 1 do
		for i = 1, #AREA_FRIGO do
			-- setFormula for the damage, rather than set callback function as otherwise we have an error
			combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)

			-- calculate the delay in ms of this event
			delay = (animationDelay * (i - 1)) + (animationDelay * #AREA_FRIGO * j)
			-- add events on a delay to call execute, so that the storm appears to be churning
			addEvent(executeCombat, delay , info, i) 
		end
	end
	return true
end
