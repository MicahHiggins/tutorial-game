extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge Everything, Reach the Oceans Abyss"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score) + "m"

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$SettingsButton.hide()
	$QuitButton.hide()
	$ControlsButton.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
