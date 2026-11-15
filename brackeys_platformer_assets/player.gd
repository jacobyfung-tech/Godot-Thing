extends CharacterBody2D

const SPEED = 130.0
const JUMP_MIN = -300.0
const JUMP_PLUS = -100.0
var JUMP_ABILITY:float = JUMP_MIN

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = JUMP_ABILITY
		JUMP_ABILITY += JUMP_PLUS
	if not(Input.is_action_pressed("up")) and is_on_floor():
		JUMP_ABILITY = JUMP_MIN
	if velocity.y<0:
		$AnimatedSprite2D.scale.y = min(max(1,-velocity.y/50+1), 5)
	else:
		scale.y = 1
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
