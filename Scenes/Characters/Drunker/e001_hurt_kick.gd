# e001_hurt_kick.gd
extends State
class_name e001_hurt_kick 


@onready var e001_body : drunker = $"../.."


func state_enter():
	%AnimationPlayer.play("HurtKick")
	print("e001_hurt_kick : state_enter")


func state_exit():
	print("e001_hurt_kick : state_exit")


func state_physics_update(_delta: float):
	e001_body.velocity = Vector2.ZERO
