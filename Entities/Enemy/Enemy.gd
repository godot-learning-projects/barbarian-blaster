extends PathFollow3D

class_name Enemy

@onready var gold_interface = get_tree().get_first_node_in_group("GOLD_INTERFACE")
@onready var base = get_tree().get_first_node_in_group("BASE")
@onready var animation_player = $AnimationPlayer
@onready var health_label = $health_label


## Speed modifier,
## represents how many m/s the enemy will be doing
@export_range(0.1, 300.0) var speed_modifier: float = 6
@export var max_health: int = 50
@export var gold := 20

var current_health: int = 0:
	set(health_in):
		if health_in < current_health:
			animation_player.play("TakeDamage")
		current_health = health_in
		_update_label(current_health)
		if current_health < 1:
			gold_interface.gold += gold
			queue_free()

const GREEN: Color = Color.GREEN
const RED: Color = Color.RED

func set_params(health_in: int) -> Enemy:
	max_health = health_in
	#current_health = max_health
	return self
	
func _ready():
	current_health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += (delta * speed_modifier)
	if progress_ratio == 1:
		set_process(false)
		base.damage()
		queue_free()

func _update_label(in_health :int) -> void:
	health_label.text = str(current_health)
	
	var blended_color = RED.lerp(GREEN, (float(in_health) / float(max_health)))
	health_label.modulate = blended_color
