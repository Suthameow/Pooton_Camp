# c001_state_machine.gd
extends Node

@export var starting_state : State
@onready var c001_body : doctor = $".."
var input_vector : Vector2 = Vector2.ZERO
var current_state  : State
var states : Dictionary = {}
var attack_in_range : bool # Enter the attack area
var sprite_action : bool = false


func _ready() -> void:
	##### Setup State_Machine dictionary
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.State_Transition.connect(on_child_transition)
	
	##### Setup Starting State
	if starting_state:
		starting_state.state_enter()
		current_state = starting_state


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.state_physics_update(delta)
	
	##### Controling - character movement
	
	input_vector.x = Input.get_axis("Backward", "Forward") #input_vector.x = Input.get_action_strength("Forward") - Input.get_action_strength("Backward")
	input_vector.y = Input.get_axis("Vertical_Up", "Vertical_Down") #input_vector.y = Input.get_action_strength("Vertical_Down") - Input.get_action_strength("Vertical_Up")
	input_vector = input_vector.normalized() 

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


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Punch"):
		sprite_action = true
		on_child_transition(current_state, "c001_punch")
	
	if Input.is_action_just_pressed("Kick"):
		sprite_action = true
		on_child_transition(current_state, "c001_kick")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Punch":
		sprite_action = false
		on_child_transition(current_state, "c001_idle")
	elif anim_name == "Kick":
		sprite_action = false
		on_child_transition(current_state, "c001_idle")
