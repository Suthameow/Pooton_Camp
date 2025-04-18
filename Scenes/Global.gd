# _Global.gd
extends Node
#####  %APPDATA%\Godot\app_userdata\Pooton Camp


##### Resources ################################################################
var MAIN_DATA : Main = preload("uid://dxl022otmr2c4") #res://Resources/MainData.tres # Main infomation

##### Setting ##################################################################
var saved_game = "user://save/playerSave.res"
var playerData = PlayerData


##### Character List
@warning_ignore("unused_signal")
signal character_selected

const vertical_different : int = 16


##### Theme
const EN_BUBBLE = preload("uid://yemmps56otm7") #res://Images/Theme/en_Bubble.tres
const TH_BUBBLE = preload("uid://c4mpia10isl2n") #res://Images/Theme/th_Bubble.tres

const resistance : int = 100
@onready var DAMAGE_NO : PackedScene = preload("uid://7jayk6adqw46") #res://Scenes/UI/damage_no.tscn
@onready var BUBBLE_BOX = preload("uid://c1cc1mdywm8x5") #res://Scenes/UI/bubble_box.tscn



var dialoque_array = ["GRANDPA1", "GRANDPA2", "GRANDPA3", "GRANDPA4", "GRANDPA5", "GRANDPA6", "GRANDPA7", "GRANDPA8", "GRANDPA9", "GRANDPA10"]

func _ready() -> void:
	user_setting = UserSetting.load_or_create()

##### Langauge #################################################################
var language_setting : int = 0 # ("en", "cn", "th")
var user_setting : UserSetting
var set_language_index = ["en", "cn", "th"] # Same order as user_setting.gd

func set_localization(language_index) -> void:
	# language_setting = user_setting.language 
	language_setting = language_index # Update current Language index
	user_setting.language = language_index # Set Language in user_setting var language : int : enum("en", "cn", "th")
	
	TranslationServer.set_locale(set_language_index[user_setting.language])
	
	


#####  #########################################################################
func clear_node(path : Node):
	for child in path.get_children(): # Clear everything in the inventory first / Empty before reload
		path.remove_child(child)
		child.queue_free()


func calculate_damage(base_damage:int, weapon_damage:int, base_defense:int, costume_defense:int) -> int:
	@warning_ignore("integer_division")
	var totol_damage = (randi_range(base_damage-10, base_damage+10) + weapon_damage) * 100 / ((base_defense + costume_defense + resistance) + 100 )
	
	return round(totol_damage)


func display_damage(value : int, position : Vector2):
	var number = DAMAGE_NO.instantiate()
	number.global_position = position - Vector2(number.size / 2)
	number.text = str(value)
	number.pivot_offset = Vector2(number.size / 2)
	
	call_deferred("add_child", number)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position:y", number.position.y - 200, 1.0).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, "position:x", number.position.x + 50, 0.5).set_ease(Tween.EASE_OUT).set_delay(0.5)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.75).set_ease(Tween.EASE_OUT).set_delay(0.25)
	
	await tween.finished
	
	if number != null: # BUG: Destroy before await finish
		number.call_deferred("queue_free")


func display_dialoque(dialoque : String, duration : float, path : Node):
	clear_node(path)
	
	var bubble_box = BUBBLE_BOX.instantiate()
	bubble_box.get_node("%Dialoque").text = dialoque
	
	if language_setting == 0:
		bubble_box.set_theme(EN_BUBBLE)
	elif language_setting == 1:
		bubble_box.set_theme(EN_BUBBLE)
	else:
		bubble_box.set_theme(TH_BUBBLE)
	
	path.call_deferred("add_child", bubble_box)
	
	await get_tree().create_timer(duration).timeout # wait for duration sec.
	
	if path.get_children().size() > 0:  # BUG: Destroy before await finish
		path.get_child(0).call_deferred("queue_free")


func randome_int(MINI : int, MAXI : int) :
	var random_number = randi_range(MINI, MAXI)
	return random_number
