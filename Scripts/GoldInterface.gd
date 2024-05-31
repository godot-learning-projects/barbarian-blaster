extends MarginContainer

@onready var gold_label = $GoldAvailable

@export var starting_gold: int = 180

var gold: int:
	set(gold_in):
		gold = max(gold_in, 0)
		gold_label.text = "Gold: " + str(gold)
		if gold < 1:
			gold_label.modulate = Color.DARK_RED
		else:
			gold_label.modulate = Color.ALICE_BLUE

func _ready():
	gold = starting_gold
