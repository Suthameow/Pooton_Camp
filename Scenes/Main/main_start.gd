# main_start.gd 
extends Control

var user_setting : UserSetting
var set_language = ["en", "cn", "th", "fr", "de", ] # Same order as user_setting.gd
var mainGame : PackedScene = preload("res://Scenes/Levels/Gym.tscn")


func _ready() -> void:
	user_setting = UserSetting.load_or_create()
	Global.language_setting = user_setting.language
	TranslationServer.set_locale(set_language[user_setting.language]) # (user_setting.language)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(mainGame)



func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ActionA"):
		get_tree().change_scene_to_packed(mainGame)
		
		
