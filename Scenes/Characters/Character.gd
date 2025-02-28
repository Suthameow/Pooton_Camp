# Character.gd
extends CharacterBody2D

const acceleration : float = 20.0
const friction : float = 10.0

#var sprite_moving : bool
var sprite_action : bool = false


func _ready() -> void:
	pass


# Make an Action RPG in Godot 3.2 - https://www.youtube.com/watch?v=EQA9MJ5_TxU&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=2
# Make an action RPG in Godot 4 - https://www.youtube.com/watch?v=aixZT_e8xsk&list=PLzp-pJarR3ar6OSfunTB2Qpwx9fl3Pxbg&index=12
# animatedSprite2D + Melee attacking - https://www.youtube.com/watch?v=q0WHhsmifkQ
func _physics_process(_delta: float) -> void:
	
	# Controling - character movement
	var input_vector : Vector2 = Vector2.ZERO
	input_vector.x = Input.get_axis("Backward", "Forward") #input_vector.x = Input.get_action_strength("Forward") - Input.get_action_strength("Backward")
	input_vector.y = Input.get_axis("Vertical_Up", "Vertical_Down") #input_vector.y = Input.get_action_strength("Vertical_Down") - Input.get_action_strength("Vertical_Up")
	input_vector = input_vector.normalized() 
	
	if input_vector != Vector2.ZERO: # Character is moving, not (0, 0) AND not action
		if sprite_action == true:
			velocity = velocity.move_toward(Vector2.ZERO, friction ) # a little bit slide.
		else:
			velocity += input_vector * acceleration
			velocity = velocity.limit_length(Global.MAIN_DATA.CharacterList[0].run_speed) * Vector2(1, 0.7071) # limit_length = setup the ceiling number.
			if input_vector.x >= 0: # Move to the right | Turn right
				$Marker2D.scale.x = 1
				$AnimationPlayer.play("Run")
			else: # Move to the left | Turn left
				$Marker2D.scale.x = -1
				$AnimationPlayer.play("Run")
	else: # released / not moving
		velocity = velocity.move_toward(Vector2.ZERO, friction) # a little bit slide.
		if sprite_action == true:
			pass
		else:
			$AnimationPlayer.play("Idle")
	move_and_slide()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Hit"):
		sprite_action = true
		$AnimationPlayer.play("Punch")
		await $AnimationPlayer.animation_finished
		sprite_action = false
	
	if Input.is_action_just_released("Kick"):
		sprite_action = true
		$AnimationPlayer.play("Kick")
		await $AnimationPlayer.animation_finished
		sprite_action = false
