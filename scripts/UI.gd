extends CanvasLayer

@onready var label = $Label

func show_interact(text):
	label.text = text
	label.visible = true

func hide_interact():
	label.visible = false
