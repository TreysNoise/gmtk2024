class_name SecurityCamera extends Node3D
@onready var pivot: Node3D = $CameraBodyPivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var vision_area: Area3D = $CameraBodyPivot/camera/ShootingPoint/VisionArea
@onready var vision_ray: RayCast3D = $CameraBodyPivot/camera/ShootingPoint/VisionRayCast
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

signal caught_player

@export_range(0, 10, 1) var animation_offset: int = 0
@export var is_static: bool = false

var hit_counter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not is_static:
		animation_player.play("cycle")
		animation_player.seek(animation_offset)

func _on_ray_cast_timer_timeout() -> void:
	var overlaps: Array[Node3D] = vision_area.get_overlapping_bodies()
	for body in overlaps:
		if body is Player:
			var player_pos: Vector3 = body.global_transform.origin
			vision_ray.look_at(player_pos, Vector3.UP)
			if vision_ray.is_colliding():
				var collider: Object = vision_ray.get_collider()
				if collider is Player:
					hit_counter += 2
					if hit_counter > Globals.camera_difficulty:
						caught_player.emit()
	hit_counter = max(0, hit_counter - 1)
	print(hit_counter)


func _on_beep_timer_timeout() -> void:
	audio_stream_player_3d.play()
