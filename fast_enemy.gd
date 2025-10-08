extends RigidBody2D
#@onready var player = get_node("root/Game/Player")

func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Replace with function body.

#func _physics_process(delta: float) -> void:
#	var direction = global_position.direction_to(player.global_position)
	
