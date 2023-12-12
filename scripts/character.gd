extends CharacterBody2D

const gravity = 1000

enum State { Idle, Run }

var current_state

func _ready():
	current_state = State.Idle
	
func _physics_process(delta):
	
	player_falling(delta)
	
	player_idle(delta)
	
	player_run(delta) 
	
	move_and_slide()  
	
 #matagak

func player_falling(delta):
	
	if !is_on_floor():
		
		velocity.y += gravity * delta
 #mag barog

func player_idle(delta):
	
	if is_on_floor():
		
		current_state = State.Idle
		#walk 
		
func player_run(delta):
	
	var direction =Input.get_axis("move_left","move_right")
	
	if direction:
		
		velocity.x = direction * 300
		
	else:
		
		velocity.x = move_toward(velocity.x, 0, 300)

func player_animations():
	if current_state == State.Idle:			
