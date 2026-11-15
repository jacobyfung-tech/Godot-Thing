extends Node2D
const speed = 50
var dir = 1
@onready var ray_r: RayCast2D = $RayR
@onready var ray_l: RayCast2D = $RayL
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_r.is_colliding():
		anim_sprite.flip_h = true
		dir = -1
	if ray_l.is_colliding():
		anim_sprite.flip_h = false
		dir = 1
	position.x += speed*delta*dir
