extends Node

signal money_picked_up

var captured_mouse_once: bool = false

var money_collected: int = 0
var max_money: int = 5
var camera_difficulty: int = 5

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if not captured_mouse_once and event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		captured_mouse_once = true
