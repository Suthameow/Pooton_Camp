# e001_down.gd
extends State
class_name e001_down


@onready var e001_body : drunker = $"../.."
var speed : int = 125 # Standstill


func state_enter():
	%AnimationPlayer.play("Down")
	print("e001_down : state_enter")
	%Marker2D/AreaAttack/AttackDetection.set_deferred("disabled", true)
	e001_body.get_node("hp_bar").set_deferred("visible", false)


func state_exit():
	print("e001_down : state_exit")


func state_physics_update(_delta: float):
	e001_body.velocity = e001_body.global_position.direction_to(%NavigationAgent2D.get_next_path_position()) * speed * -1
