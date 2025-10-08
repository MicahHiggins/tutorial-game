extends Control

@onready var input_button_scene = preload("res://input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList


var is_remapping = false
var action_to_remap = null
var remapping_button = null
var OPEN = false

var input_actions = {
	"move_up": "Move up",
	"move_down": "Move down",
	"move_left": "Move left",
	"move_right": "Move right",
	"Dash": "Dash",
}

func _ready():
	_create_action_list()
	$AnimationPlayer.play("RESET")
	hide()
	
func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size()> 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press Key to Bind..."

func _input(event):
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()
			
func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")


func close():
	get_tree().paused = false
	OPEN = false
	$AnimationPlayer.play_backwards("blur")
	hide()
	
func open():
	get_tree().paused = true
	OPEN = true
	$AnimationPlayer.play("blur")
	show()
	#get_tree().paused = true
	
func testEsc():
	if Input.is_action_just_pressed("escape") and OPEN == true:
		close()
		
func _on_controls_button_pressed() -> void:
	open()
	get_tree().root.get_viewport().set_input_as_handled()
	
func _process(_delta):
	testEsc()


func _on_reset_button_pressed() -> void:
	_create_action_list()
