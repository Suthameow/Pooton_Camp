# e001_stun.gd
class_name e001_stun 
extends State

@onready var state_machine: Node = $".."
@onready var e001_body : drunker = $"../.."


func state_enter():
	%AnimationPlayer.play("Stun")
	print("e001_stun : state_enter")


func state_exit():
	print("e001_stun : state_exit")


func state_physics_update(_delta: float):
	e001_body.velocity = Vector2.ZERO
