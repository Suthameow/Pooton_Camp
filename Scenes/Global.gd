# _Global.gd
extends Node

const resistance : int = 100
@onready var DAMAGE_NO : PackedScene = preload("res://Scenes/UI/damage_no.tscn")

func calculate_damage(base_damage:int, weapon_damage:int, base_defense:int, costume_defense:int) -> int:
	var totol_damage = (randi_range(base_damage-10, base_damage+10) + weapon_damage) * 100 / ((base_defense + costume_defense + resistance) + 100 )
	
	return round(totol_damage)


func display_damage(value : int, position : Vector2, is_critical: bool = false):
	var number = DAMAGE_NO.instantiate()
	number.global_position = position
	number.text = str(value)
	number.pivot_offset = Vector2(number.size / 2)
	
	call_deferred("add_child", number)
	
	
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position:y", number.position.y - 200, 1.0).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, "position:x", number.position.x + 50, 0.5).set_ease(Tween.EASE_OUT).set_delay(0.5)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.75).set_ease(Tween.EASE_OUT).set_delay(0.25)
	await tween.finished
	number.queue_free()
