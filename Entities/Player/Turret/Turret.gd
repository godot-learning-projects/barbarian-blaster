extends Node3D
class_name Turret

@onready var _turret_top: MeshInstance3D = $TurretBase/TurretTop
@onready var _turret_range_view := $TurretBase/TurretRangeView
@onready var _animation_player = $AnimationPlayer

@export var _projectile: PackedScene;
@export var turret_range: float = 10.0;

var current_target = null
var _enemy_path: Path3D

# Instance parameters constructor setter.
func set_params(path: Path3D) -> Turret:
	self._enemy_path = path
	return self


func _ready():
	_turret_range_view.mesh.top_radius = turret_range

# Timed signal to shoot
func _on_timer_timeout():
	shoot()

# Process if there is an enemy to be shoot and if it is possible to shot.
func shoot() -> void:
	# If there is no enemy on target, try to find one,
	# If not able to find a possible target just stop.
	if current_target == null:
		if !_aim_next_enemy():
			return

	# If the distance of the current target is farther than the turret could shot,
	# call the function again
	var distance = global_position.distance_to(current_target.global_position)
	if distance > turret_range:
		current_target = null
		return shoot()
		
	# Instantiate a new project and throw to the target
	
	look_at(current_target.global_position, Vector3.UP, true)
	var shot = _projectile.instantiate()
	get_parent().add_child(shot)
	_animation_player.play("Shoot")
	shot.global_position = _turret_top.global_position
	shot.rotation = _turret_top.global_rotation
	shot.direction = _turret_top.global_transform.basis.z

# Keep tracking the enemy
func _physics_process(_delta):
	if current_target != null:
		look_at(current_target.global_position, Vector3.UP, true)

# Find a new enemy
func _aim_next_enemy() -> bool:
	current_target = _find_best_target(_enemy_path.get_enemy_children())
	
	if current_target:
		return true
	return false

# Look throw possible enemies and discover which is the best target
func _find_best_target(enemies: Array[PathFollow3D]) -> PathFollow3D:
	var best_target = null
	
	for element in enemies:
		var distance = global_position.distance_to(element.global_position)
		if distance < turret_range:
			best_target = element
	
	return best_target


func show_view_range(draw: bool) -> void:
	_turret_range_view.visible = draw
