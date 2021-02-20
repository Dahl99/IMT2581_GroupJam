extends Node2D

onready var player = preload("res://source/player/player.tscn").instance()


func _ready():
	randomize()
	self.add_child(player)
