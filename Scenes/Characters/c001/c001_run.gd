# c001_run.gd
class_name c001_run
extends State

@onready var c001_body : doctor = $"../.."

const acceleration : float = 20.0
const friction : float = 10.0

func state_enter():
	%AnimationPlayer.play("Run")
	print("c001_run : state_enter")


func state_exit():
	print("c001_run : state_exit")


func state_physics_update(_delta: float):
	
	
	if %State_Machine.input_vector != Vector2.ZERO: # Character is moving, not (0, 0) AND not action
		if %State_Machine.sprite_action == true:
			c001_body.velocity = c001_body.velocity.move_toward(Vector2.ZERO, friction ) # a little bit slide.
		else:
			c001_body.velocity += %State_Machine.input_vector * acceleration
			c001_body.velocity = c001_body.velocity.limit_length(Global.MAIN_DATA.CharacterList[0].run_speed) * Vector2(1, 0.7071) # limit_length = setup the ceiling number.
			if %State_Machine.input_vector.x >= 0: # Move to the right | Turn right
				%Marker2D.scale.x = 1
				%AnimationPlayer.play("Run")
				#on_child_transition(current_state, "c001_run")
			else: # Move to the left | Turn left
				%Marker2D.scale.x = -1
				%AnimationPlayer.play("Run")
				#on_child_transition(current_state, "c001_run")
	else: # released / not moving
		c001_body.velocity = c001_body.velocity.move_toward(Vector2.ZERO, friction) # a little bit slide.
		if %State_Machine.sprite_action == true:
			pass
		else:
			#%AnimationPlayer.play("Idle")
			%State_Machine.on_child_transition(%State_Machine.current_state, "c001_idle")
