class_name Player extends CharacterBody3D
@onready var camera: Camera3D = $Camera3D
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var money_count: Label = $CanvasLayer/Container/MoneyCount
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export_category("Player Stats")
@export_range(0, 400, 10) var player_move_speed: int = 200
@export_range(0, 300, 10) var player_jump_force: int = 100
@export_range(0.001, 0.01, 0.001) var player_look_sense: float = 0.005

var waiting: bool = false

func _ready() -> void:
	Globals.money_picked_up.connect(_on_money_pick_up)
	money_count.text = "%s/%s" % [Globals.money_collected, Globals.max_money]
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var tween: Tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color(1,1,1,0), 3)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * player_look_sense)
		camera.rotate_x((-event.relative.y * player_look_sense))
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = player_jump_force * delta
		
	var input_vector: Vector2 = Input.get_vector("player_move_left", "player_move_right", "player_move_forward", "player_move_backward")
	var direction: Vector3 = (transform.basis * Vector3(input_vector.x, 0, input_vector.y)).normalized()
	if direction and not waiting:
		velocity.x = direction.x * player_move_speed * delta
		velocity.z = direction.z * player_move_speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, player_move_speed * delta)
		velocity.z = move_toward(velocity.z, 0, player_move_speed * delta)
	
	move_and_slide()

func _process(_delta: float) -> void:
	pass


func entered_elevator(duration: float) -> void:
	waiting = true
	var tween: Tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color(1,1,1,1), duration)

func flash_screen() -> void:
	if animation_player.has_animation("flash"):
		animation_player.play("flash")

func _on_money_pick_up() -> void:
	money_count.text = "%s/%s" % [Globals.money_collected, Globals.max_money]
