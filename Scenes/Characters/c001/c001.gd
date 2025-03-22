# c001.gd
class_name doctor
extends CharacterBody2D


func _ready() -> void:
	self.platform_floor_layers = false # BUG fixed : https://forum.godotengine.org/t/what-is-causing-my-collision2d-to-stick-to-each-others/1404/4
	call_deferred("setup_character")


func setup_character() -> void:
	PlayerData.attack_melee = 100
	PlayerData.attack_range = 0
	PlayerData.defense = 100
	PlayerData.costume_defense = 0


# Make an Action RPG in Godot 3.2 - https://www.youtube.com/watch?v=EQA9MJ5_TxU&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=2
# Make an action RPG in Godot 4 - https://www.youtube.com/watch?v=aixZT_e8xsk&list=PLzp-pJarR3ar6OSfunTB2Qpwx9fl3Pxbg&index=12
# animatedSprite2D + Melee attacking - https://www.youtube.com/watch?v=q0WHhsmifkQ
func _physics_process(_delta: float) -> void:
	move_and_slide()


#func _input(_event: InputEvent) -> void:
	#if Input.is_action_just_pressed("Hit"):
		#sprite_action = true
		#$AnimationPlayer.play("Punch")
		#await $AnimationPlayer.animation_finished
		#sprite_action = false
	#
	#if Input.is_action_just_released("Kick"):
		#sprite_action = true
		#$AnimationPlayer.play("Kick")
		#await $AnimationPlayer.animation_finished
		#sprite_action = false
