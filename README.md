WIP Theme for SM5 that uses an older build of Simply Love as a base, but hopefully I can fix some problems I had with it along with adding even more features.

# ---------------- Notable changes ----------------

- Removal of visual themes
- Removal of different game modes (ITG only)
- No more difficulty "blocks".
- Instead of blocks now only the numbers are displayed, but enlarged and accompanied by a highlight cursor to indicate which difficulty you've selected. Both cursors are colored based on player.
- The chart pane on screen select music (the thing that lists steps, holds, etc) has the difficulty number removed as well. Don't need the redundancy of having the difficulty shown in 3 different ways. Also gives more space for additional info in the future.
- Density graphs always present on screen select music along with a generalized breakdown if any.
- Step artist field extended and text made slightly smaller to fit more information before it gets squished into oblivion.
- Difficulties are colored by their actual difficulty :O wow
- CDTitle support added (I think I have it so most sizes will work ?)
- Massive removal of bloat from the theme bringing it down from ~120mbs to just shy of 40mbs (over half of that is the background video on select music LOL)
- Preview music no longer loops.
- Song title present at the bottom of the mod menu.
- Style indicator at the top right on evaluation (to distinguish between single and double)
- The per column note tracking will stop counting up once you fail. (This makes determining pad issues a lot easier.)
- Player stats added that include things like steps per set/lifetime, songs in set/lifetime, average bpm, average difficulty.
- Added Player Stats support to 4:3 displays (Only in 1 player mode)
- Average difficulty will now account for rate mods : )
- Each player can have their own unique profile picture and if one isn't present then a default image will appear in place.
- Each player gets their own difficulty selection instead of being shared.
- Music wheel is centered and each player's assets are on their own side instead of arbitrarily having P2 cover up the wheel when playing. (Only on widescreen)
- Added a song search function. (Up + Enter on Screen Select Music)

# ---------------- How to use a profile picture ----------------

- Add a new image at the root of your save folder of your profile.
- (Example: \Save\LocalProfiles\00000000\Profile Picture.png)

The image must:
- Be in png format
- Have a 1:1 aspect ratio for best appearance. (Image will be resized as such).
- Be titled "Profile Picture"

# -- KNOWN ISSUES and general things to note --

- Theme is intended for home use only.
- Theme will not work without a profile.
- I have no idea if this still works properly outside of event mode? (it might? idk lol)
- Scrolling to a marathon on screen select music will cause some lag while it tries to draw the density graph.
- CDTitles appear on top of the sort menu despite draw orders being correct x_x

# ---------------- TO DO ----------------

- Make the density graph load in chunks so that when loading a marathon you're not stuck waiting for the entire thing to load preventing you from scrolling. (You can actually scroll now while it's loading, but it's still slow).
- Add back in the pacemaker goal. (there was some issues early on that made me remove it and then it got added back, but forgot to add that part too lol)
- Maybe add more player stats (highest difficulty passed?)
- I really want to add a chart preview, but I don't know how realistic it is to do that theme-side and not be a laggy mess.
- Completely remove game modes. (competitive/itg mode still technically exists and I'd rather it not set all the metrics and things through lua)
- Fix CDTitles to not appear on top of the sort menu.
- Remake screen select music through lua to add custom sort/subsort and filter options... and also not be a laggy mess...
- Clean up my code. (it's very messy and unoptimized atm x___x) At least most things are labeled lol
