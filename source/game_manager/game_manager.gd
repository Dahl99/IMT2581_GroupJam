extends Node2D


func _ready():
	conecc_enemy()
	pass

func conecc_enemy():
	for child in get_children():
		if child.name == "Enemy":
			child.connect("attack", self, "attack_by_enemy")

func attack_by_enemy():
	print ("Hello")
