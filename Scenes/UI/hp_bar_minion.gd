extends Control


var MAX_HP : float
var CURRENT_HP : float


func _ready() -> void:
	call_deferred("start_setup")


func start_setup() -> void:
	$ProgressBar.max_value = MAX_HP
	$ProgressBar.value = CURRENT_HP
