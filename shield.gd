extends Area2D
signal Shielded

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _process(delta):
	var overlapping_player = get_overlapping_areas()
	#print(overlapping_player.size())
	if overlapping_player.size() > 0:
		hide()
		queue_free()
		
		Shielded.emit()


#func _on_body_entered(body: Node) -> void:
#	pass # Replace with function body.
