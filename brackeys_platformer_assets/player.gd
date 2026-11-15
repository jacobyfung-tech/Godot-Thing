extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0



var jumpMult:= 1.0
const BPM = 105
var quarter = 1.0
var beatsPassed = 0
var nextBeat = 0


const CHIIKAWA_105 = preload("uid://ddxjdub0sgjxs")
const METRONOME = preload("uid://vbeyty8bmf2g")

const PRESS_GOOD = preload("uid://dk7m44q2piohw")
const PRESS_BAD = preload("uid://jel4jygf3lsv")



@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sfx: AudioStreamPlayer2D = $SFX
@onready var sfx_2: AudioStreamPlayer2D = $SFX2


var start_time: float = 0.0
var elapsed: float = 0.0
const offset = -0.03
const window = 0.1

var onBeat = false

func _ready() -> void:
	audio_player.stream = CHIIKAWA_105
	audio_player.play()
	
	nextBeat = quarter
	audio_player.max_polyphony = 10
	sfx.max_polyphony = 10

	
	quarter = 60.0/BPM
	print(quarter)

	start_time = Time.get_ticks_msec() /1000.0
	
func closeWindow():
	onBeat = false
	print("beat end")
	pass

func _physics_process(delta: float) -> void:
	elapsed = (Time.get_ticks_msec()/1000.0 - start_time)-offset
	#print(elapsed)
	if(elapsed > nextBeat):
		onBeat = true
		print("BEAT")
		beatsPassed = beatsPassed + 1
		nextBeat = quarter*beatsPassed
		sfx.stream = METRONOME
		sfx.play()
		await get_tree().create_timer(window).timeout
		closeWindow()
		
		
		

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if(onBeat):
			sfx_2.stream = PRESS_GOOD
			sfx_2.play()
			print("YOU JUMPED ON BEAT!!!")
			
		else:
			jumpMult += 1.05
			sfx_2.stream = PRESS_BAD
			sfx_2.play()
			print("whatever")
			
		velocity.y = JUMP_VELOCITY * jumpMult

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
