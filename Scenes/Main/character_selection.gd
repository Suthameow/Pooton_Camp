#character_selection.gd
extends Control

const CHARACTER_PANEL = preload("res://Scenes/UI/character_panel.tscn") # character_panel scene
const BUTTON_G_CHARACTER_LIST = preload("res://Images/Theme/ButtonG_CharacterList.tres") # Button Group
const GYM = preload("res://Scenes/Levels/Gym.tscn")


func _ready() -> void:
	Global.set_localization(2) # ("en", "cn", "th")
	print(Global.language_setting)
	
	Global.clear_node(%CharacterList)
	Global.character_selected.connect(Character_selected)
	
	%Start.disabled = true
	%Start/Background.self_modulate = Color("ffffff64")
	call_deferred("populate_character")
	call_deferred("scene_preparation")
	


func scene_preparation() -> void:
	Global.character_selected.emit(Global.MAIN_DATA.CharacterList[0]) # fill the Doctor infomation
	%CharacterList.get_child(0).button_pressed = true
	
	#%Info/JobName.text = tr("")
	#%Info/Slogan.text = tr("")
	#%Info/Detail.text = tr("")
	#%Info/Motto.text = tr("")
	#
	#%Start.disabled = true


func populate_character() -> void:
	for Chalacter_slot in Global.MAIN_DATA.CharacterList:
		var new_character = CHARACTER_PANEL.instantiate() # Template
		
		if Chalacter_slot.unlocked == true: 
			
			var sprite = Chalacter_slot.character_scene.instantiate() # Resource
			
			new_character.character = Chalacter_slot # store character infomation
			new_character.name = Chalacter_slot.job
			new_character.get_node("%JobLabel").text = tr(Chalacter_slot.job)
			new_character.get_node("%Pos").add_child(sprite)
			new_character.get_node("%Pos").get_child(0).position = Vector2(0,0)
			#new_character.get_node("%Pos").get_child(0).set_physics_process(false)
			new_character.button_group = BUTTON_G_CHARACTER_LIST
			%CharacterList.add_child(new_character)
			
			print("Job added: " + str(Chalacter_slot.job))
		else: 
			#var new_character = CHARACTER_PANEL.instantiate() # Template
			var sprite = Chalacter_slot.character_scene.instantiate() # Resource
			
			new_character.disabled = true
			new_character.name = Chalacter_slot.job
			new_character.get_node("%JobLabel").text = tr(Chalacter_slot.job)
			new_character.get_node("%Pos").add_child(sprite)
			new_character.get_node("%Pos").get_child(0).position = Vector2(0,0)
			new_character.get_node("%Pos").get_child(0).modulate = Color.BLACK
			new_character.button_group = BUTTON_G_CHARACTER_LIST
			%CharacterList.add_child(new_character)
			
			print("Job locked: " + str(Chalacter_slot.job))
		



func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(GYM)


func Character_selected(character : CharacterData) -> void:
	##### Update infomation 
	%Info/JobName.text = tr(character.job)
	%Info/Slogan.text = tr(character.slogan)
	%Info/Detail.text = tr(character.job_detail)
	%Info/Motto.text = tr(character.motto)
	
	##### Start button 
	%Start.disabled = false
	%Start/Background.self_modulate = Color("ffffff")


func _on_character_selected() -> void:
	pass # Replace with function body.
