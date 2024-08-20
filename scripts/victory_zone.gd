extends Area3D

@export var player: Player

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		player.entered_elevator(1)
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://ui/victory_menu.tscn")
