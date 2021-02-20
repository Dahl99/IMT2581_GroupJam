extends Node2D

signal deal_damage

var evade_damage : bool = true

func _ready():
	conecc_enemy()
	pass

func conecc_enemy():
	for child in get_children():
		if child.name == "Enemy":
			child.connect("attack", self, "attack_by_enemy")
			child.connect("prepare_attack", self, "prepare_attack")

# Is run when the preparation attack signal is sent.
# Does not deal damage by itself, but simply enables
# the player to take damage if he doesn't evade
func prepare_attack():
	evade_damage = false


# Is supposed to be run when player evades 
func evade_attack():
	evade_damage = true
	pass

# Is run when the attack signal is sent. 
# Will deal damage to player if not evaded
func attack_by_enemy():
	if evade_damage:
		# No damage taken, the player must use dodge though.
		pass
	else:
		# Player takes damage
		pass
