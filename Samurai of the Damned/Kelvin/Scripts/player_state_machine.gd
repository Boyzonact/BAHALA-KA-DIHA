class_name PlayerNodeFiniteStateMachine
extends Node

@export var initial_player_node_state : PlayerNodeState

var player_node_states : Dictionary = {}
var current_player_node_state : PlayerNodeState
var current_player_node_state_name : String

func _ready():
	for child in get_children():
		if child is PlayerNodeState:
			player_node_states[child.name.to_lower()] = child
	
	if initial_player_node_state:
		initial_player_node_state.enter()
		current_player_node_state = initial_player_node_state


func _process(delta : float):
	if current_player_node_state:
		current_player_node_state.on_process(delta)


func _physics_process(delta: float):
	if current_player_node_state:
		current_player_node_state.on_physics_process(delta)
	
	#print("Current State: ", current_player_node_state.name.to_lower())


func transition_to(node_state_name : String):
	if node_state_name == current_player_node_state.name.to_lower():
		return
	
	var new_player_node_state = player_node_states.get(node_state_name.to_lower())
	
	if !new_player_node_state:
		return
	
	if current_player_node_state:
		current_player_node_state.exit()
	
	new_player_node_state.enter()
	
	current_player_node_state = new_player_node_state
	current_player_node_state_name = current_player_node_state.name.to_lower()
