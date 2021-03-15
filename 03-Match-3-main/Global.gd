extends Node

var score = 0
var time = 0

signal score_changed
signal time_changed

var scores = {
	0:0,
	1:0,
	2:0,
	3:10,
	4:20,
	5:50,
	6:100,
	7:200,
	8:300,
	9:1000
}

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func change_score(s):
	score += s
	var Camera_shake = get_node_or_null("/root/Game/Camera")
	if Camera:
		Camera_shake.add_trauma(.5)
	emit_signal("score_changed")

func change_time():
	time += 1
	emit_signal("time_changed")
