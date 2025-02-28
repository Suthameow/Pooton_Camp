extends Resource
class_name UserSetting 

#####  %APPDATA%\Godot\app_userdata\Pooton Camp

@export_category("User Information")
@export var username : String = "StudentA"


@export_category("Audio")
@export_range(0, 1, 0.05) var main_level : float = 1.0
@export_range(0, 1, 0.05) var music_level : float = 1.0
@export_range(0, 1, 0.05) var sfx_level : float = 1.0
@export_range(0, 1, 0.05) var ui_level : float = 1.0

@export_category("Language")
@export_enum("en", "cn", "th") var language : int = 0


func save() -> void : 
	ResourceSaver.save(self, "user://user_setting.tres")


static func load_or_create() -> UserSetting :
	var user_setting: UserSetting
	if ResourceLoader.exists("user://user_setting.tres"): # found saved setting
		user_setting = load("user://user_setting.tres") as UserSetting # TRANSFER 
	else:
		user_setting = UserSetting.new()
	return user_setting
