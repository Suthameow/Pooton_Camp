# e001_walk.gd
extends State
class_name e001_walk

@export var idle : e001_idle
@export var attack : e001_attack

@onready var state_machine: Node = $".."
@onready var e001_body : drunker = $"../.."
const speed : int = 25 # Walking speed
var target_to_chase : CharacterBody2D 


func state_enter():
	target_to_chase = get_tree().get_first_node_in_group("Character")
	$"../../AnimationPlayer".play("Walk")
	print("e001_walk : state_enter")


func state_exit():
	print("e001_walk : state_exit")


func state_physics_update(_delta: float):
	##### Chasing Player 
	%NavigationAgent2D.target_position = target_to_chase.global_position
	e001_body.velocity = e001_body.global_position.direction_to(%NavigationAgent2D.get_next_path_position()) * speed
	
	if e001_body.attack_in_range == true and state_machine.current_state == self:
		State_Transition.emit(self, "e001_attack")
