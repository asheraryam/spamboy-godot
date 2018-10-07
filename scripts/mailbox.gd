extends Node2D

signal feed

var scoreScene = preload("res://scenes/scoreText.tscn")

export(String, "SMALL", "MEDIUM", "LARGE") var type = "MEDIUM" setget set_mailbox_type
var mail_capacity
export (int) var mail_count = 0

func _ready():
	$debug.hide()

func feed(sender):
	if mail_count < mail_capacity:
		mail_count += 1
		$AnimationPlayer.play("feeded")
		spawn_score_text(str(mail_count * 100))
		emit_signal("feed")
	else:
		spawn_score_text("FULL", "spawn_b")
		pass

func spawn_score_text(text, animation = "spawn_a"):
	var score = scoreScene.instance()
	score.text = text
	score.position = $scoreSpawn.position
	score.animation = animation
	self.add_child(score)

func _on_Area2D_body_entered(body):
	body.connect("stuff_mail",self,"feed") 

func _on_Area2D_body_exited(body):
	body.disconnect("stuff_mail",self,"feed") 

func set_mailbox_type(new_type):
	type = new_type
	if type == "SMALL":
		mail_capacity = 5
	elif type == "MEDIUM":
		mail_capacity = 10
	elif type == "LARGE":
		mail_capacity = 15