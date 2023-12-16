extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const gravity = 1000

const dalagan = 300

@export var max_horizontal_speed: int = 300

@export var slow_down_speed: int = 2000

@export var jump: int = -450

@export var jump_horizontal_speed: int = 1000

@export var max_jump_horizontal_speed: int = 300

@export var jump_count: int = 1

enum State { barog, dagan, layat, tagak, Hapak }

var current_state

var current_jump_count: int

var attack_cooldown: float = 0.5  # Adjust the cooldown time as needed

var time_since_last_attack: float = 0.0

func _ready():
	
	current_state = State.barog

func _physics_process(delta):
	
	player_falling(delta)
	
	player_idle(delta)
	
	player_run(delta)
	
	player_jump(delta)
	
	player_attack(delta) 
	
	move_and_slide()
	
	player_animations()

func player_falling(delta):
	
	if !is_on_floor():
		
		velocity.y += gravity * delta
		
		if velocity.y > 0:
			
			current_state = State.tagak

func player_idle(delta):
	
	if is_on_floor():
		
		current_state = State.barog

func player_run(delta : float):
	
	if !is_on_floor():
		
		return
	
	var direction = input_movement()
	
	if direction:
		
		velocity.x += direction * dalagan * delta
		
		velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
		
	else:
		
		velocity.x = move_toward(velocity.x, 0, slow_down_speed * delta)
	
	if direction != 0:
		
		current_state = State.dagan
		
		animated_sprite_2d.flip_h = false if direction > 0 else true

func player_jump(delta: float):
	
	var jump_input: bool = Input.is_action_just_pressed("jump")
	
	if is_on_floor() and jump_input:
		
		current_jump_count = 0
		
		velocity.y = jump
		
		current_jump_count += 1
		
		current_state = State.layat
	
	if !is_on_floor() and jump_input and current_jump_count < jump_count:
		
		velocity.y = jump
		
		current_jump_count += 1
		
		current_state = State.layat
	
	if !is_on_floor() and current_state == State.layat:
		
		var direction = input_movement()
		
		velocity.x += direction * jump_horizontal_speed * delta
		
		velocity.x = clamp(velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)

func player_attack(delta):
	
	if Input.is_action_just_pressed("attacks"):
		
		current_state = State.Hapak
		
		print("Attacking!")

func player_animations():
	
	if current_state == State.barog and animated_sprite_2d.animation != "attacks":
		
		animated_sprite_2d.play("idle")
		
	elif current_state == State.dagan:
		
		animated_sprite_2d.play("run")
		
	elif current_state == State.layat:
		
		animated_sprite_2d.play("jump")
		
	elif current_state == State.tagak:
		
		animated_sprite_2d.play("fall")
		
	elif current_state == State.Hapak:
		
		animated_sprite_2d.play("attacks")

func input_movement():
	
	var direction : float = Input.get_axis("ui_left", "ui_right")
	
	return direction
	


func _on_hurtbox_body_entered(body:Node2D):
	if body.is_in_group("Enemy"):
		print("nay kuntra")
