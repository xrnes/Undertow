extends Area3D

@export var inspect_overlay_scene: PackedScene

# NEW: Typing your text and dropping images directly in the Inspector
@export_multiline var flavor_text: String = "It's an object."
@export var closeup_image: Texture2D = null # Leave empty for text-only!

var player_in_range: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player": # Using your fixed capital P!
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		open_inspection()

func open_inspection():
	if inspect_overlay_scene:
		get_tree().paused = true
		
		var overlay = inspect_overlay_scene.instantiate()
		get_tree().root.add_child(overlay)
		
		# NEW: Feed the text and image into our upgraded overlay setup
		overlay.setup(flavor_text, closeup_image)
