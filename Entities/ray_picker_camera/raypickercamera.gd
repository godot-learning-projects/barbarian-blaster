extends Camera3D

@export var turret_manager: TurretManager
@export var enemy_path: Path3D
@export var gridmap: GridMap

@export var ray_cast_Z_distance: float = 100.0
@onready var ray_cast_3d = $RayCast3D

@onready var gold_interface = get_tree().get_first_node_in_group("GOLD_INTERFACE")

# Called every frame. 'delta' is the elapsed time since the previous frame.
var _previous_gridmap_cell: Vector3
func _process(_delta):
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var target = project_local_ray_normal(mouse_position) * ray_cast_Z_distance
	ray_cast_3d.target_position = target
	ray_cast_3d.force_raycast_update()
	
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	
	if ray_cast_3d.is_colliding():
		
		var collider = ray_cast_3d.get_collider()
		if collider is GridMap:
			var cell = gridmap.local_to_map(ray_cast_3d.get_collision_point())
			var gridmap_cell = gridmap.get_cell_item(cell)
			
			if _previous_gridmap_cell != gridmap.map_to_local(cell):
				turret_manager.show_view_range(_previous_gridmap_cell, false)
				_previous_gridmap_cell = gridmap.map_to_local(cell)
	
	
			if gridmap_cell == 2:
				if Input.is_action_just_pressed("left_click"):
					enemy_path.spawn_enemy()
					
			if gridmap_cell == 0:
				if gold_interface.gold >= turret_manager.turret_cost:
					Input.set_default_cursor_shape(Input.CURSOR_ARROW)
					if Input.is_action_just_pressed("left_click"):
						if turret_manager.build(gridmap.map_to_local(cell)):
							gridmap.set_cell_item(cell, 1)
				else:
					Input.set_default_cursor_shape(Input.CURSOR_FORBIDDEN)
			else:
				Input.set_default_cursor_shape(Input.CURSOR_HELP)
				_previous_gridmap_cell = gridmap.map_to_local(cell)
				turret_manager.show_view_range(_previous_gridmap_cell, true)
				if Input.is_action_just_pressed("right_click"):
					turret_manager.destroy(gridmap.map_to_local(cell))
					gridmap.set_cell_item(cell, 0)
			
	else:
		Input.set_default_cursor_shape(Input.CURSOR_CAN_DROP)
		if _previous_gridmap_cell:
			turret_manager.show_view_range(_previous_gridmap_cell, false)
