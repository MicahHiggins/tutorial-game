extends Control
signal settings_pressed

func _ready():
	$AnimationPlayer.play("RESET")
	hide()
	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	hide()
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()
	
	
func testEsc():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_settings_pressed() -> void:
	resume()
	settings_pressed.emit()
	
	#$AnimationPlayer.play_backwards("blur")
	#hide()
	
	

func _on_quit_pressed() -> void:
	get_tree().quit()

func _process(delta):
	testEsc()
