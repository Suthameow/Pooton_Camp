extends Node2D


func _ready() -> void:
	intro_01_start()
	$NPC1.get_node("%AnimationPlayer").play("Push")
	$NPC2.get_node("%AnimationPlayer").play("Push")
	$NPC3.get_node("%AnimationPlayer").play("Push")
	$NPC4.get_node("%AnimationPlayer").play("Push")


func intro_01_start() -> void:
	var tween = get_tree().create_tween().set_loops(0)
	tween.tween_property($NPC1, "position", Vector2.LEFT*50, 2.25).as_relative().set_trans(Tween.TRANS_SINE)
	tween.set_parallel().tween_property($NPC2, "position", Vector2.LEFT*50, 2.25).as_relative().set_trans(Tween.TRANS_SINE)
	tween.set_parallel().tween_property($NPC3, "position", Vector2.LEFT*50, 2.25).as_relative().set_trans(Tween.TRANS_SINE)
	tween.set_parallel().tween_property($NPC4, "position", Vector2.LEFT*50, 2.25).as_relative().set_trans(Tween.TRANS_SINE)
