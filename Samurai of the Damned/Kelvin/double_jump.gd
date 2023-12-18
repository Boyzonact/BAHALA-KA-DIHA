extends PlayerNodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var jump_force: int
@export var SPEED : int
func on_process(delta : float):
	pass


func on_physics_process(delta : float):
	animated_sprite_2d.play("jump")
	var direction = Input.get_axis("left", "right")
	if Input.is_action_pressed("right"):
		character_body_2d.velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = false
			
	elif Input.is_action_pressed("left"):
		character_body_2d.velocity.x = -direction * -SPEED
		animated_sprite_2d.flip_h = true
	character_body_2d.move_and_slide()
func enter():
	character_body_2d.velocity.y = jump_force * -1
	character_body_2d.move_and_slide()
func exit():
	pass
