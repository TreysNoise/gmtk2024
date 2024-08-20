class_name LightningDetector extends Area3D
@onready var sfx_1: AudioStreamPlayer3D = $Sfx1
@onready var sfx_2: AudioStreamPlayer3D = $Sfx2

@export var player: Player


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		$"../OfficeFloor/LeftDoor/AnimationPlayer".play("close_door")
		await get_tree().create_timer(1).timeout
		body.flash_screen()
		
		sfx_1.reparent(get_parent())
		sfx_2.reparent(get_parent())
		sfx_1.play()
		sfx_2.play()
		var tween: Tween = create_tween()
		tween.tween_property(player, "scale", Vector3(0.25,0.25,0.25), 0.5)
		player.player_move_speed = 150
		player.player_jump_force = 150
		await tween.finished
		queue_free()
