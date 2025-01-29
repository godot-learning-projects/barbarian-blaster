extends Area3D

class_name projectile

var direction: Vector3 = Vector3.BACK
@export var speed: float = 60.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_timer_timeout():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy_area"):
		area.get_parent().current_health -= 20
	
	queue_free()
