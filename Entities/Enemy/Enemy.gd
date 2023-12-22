extends PathFollow3D

## Speed modifier,
## represents how many m/s the enemy will be doing
@export_range(0.1, 300.0) var speed_modifier: float = 2

@onready var base = get_tree().get_first_node_in_group("BASE")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += (delta * speed_modifier)
	if progress_ratio == 1:
		set_process(false)
		base.damage()
		get_parent().remove_child(self)
