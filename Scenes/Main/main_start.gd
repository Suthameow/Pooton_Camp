# main_start.gd 
extends Control

var mainGame : PackedScene = preload("res://Scenes/Main/test_map.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(mainGame)


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ActionA"):
		get_tree().change_scene_to_packed(mainGame)
