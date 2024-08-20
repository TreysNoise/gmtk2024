extends Control
@onready var label: Label = $VBoxContainer/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	label.text = "You stole %s stack%s of cash!" % [Globals.money_collected, "" if Globals.money_collected == 1 else "s"]


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")
