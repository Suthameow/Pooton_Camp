extends Node2D

var user_setting : UserSetting
var set_language = ["en", "cn", "th", "fr", "de"] # Same order as user_setting.gd


func _ready() -> void:
	user_setting = UserSetting.load_or_create()
	call_deferred("set_localization", 2)


func set_localization(language_index) -> void:
	TranslationServer.set_locale("th")
	user_setting.language = language_index # ("en", "cn", "th", "fr", "de")
	Global.language_setting = language_index
