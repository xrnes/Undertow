extends CanvasLayer

# This grabs your UI components automatically when the scene loads
@onready var texture_rect = $TextureRect
@onready var label = $RichTextLabel

func setup(text_to_show: String, image_to_show: Texture2D = null):
	# 1. Set the text
	label.text = text_to_show
	
	# 2. Check if an image was provided. If not, hide the image box!
	if image_to_show != null:
		texture_rect.texture = image_to_show
		texture_rect.show()
	else:
		texture_rect.hide() # Text-only mode! Keeps the gameplay camera visible behind it.

func _process(_delta):
	# Using your updated ui_* actions!
	if (Input.is_action_just_pressed("ui_up") or 
		Input.is_action_just_pressed("ui_down") or 
		Input.is_action_just_pressed("ui_left") or 
		Input.is_action_just_pressed("ui_right") or 
		Input.is_action_just_pressed("interact")):
		
		get_tree().paused = false
		queue_free()
