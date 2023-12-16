extends Node
@export var node_finite_state_machine :NodeFiniteStateMachine
@export var character_body_2d : CharacterBody2D


func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("chase")


func _on_area_2d_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("idle")
