extends Area2D
signal heal
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Replace with function body.


func _process(_delta):
	var overlapping_player = get_overlapping_areas()
	#print(overlapping_player.size())
	if overlapping_player.size() > 0:
		#hide()
		queue_free()
		
		heal.emit()


#func _on_area_2d_body_entered(body: Node2D) -> void:
#	if body.has_method()
