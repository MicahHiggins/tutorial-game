extends Node

@export var mob_scene: PackedScene
@export var power_up_scene: PackedScene  = preload("res://power_up.tscn")
@export var Shield_scene: PackedScene  = preload("res://Shield.tscn")

#@onready var player_node= get_node("player")
var score =0
var score2 = 0.0
var scoreCheck = 0
var BLUE = Color(0.38,0.50,0.90,1.0)


func _ready():
	pass



func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HealthPowerTimer.stop()
	$ShieldPowerTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	score2 = 0.0
	scoreCheck = 0
	%Player.health = 100.0
	%ColorRect.color = BLUE
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("power_ups", "queue_free")
	get_tree().call_group("Shields", "queue_free")
	$Music.play()
	#%player.protection.hide()
	
func _process(delta):
	$MobTimer.wait_time = 1.0/((score2/15) + 5.0)
	#print($MobTimer.wait_time)
	if score >= (scoreCheck + 10):
		scoreCheck=score
		var darkColor = %ColorRect.color #Color(0.1,0.1,0.1,0.1)
		
		darkColor.r -= 0.04
		darkColor.g -= 0.055
		darkColor.b -= 0.1
		
		print(darkColor)
		%ColorRect.color = darkColor
		
	#if  $powerUp.HealBox.overlaps_area($player/HurtBox):
	#	get_tree().call_group("power_ups", "queue_free")
	#	print("boom")
#	#	queue_free()
#		heal.emit()
		
func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0+(score*3), 250.0+(score*10)), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score += 1
	score2+= 1.0
	$HUD.update_score(score)
	


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$HealthPowerTimer.start()
	$ShieldPowerTimer.start()



func _on_health_power_timer_timeout() -> void:
	get_tree().call_group("power_ups", "queue_free")
		
	var HP = power_up_scene.instantiate()
	# Choose a random location on Path2D.
	var HealthUp_spawn_location = $PowerUpPath/PowerUpSpawnLocation
	HealthUp_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	HP.position = HealthUp_spawn_location.position
	add_child(HP)

func _on_shield_power_timer_timeout() -> void:
	get_tree().call_group("Shields", "queue_free")
	var SHLD = Shield_scene.instantiate()
	var ShieldUp_spawn_location = $PowerUpPath/PowerUpSpawnLocation
	ShieldUp_spawn_location.progress_ratio = randf()
	# Set the mob's position to the random location.
	SHLD.position = ShieldUp_spawn_location.position
	add_child(SHLD)

func _on_power_up_heal() -> void:
	%Player.health += 20.0
	
func _on_shield_shielded() -> void:
	%player.protection += 1.0
	if %player.protection > 0:
		%player.protection.show()
