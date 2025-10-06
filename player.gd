extends Area2D

class_name Player
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var screen_pos
var health = 100.0
var protection = 0.0
var DASHING = false

#print(main.DashPower)


func _ready():
	screen_size = get_viewport_rect().size
	
	#print(screen_size)
	hide()
	
func _process(delta):
	
	screen_pos = get_viewport_rect().position
	var main = get_parent()
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if main.DashPower == true and Input.is_action_pressed("move_right") and Input.is_action_pressed("move_down") and Input.is_action_pressed("Dash") and DASHING == false:
		position.x += 92
		position.y += 92
		DASHING = true
	elif main.DashPower == true and Input.is_action_pressed("move_right") and Input.is_action_pressed("move_up")  and Input.is_action_pressed("Dash") and DASHING == false:
		position.x += 92
		position.y -= 92
		DASHING = true
	elif main.DashPower == true and Input.is_action_pressed("move_left") and Input.is_action_pressed("move_down") and Input.is_action_pressed("Dash") and DASHING == false:
		position.x -= 92
		position.y += 92
		DASHING = true
	elif main.DashPower == true and Input.is_action_pressed("move_left") and Input.is_action_pressed("move_up") and Input.is_action_pressed("Dash") and DASHING == false:
		position.x -= 92
		position.y -= 92
		DASHING = true
	elif main.DashPower == true and Input.is_action_pressed("move_right") and Input.is_action_pressed("Dash") and DASHING == false:
		position.x += 130
		DASHING = true
	elif main.DashPower == true and Input.is_action_pressed("move_left")  and Input.is_action_pressed("Dash") and DASHING == false:
		position.x -= 130
		DASHING = true
	elif main.DashPower == true and Input.is_action_pressed("move_down")  and Input.is_action_pressed("Dash") and DASHING == false:
		position.y += 130
		DASHING = true
	elif main.DashPower == true and Input.is_action_pressed("move_up")  and Input.is_action_pressed("Dash") and DASHING == false:
		position.y -= 130
		DASHING = true
	
	if DASHING == true and %DashTimer.is_stopped():
		%DashTimer.start()
		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	#position = position.clamp(screen_pos - screen_size/2, screen_pos + screen_size/2)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	#if %HurtBox.body_entered(%Health)
	
	const DMG_Rate = 40.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		if protection > 0:
			protection -=3.0*overlapping_mobs.size() * delta
			%ProgressBar2.value = protection
		else:
			health-=DMG_Rate * overlapping_mobs.size() * delta
			%ProgressBar.value = health
		if health <= 0.0:
			hide() # Player disappears after being hit.
			hit.emit()
			# Must be deferred as we can't change physics properties on a physics callback.
			$CollisionShape2D.set_deferred("disabled", true)
			
	
func start(pos):
	%ProgressBar.value = health
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
	%ProgressBar2.value = protection
	position = pos
	show()
	$CollisionShape2D.disabled = false
	


#func _on_power_up_heal() -> void:
#	print(health)
	#health += 50.0
	
#	%ProgressBar.value = health
#	print(%ProgressBar.value)


func _on_dash_timer_timeout() -> void:
	DASHING = false
