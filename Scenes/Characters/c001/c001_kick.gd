# c001_punch.gd
class_name c001_kick
extends State


@onready var c001_body : doctor = $"../.."


func state_enter():
	%AnimationPlayer.play("Kick")
	print("c001_kick : state_enter")


func state_exit():
	print("c001_kick : state_exit")


func state_physics_update(_delta: float):
	c001_body.velocity = Vector2.ZERO
	
