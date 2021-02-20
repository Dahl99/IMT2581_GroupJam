extends KinematicBody2D

var _attack_btn: String
var _dodge_btn: String

var _health = 10

var _keys = ["A", "X", "Space", "P", "8", "B"]

func _ready():
	_keys.shuffle()
	_attack_btn = _keys.front()
	_dodge_btn = _keys.back()

func _physics_process(_delta):
	
	if Input.is_action_just_pressed(_attack_btn):
		_attack()
		_attack_btn = _get_random_unused_key(_attack_btn, _dodge_btn)
	elif Input.is_action_just_pressed(_dodge_btn):
		_dodge()
		_dodge_btn = _get_random_unused_key(_dodge_btn, _attack_btn)

func _attack():
	pass

func _dodge():
	pass

func _hurt(_dmg_taken: int):
	_health -= _dmg_taken

func _get_random_unused_key(_previous_key: String, _used_key: String):
	var _new_key: String
	_keys.shuffle()
	_new_key = _keys.front()

	while _new_key == _previous_key or _new_key == _used_key:
		_keys.shuffle()
		_new_key = _keys.front()
	
	return _new_key