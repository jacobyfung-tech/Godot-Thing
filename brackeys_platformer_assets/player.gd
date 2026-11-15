extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
<<<<<<< HEAD


func _physics_process(delta: float) -> void:
=======
var jumpMult:= 1
const BPM = 105
var quarter = 1.0
var beatsPassed = 0
var nextBeat = 0


const CHIIKAWA_105 = preload("uid://ddxjdub0sgjxs")
const METRONOME = preload("uid://vbeyty8bmf2g")


@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sfx: AudioStreamPlayer2D = $SFX

var start_time: float = 0.0
var elapsed: float = 0.0
func _ready() -> void:
	audio_player.stream = CHIIKAWA_105
	audio_player.play()
	
	nextBeat = quarter
	audio_player.max_polyphony = 10

	
	quarter = 60.0/BPM
	print(quarter)

	start_time = Time.get_ticks_msec() /1000.0
	
func _physics_process(delta: float) -> void:
	elapsed = (Time.get_ticks_msec()/1000.0 - start_time)
	print(elapsed)
	if(elapsed > nextBeat):
		print("BEAT")
		beatsPassed = beatsPassed + 1
		nextBeat = quarter*beatsPassed
		sfx.stream = METRONOME
		sfx.play()
		
		
		
>>>>>>> c670499 (rhythm metronome)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
