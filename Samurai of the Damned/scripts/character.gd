extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@export var sword : Area2D
@export var hitzone : CollisionShape2D
@export var hit_range : Marker2D

const gravity = 1350
var swing_direction : int
const dalagan = 650
var direction : int

@export var max_horizontal_speed: int = 400

@export var slow_down_speed: int = 8500

@export var jump: int = -500

@export var jump_horizontal_speed: int = 3000

@export var max_jump_horizontal_speed: int = 400

@export var jump_count: int = 2

enum State { barog, dagan, layat, tagak, Hapak }

var current_state

var current_jump_count: int

var attack_cooldown: float = 0.5 

var time_since_last_attack: float = 0.0

var layat_kaduha = 2
var attack_done = true
var layat_ihap = 0

func _ready():
	
	current_state = State.barog
	hit_range.position.x = 50

func _physics_process(delta):
	
	player_falling(delta)
	
	player_idle(delta)
	
	player_run(delta)
	
	player_jump(delta)
	
	player_attack(delta) 
	
	move_and_slide()
	
	player_animations()
	hit_range.position.x = 50 * direction

func player_falling(delta):
	
	if !is_on_floor():
		
		velocity.y += gravity * delta
		
		if velocity.y > 0:
			
			current_state = State.tagak

func player_idle(delta):
	
	if is_on_floor():
		
		current_state = State.barog

func player_run(delta: float):
	
	if !is_on_floor():
		
		return

	direction = input_movement()

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
	
	if Input.is_action_just_pressed("attackz"):
		current_state = State.Hapak
		
		print("Attacking!")

func player_animations():
	
	if current_state == State.barog and animated_sprite_2d.animation != "attackz" and animated_sprite_2d.animation != "hurt" and animated_sprite_2d.animation != "death":
		
		animated_sprite_2d.play("idle")
		
	elif current_state == State.dagan :
		
		animated_sprite_2d.play("run")
		
	elif current_state == State.layat and animated_sprite_2d.animation != "hurt":
		
		animated_sprite_2d.play("jump")
		
	elif current_state == State.tagak and animated_sprite_2d.animation != "death":
		
		animated_sprite_2d.play("fall")
		
	elif current_state == State.Hapak and animated_sprite_2d.animation != "hurt":
		attack_done =  false
		if hitzone.position > hit_range.position:
			swing_direction = -1
		elif hitzone.position < hit_range.position:
			swing_direction = 1
		elif hitzone.position == hit_range.position:
			swing_direction = 0
		swing_handler()
		_on_animated_sprite_2d_animation_finished()
		if attack_done:
			hitzone.position = sword.position
		animated_sprite_2d.play("attackz")


func input_movement():
	
	var direction: float = Input.get_axis("ui_left", "ui_right")
	
	return direction

func _on_hurtbox_body_entered(body: Node2D):
	
	if body.is_in_group("Enemy"):
		
		print("nay kuntra", body.damage_amount)
		
		animated_sprite_2d.play("hurt")
		
		HealthManager.decrease_HP(body.damage_amount)
		
		print("afatay", body.damage_amount)
		
	if HealthManager.currentHP==0:
		animated_sprite_2d.play("death")


func _on_animated_sprite_2d_animation_finished():
	attack_done = true
func swing_handler():
	hitzone.move_local_x(1*swing_direction)
