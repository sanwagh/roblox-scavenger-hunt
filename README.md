# Scavenger Hunt

A team scavenger hunt built in Roblox. Players get a clue, guess the item it describes, then find it in the world to score points for their team.

2023. Solo project.

## What it is

Players queue up in a lobby, get grouped by game mode, and are teleported together into a live match. A short walkthrough teaches the hint-guess-find loop the first time someone joins, then steps aside for the real thing.

## Splitting the game into three places

The lobby, the tutorial, and the match itself each run as their own Roblox place, joined by TeleportService rather than being screens inside one server. The idea was to keep each phase's state contained to the server running it. The matchmaking queue and the anti-cheat counters for a session live in that place's own ServerStorage tree for as long as that server is up, instead of one server holding the queue, the tutorial, and the match all at once.

## Anti-cheat: tolerance for movement, none for tampering

Movement gets sampled once a second and compared against the player's WalkSpeed. Drift past a threshold snaps the player back to their last position and adds a flag, and only after five flags does it kick. Entering a noclip movement state kicks immediately, with no tolerance at all. A separate check kicks on the spot if the anti-cheat's own module folder is missing when it looks for it, on the assumption that its absence means someone deleted it. Every kick and flag gets posted to a Discord webhook along with the player's account age and user ID, so it can be reviewed outside the game. This resource was taken from the Roblox Marketplace.

## Status

Released in 2023. The game is private now.
