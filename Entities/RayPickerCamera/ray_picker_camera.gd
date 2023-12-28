extends Camera3D

@export var gridmap: GridMap
@export var turret_manager: TurretManager
@export var ray_cast_Z_distance: float = 100.0
@onready var ray_cast_3d = $RayCast3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var target = project_local_ray_normal(mouse_position) * ray_cast_Z_distance
	ray_cast_3d.target_position = target
	ray_cast_3d.force_raycast_update()
	
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		if collider is GridMap:
			var cell = gridmap.local_to_map(ray_cast_3d.get_collision_point())
			var gridmap_cell = gridmap.get_cell_item(cell)
			if gridmap_cell == 1:
				Input.set_default_cursor_shape(Input.CURSOR_FORBIDDEN)
			else:
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
				
			if gridmap_cell == 0:
				if Input.is_action_just_pressed("click"):
					turret_manager.build_turret(gridmap.map_to_local(cell))
					gridmap.set_cell_item(cell, 1)
					
	else:
		Input.set_default_cursor_shape(Input.CURSOR_CAN_DROP)
