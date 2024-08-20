class_name Money extends Node3D
@onready var model: Node3D = $model
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	model.rotate_y(delta)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		Globals.money_collected += 1
		Globals.money_picked_up.emit()
		audio_stream_player_3d.play()
		audio_stream_player_3d.reparent(get_parent())
		queue_free()
