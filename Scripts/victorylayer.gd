extends CanvasLayer

@onready var star_2 := %Star2
@onready var star_3 := %Star3
@onready var health_label := %HealthLabel
@onready var gold_label := %GoldLabel

@onready var base = get_tree().get_first_node_in_group("BASE")
@onready var gold_interface = get_tree().get_first_node_in_group("GOLD_INTERFACE")

func _ready():
	visible = false;

func victory() -> void:
	visible = true
	if base.max_health == base.current_health:
		star_2.modulate = Color.WHITE
		health_label.visible = true
		
	if gold_interface.gold > 499:
		star_3.modulate = Color.WHITE
		gold_label.visible = true

func _on_retry_pressed():
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()

