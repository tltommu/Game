extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.animation="jump"
		
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction ==-1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction==1:
		get_node("AnimatedSprite2D").flip_h= false
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.animation="run"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y==0:
			animated_sprite_2d.animation="idle"
		if velocity.y>0:
			animated_sprite_2d.animation="fall"

	move_and_slide()
	
	
