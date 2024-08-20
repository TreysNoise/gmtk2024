extends Control

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/lobby.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
