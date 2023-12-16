extends CharacterBody2D
@export var node_finite_state_machine :NodeFiniteStateMachine

@export var health_amount : int =3

@export var damage_amount : int =1
var player_in_range = false
var has_sight = true
@export var timer : Timer
@onready var player = get_parent().get_node("Jinbei")
var can_shoot = true
var can_summon = true
@export var summon_cd : Timer
func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("chase")


func _on_area_2d_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("idle")
		


func _on_timer_timeout():
	can_shoot = true


func _on_spawn_cd_timeout():
	can_summon = true
