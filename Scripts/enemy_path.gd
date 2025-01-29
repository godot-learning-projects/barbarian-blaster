extends Path3D

@export var _enemy: PackedScene
@export var dificulty_manager: Node
@export var victory_layer: CanvasLayer

@onready var timer := $Timer

func _ready():
	timer.start(dificulty_manager.get_spawn_time())

func spawn_enemy() -> void:
	var _enemy_instance = _enemy.instantiate()
	add_child(_enemy_instance.set_params(int(dificulty_manager.get_health_ratio())))
	_enemy_instance.tree_exited.connect(enemy_defeatead)
	timer.wait_time = dificulty_manager.get_spawn_time()


func _on_dificulty_manager_stop_spawning_enemies():
	timer.stop()

func enemy_defeatead() -> void:
	if timer.is_stopped():
		if get_enemy_children().size() > 0:
			return
		victory_layer.victory()


func get_enemy_children() -> Array[PathFollow3D]:
	var filtered_array := get_children().filter(func(element): return element is PathFollow3D)
	var enemies: Array[PathFollow3D] = []
	enemies.assign(filtered_array)
	return enemies;
