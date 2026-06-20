extends Area3D

# This allows you to assign the specific camera in the Inspector
@export var region_camera: Camera3D

func _ready():
	# Connect the signal through code (or you can do it via the Node tab)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Check if the object entering is the player
	if body.is_in_group("Player"):
		if region_camera:
			# Switch the active camera
			region_camera.make_current()
