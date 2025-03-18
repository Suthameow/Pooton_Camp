# e001_main.gd
extends CharacterBody2D
class_name drunker


@export var target_to_chase : CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var area_attack: CollisionShape2D = $Marker2D/AreaAttack/AttackDetection


var target_in_range : bool = false
var punch_quest : int = 10
var attackable : bool # Vertical attack check

var attack_in_range : bool # Enter the attack area


func _ready() -> void:
	self.platform_floor_layers = false # BUG fixed : https://forum.godotengine.org/t/what-is-causing-my-collision2d-to-stick-to-each-others/1404/4


func _physics_process(_delta: float) -> void:
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
		attack_in_range = true
		%State_Machine.on_child_transition(%State_Machine.current_state, "e001_attack")


func _on_area_attack_body_exited(body: Node2D) -> void:
	if body.is_in_group("Character"):
		attack_in_range = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		%State_Machine.on_child_transition(%State_Machine.current_state, "e001_tired")
	elif anim_name == "Tired":
		%State_Machine.on_child_transition(%State_Machine.current_state, "e001_walk")
	elif anim_name == "HurtPunch":
		%State_Machine.on_child_transition(%State_Machine.current_state, "e001_idle")
		
	


func _on_hurt_box_area_entered(_area: Area2D) -> void:
	var damage = Global.calculate_damage(PlayerData.attack_melee, 0, PlayerData.defense, 0)
	
	if attackable == true:
		Global.display_damage(damage, $Marker2D/HurtBox/Head.global_position)
		%State_Machine.on_child_transition(%State_Machine.current_state, "e001_hurt_punch")


func _on_timer_timeout() -> void:
	%State_Machine.on_child_transition(%State_Machine.current_state, "e001_walk")
