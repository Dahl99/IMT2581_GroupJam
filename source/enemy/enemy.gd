extends Node2D

signal attack
signal prepare_attack
signal enemy_died

onready var attack_timer = $AttackTimer
onready var prepare_timer = $AttackPrepareTimer
onready var animation_player = $AnimationPlayer
onready var health_bar = $TextureProgress

var max_health = 5
export (int) var health = 5

# This function PREPARES the attack. It's the same as indication
# that the enemy is about to attack. The attacking happens in 
# start_attack_timer 
func start_prepare_timer():
	var time = randi() % 4 + 1
	prepare_timer.start(time)

# The attack happens always after 1.3 seconds after the preparation
func start_attack_timer():
	attack_timer.start(1.3)

func _ready():
	start_prepare_timer()
	get_parent().connect("player_deal_damage", self, "_on_take_damage")

func _die():
	attack_timer.stop()
	prepare_timer.stop()
	health_bar.visible = false
	
	emit_signal("enemy_died")
	
	animation_player.clear_queue()
	animation_player.play("Die")

func _respawn():
	health = max_health
	health_bar.value = health
	animation_player.play("Respawn")
	start_prepare_timer()
	health_bar.visible = true

func _on_take_damage():
	health = health - 1
	health_bar.value = health
	if health <= 0:
		_die()
	else:
		animation_player.play("Take Damage")


func _on_AttackTimer_timeout():
	animation_player.play("Attack")
	emit_signal("attack")
	start_prepare_timer()

func _on_AttackPrepareTimer_timeout():
	animation_player.stop()
	animation_player.play("Prepare Attack")
	emit_signal("prepare_attack")
	start_attack_timer()
	
