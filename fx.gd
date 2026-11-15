extends AnimatedSprite2D


@onready var rigidBody : RigidBody2D = $RigidBody2D
var lifetime : float = 3
var timer : float = 0

var bad_sprites = ["bad1", "bad2", "bad3", "bad4"]
var good_sprites = ["good1", "good2", "good3", "good4", "good5"]
var mid_sprites = ["mid1", "mid2", "mid3", "mid4"]
# 1 = good, 2 = mid, 3 = mid, else = bad
func on_create(state : int):
	var new_velocity = Vector2(randi_range(-10, 10), randi_range(4, 12))
	var sprite = good_sprites[1]
	if state == 1:
		sprite = good_sprites.pick_random()
	elif state == 2 or state == 3:
		sprite = bad_sprites.pick_random()
	else:
		sprite = bad_sprites.pick_random()
	play(sprite)
	rigidBody.linear_velocity += new_velocity


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= lifetime: 
		queue_free()
