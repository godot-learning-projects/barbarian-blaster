extends Node3D
class_name TurretManager

@export var Turret: PackedScene

func build_turret(turret_position: Vector3) -> void:
	var _turret = Turret.instantiate()
	add_child(_turret)
	_turret.global_position = turret_position
