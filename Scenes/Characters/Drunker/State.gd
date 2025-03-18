# State.gd
extends Node
class_name State

@warning_ignore("unused_signal")
signal State_Transition


func state_enter():
	pass


func state_exit():
	pass


func state_physics_update(_delta: float):
	pass
