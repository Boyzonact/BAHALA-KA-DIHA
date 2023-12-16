extends CharacterBody2D
var in_range = false
var has_sight =false
var attack_range = false
signal action(int)
@onready var player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		in_range=true
func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		in_range=false
		
func _physics_process(delta):
	if in_range:
		SightCheck()
		if has_sight:
			action.emit_signal(true)
			if attack_range:
				pass
		else:
			action.emit_signal
func SightCheck():
	if in_range:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, player.position)
		query.exclude = [self]
		var result = space_state.intersect_ray(query)
		if result:
			if result.collider.is_in_group("Player"):
				has_sight = true
				print("Player in sight",has_sight)
			else:
				has_sight = false
				print("Player in sight",has_sight)
