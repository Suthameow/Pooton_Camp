# Drunker.gd e001.gd
extends CharacterBody2D
#class_name drunker


@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var area_attack: CollisionShape2D = $Marker2D/AreaAttack/AttackDetection

@export var target_to_chase : CharacterBody2D


const speed_drunker : int = 25
const speed_run : int = 115
var speed : int
var target_in_range : bool = false
var punch_quest : int = 10
var attackable : bool # Vertical attack check
var Hurt_condition : bool = false


func _ready() -> void:
	self.platform_floor_layers = false # BUG fixed : https://forum.godotengine.org/t/what-is-causing-my-collision2d-to-stick-to-each-others/1404/4
	set_physics_process(false)
	speed = speed_drunker
	
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
	
	##### Chasing Player 
	if target_to_chase.is_in_group("Character"):
		$AnimationTree.set("parameters/conditions/A_Hunt", true)



##### Area2D AreaAttack ##############################################################
func _on_area_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Character"):
		target_in_range = true
		speed = speed_run
	$AnimationTree.set("parameters/conditions/A_Attack", target_in_range)


func _on_area_attack_body_exited(body: Node2D) -> void:
	if body.is_in_group("Character"):
		target_in_range = false
	$AnimationTree.set("parameters/conditions/A_Attack", target_in_range)


##### Hurt Box ##############################################################
func _on_hurt_box_area_entered(_area: Area2D) -> void:
	var damage = Global.calculate_damage(PlayerData.attack_melee, 0, PlayerData.defense, 0)
	
	if attackable == true:
		Global.display_damage(damage, $Marker2D/HurtBox/Head.global_position)
		Hurt_condition = true
		speed = 0



##### Animation Tree ###########################################################
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		speed = 0
		$Marker2D/AreaAttack/AttackDetection.disabled = true
		
	elif anim_name == "Tired":
		speed = speed_drunker
		$Marker2D/AreaAttack/AttackDetection.disabled = false
	
	elif  anim_name == "HurtPunch":
		Hurt_condition = false
		target_in_range = false
		speed = speed_drunker
		$Marker2D/AreaAttack/AttackDetection.disabled = false
		
	print(str(anim_name) + " : Speed = " + str(speed))
