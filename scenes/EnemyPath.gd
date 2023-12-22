extends Path3D

@export var enemies: int = 10
var spawn: int:
	set(spawn_in):
		spawn = spawn_in
		preload("res://Models/Enemy/enemy.gd").new
		if spawn > enemies:
			set_process(false)

func _ready():
	spawn = 0
	
func _process(delta):
	spawn += 1
