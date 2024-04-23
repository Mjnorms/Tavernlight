-- All functions and variables inside a module are inherently local,
-- but, per edubart's syle recommendations, all public functions should be stored in a table
-- I want to stay consistient with the rest of the modules
JumpGame = {}

jumpWindow = nil
jumpButton = nil
updateEvent = nil
max_margins = {}

-- if module is loaded, create window on game start, and remove on onGameEnd
function init()
  connect(g_game, { onGameStart = JumpGame.create,  onGameEnd = JumpGame.destroy })
end

function terminate()
  disconnect(g_game, { onGameStart = JumpGame.create, onGameEnd = JumpGame.destroy })
  JumpGame.destroy()
  JumpGame = nil
end

-- move the button across the window by decrementing the margins
function JumpGame.update() 
  jumpButton:setMarginLeft(jumpButton:getMarginLeft() - 10)
  -- if the button reaches the left side, reset the button to a starting position
  if jumpButton:getMarginLeft() <= 0 then
    JumpGame.resetButton()
  end
end


function JumpGame.create()
  -- create the window+button and save references to them so we can call functions on the widgets
  jumpWindow = g_ui.displayUI('jumpgame.otui')
  jumpButton = jumpWindow:recursiveGetChildById('jumpButton')
  -- start the cycle of update calls, save the event so we can safely stop the cycle later
  updateEvent = cycleEvent( JumpGame.update , 100)

  -- save the max margins we want for the button so that we don't call all these getters every update
  -- accounts for the anchors being relative to the window's padding
  max_margins = {x = jumpWindow:getWidth() - jumpButton:getWidth() - jumpWindow:getPaddingLeft() - jumpWindow:getPaddingRight(),
                 y = jumpWindow:getHeight() - jumpWindow:getPaddingBottom() - jumpWindow:getPaddingTop() - jumpButton:getHeight()}
end

-- safely remove all local references and turn off the event cycle
function JumpGame.destroy()
  if updateEvent then
    removeEvent(updateEvent)
    updateEvent = nil
  end
  if jumpWindow then
    jumpWindow:destroy()
    jumpWindow = nil
    jumpButton = nil
  end
  max_margins = nil
end

-- reset the button to the right side of the window
-- randomize the y position
function JumpGame.resetButton() 
  jumpButton:setMarginLeft(max_margins.x)
  jumpButton:setMarginTop(math.random(max_margins.y))
end
