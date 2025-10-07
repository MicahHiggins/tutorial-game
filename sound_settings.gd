extends Control

var music = AudioServer.get_bus_index("Music")
var sfx = AudioServer.get_bus_index("SFX")
var OPEN = false

func _ready():
	$AnimationPlayer.play("RESET")
	hide()
	$PanelContainer/VBoxContainer/HSlider.value = db_to_linear(music)
	$PanelContainer/VBoxContainer/HSlider2.value = db_to_linear(sfx)

func close():
	get_tree().paused = false
	OPEN = false
	$AnimationPlayer.play_backwards("Blur")
	hide()
	
func open():
	get_tree().paused = true
	OPEN = true
	$AnimationPlayer.play("Blur")
	show()
	#get_tree().paused = true
	
func testEsc():
	if Input.is_action_just_pressed("escape") and OPEN == true:
		close()
		
func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music, linear_to_db(value)) # Replace with function body.

func _on_h_slider_2_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx, linear_to_db(value)) # Replace with function body.



func _on_settings_button_pressed() -> void:
	open()

func _on_button_pressed() -> void:
	close()

func _on_pause_menu_settings_pressed() -> void:
	open()

func _process(_delta):
	testEsc()
