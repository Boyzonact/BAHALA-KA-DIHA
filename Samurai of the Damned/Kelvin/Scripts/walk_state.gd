extends PlayerNodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d  : AnimatedSprite2D
var SPEED = 200
func on_process(delta : float):
	pass


func on_physics_process(delta : float):
	var direction = Input.get_axis("left", "right")
	if Input.is_action_pressed("right"):
		character_body_2d.velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("walk")
			
	elif Input.is_action_pressed("left"):
		character_body_2d.velocity.x = -direction * -SPEED
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walk")
	character_body_2d.move_and_slide()
func enter():
	pass


func exit():
	pass
