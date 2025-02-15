# GrandPa.gd
extends CharacterBody2D



func _ready() -> void:
	$AnimationPlayer.play("Idle")


func _on_hurt_box_area_entered(area: Area2D) -> void:
	var damage = Global.calculate_damage(PlayerData.attack_melee, 0, PlayerData.defense, 0)
	
	Global.display_damage(damage, $Damage_no.global_position, false)
	print("Hit damage: " + str(damage))
