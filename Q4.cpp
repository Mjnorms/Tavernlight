/* 
The memory leak here comes from when we leave the addItemToPlayer function, the Player* player
goes out of scope, and the address is erased off the stack. However, it was the only pointer 
pointing at the new  Player() created on the heap, so we can never clear it. RIP

Since the prompt says we can assume everything works fine, I will just delete the newly 
constructed player any time we leave this function.
*/
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool createdPlayer = false; // Flag to track whether we created a new player

    if (!player) 
    {
        player = new Player(nullptr);
        createdPlayer = true; // Set the flag since we created a new player
        if (!IOLoginData::loadPlayerByName(player, recipient)) 
        {
            delete player; // Free the memory since loadPlayerByName failed
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) 
    {
        delete player; // Free the memory since the item could not be created
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) 
    {
        IOLoginData::savePlayer(player);
    }

    if (createdPlayer)
    {
        delete player; // Free the memory once we want to leave the function
    }
}