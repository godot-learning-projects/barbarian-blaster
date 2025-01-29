extends Node

signal stop_spawning_enemies

@export var game_length := 60.0
@export var spawn_time_curve: Curve
@export var enemy_health_curve: Curve
@export var victory_layer: CanvasLayer

@onready var timer := $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	victory_layer.visible = false
	timer.start(game_length)
	#Engine.time_scale = 100


func _game_progress_time_ratio() -> float:
	return 1.0 - (timer.time_left / game_length)


func get_spawn_time() -> float:
	return spawn_time_curve.sample(_game_progress_time_ratio())

func get_health_ratio() -> float:
	return enemy_health_curve.sample(_game_progress_time_ratio())


func _on_timer_timeout():
	stop_spawning_enemies.emit()
