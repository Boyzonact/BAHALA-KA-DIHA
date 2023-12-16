extends Node
@export var ch : CharacterBody2D
@export var an : AnimatedSprite2D
func _physics_process(delta):
	ch.move_and_slide()
