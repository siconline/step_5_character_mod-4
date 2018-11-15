extends Node

onready var character = $character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if character.state == 1:
		$color.texture_normal = load("res://images/color.png")
	else:
		$color.texture_normal = load("res://images/color-unclickt.png")
	
	
	if character.state == 0:
		$style.texture_normal = load("res://images/style.png")
	else:
		$style.texture_normal = load("res://images/style-unclickt.png")

func _on_color_pressed():
	character.state = 1


func _on_style_pressed():
	character.state = 0
