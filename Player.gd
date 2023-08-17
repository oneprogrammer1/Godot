extends KinematicBody2D

# Variables

var VELOCITY = Vector2(0, 0)
var UP = Vector2(0, -1)

const SPEED = 500
const JUMP_SPEED = 1000
const GRAVITY = 75

var JUMP_COUNT = 0
var lives = 10
var height_for_falling = 2500

func _ready():
	pass 

func hurt():
	if lives > 0:
		lives = lives - 1
		print(lives)
	elif lives == 0:
		update_gui()

func enemy_jump():
	VELOCITY.y = -JUMP_SPEED
	
	

func _physics_process(delta):
		jump() 	
		move()
		
		apply_gravity()
		animate()
		move_and_slide(VELOCITY, UP)
		
func move():
	if Input.is_action_pressed("Left"):
		VELOCITY.x = -SPEED	
	elif Input.is_action_pressed("Right"):
		VELOCITY.x = SPEED
	else:
		VELOCITY.x = 0

func jump():
	if 	Input.is_action_pressed("Jump") and JUMP_COUNT < 2:
		VELOCITY.y -= JUMP_SPEED
		JUMP_COUNT = JUMP_COUNT + 1
		$Jump_sound.play()
	elif is_on_floor():
		JUMP_COUNT = 0

func apply_gravity():
	if not is_on_floor():
		VELOCITY.y += GRAVITY
	elif is_on_ceiling():
		VELOCITY.y += GRAVITY * 2
	elif is_on_floor():
		VELOCITY.y = 0
		
	if position.y >= height_for_falling:
		get_tree().call_group("GUI", "game_restart")
		
		
		
func animate():
	if VELOCITY.y < 0:
		$AnimatedSprite.play("jump")
	elif VELOCITY.x != 0 and VELOCITY.x > 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false	
	elif VELOCITY.x != 0 and VELOCITY.x < 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true	
	elif is_on_floor():
		$AnimatedSprite.play("idle")

func update_gui():
	get_tree().call_group("GUI", "update_gui", lives)
	
	
