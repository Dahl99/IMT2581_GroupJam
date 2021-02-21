extends Node2D

# Preloading
onready var player = preload("res://source/player/player.tscn").instance()

# Signals
signal deal_damage
signal enemy_deal_damage

# Variables
var evade_damage : bool = true

func _ready():
	_conecc_enemy()

	randomize() 			# Randomizes rng seed

	self.add_child(player)	# Adding player to scene

func _conecc_enemy():
	for child in get_children():
		if child.name == "Enemy":
			child.connect("attack", self, "_attack_by_enemy")
			child.connect("prepare_attack", self, "_prepare_attack")

func _connec_player():
	for child in get_children():
		if child.name == "Player":
			child.connect("deal_damage", self, "_attack_enemy")


# Is run when the preparation attack signal is sent.
# Does not deal damage by itself, but simply enables
# the player to take damage if he doesn't evade
func _prepare_attack():
	evade_damage = false


# Is supposed to be run when player evades 
func _evade_attack():
	evade_damage = true
	pass

# Is run when the attack signal is sent. 
# Will deal damage to player if not evaded
func _attack_by_enemy():
	if evade_damage:
		# No damage taken, the player must use dodge though.
		pass
	else:
		emit_signal("enemy_deal_damage")
		pass

func _attack_enemy():
	emit_signal("deal_damage")


func _on_Button_button_down():
	_attack_enemy()
	pass # Replace with function body.
