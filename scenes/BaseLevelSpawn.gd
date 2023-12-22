extends Path3D

@onready var enemy = preload("res://Entities/Enemy/Enemy.gd")
@export var enemies: int = 10
var spawn: int = 0:
	set(spawn_in):
		print("spawn", spawn_in)
		spawn = spawn_in
		var instance = enemy.new()
		add_child(enemy.new())
		if spawn >= enemies:
			set_process(false)

func _process(_delta):
	spawn += 1
