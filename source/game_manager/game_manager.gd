extends Node2D

# Preloading
onready var player = preload("res://source/player/player.tscn").instance()
onready var enemy = preload("res://source/enemy/enemy.tscn").instance()

# Signals
signal enemy_deal_damage
signal player_deal_damage

# Variables
var evade_damage : bool = true

func _ready():
	_conecc_enemy()
	_conecc_player()
	
	randomize() 			# Randomizes rng seed

	add_child(enemy)
	enemy.position = Vector2(216, 57)

	self.add_child(player)	# Adding player to scene
	player.position = Vector2(1024/2, 768/2)

func _conecc_enemy():
	enemy.connect("attack", self, "_attack_by_enemy")
	enemy.connect("prepare_attack", self, "_prepare_attack")


func _conecc_player():
	player.connect("dodge", self, "player_evade_attack")
	player.connect("attack", self, "player_attack")

# Is run when the preparation attack signal is sent.
# Does not deal damage by itself, but simply enables
# the player to take damage if he doesn't evade
func _prepare_attack():
	evade_damage = false


# Is supposed to be run when player evades 
func _player_evade_attack():
	evade_damage = true
	pass

# Function to be executed when player presses attack button
func _player_attack():
	emit_signal("player_deal_damage")

# Is run when the attack signal is sent. 
# Will deal damage to player if not evaded
func _attack_by_enemy():
	if !evade_damage:
		print ("hello")
		emit_signal("enemy_deal_damage")

func _on_Button_button_down():
	_player_attack()
	pass # Replace with function body.
