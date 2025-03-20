# StateMachine.gd
extends Node

@export var starting_state : State
@onready var e001_body: drunker = $".."

var current_state  : State
var states : Dictionary = {}
var attack_in_range : bool # Enter the attack area


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.State_Transition.connect(on_child_transition)
	
	if starting_state:
		starting_state.state_enter()
		current_state = starting_state


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.state_physics_update(delta)


func on_child_transition(old_state_name, new_state_name):
	if old_state_name != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.state_exit()
	
	new_state.state_enter()
	current_state = new_state


func _on_hurt_box_area_entered(_area: Area2D) -> void:
	var damage = Global.calculate_damage(PlayerData.attack_melee, PlayerData.attack_range, PlayerData.defense, PlayerData.costume_defense)
	
	print("melee atk: " + str(PlayerData.attack_melee) + ", range atk: " + str(PlayerData.attack_range) + ", def: " + str(PlayerData.defense) + ", arm: " + str(PlayerData.costume_defense))
	print("damage: " + str(damage))
	if e001_body.attackable == true:
		
		##### Calculate a hp_bar
		e001_body.current_hp -= damage
		e001_body.get_node("hp_bar").get_node("ProgressBar").value = e001_body.current_hp
		
		
		##### Pop up a damage number
		Global.display_damage(damage, %Marker2D/HurtBox/Head.global_position)
		
		##### Dead or Alive States
		if e001_body.current_hp <= 0:
			on_child_transition(current_state, "e001_down")
		else:
			on_child_transition(current_state, "e001_hurt_punch")


func _on_nuts_box_area_entered(_area: Area2D) -> void:
	if e001_body.attackable == true:
		on_child_transition(current_state, "e001_hurt_kick")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		on_child_transition(current_state, "e001_tired")
	elif anim_name == "Tired":
		on_child_transition(current_state, "e001_walk")
	elif anim_name == "HurtPunch":
		on_child_transition(current_state, "e001_walk")
	elif anim_name == "HurtKick":
		on_child_transition(current_state, "e001_tired")
	elif anim_name == "Down":
		$e001_down.speed = 0
		


func _on_area_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Character"):
		attack_in_range = true
		%State_Machine.on_child_transition(%State_Machine.current_state, "e001_attack")
	


func _on_area_attack_body_exited(body: Node2D) -> void:
	if body.is_in_group("Character"):
		attack_in_range = false


func _on_timer_timeout() -> void:
	on_child_transition(%State_Machine.current_state, "e001_walk")
	print("Timer time out")
