extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const gravity = 1000
const dalagan = 300

@export var max_horizontal_speed: int = 300
@export var slow_down_speed: int = 1700
@export var jump: int = -300
@export var jump_horizontal_speed: int = 1000
@export var max_jump_horizontal_speed: int = 300
@export var jump_count: int = 1

enum State { Idle, Run, Jump, Fall, Hapak }

var current_state
var current_jump_count: int

var attack_cooldown: float = 0.5  # Adjust the cooldown time as needed
var time_since_last_attack: float = 0.0

func _ready():
	current_state = State.Idle

func _physics_process(delta):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	player_attack(delta)  # Call the attack function here
	move_and_slide()
	player_animations()

func player_falling(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			current_state = State.Fall

func player_idle(delta):
	if is_on_floor():
		current_state = State.Idle

func player_run(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * dalagan
	else:
		velocity.x = move_toward(velocity.x, 0, dalagan)
	if direction != 0:
		current_state = State.Run
		animated_sprite_2d.flip_h = false if direction > 0 else true

func player_jump(delta: float):
	var jump_input: bool = Input.is_action_just_pressed("jump")
	if is_on_floor() and jump_input:
		current_jump_count = 0
		velocity.y = jump
		current_jump_count += 1
		current_state = State.Jump
	if !is_on_floor() and jump_input and current_jump_count < jump_count:
		velocity.y = jump
		current_jump_count += 1
		current_state = State.Jump

func player_attack(delta):
	var attack_input = Input.is_action_just_pressed("attack1")
	time_since_last_attack += delta  # Increment the time_since_last_attack

	if attack_input and time_since_last_attack > attack_cooldown:
		current_state = State.Hapak
		time_since_last_attack = 0.

		print("Attacking!")

func player_animations():
	match current_state:
		State.Idle:
			animated_sprite_2d.play("idle")
		State.Run:
			animated_sprite_2d.play("run")
		State.Jump:
			animated_sprite_2d.play("jump")
		State.Fall:
			animated_sprite_2d.play("fall")
		State.Hapak:
			animated_sprite_2d.play("attack1")
