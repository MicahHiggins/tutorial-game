extends Area2D
signal Bolt_collect

func _process(delta):

	var overlapping_player = get_overlapping_areas()
	#print(overlapping_player.size())
	if overlapping_player.size() > 0:
		hide()
		queue_free()
		
		Bolt_collect.emit()
