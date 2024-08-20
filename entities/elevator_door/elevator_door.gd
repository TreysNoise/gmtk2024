class_name ElevatorDoor extends Area3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bing_sound: AudioStreamPlayer3D = $BingSound
@onready var door_sound: AudioStreamPlayer3D = $DoorSound

signal player_entered_elevator

@export var end_door: bool = false
@export var wait_for_call: bool = false

func _ready() -> void:
	if not wait_for_call:
		await get_tree().create_timer(1.0).timeout
		if not end_door:
			bing_sound.play()
			door_sound.play()
		animation_player.play("open_door")
	

func _on_body_entered(body: Node3D) -> void:
	if body is Player and end_door:
		body.entered_elevator(4)
		animation_player.play("close_door")
		door_sound.play()
		player_entered_elevator.emit()


func open_door() -> void:
	bing_sound.play()
	door_sound.play()
	animation_player.play("open_door")
