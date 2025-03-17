# Drunker.gd
extends CharacterBody2D


@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var area_attack: CollisionShape2D = $Marker2D/AreaAttack/AttackDetection

@export var target_to_chase : CharacterBody2D


const speed_drunker : int = 25
var speed : int
var target_in_range : bool = false
var punch_quest : int = 10
var attackable : bool


func _ready() -> void:
	self.platform_floor_layers = false # BUG fixed : https://forum.godotengine.org/t/what-is-causing-my-collision2d-to-stick-to-each-others/1404/4
	set_physics_process(false)
	speed = speed_drunker
	$AnimationPlayer.play("Walk")
	
	call_deferred("wait_for_physics")


func wait_for_physics() -> void:
	await get_tree().physics_frame
	call_deferred("set_physics_process", true)


func _physics_process(_delta: float) -> void:
	navigation_agent.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * speed
	move_and_slide()
	
	##### Turning system
	if target_to_chase.global_position.x - self.global_position.x > 0:
		$Marker2D.scale.x = -1
	else:
		$Marker2D.scale.x = 1
	
	##### UI Attackable
	if abs(target_to_chase.global_position.y - self.global_position.y) <= Global.vertical_different :
		$Marker2D/Attackable.visible = true
		attackable = true
	else: 
		$Marker2D/Attackable.visible = false
		attackable = false


func _on_area_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Character"):
		target_in_range = true
		speed = 115
		$AnimationPlayer.play("Attack")
		await $AnimationPlayer.animation_finished
		
		speed = 0
		$AnimationPlayer.play("Tired")
		$Marker2D/AreaAttack/AttackDetection.disabled = true
		$Timer.start(5.0)
		await $AnimationPlayer.animation_finished
		
		$AnimationPlayer.play("Walk")
		speed = speed_drunker


func _on_timer_timeout() -> void:
	$Marker2D/AreaAttack/AttackDetection.disabled = false
	
