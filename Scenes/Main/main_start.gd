# main_start.gd 
extends Control


const CHARACTER_SELECTION = preload("res://Scenes/Main/character_selection.tscn")



func _ready() -> void:
	Global.set_localization(1) # ("en", "cn", "th")
	call_deferred("set_language")


func set_language() -> void:
	$MarginContainer/HBoxContainer/Menu/Button.text = tr("PLAY")



func _on_button_pressed() -> void:
	Global.user_setting.save()
	get_tree().change_scene_to_packed(CHARACTER_SELECTION)



func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ActionA"):
		_on_button_pressed()
		
		
