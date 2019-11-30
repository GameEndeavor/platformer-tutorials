extends KinematicBody2D

const GRAVITY = 1500
const JUMP_VELOCITY = -700
const MOVE_SPEED = 8 * 32

var velocity = Vector2()
var is_jumping = false

func _input(event):
	if event.is_action_pressed("jump") && is_on_floor():
		is_jumping = true
		velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	if is_jumping && velocity.y > 0:
		is_jumping = false
	
	var move_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	velocity.x = move_direction * MOVE_SPEED
	
	
	var snap = Vector2.ZERO if is_jumping else Vector2.DOWN * 8
	
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)