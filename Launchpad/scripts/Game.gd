extends Node

onready var icon = preload("res://icon.png")
onready var audio = preload("res://resourses/songs/drop.wav")

func _ready():
	for i in 3:
		for e in 3:
			var btn = TouchScreenButton.new()
			var audioPlayer = AudioStreamPlayer.new()
			btn.connect("pressed", self, "_on_btn_pressed", [btn, audioPlayer])
			btn.connect("released", self, "_on_btn_released", [btn, audioPlayer])
			audioPlayer.connect("finished", self, "_on_player_finished", [btn])
			btn.normal = icon
			btn.modulate = Color.from_hsv(0.666667, 1,1,1)
#			print("h:",btn.modulate.h,"\ns:",btn.modulate.s,"\nv:",btn.modulate.v,"\na:",btn.modulate.a)
			btn.position.y = icon.get_size().x * i
			btn.position.x = icon.get_size().y * e
			add_child(btn)
			add_child(audioPlayer)

func _on_btn_pressed(btn, audioPlayer):
#	btn.modulate = Color(0.2,0.2,0.2,1)
	btn.modulate.v = 0.3
	audioPlayer.stream = audio
	audioPlayer.play()

#func _on_btn_released( audioPlayer):
#	audioPlayer.stop()

func _on_player_finished(btn):
	btn.modulate.v = 1
#	btn.modulate = Color(1,1,1,1)
