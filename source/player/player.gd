extends KinematicBody2D

signal attack
signal dodge

onready var _label_attack = $LabelAttack
onready var _label_dodge = $LabelDodge

onready var _timer_attack = $TimerAttack
onready var _timer_dodge = $TimerDodge

const _attack_text = "Attack: "
const _dodge_text = "Dodge: "

# Varables used to keep track of currently used buttons
var _keys = ["A", "X", "Space", "P", "8", "B"]

var _attack_btn: String
var _dodge_btn: String

var _max_health = 10	# Keeps track of player max health
var _health = 10		# Keeps track of player health

# When player object is created,
# the keys will be shuffled
# and a random attack and dodge
# key will be chosen
func _ready():
	get_parent().connect("enemy_deal_damage", self, "_hurt")

	_keys.shuffle()
	_attack_btn = _keys.front()
	_dodge_btn = _keys.back()

	_label_attack.text = _attack_text + _attack_btn
	_label_dodge.text = _dodge_text + _dodge_btn

	$Animation.play("idle")

func _physics_process(_delta):
	if Input.is_action_just_pressed(_attack_btn):						# Checking if attack button is pressed
		_attack()														# Execeuting attack
		_attack_btn = _get_random_unused_key(_attack_btn, _dodge_btn)	# Assigning new key for attack action
		_label_attack.text = _attack_text + _attack_btn

	elif Input.is_action_just_pressed(_dodge_btn):						# Checking if dodge button is pressed
		_dodge()														# Executing dodge
		_dodge_btn = _get_random_unused_key(_dodge_btn, _attack_btn)	# Assigning new key for dodge action
		_label_dodge.text = _dodge_text + _dodge_btn

func _attack():
	$Animation.play("attack")
	_timer_attack.start()
	print("attack timer should start")
	emit_signal("attack")

func _dodge():
	$Animation.play("dodge")
	_timer_dodge.start()
	print("dodge timer should start")
	emit_signal("dodge")

func _hurt():
	_health -= 1

	if _health <= 0:
		$Animation.play("die")
	else:
		$Animation.play("hurt")

# Gets a randomly chosen new key
# that's not equal to previously used key
# or another currently in-use key
func _get_random_unused_key(_previous_key: String, _used_key: String) -> String:
	var _new_key: String
	_keys.shuffle()
	_new_key = _keys.front()

	while _new_key == _previous_key or _new_key == _used_key:
		_keys.shuffle()
		_new_key = _keys.front()
	
	return _new_key

func _on_TimerAttack_timeout():
	print("idle should play now")
	$Animation.play("idle")

func _on_TimerDodge_timeout():
	print("idle should be play now")
	$Animation.play("idle")