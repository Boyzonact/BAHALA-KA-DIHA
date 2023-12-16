extends Node

var main_menu_screen = preload("res://ui/main_menu.tscn")
var startlvl = preload("res://stage_1/Stage1/level_1.tscn")
var pause_menu =  preload("res://ui/pause_menu.tscn")

func _ready():
	RenderingServer.set_default_clear_color(Color(0,0,0,0))
	
#a function to start the game
func start_game():
	if get_tree().paused:
		resume_game()
		return
	transition_to_scene(startlvl.resource_path)
	
#pause function	
func pause_game():
	get_tree().paused = true
	
	var pause_menu_instance = pause_menu.instantiate()
	get_tree().get_root().add_child(pause_menu_instance)

#resume function	
func resume_game():
	get_tree().paused = false

#main menu function
func main_menu():
	var main_menu_instance = main_menu_screen.instantiate()
	get_tree().get_root().add_child(main_menu_instance)
	
#exit game function	
func exit_game():
	get_tree().quit()
	
	
func transition_to_scene(scene_path):
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(scene_path)
	
