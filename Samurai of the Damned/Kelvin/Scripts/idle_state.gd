extends PlayerNodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
func on_process(delta : float):
	pass


func on_physics_process(delta : float):
	animated_sprite_2d.play("idle")


func enter():
	character_body_2d.velocity.x = 0
	character_body_2d.move_and_slide()
func exit():
	pass
