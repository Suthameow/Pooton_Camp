# Character.gd
extends CharacterBody2D

const acceleration : float = 20.0
const friction : float = 10.0
#const walk_speed : float = 75.0
#const double_tap_time : float = 0.25
var move_speed = 100.0
var time2run : float = 0.0


# https://www.youtube.com/watch?v=EQA9MJ5_TxU&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=2
func _physics_process(delta: float) -> void:
	
	
	# Controling
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("Forward") - Input.get_action_strength("Backward")
	input_vector.y = Input.get_action_strength("Vertical_Down") - Input.get_action_strength("Vertical_Up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO: # pressing
		velocity += input_vector * acceleration * delta
		velocity = velocity.limit_length(move_speed * delta)
		
		##### Walk -> Run
		time2run += delta 
		if time2run >= 3.0:
			move_speed = PlayerData.run_speed
		print(time2run)
	else: # released
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
		##### Run -> Walk
		time2run = 0.0 
		move_speed = 75.0
	
	move_and_collide(velocity * delta * move_speed)
