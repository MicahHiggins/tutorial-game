extends RigidBody2D
signal Shielded

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _process(delta):
	var overlapping_player = %ShieldBox.get_overlapping_bodies()
	#print(overlapping_player.size())
	if overlapping_player.size() > 0:
		hide()
		queue_free()
		
		Shielded.emit()
