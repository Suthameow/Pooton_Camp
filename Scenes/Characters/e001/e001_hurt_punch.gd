# e001_hurt_punch.gd
class_name e001_hurt_punch
extends State

@onready var e001_body : drunker = $"../.."


func state_enter():
	%AnimationPlayer.play("HurtPunch")
	print("e001_hurt_punch : state_enter")


func state_exit():
	print("e001_hurt_punch : state_exit")


func state_physics_update(_delta: float):
	e001_body.velocity = Vector2.ZERO
