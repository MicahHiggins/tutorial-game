extends Node2D

@onready var pathfollow = $Path2D/PathFollow2D

func _process(delta):
	pathfollow.progress_ratio += 0.0005
