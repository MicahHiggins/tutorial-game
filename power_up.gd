extends RigidBody2D
signal heal
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Replace with function body.


func _process(delta):
	var overlapping_player = %HealBox.get_overlapping_bodies()
	print(overlapping_player.size())
	if overlapping_player.size() > 0:
		hide()
		queue_free()
		
		heal.emit()
