extends Resource

class_name UserSetting 

@export_category("User Information")
@export var username : String = "GardenerA"


@export_category("Audio")
@export_range(0, 1, 0.05) var main_level : float = 1.0
@export_range(0, 1, 0.05) var music_level : float = 1.0
@export_range(0, 1, 0.05) var sfx_level : float = 1.0
@export_range(0, 1, 0.05) var ui_level : float = 1.0

@export_category("Language")
@export_enum("en", "cn", "th", "fr", "de") var language : int = 0


func save() -> void : 
	ResourceSaver.save(self, "user://user_setting.tres")


#static func load_or_create() -> UserSetting :
#	var res: UserSetting = load("user://user_setting.tres") as UserSetting
#	if !res :
#		res = UserSetting.new()
#	return res

static func load_or_create() -> UserSetting :
	var res: UserSetting
	if ResourceLoader.exists("user://user_setting.tres"): # found saved setting
		res = load("user://user_setting.tres") as UserSetting # TRANSFER 
	else:
		res = UserSetting.new()
	return res
