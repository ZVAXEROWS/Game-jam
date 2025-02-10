extends CharacterBody2D

@onready var anime_player: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# double jump var
var number_of_jumps = 0
# dash var
const dash_speed = 3.0
var dash = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		number_of_jumps = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and number_of_jumps < 2:
		velocity.y = JUMP_VELOCITY
		number_of_jumps += 1


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction < 0 && dash == false :
		anime_player.play("run")
		anime_player.flip_h = true
	if direction > 0 && dash == false :
		anime_player.play("run")
		anime_player.flip_h = false
	if direction == 0 && is_on_floor() && dash == false :
		anime_player.play("idle")
	if ! is_on_floor() :
		anime_player.play("jump")

	if Input.is_action_just_pressed("dash"):
		if !dash && direction:
			start_dash()

	if direction:
		if dash:
			velocity.x = direction * SPEED * dash_speed
		else:
			velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func start_dash():
	dash = true
	anime_player.play("dash")
	$Timer.connect("timeout",stop_dash)
	$Timer.start()

func stop_dash():
	dash = false


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
