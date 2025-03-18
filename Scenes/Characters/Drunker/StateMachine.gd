# StateMachine.gd
extends Node

@export var starting_state : State

var current_state  : State
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.State_Transition.connect(on_child_transition)
	
	if starting_state:
		starting_state.state_enter()
		current_state = starting_state


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.state_physics_update(delta)


func on_child_transition(old_state_name, new_state_name):
	if old_state_name != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.state_exit()
	
	new_state.state_enter()
	current_state = new_state
