extends Node2D


signal attack

onready var attack_timer = $AttackTimer
onready var animation_player = $AnimationPlayer

func start_timer():
	var time = randi() % 5 + 3
	attack_timer.start(time)


func _on_AttackTimer_timeout():
	animation_player.play("Attack")
	emit_signal("attack")
