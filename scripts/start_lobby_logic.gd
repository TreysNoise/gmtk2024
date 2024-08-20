extends Node3D

@export var right_door: ElevatorDoor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	right_door.open_door()
