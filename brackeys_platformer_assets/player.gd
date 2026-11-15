extends CharacterBody2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 130.0
const JUMP_VELOCITY = -300.0

const LIMIT = 2

var jumpMult:= 1.0
const BPM = 105
var quarter = 1.0
var beatsPassed = 0
var nextBeat = 0


const CHIIKAWA_105 = preload("uid://ddxjdub0sgjxs")
const METRONOME = preload("uid://vbeyty8bmf2g")

const PRESS_GOOD = preload("uid://dk7m44q2piohw")
const PRESS_BAD = preload("uid://jel4jygf3lsv")
const PRESS_LATE = preload("uid://cuqc8h2pjv4ui")
const PRESS_EARLY = preload("uid://nlnj36wkbpif")




@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sfx: AudioStreamPlayer2D = $SFX
@onready var sfx_2: AudioStreamPlayer2D = $SFX2


var start_time: float = 0.0
var elapsed: float = 0.0
const offset = -0.04
const window = 0.17

var onBeat = 0
#0: nothing
#1: early
#2: good
#3: late

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
	#print("SCHEDULE EARLY")
	onBeat = 1
	#print("@early")
	await get_tree().create_timer(window*(2.0/12)).timeout
	#print("SCHEDULE MID")
	sfx.stream = METRONOME
	sfx.play()
	onBeat = 2
	#print("@good")
	await get_tree().create_timer(window*(5.0/12)).timeout
	#print("SCHEDULE LATE")
	onBeat = 3
	#print("@late")
	await get_tree().create_timer(window*(4.0/12)).timeout
	#print("@cooked")
	onBeat = 0
	#print("@beat end")
	pass

func _physics_process(delta: float) -> void:
	elapsed = (Time.get_ticks_msec()/1000.0 - start_time)-offset
	#print(elapsed)
	if(elapsed > nextBeat):
		
		beatsPassed = beatsPassed + 1
		nextBeat = quarter*beatsPassed
		
		
			
		
		closeWindow()
		
		
		

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if(onBeat != 0):
			
			
			if(onBeat == 1):
				sfx_2.stream = PRESS_EARLY
				
				print("early")
				jumpMult += 0.1
			elif(onBeat == 2):
				sfx_2.stream = PRESS_GOOD
				jumpMult += 0.2
				print("good")
			elif(onBeat == 3):
				sfx_2.stream = PRESS_LATE
				print("late")
				jumpMult += 0.1
			
				
			sfx_2.play()
			
			
		else:
			sfx_2.stream = PRESS_BAD
			sfx_2.play()
			print("whatever")
			if(jumpMult > 1):
				jumpMult -= 0.12
				
		if(jumpMult > LIMIT):
			jumpMult = LIMIT
			
		velocity.y = JUMP_VELOCITY * jumpMult

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if(direction > 0):
			anim_sprite.flip_h = false
		
		elif(direction < 0):
			anim_sprite.flip_h = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
