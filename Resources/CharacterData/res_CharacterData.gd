extends Resource
class_name CharacterData



@export var unlocked : bool = false

#####
@export_category("Character")
@export var character_scene : PackedScene
@export var character_icon : AtlasTexture
@export var job : String
@export_multiline var job_detail : String = ""
@export var slogan : String
@export var motto : String

#####
@export_category("Stats")
@export var health : int = 100
@export var max_health : int
@export var attack_melee : int = 100
@export var attack_range : int = 100
@export var defense : int = 100
@export var accuracy : int
@export var run_speed : int = 100 # max speed
