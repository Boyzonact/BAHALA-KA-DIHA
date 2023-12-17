extends CharacterBody2D
@export var state_machine : PlayerNodeFiniteStateMachine
var can_double_jump = true
var can_transition =  true
func _process(delta):
	if is_on_floor():
		if Input.action_press("left")|| Input.action_press():
		
