
local function setMapShader(name)
    local shader = g_shaders.getShader(name)
    local map = modules.game_interface.getMapPanel()

    shader:addPlayerOutfitMultiTexture()
    map:setMapShader(shader)
end


function dash()

    local player = g_game.getLocalPlayer()
    g_game.talk("flash");
end 

function init()

    g_keyboard.bindKeyDown("F1", dash)

	local shader = g_shaders.createFragmentShader('Flash', 'shader/outline.frag')

end

function terminate()

    g_keyboard.unbindKeyDown("F1")
end

