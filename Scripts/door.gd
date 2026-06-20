# door.gd
extends Area3D

@export_subgroup("Inter-Scene (Different File)")
@export_file("*.tscn") var next_room_path: String

@export_subgroup("Intra-Scene (Same File)")
@export var target_marker: Marker3D
@export var target_camera: Camera3D

@export_subgroup("Configuration")
@export var destination_door_name: String

var player_node: CharacterBody3D = null

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_node = body

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_node = null

func _process(_delta):
	if player_node and Input.is_action_just_pressed("interact"):
		# Choice A: Teleporting within the exact same scene
		if target_marker and target_camera:
			TransitionManager.fade_to_same_scene(player_node, target_marker, target_camera)
		
		# Choice B: Teleporting to an entirely different scene file
		elif next_room_path != "":
			TransitionManager.fade_to_new_scene(next_room_path, destination_door_name)
