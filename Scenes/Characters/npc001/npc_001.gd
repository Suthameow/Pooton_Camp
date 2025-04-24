extends CharacterBody2D

signal exit_screen

var npc_type : String
var tween : Tween
var go_direction : Vector2 # assign the direction when spawn


func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_INHERIT



func npc_box(direction : Vector2) -> void :
	go_direction = direction
	self.get_node("%AnimationPlayer").play("Push")
	tween = get_tree().create_tween().bind_node(self).set_loops()
	tween.tween_property(self, "position", direction * Global.randome_int(20, 40), 2.25).as_relative().set_trans(Tween.TRANS_SINE)
	


func npc_cart(direction : Vector2) -> void :
	go_direction = direction
	self.get_node("%AnimationPlayer").play("Cart")
	tween = get_tree().create_tween().bind_node(self).set_loops()
	tween.tween_property(self, "position", direction * Global.randome_int(25, 50), 2.0).as_relative()


func npc_bloom(direction : Vector2) -> void :
	go_direction = direction
	self.get_node("%AnimationPlayer").play("Bloom")
	tween = get_tree().create_tween().bind_node(self).set_loops()
	tween.tween_property(self, "position", direction * Global.randome_int(35, 60), 1.5).as_relative()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	exit_screen.emit(npc_type, go_direction)
	tween.kill()
	call_deferred("queue_free")
