extends Node2D


signal attack
signal prepare_attack

onready var attack_timer = $AttackTimer
onready var prepare_timer = $AttackPrepareTimer
onready var animation_player = $AnimationPlayer

func start_attack_timer():
	attack_timer.start(1.3)

func start_prepare_timer():
	var time = randi() % 4 + 3
	prepare_timer.start(time)

func _ready():
	start_prepare_timer()


func _on_AttackTimer_timeout():
	animation_player.play("Attack")
	emit_signal("attack")

func _on_AttackPrepareTimer_timeout():
	animation_player.play("Prepare Attack")
	emit_signal("prepare_attack")
	start_attack_timer()
	
