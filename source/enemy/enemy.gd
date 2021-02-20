extends Node2D

signal attack
signal prepare_attack

onready var attack_timer = $AttackTimer
onready var prepare_timer = $AttackPrepareTimer
onready var animation_player = $AnimationPlayer

var max_health = 5
var health = 5
var dead : bool = false

# This function PREPARES the attack. It's the same as indication
# that the enemy is about to attack. The attacking happens in 
# start_attack_timer 
func start_prepare_timer():
	var time = randi() % 4 + 3
	prepare_timer.start(time)

# The attack happens always after 1.3 seconds after the preparation
func start_attack_timer():
	attack_timer.start(1.3)

func _ready():
	start_prepare_timer()
	get_parent().connect("take_damage", self, "_on_take_damage")

func _on_take_damage():
	health = health - 1
	animation_player.play("Take Damage")

func die():
	health = max_health
	
	animation_player.clear_queue()
	animation_player.play("Die")
	

func _on_AttackTimer_timeout():
	animation_player.play("Attack")
	emit_signal("attack")

func _on_AttackPrepareTimer_timeout():
	animation_player.play("Prepare Attack")
	emit_signal("prepare_attack")
	start_attack_timer()
	
