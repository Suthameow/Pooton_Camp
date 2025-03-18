extends State
class_name e001_tired

@onready var state_machine: Node = $".."
@onready var e001_body : drunker = $"../.."
const speed : int = 0 # Standstill


func state_enter():
	%AnimationPlayer.play("Tired")
	print("e001_tired : state_enter")


func state_exit():
	print("e001_tired : state_exit")


func state_physics_update(_delta: float):
	e001_body.velocity = Vector2.ZERO
