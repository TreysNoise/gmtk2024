extends Node3D
@onready var label: Label = $CanvasLayer/Label

@export var floor_title: String = "base level"
@export var next_floor: String = "level1"
@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var security_cameras: Array[Node] = get_tree().get_nodes_in_group("SecurityCameras")
	for cam in security_cameras:
		if cam is SecurityCamera:
			cam.caught_player.connect(_player_caught)
	
	label.text = floor_title
	var tween: Tween = create_tween()
	tween.tween_property(label, "modulate", Color(1,1,1,1), 2)
	tween.tween_property(label, "modulate", Color(1,1,1,0), 2)

func _player_caught() -> void:
	label.text = "🚨 You've been caught 🚨"
	label.modulate = Color(1,0,0,1)
	player.entered_elevator(0.5)
	var tween: Tween = create_tween()
	tween.tween_property(label, "modulate", Color(1,0,0,0), 1)
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()

func _on_right_door_player_entered_elevator() -> void:
	await get_tree().create_timer(4.0).timeout
	print(name)
	get_tree().change_scene_to_file("res://levels/%s.tscn" % next_floor)
