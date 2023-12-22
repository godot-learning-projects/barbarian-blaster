extends Camera3D

@export var gridmap: GridMap
@export var ray_cast_Z_distance: float = 100.0
@onready var ray_cast_3d = $RayCast3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var target = project_local_ray_normal(mouse_position) * ray_cast_Z_distance
	ray_cast_3d.target_position = target
	ray_cast_3d.force_raycast_update()
	
	#printt(ray_cast_3d.get_collider(), ray_cast_3d.get_collision_point())
	
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		if collider is GridMap:
			#var _collision_point = ray_cast_3d.get_collision_point()
			var _cell = gridmap.local_to_map(ray_cast_3d.get_collision_point())
			if gridmap.get_cell_item(_cell) == 0:
				gridmap.set_cell_item(_cell, 1)
			
