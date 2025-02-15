# GrandPa.gd
extends CharacterBody2D



func _ready() -> void:
	$AnimationPlayer.play("Idle")
