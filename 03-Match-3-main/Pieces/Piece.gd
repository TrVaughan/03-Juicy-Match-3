extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2(0,0)
var default_modulate = Color(1,1,1,1)
var highlight = Color(1,0.8,0,1)

var fall_speed = 1.0

var dying = false

func _ready():
	default_modulate = modulate

func _physics_process(_delta):
	if dying and $Tween.is_active():
		queue_free()
	if selected:
		$Selected.emitting = true
		$Select.show()
	else:
		$Selected.emitting = false 
		$Select.hide()

func move_piece(change):
	target_position = position + change
	position = target_position

func die():
	dying = true
	var target_color = $Piece.modulate.darkened(0.75)
	target_color.s = 1
	target_color.a = 0
	var fall_duration = randf()*fall_speed + 1
	var rotate_amount = (randi() % 1440) - 720
	var target_pos = position
	target_pos.y = 1200
	$Tween.interpolate_property(self, "position", position, target_pos, fall_duration, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	$Tween.interpolate_property($Piece, "modulate", $Piece.modulate, target_color, fall_duration-0.25, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	$Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotate_amount, fall_duration-0.25, Tween.TRANS_QUINT, Tween.EASE_IN)
	$Tween.start()
	if color == "Chirp":
		get_node("/root/Game/Chirp").playing = true
	if color == "Daejor":
		get_node("/root/Game/Daejor").playing = true
	if color == "Paige_scene":
			get_node("/root/Game/Paige").playing = true
