# e001_main.gd
extends CharacterBody2D
class_name drunker


@export var target_to_chase : CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var area_attack: CollisionShape2D = $Marker2D/AreaAttack/AttackDetection
const HP_BAR_MINION = preload("uid://dlytq1pl1xsx0") # res://Scenes/UI/hp_bar_minion.tscn
const max_hp : float = 100
var current_hp : float
var target_in_range : bool = false
var attackable : bool # Vertical attack check


func _ready() -> void:
	self.platform_floor_layers = false # BUG fixed : https://forum.godotengine.org/t/what-is-causing-my-collision2d-to-stick-to-each-others/1404/4
	call_deferred("spawn_hp_bar", max_hp, max_hp)


func spawn_hp_bar(MAX_HP_F : float, CURRENT_HP_F : float):
	var new_hp_bar = HP_BAR_MINION.instantiate()
	new_hp_bar.MAX_HP = MAX_HP_F 
	new_hp_bar.CURRENT_HP = CURRENT_HP_F
	current_hp = MAX_HP_F
	new_hp_bar.set_name("hp_bar")
	add_child(new_hp_bar)


func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	##### UI Attackable
	if abs(target_to_chase.global_position.y - self.global_position.y) <= Global.vertical_different :
		$Marker2D/Attackable.visible = true
		attackable = true
	else: 
		$Marker2D/Attackable.visible = false
		attackable = false
