# _Global.gd
extends Node


func calculate_damage(base_damage:int, weapon_damage:int, base_defense:int, costume_defense:int) -> int:
	var totol_damage = (randi_range(base_damage-10, base_damage+10) + weapon_damage) * 100 / ((base_defense + costume_defense) + 100 )
	
	return round(totol_damage)
