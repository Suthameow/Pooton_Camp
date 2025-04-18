extends Node2D


func _ready() -> void:
	call_deferred("npc_go_left")
	call_deferred("noble_go_left")


func noble_go_left() -> void :
	%Noble/Noble1.get_node("%AnimationPlayer").play("walk1")
	%Noble/Noble2.get_node("%AnimationPlayer").play("walk2")
	
	var tween = get_tree().create_tween()
	tween.tween_property(%Noble/Noble1, "position", Vector2(620, 325), 10.0)
	tween.parallel().tween_property(%Noble/Noble2, "position", Vector2(675, 325), 10.0)
	
	tween.tween_callback(look_down.bind(%Noble/Noble1))
	tween.tween_callback(look_down.bind(%Noble/Noble2)).set_delay(1)


func look_down(path : CharacterBody2D) -> void:
	path.get_node("%AnimationPlayer").play("Look")


func npc_go_left() -> void :
	for npc_node in %NPC.get_children(): # Get_every nodes in %NPC
		npc_node.get_node("%AnimationPlayer").play("Push")
		var tween = get_tree().create_tween().set_loops(0)
		tween.tween_property(npc_node, "position", Vector2.LEFT * Global.randome_int(20, 50), 2.25).as_relative().set_trans(Tween.TRANS_SINE)
		
