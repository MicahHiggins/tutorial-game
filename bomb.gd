extends Area2D
signal bomb_collect

func _process(delta):
	var overlapping_player = get_overlapping_areas()
	#print(overlapping_player.size())
	if overlapping_player.size() > 0:
		hide()
		queue_free()
		
		bomb_collect.emit()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Replace with function body.
