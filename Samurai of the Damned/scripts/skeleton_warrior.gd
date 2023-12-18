extends CharacterBody2D


const SPEED = 240.0
const JUMPFORCE = -290.0
@onready var sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite2D.play("jump")

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE


	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if Input.is_action_pressed("right"):
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
			
	elif Input.is_action_pressed("left"):
		velocity.x = -direction * -SPEED
		$AnimatedSprite2D.play("run")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
		
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	
	if(direction != 0):
		sprite.flip_h = (direction == -1)
		
		
	if Input.is_action_pressed("attack1"):
		$AnimatedSprite2D.play("attack1")

	move_and_slide()





