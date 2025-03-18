# e001_attack.gd
extends State
class_name e001_attack


@onready var e001_body : drunker = $"../.."
const speed : int = 125 # Standstill
var target_to_chase : CharacterBody2D

func state_enter():
	target_to_chase = get_tree().get_first_node_in_group("Character")
	%AnimationPlayer.play("Attack")
	print("e001_attack : state_enter")


func state_exit():
	print("e001_attack : state_exit")



func state_physics_update(_delta: float):
	##### Chasing Player 
	%NavigationAgent2D.target_position = target_to_chase.global_position
	e001_body.velocity = e001_body.global_position.direction_to(%NavigationAgent2D.get_next_path_position()) * speed
