extends Node

@export var mob_scene: PackedScene
@export var power_up_scene: PackedScene  = preload("res://power_up.tscn")
@export var Shield_scene: PackedScene  = preload("res://Shield.tscn")
@export var bomb_scene: PackedScene  = preload("res://bomb.tscn")
@export var bolt_scene: PackedScene  = preload("res://bolt.tscn")
@export var enemy_scene: PackedScene  = preload("res://fast_enemy.tscn")
@onready var player = get_node("root/Game/Player")


#@onready var player_node= get_node("player")
var score =0
var score2 = 0.0
var scoreCheck = 0
var BLUE = Color(0.38,0.50,0.90,1.0)
var Scene1 = false
#var player =


func _ready():
	pass



func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HealthPowerTimer.stop()
	$ShieldPowerTimer.stop()
	$BombPowerTimer.stop()
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
	get_tree().call_group("Bombs", "queue_free")
	$Music.play()
	#%player.protection.hide()
	
func _process(delta):
	$MobTimer.wait_time = 1.0/((score2/15) + 5.0)
	$BombPowerTimer.wait_time = randfn(10.0, 6.0)
	$ShieldPowerTimer.wait_time = randfn(10.0, 6.0)
	$HealthPowerTimer.wait_time = randfn(10.0, 6.0)
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
	#if Scene1 == false:
		#if score >= 5 and score < 10:
		#func _on_bolt_timer_timeout() -> void:
			#
			#
			#$MobTimer.stop()
			#$HealthPowerTimer.stop()
			#$ShieldPowerTimer.stop()
			#$BombPowerTimer.stop()
			#$FastEnemyTimer.start()
			#var BLT = bolt_scene.instantiate()
			#var BoltUp_spawn_location = $PowerUpPath/PowerUpSpawnLocation
			#BoltUp_spawn_location.progress_ratio = randf()
#
			## Set the mob's position to the random location.
			#BLT.position = BoltUp_spawn_location.position
			#add_child(BLT)
			#Scene1 = true
	#if Scene1 == true:
		#if score >= 10:
			#Scene1 = false
			#$MobTimer.start()
			#$HealthPowerTimer.start()
			#$ShieldPowerTimer.start()
			#$BombPowerTimer.start()
			#$FastEnemyTimer.stop()
		
#func _physics_process(delta: float) -> void:
#	var direction = global_position.direction_to(player.global_position)
		
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
	var velocity = Vector2(randf_range(250.0+(score*4), 300.0+(score*8)), 0.0)
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
	$BombPowerTimer.start()
	$BoltTimer.start()
	$Scene1Timer.start()

func _on_bolt_timer_timeout() -> void:
	$MobTimer.stop()
	$HealthPowerTimer.stop()
	$ShieldPowerTimer.stop()
	$BombPowerTimer.stop()
	$Music.stop()
	#$FastEnemyTimer.start()
	var BLT = bolt_scene.instantiate()
	var BoltUp_spawn_location = $PowerUpPath/PowerUpSpawnLocation
	BoltUp_spawn_location.progress_ratio = randf()

			# Set the mob's position to the random location.
	BLT.position = BoltUp_spawn_location.position
	add_child(BLT)
	
func _on_scene_1_timer_timeout() -> void:
	$FastEnemyTimer.start()
	$Scene1EndTimer.start()
	
func _on_fast_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	# Choose a random location on Path2D.
	var enemy_spawn_location = $MobPath/MobSpawnLocation
	enemy_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	enemy.position = enemy_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	#%fast_enemy.direction = global_position.direction_to(player.global_position)
	# Add some randomness to the direction.
	#direction += randf_range(-PI / 4, PI / 4)
	var direction = enemy_spawn_location.rotation + PI / 2

	enemy.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(700.0+(score*10), 700.0+(score*14)), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)


func _on_scene_1_end_timer_timeout() -> void:
	$FastEnemyTimer.stop()
	$MobTimer.start()
	$HealthPowerTimer.start()
	$ShieldPowerTimer.start()
	$BombPowerTimer.start()
	$Music.play()


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
	
func _on_bomb_power_timer_timeout() -> void:
	get_tree().call_group("Bombs", "queue_free")
	var BMB = bomb_scene.instantiate()
	var BombUp_spawn_location = $PowerUpPath/PowerUpSpawnLocation
	BombUp_spawn_location.progress_ratio = randf()
	# Set the mob's position to the random location.
	BMB.position = BombUp_spawn_location.position
	add_child(BMB)

func _on_power_up_heal() -> void:
	%Player.health += 20.0
	
func _on_shield_shielded() -> void:
	%player.protection += 1.0
	if %player.protection > 0:
		%player.protection.show()


func _on_bomb_bomb_collect() -> void:
	get_tree().call_group("mobs", "queue_free")
