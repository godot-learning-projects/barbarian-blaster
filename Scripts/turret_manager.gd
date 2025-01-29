extends Node3D

class_name TurretManager

@onready var gold_interface = get_tree().get_first_node_in_group("GOLD_INTERFACE")
@export var enemy_path: Path3D
@export var _Turret: PackedScene
@export var turret_cost := 100

var _turret_map = {}

func build(turret_position: Vector3) -> bool:
	if gold_interface.gold >= turret_cost:
		gold_interface.gold -= turret_cost
		var turret = _Turret.instantiate().set_params(enemy_path)
		_turret_map[turret_position] = turret
		add_child(turret)
		turret.global_position = turret_position
		return true
	return false

func destroy(turret_position: Vector3) -> void:
	_turret_map[turret_position].queue_free()
	show_view_range(turret_position, false)
	_turret_map.erase(turret_position)
	gold_interface.gold += int(turret_cost / 2.0)

func show_view_range(turret_position: Vector3, show_range :bool) -> void:
	if _turret_map.has(turret_position):
		var turret = _turret_map[turret_position]
		turret.show_view_range(show_range)
