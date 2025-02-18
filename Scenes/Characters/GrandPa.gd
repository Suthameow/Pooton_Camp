# GrandPa.gd
extends CharacterBody2D


@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@export var target_to_chase : CharacterBody2D


const grandpa_speed : int = 20
var speed : int
var target_in_range : bool = false
var punch_quest : int = 10
var attackable : bool

func _ready() -> void:
	set_physics_process(false)
	speed = grandpa_speed
	$AnimationPlayer.play("Walk")
	
	call_deferred("wait_for_physics")
	call_deferred("quest_inform")


func wait_for_physics() -> void:
	await get_tree().physics_frame
	call_deferred("set_physics_process", true)

func quest_inform() -> void:
	await get_tree().create_timer(1).timeout
	Global.display_dialoque(tr("GRANDPA_QUEST"), 2.0, $Bubble_path)



func _physics_process(_delta: float) -> void:
	navigation_agent.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * speed
	move_and_slide()
	
	if target_to_chase.global_position.x - self.global_position.x > 0:
		$Marker2D.scale.x = -1
	else:
		$Marker2D.scale.x = 1
	
	##### UI Attackable
	if abs(target_to_chase.global_position.y - self.global_position.y) <= 8 :
		$Marker2D/Attackable.visible = true
		attackable = true
	else: 
		$Marker2D/Attackable.visible = false
		attackable = false




func _on_hurt_box_area_entered(_area: Area2D) -> void:
	var damage = Global.calculate_damage(PlayerData.attack_melee, 0, PlayerData.defense, 0)
	
	if attackable == true:
		Global.display_damage(damage, $Marker2D/BoxingPads/Padding.global_position)
		Global.display_dialoque(tr(Global.dialoque_array[randi_range(0, Global.dialoque_array.size()-1)]), 0.75, $Bubble_path)
			
		if punch_quest > 0:
			punch_quest -= 1


func _on_nuts_box_area_entered(_area: Area2D) -> void:
	if attackable == true:
		$AnimationPlayer.play("Kick_Nut")
		Global.display_dialoque(tr("GRANDPAHURT"), 0.75, $Bubble_path)
		await  $AnimationPlayer.animation_finished
		$AnimationPlayer.play("PunchPad")


func _on_area_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Character"):
		target_in_range = true
		speed = 0
		$AnimationPlayer.play("PunchPad")
		target_in_range = true
		
		if punch_quest > 0:
			Global.display_dialoque(tr("GRANDPA0") + " " + str(punch_quest) + " " + tr("TIMES"), 2.0, $Bubble_path)


func _on_area_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Character"):
		target_in_range = false
		speed = grandpa_speed
		$AnimationPlayer.play("Walk")
		target_in_range = false
	
