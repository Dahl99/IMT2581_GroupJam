extends Node2D

# Preloading
onready var player = preload("res://source/player/player.tscn").instance()
onready var enemy = preload("res://source/enemy/enemy.tscn").instance()
onready var pop_up = preload("res://source/menus/pop-up.tscn").instance()

# Signals
signal enemy_deal_damage
signal player_deal_damage

# Variables
var evade_damage : bool = true
var enemies_killed : int = 0

func _ready():
	_conecc_enemy()
	_conecc_player()
	
	randomize() 			# Randomizes rng seed

	add_child(enemy)
	enemy.position = Vector2(179, 768 - 200)

	self.add_child(player)	# Adding player to scene
	player.position = Vector2(652, 768 - 200)

func _conecc_enemy():
	enemy.connect("attack", self, "_attack_by_enemy")
	enemy.connect("prepare_attack", self, "_prepare_attack")
	enemy.connect("enemy_died", self, "_on_enemy_died")


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


func _on_enemy_died():
	enemies_killed += 1
	if enemies_killed >= 1:
		add_child(pop_up)
		pop_up.visible = true
		pop_up.rect_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
 
func _on_Button_button_down():
	_player_attack()
	pass # Replace with function body.
