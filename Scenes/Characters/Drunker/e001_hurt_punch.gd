# e001_hurt_punch.gd
extends State
class_name e001_hurt_punch


@onready var e001_body : drunker = $"../.."
const speed : int = 125 # Standstill
var target_to_chase : CharacterBody2D

func state_enter():
	%AnimationPlayer.play("HurtPunch")
	print("e001_hurt_punch : state_enter")


func state_exit():
	print("e001_hurt_punch : state_exit")


func state_physics_update(_delta: float):
	e001_body.velocity = Vector2.ZERO
