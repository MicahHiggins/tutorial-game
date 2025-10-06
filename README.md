# tutorial-game
Written tutorial used: https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html (all assets used are inside here)
Video tutorial used for healthbar help: https://www.youtube.com/watch?v=GwCiGixlqiU&ab_channel=GDQuest 
Used for sprite help: https://godotengine.org/asset-library/asset/2716

Assets:
	Shield - https://havran.itch.io/wooden-shield-2/download/eyJleHBpcmVzIjoxNzU4MDQzMjIzLCJpZCI6NDIxODk4fQ%3d%3d.IFkfmMzonrk973F011WRAArYqjk%3d 
	Bomb - https://www.deviantart.com/raenko87/art/FREE-Simple-Bomb-Sprite-746596954
	Heart - https://xxashuraxx.itch.io/heart
	Bolt - https://pngimg.com/image/28062
	Used for Music Creation - https://suno.com/create?wid=default
	Background Water - https://ninjikin.itch.io/water
	Fish - https://pixelgnome.itch.io/fish/download/eyJleHBpcmVzIjoxNzU5Mjg4MzU2LCJpZCI6MzM0MDE1Nn0%3d.2eGl3ykzsCamsCfUCiaZ9KYS6Y0%3d
	Shark - https://sergeant-slash.itch.io/32x32-animated-shark-sprite
	More Underwater Enemies - https://free-game-assets.itch.io/free-underwater-enemies-pixel-art-character-pack
	
9/8-9/9
	Tutorial took me roughly 3-4 hours to complete

	Planned to change 1.Add Healthbar, 2.Increase Screen Size, 3. Darken background color as score rises

	Changes applied, took roughly 3 hours I want to increase mob speed size over time or maybe total number of mobs. 
	I like the darkening effect, makes it feel like we go continuously deeper underwater

	Sorry, I didn't read the assignment well before comitting so my 3 changes were all done at once and have poor commit message names. 
	Made the mobs faster over time, and spawn more over time, took about an hour and a half

9/15
	Game Loop Ideas
	The game as a whole will be a difficulty soft gate where you try to get as far as you can
	Power ups - Shield, temporary blue bar that absorbs some hits
			  - Heal
			  - Clear Screen, wipes all the enemies currently on the screen
9/16
	Added health and shield powerups but the collisions aren't working. Took about 4 hours
	
	Added Bomb powerup, dash skill and fast enemies once you reach a certain point. Powerup collisions still aren't working and I have no idea why. Took probably 4 more hours. Around 8 hours total today, mostly due to trying to figure out why collisions aren't working
	
9/17
	FastEnemies and Bolt now despawn when starting a new game, took 40 minutes or so
	
	
9/22
	Heal and Shield powerups now properly update their corresponding progress bars, took roughly an hour
	Fixes Needed: Bolt needs to give ability to dash
					Dash can't be spammed
					Diagonal Dash travels same distance as orthographic movement
					
	Improvements Desired: Background color gets darker gradually, better descending effect
						Particles for player movement and dash
						Better assets for player/enemy
						More sound effects
					
9/23
	You can't dash without picking up the lightning bolt now, diagnol dashing doesn't give a boost (still broken though, dashing down/left doesn't work for some reason)
	Added a light to the player (Needs improvement, want it to be more apparent as the background gets darker but it's the opposite right now)
	Added simple particles to the player and the fast enemies
	Added custom music
	These 4 additions/fixes took roughly 3.5 to 4 hours
	Total time spent this week: ~5.5 hours
	
9/29
	Added Shark sprite for fast enemy
	Followed the tilemap tutorial and used a water background
	Not sure I will keep the animations	
	Took ~2.5 hours

9/30
	Session 1 ~2 hours
		Added camera that moves down
		Adjusted Lighting
		Changed font color
		Trying to get mob path and power up paths to move down with the camera but it's not working
		
	Session 2 ~1.75 hours
		Replaced tutorial enemies with fish
		Adjusted mob spawing so that it looks like the fish are swimming away from sharks
		Mobs spawn location is based on player location instead of path since I couldn't move the path with the camera
		Lengthened background art
		
	
	
