
--[[ Q1
  Check the arguments before calling functions 
  
  Define a constant for what I am assuming is the storage key as
  it was confusing with having a 1000ms delay and a key that was 
  also 1000
]]


local STORAGE_KEY = 1000 -- Define a constant for the storage key

local function releaseStorage(player)
    -- Check if player exists and is a valid player object
    if player and player:isPlayer() then
        player:setStorageValue(STORAGE_KEY, -1)
    end
end

function onLogout(player)
    -- Check if player exists and is a valid player object
    if player and player:isPlayer() then
      if player:getStorageValue(STORAGE_KEY) == 1 then
          addEvent(releaseStorage, 1000, player)
      end
    end
    return true
end

--[[ Q2
  Add a check for the result to make sure it actually came back
  
  Loop through all results instead of just printing the first
  I'm assuming that resultId is a set of names that privides the :next()
  method
]]

function printSmallGuildNames(memberCount)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    -- Make sure result exists
    if not resultId then
        print("Error executing small guild name query")
        return
    end
    
    -- Loop through all results and print each 
    while resultId:next() do
        local guildName = resultId:getString("name")
        print(guildName)
    end
end

--[[ Q3
  The end goal is to remove a requested member(memberName) from the player's party
  We can do that calling removeMember(Player type)
  From the code given it looks like we can construct the requested Player by 
  calling Player(memberName); we don't have to do the loop comparison.
  
  Updated the name as well
]]
-- function name change to better represent function
function removeMemberFromPlayerParty(playerId, memberName)
    -- add local to player for better scope management
    local player = Player(playerId)
    local party = player:getParty()
    -- retrive member without looping through party list
    local member = Player(memberName)

    -- remove requested member from party
    party:removeMember(member)
end







































