# c001_idle.gd
class_name c001_idle
extends State

@onready var c001_body : doctor = $"../.."


func state_enter():
	%AnimationPlayer.play("Idle")
	print("c001_idle : state_enter")


func state_exit():
	print("c001_idle : state_exit")


func state_physics_update(_delta: float):
	c001_body.velocity = Vector2.ZERO
	
	
	if %State_Machine.input_vector != Vector2.ZERO: # Character is moving, not (0, 0) AND not action
		%State_Machine.on_child_transition(%State_Machine.current_state, "c001_run")
			
