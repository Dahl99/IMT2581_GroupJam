extends Node2D

# Preloading
onready var player = preload("res://source/player/player.tscn").instance()

# Signals
signal player_deal_damage

# Variables
var evade_damage : bool = true

func _ready():
	_conecc_enemy()
	_conecc_player()

	randomize() 			# Randomizes rng seed

	self.add_child(player)	# Adding player to scene

func _conecc_enemy():
	for child in get_children():
		if child.name == "Enemy":
			child.connect("attack", self, "attack_by_enemy")
			child.connect("prepare_attack", self, "prepare_attack")

func _conecc_player():
	player.connect("dodge", self, "player_evade_attack")
	player.connect("attack", self, "player_attack")

# Is run when the preparation attack signal is sent.
# Does not deal damage by itself, but simply enables
# the player to take damage if he doesn't evade
func prepare_attack():
	evade_damage = false


# Is supposed to be run when player evades 
func player_evade_attack():
	evade_damage = true
	pass

# Function to be executed when player presses attack button
func player_attack():
	emit_signal("player_deal_damage")

# Is run when the attack signal is sent. 
# Will deal damage to player if not evaded
func attack_by_enemy():
	if evade_damage:
		# No damage taken, the player must use dodge though.
		pass
	else:
		# Player takes damage
		pass
