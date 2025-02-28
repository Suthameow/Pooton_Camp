# character_panel.gd
extends Button

var character : CharacterData

func _ready() -> void:
	pass


func change_language() -> void:
	pass


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true :
		%Pos.get_child(0).position = Vector2.ZERO
		Global.character_selected.emit(character)
		$Background.self_modulate = Color("ffffff")
		#%Pos.get_child(0).sprite_action = true
		%Pos.get_child(0).get_node("AnimationPlayer").play("Punch")
		await %Pos.get_child(0).get_node("AnimationPlayer").animation_finished
		%Pos.get_child(0).get_node("AnimationPlayer").play("Kick")
		
		
	else:
		$Background.self_modulate = Color("ffffff64")
