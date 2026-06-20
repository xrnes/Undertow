extends Area3D

@export var inspect_overlay_scene: PackedScene

# Configuration for this specific door
@export var required_key_name: String = "Saloon Key"
@export var is_locked: bool = true

# This automatically grabs the audio player child node we just created
@onready var unlock_sound_player = $UnlockSoundPlayer

var player_in_range: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		handle_door_interaction()

func handle_door_interaction():
	if is_locked:
		# Check our global inventory backend for the specific key
		if InventoryManager.has_item("KEY ITEMS", required_key_name):
			# 1. PLAY THE SOUND! (No text box, game does not pause)
			unlock_sound_player.play()
			print("SUCCESS: Played unlock sound.")
			
			# 2. Unlock the door permanently
			is_locked = false
		else:
			# FAILURE: Still freeze the game and show the locked message
			open_text_prompt("This door is locked and requires a key")
	else:
		print("The door is already unlocked. Walking through...")

# Keeps your text overlay logic for when the door IS locked
func open_text_prompt(message: String):
	if inspect_overlay_scene:
		get_tree().paused = true
		var overlay = inspect_overlay_scene.instantiate()
		get_tree().root.add_child(overlay)
		overlay.setup(message, null)
