# GrandPa.gd
extends CharacterBody2D

var target_in_range : bool = false

func _ready() -> void:
	$AnimationPlayer.play("Idle")

func _physics_process(delta: float) -> void:
	pass


func _on_hurt_box_area_entered(area: Area2D) -> void:
	var damage = Global.calculate_damage(PlayerData.attack_melee, 0, PlayerData.defense, 0)
	
	Global.display_damage(damage, $Damage_no.global_position, false)
	Global.display_dialoque(Global.dialoque_array[randi_range(0, Global.dialoque_array.size()-1)], self.global_position + Vector2(0, -250))
	


func _on_area_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Character"):
		target_in_range = true
		$AnimationPlayer.play("PunchPad")


func _on_area_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Character"):
		target_in_range = false
		$AnimationPlayer.play("Idle")
