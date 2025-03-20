# e001_idle.gd
extends State
class_name e001_idle 


@onready var e001_body : drunker = $"../.."


func state_enter():
	%AnimationPlayer.play("Idle")
	$"../../Timer".start(1.0)
	print("e001_idle : state_enter")


func state_exit():
	print("e001_idle : state_exit")


func state_physics_update(_delta: float):
	e001_body.velocity = Vector2.ZERO
