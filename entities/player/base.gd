extends Node3D

class_name Base

@export var max_health: int = 10;
var current_health: int = 0:
	set(health_in):
		#if health_in > current_health:
		current_health = health_in
		_update_label(current_health)
		if current_health <= 0:
			print("You lose!")
			get_tree().reload_current_scene()

@onready var health_label: Label3D = $Health_Label

const GREEN: Color = Color.GREEN
const RED: Color = Color.RED

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health

func damage() -> void:
	current_health -= 1

func _update_label(in_health :int) -> void:
	health_label.text = str(current_health) + " / " + str(max_health)
	var blended_color = RED.lerp(GREEN, (float(in_health) / float(max_health)))
	health_label.modulate = blended_color
