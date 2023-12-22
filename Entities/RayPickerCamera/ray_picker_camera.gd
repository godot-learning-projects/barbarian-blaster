extends Camera3D

@export var ray_cast_Z_distance: float = 100.0
@onready var ray_cast_3d = $RayCast3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var target = project_local_ray_normal(mouse_position) * ray_cast_Z_distance
	ray_cast_3d.target_position = target
	ray_cast_3d.force_raycast_update()
	printt(ray_cast_3d.get_collider(), ray_cast_3d.get_collision_point())
	#print(target)
