extends PlayerNodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d  : AnimatedSprite2D
@export var attack_range : Marker2D
@export var hit_box : CollisionShape2D
@export var hit_space : Area2D
var swing_direction : int
var counter = 1
func on_process(delta : float):
	pass


func on_physics_process(delta : float):
	animation_handler()
	if hit_box.position > attack_range.position:
		swing_direction = 1
	elif hit_box.position < attack_range.position:
		swing_direction = -1
	elif hit_box.position == attack_range.position:
		swing_direction = 0
	mover()
func enter():
	if animated_sprite_2d.flip_h == true:
		attack_range.position.x = 20
	else:
		attack_range.position.x = -20
	hit_space.monitorable = true
	if counter > 3:
		counter = 1
	print(counter)
func exit():
	attack_range.position = hit_space.position
	hit_box.position = attack_range.position
	hit_space.monitorable = false
	counter += 1
func animation_handler():
	if counter == 1:
		animated_sprite_2d.play("attack_1")
	if counter == 2:
		animated_sprite_2d.play("attack_2")
	if counter == 3:
		animated_sprite_2d.play("attack_3")
func mover():
	hit_box.move_local_x(1*swing_direction)
